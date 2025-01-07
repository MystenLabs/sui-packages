module 0xaa21e25d1df6fd769a838b2238f7ce799eb48e06b4fa7dbab6a4d084caae03b7::simbasui {
    struct SIMBASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMBASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMBASUI>(arg0, 6, b"Simbasui", b"Simba", b"Simba on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000903900_177d41c9ba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMBASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMBASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

