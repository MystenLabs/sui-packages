module 0x13bdcaf8cf15f6a9b439b242a4ccf0ea4b9614898520fa81753f4e9da31acbdc::magatron {
    struct MAGATRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGATRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGATRON>(arg0, 9, b"MAGATRON", b"MAGATRON AI", x"4d616b652043727970746f20477265617420416761696e200a0a4272696e67696e67206261636b20746865206d656d6520636f696e206368616f73207768696c65207765206261636b205472756d7020696e2068697320657069632073686f77646f776e20616761696e737420726567756c6174696f6e2e0a0a4c657427732070756d702069742c2064756d702069742c20616e64206b65657020746865207265766f6c7574696f6e206c69742120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdZtcF49p5pyysyF7D6qQkXLuN4yV3VSBGLqLkN7hiehs")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAGATRON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGATRON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGATRON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

