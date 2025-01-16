module 0x179bd4618f1ed319338bd59f67940e84e53be256695d8fcd8a61a47fd08954d1::zeryn {
    struct ZERYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZERYN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ZERYN>(arg0, 6, b"ZERYN", b"ZerynAI by SuiAI", b"Your Digital Space With ZerynAI Agents, Ensuring Continuous Protection.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2165_defa286138.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZERYN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZERYN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

