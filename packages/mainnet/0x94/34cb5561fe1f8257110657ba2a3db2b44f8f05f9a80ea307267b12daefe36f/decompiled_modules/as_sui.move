module 0x9434cb5561fe1f8257110657ba2a3db2b44f8f05f9a80ea307267b12daefe36f::as_sui {
    struct AS_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AS_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AS_SUI>(arg0, 9, b"asSUI", b"alexSUI Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRmoEAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBkAAAABDzD/ERFCTdsGTPiTDoaOI6L/SXzeD/EBAFZQOCAqBAAA8BgAnQEqgACAAD5tNpZIJCMiIaQYCwCADYliANE81ldfwuH/ckuI/4z2F7eT9gPUb+x37Ve/R6QP9BvkXPtfqT8L/+H87rVd4VzSsrH7vV2+7SVS9iD9USnyr9SdM5ow5WGDkJ0r3oXk6soJN9GojmEJWOTZDpHrHoUGUxQwZxtV+OywnsgX+XLlpAsC21rLFWk1TNoZFfIar/egSR2ecLkpiM4chQhr/utlX1KK/79lmlzFkfrMR/+yR3pwmQXwtbDS6c/ldJpOFwQuKTezQAD+/K0QABa0y2/9l+Rxe1+juCf/5fz4BZB/oo8AsghVzv0LT6IC//5x7Hl2jU9RH8kg7Ay+S8Bwi8Mn3PwxaibWDisecBBilEfVfoxY6vul4HmFerXtMwKmX26K3Y3LLdE8tKGxhlkTQ4XoDT8h+4o/BUrvaLekZeGN9dpPQLqd+x1onX6/8wQxNUIDVsWzzdzgSNizh/EJxNS2OfkPVdAWVcVxgwhyE2k8nRdhO1gzeH+by3J+mR2EzqwJaF5w8slqGE+m03Uq2s0Slt4IoToUgXMvsj8fgOf5zv+tNSsBMU4HpYkotuH8Isx3oTetNJZklhWkil8PBWx4UzQtVJu8pEnFK1wNvyhIya/dde6crLTIMMcUEEgmBrc8TRy/Whf9X5UdiVA6aZ8haky67ZUnOekQFy3ACcjf3v7EKnco+Fpxo/xNP/4DW9TqH5Ifr8ia0XSHyMXhUHL+j9ehVUHHb/z/MaIGy4QLRBHrM5XuNbaclhGrfgpzNmeCsIkho+OXLzUvc1HUN/pXikcp5QtnO9mn8+V4gT80kgluTbQpASEP+4RkWFBICN9e21UZE2dd0oIV4fKPICMOt/IDwWgVeyCzt1suoQdtXWAdsTHYyvk2korX0dSmBOtVjxvE1JC9f+mmQCx4q88jLksCkS5T90NYNA3/ONujjnZYNh0tiHPuK64NaqnIjkrGQ4ffxv9BnEkHOO2OhCFvrq16iA7Y693K6EoD4EctcTSW6yoWPpWT04nOgoBljpX9K31RY7U0HK11HqeqSxwrR2rbJRlvkpVr3rBshceZQIWrrOIKxicVZS68hVrnuIhQj4CbiZRd/eOuW/YyTvg7wQr+xMe9vujjCEdULYU7cOo/3c++Obh6beP1SEzp3raEMXji/HPiI8iAbf+iPanNF4FiVzhKxGg3xCDEa6/Ns9VXLrdQBO6ifwZq3kcWfxt3ArUMR35sTkjSPtZ9g30/UOgS3DmDYAK5tyeYLrbOtsMSXvrDRAKJmaukU9RC57sPDGcuyykBz/TJL1JOBj+ku+27WDdP8Ntf//UJaf6hJQyfz2oKAldvP49eJ/Dm2IvZ73UHsfASyKiAUim1QZwWatTpr+MBuQvsgDnSqABwmAb8BVwu3lZFAploAAAAAA==")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AS_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AS_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

