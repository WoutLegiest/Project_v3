package be.kuleuven.gent.project;

import be.kuleuven.gent.project.data.ProfessionalProject;
import be.kuleuven.gent.project.ejb.ProfessionalProjectManagementEJBLocal;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

import javax.ejb.EJB;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * EJB controller voor het aanmaken van een project
 */
@Path("project_service")
public class ProjectRestService {

    @EJB
    private ProfessionalProjectManagementEJBLocal ppEJB;

    /**
     * Er wordt een project aangemaakt en op de database gezet
     * @param jsonInput De input data uit de applicatie
     * @return Response, in JSON vorm, met het net aangemaakte project
     */
    @POST
    @Path("/project_registration")
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    public Response generateProject(String jsonInput)  {

        try {
            JSONObject jsonObject = new JSONObject(jsonInput);

            String name = jsonObject.getString("name");
            String location = jsonObject.getString("location");
            float latitude = Float.parseFloat(jsonObject.getString("latitude"));
            float longitude = Float.parseFloat(jsonObject.getString("longitude"));
            String description = jsonObject.getString("description");


            ProfessionalProject profProject = ppEJB.makeProject(name, location, latitude, longitude, description);
            return Response.ok(profProject,MediaType.APPLICATION_JSON).build();
        } catch (JSONException e) {
            e.printStackTrace();
            return Response.ok(e,MediaType.APPLICATION_JSON).build();
        }

    }


}
