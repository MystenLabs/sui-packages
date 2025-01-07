module 0xc1b517256d194e3c1e583d59a2ec3d52f7ecc6e69ece235f64a580c5686e6f47::sui314dao {
    struct SUI314DAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI314DAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI314DAO>(arg0, 6, b"Sui314Dao", b"Sui314", b"2. Launch the Oasis plan in advance: The development of Project Oasis has been ongoing. In the early stage of development, we borrowed some unlicensed engine systems from other game manufacturers to complete the overall structure as soon as possible. After Project Oasis is launched, we will complete the authorization. 3. Recent content of Oasis: 1. Players can customize the character's gender, race, skin color, and appearance, and purchase clothing, accessories, and vehicles other than the default ones. 2. Players can purchase land parcels and real estate in designated cities through bidding. The current open city is Hong Kong. 3. After purchasing the property, players can design it themselves. Note: all materials and furniture need to be purchased additionally. 4. The currency used in the game is 314, and all assets in the game can be traded at customized prices. 5. The trial demo will be launched soon. Please pay attention to the official announcement for subsequent content development.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8627_9f9d8e78ae.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI314DAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI314DAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

