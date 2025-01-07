module 0x9d20b86fe7b181580f6f535fbdc3dcb33523c9c12504c2861a66399478b34bf0::cwn {
    struct CWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWN>(arg0, 6, b"CWN", b"Crab With Knife", x"68747470733a2f2f796f7574752e62652f305161414b69304e466b413f73693d3170314c5165506479584a38647967570a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mqdefault_4b1ba572e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

