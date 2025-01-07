module 0x1cb9c0e15cce3e1137d75eaf62e5b85fa18950e4327cd15b203a61341c6aa94::trashy {
    struct TRASHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRASHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRASHY>(arg0, 6, b"TRASHY", b"Trashy On SUI", b"Trashy AI is a one-of-a-kind automated trading bot that works through discord and telegram. Powered by TRASHY.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G5d_H6l_Y0_400x400_36d9614f55.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRASHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRASHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

