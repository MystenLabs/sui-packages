module 0x4117b07f3d769fd2e9b2a6b1edb59d25726c29c6c092be7376035af23dd37f91::boyz {
    struct BOYZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOYZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOYZ>(arg0, 6, b"BOYZ", b"BeraBoyz", b"BeraBoyz project on Bera chain having a meme coin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731206743470.44")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOYZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOYZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

