module 0xaa7cd33a7ed71c7b95d212e5d976b49b17858538568e1f2e9085e3d559f3a43d::dmouse {
    struct DMOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMOUSE>(arg0, 6, b"DMouse", b"Mouse", b"Tokken mouse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010136_acaa950105.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMOUSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DMOUSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

