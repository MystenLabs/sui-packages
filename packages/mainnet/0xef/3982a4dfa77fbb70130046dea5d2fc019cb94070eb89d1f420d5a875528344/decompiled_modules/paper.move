module 0xef3982a4dfa77fbb70130046dea5d2fc019cb94070eb89d1f420d5a875528344::paper {
    struct PAPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPER>(arg0, 6, b"PAPER", b"$PAPER", b"Welcome to $PAPER, The real Satoshi.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CHINA_CAT_1515ade544.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

