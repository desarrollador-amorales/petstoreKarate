package karate;

import com.intuit.karate.junit5.Karate;

public class PetStoreTest {
    @Karate.Test
    Karate testPetStoreApi() {
        return Karate.run("petstore-api").relativeTo(getClass());
    }

}
