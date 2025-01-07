module 0xfa94718a03508c14eeec7cad727258d7a5c7cef53a273f568fbabdb960e7d6db::catspump {
    struct CATSPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSPUMP>(arg0, 6, b"CATSPUMP", b"CATS PUMP", x"4f6e6c79206120434154206d656d6520666f7220636f6d6d756e69747920200a43617473206d656d65200a234361747350756d70", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catspump_c6dd91bd3d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

