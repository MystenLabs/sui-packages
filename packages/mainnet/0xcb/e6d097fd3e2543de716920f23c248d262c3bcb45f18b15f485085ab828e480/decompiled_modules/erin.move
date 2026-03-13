module 0xcbe6d097fd3e2543de716920f23c248d262c3bcb45f18b15f485085ab828e480::erin {
    struct ERIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERIN>(arg0, 6, b"ERIN", b"Restless Spirits", x"436f6e6365707420636f696e20666f722064656d6f200a31303025206d656d6520636f696e206e6f742072656c6174656420746f2074686520636f6d70616e79206174207468697320706f696e7420696e2074696d652e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1773388812902.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

