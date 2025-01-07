module 0x27ff67e2a0e0352755905e9126f5f3acdd0cd05b709026f44dc79d14eaf7ad23::play {
    struct PLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLAY>(arg0, 9, b"PLAY", b"SuiPlayCoin", b"SuiPlayCoin the next-generation handheld gaming device", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.preorder.suiplay0x1.com/api/display/0x0007e6a01273080a8b57cca4ac528e97a7e378333fb2daddaa0503eb22edb813")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PLAY>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLAY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

