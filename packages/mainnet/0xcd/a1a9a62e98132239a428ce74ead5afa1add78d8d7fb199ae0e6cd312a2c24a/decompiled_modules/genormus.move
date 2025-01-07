module 0xcda1a9a62e98132239a428ce74ead5afa1add78d8d7fb199ae0e6cd312a2c24a::genormus {
    struct GENORMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENORMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENORMUS>(arg0, 6, b"GENORMUS", b"GREAT NORMUS SUI", b"Meet GREAT NORMUS, a memecoin inspired by the fierce spirit of ancient Sparta.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_23_01_34_cda6fa69b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENORMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENORMUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

