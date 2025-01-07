module 0x7b154e2c2f0786cee004f3cff024ab810f34e2e9522efda1bc7cc76931a66402::plz {
    struct PLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLZ>(arg0, 9, b"PLZ", b"Plazarium", x"506c617a617269756d2028504c4d292069732061207365637572652c20666173742063727970746f63757272656e637920666f72207365616d6c657373207472616e73616374696f6e7320616e64206441707020696e746567726174696f6e2e20576974682061207374726f6e6720636f6d6d756e69747920616e6420696e6e6f76617469766520746563682c206974206272696467657320747261646974696f6e616c2066696e616e636520616e6420626c6f636b636861696e20666f722061636365737369626c652c20656666696369656e74207573652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d5545f16-88c2-4842-bf49-e4e25439cfe8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

