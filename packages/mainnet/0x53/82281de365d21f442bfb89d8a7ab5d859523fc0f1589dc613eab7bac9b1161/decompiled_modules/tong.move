module 0x5382281de365d21f442bfb89d8a7ab5d859523fc0f1589dc613eab7bac9b1161::tong {
    struct TONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONG>(arg0, 6, b"TONG", b"TongTong", x"546f6e67546f6e672028544f4e472920e698af537569e7bd91e7bb9ce4b88ae9a696e4b8aa4149e9a9b1e58aa8e79a84e58ebbe4b8ade5bf83e58c96e4bba3e5b881efbc8ce781b5e6849fe6ba90e887aae585a8e79083e9809ae794a8e4babae5b7a5e699bae883bde4bd93e2809ce9809ae9809ae2809de38082e68891e4bbace8bf9ee68ea54149e7ae97e58a9be38081e695b0e68daee5b882e59cbae5928c4e4654e5889be4bd9cefbc8ce68993e980a0e5bc80e694bee79a84576562332b4149e7949fe68081e38082e588a9e794a8537569e79a84e9ab98e5909ee59090e9878fe5928ce4bd8ee68890e69cacefbc8c544f4e47e8b58be883bde5bc80e58f91e88085e4b88ee794a8e688b7efbc8ce5bc80e590afe58886e5b883e5bc8f4149e99da9e591bde38082e68c81e69c89544f4e47efbc8ce58f82e4b88e44414fe6b2bbe79086efbc8ce585b1e4baab4149e69caae69da5efbc81e7ab8be58db3e58aa0e585a5efbc8ce782b9e78783e699bae883bde696b0e697b6e4bba3e38082", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750325076288.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TONG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

