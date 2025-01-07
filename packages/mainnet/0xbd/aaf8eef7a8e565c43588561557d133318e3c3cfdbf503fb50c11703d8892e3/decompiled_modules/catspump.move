module 0xbdaaf8eef7a8e565c43588561557d133318e3c3cfdbf503fb50c11703d8892e3::catspump {
    struct CATSPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSPUMP>(arg0, 6, b"CATSPUMP", b"CATS PUMP", x"4f6e6c79206120434154206d656d6520666f7220636f6d6d756e69747920200a5355492043617473206d656d65200a234361747350756d70", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catspump_0e9bbf5906.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

