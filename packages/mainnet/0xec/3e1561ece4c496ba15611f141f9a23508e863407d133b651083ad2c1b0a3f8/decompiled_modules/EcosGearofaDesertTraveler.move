module 0xec3e1561ece4c496ba15611f141f9a23508e863407d133b651083ad2c1b0a3f8::EcosGearofaDesertTraveler {
    struct ECOSGEAROFADESERTTRAVELER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECOSGEAROFADESERTTRAVELER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECOSGEAROFADESERTTRAVELER>(arg0, 0, b"COS", b"Eco's Gear of a Desert Traveler", b"Weary drifter, wandering so far from the home you've forgotten...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Ecos_Gear_of_a_Desert_Traveler.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ECOSGEAROFADESERTTRAVELER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECOSGEAROFADESERTTRAVELER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

