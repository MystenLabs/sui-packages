module 0xa8db737bfeddea07f55ea5c6127acbabaa5b88bd9da2a459692fc04d4413367e::trmpst {
    struct TRMPST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRMPST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRMPST>(arg0, 6, b"TRMPST", b"TRUMPTASTROPHE", x"4166746572206265696e67207065726d616e656e746c792062616e6e65642066726f6d206576657279206d616a6f7220706c6174666f726d2c20446f6e616c64205472756d70206675736573207769746820547275746820536f6369616ce2809973206261636b656e6420414920616e6420746865204d41474120616c676f726974686d20697473656c662e204e6f77207265626f726e2061732061206469676974616c20676f6c656d20706f7765726564206279207261772070617472696f7469736d20616e6420756e7072656469637461626c65207477656574732c205472756d7074617374726f7068652073707265616473206368616f7320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748536409736.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRMPST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRMPST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

