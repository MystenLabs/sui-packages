module 0x2c2e107cb3619606358d013cd8781bdb188ccb2dc7b7659cd3c35d7886a85030::miggles {
    struct MIGGLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIGGLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIGGLES>(arg0, 6, b"MIGGLES", b"MR MIGGLES ON SUI", b"MR MIGGLES IS CUTE CAT ON SUI DYOR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/EW_9g_Sc_Xu_400x400_03bc98807d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIGGLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIGGLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

