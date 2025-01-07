module 0xa6ac877cd2d64d3c9e79d74f86a5bdb1e63ecf8122704589167a3d762f0169a7::dwolf {
    struct DWOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWOLF>(arg0, 6, b"DWOLF", b"DWolf On Sui", b"The biggest & baddest character on Sui...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prop_e0b92d825d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

