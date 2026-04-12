module 0x2f219e26ecbe5b7eb84adf5df4e5dcddb9a6151297f9c12c5475fdf365b9fb9f::DDO {
    struct DDO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DDO>, arg1: 0x2::coin::Coin<DDO>) {
        0x2::coin::burn<DDO>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DDO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DDO>>(0x2::coin::mint<DDO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDO>(arg0, 4, b"DDO", b"DDO", x"44444fefbc8ce585a8e7a7b020446563656e7472616c697a6564204469676974616c204f7267616e69736defbc88e58ebbe4b8ade5bf83e58c96e695b0e5ad97e7949fe591bde4bd93efbc89efbc8ce698afe4b880e4b8aae89e8de59088204149202b205765623320e68a80e69cafe79a84e5889be696b0e9a1b9e79baeefbc8ce697a8e59ca8e69e84e5bbbae585b7e5a487e887aae68891e5ada6e4b9a0e4b88ee58d8fe4bd9ce883bde58a9be79a84e699bae883bde58ebbe4b8ade5bf83e58c96e7949fe68081e3808244444f20e9809ae8bf87e58cbae59d97e993bee4bf9de99a9ce695b0e68daee7a1aee69d83e4b88ee9808fe6988ee8bf90e8a18cefbc8ce7bb93e59088e4babae5b7a5e699bae883bde79a84e6b7b1e5baa6e5ada6e4b9a0e4b88ee586b3e7ad96e883bde58a9befbc8ce5ae9ee78eb0e993bee4b88ae887aae6b2bbe38081e58fafe4bfa1e4baa4e4ba92e4b88ee699bae883bde68890e995bfe38082e6af8fe4b880e4b8aa2044444f20e5ae9ee4bd93e983bde698afe58fafe68c81e7bbade8bf9be58c96e79a84e695b0e5ad97e7949fe591bde4bd93efbc8ce58fafe59ca8e58ebbe4b8ade5bf83e58c96e7bd91e7bb9ce4b8ade78bace7ab8be8bf90e8a18ce38081e5ada6e4b9a0e4b88ee5889be980a0e38082e9a1b9e79baee5b086e9809ae8bf872044414f20e6b2bbe79086e5ae9ee78eb0e7a4bee58cbae585b1e5bbbae585b1e6b2bbefbc8ce585b1e4baabe794b120414920e9a9b1e58aa8e79a84e697a0e99990e5889be980a0e58a9be3808244444fefbc8ce4b88de58faae698afe4b880e4b8aae58d8fe8aeaeefbc8ce69bb4e698afe699bae883bde4b88ee4bbb7e580bce89e8de59088e79a84e696b0e697b6e4bba3e8b5b7e782b9e38082", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lxtry1211.s3.us-west-1.amazonaws.com/ddo_coin1_network.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

