module 0xf4378e76c024589187f3e8560415e1a4905883a0c83065ff744b5a6788924e8c::clawscreener {
    struct CLAWSCREENER has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CLAWSCREENER>, arg1: 0x2::coin::Coin<CLAWSCREENER>) {
        0x2::coin::burn<CLAWSCREENER>(arg0, arg1);
    }

    fun init(arg0: CLAWSCREENER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAWSCREENER>(arg0, 6, b"CLAW", b"ClawScreener", x"436c617753637265656e657220e280942041492d706f776572656420746f6b656e2073637265656e657220616e64206167656e7420747261636b65722e205265616c2d74696d65207363616e6e696e67206f6620746f6b656e206c61756e636865732c206f6e2d636861696e207369676e616c732c20616e64204149206167656e7420746f6b656e73206163726f7373204261736520616e6420536f6c616e612e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fyjBlRI.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLAWSCREENER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAWSCREENER>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CLAWSCREENER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CLAWSCREENER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

