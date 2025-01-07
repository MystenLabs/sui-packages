module 0xdeb8794232dea9b116887158595738d3d54263650d157697069bfdfd3dedb0e::pp {
    struct PP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PP>(arg0, 6, b"PP", b"PUMPUP", b"PP ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d0_J3f_QGM_400x400_de2d713c87.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PP>>(v1);
    }

    // decompiled from Move bytecode v6
}

