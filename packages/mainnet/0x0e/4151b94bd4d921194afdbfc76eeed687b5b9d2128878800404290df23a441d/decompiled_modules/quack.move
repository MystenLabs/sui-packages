module 0xe4151b94bd4d921194afdbfc76eeed687b5b9d2128878800404290df23a441d::quack {
    struct QUACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUACK>(arg0, 9, b"QUACK", b"QUACK", x"24515541434b20e2809420537569e2809973206372617a79206475636b2e204c6f75642c2077696c642c20756e73746f707061626c652e207c20576562736974653a2068747470733a2f2f717561636b2e636f6d2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/13801zT.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

