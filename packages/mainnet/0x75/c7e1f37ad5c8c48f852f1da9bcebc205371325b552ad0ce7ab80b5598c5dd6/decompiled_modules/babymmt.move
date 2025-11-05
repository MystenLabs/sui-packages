module 0x75c7e1f37ad5c8c48f852f1da9bcebc205371325b552ad0ce7ab80b5598c5dd6::babymmt {
    struct BABYMMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYMMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYMMT>(arg0, 6, b"BabyMMT", b"Baby MMT", b"The brand-new coin of Baby MMT originated from fans of the Baby MMT community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MMT_35841f6c93.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYMMT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYMMT>>(v1);
    }

    // decompiled from Move bytecode v6
}

