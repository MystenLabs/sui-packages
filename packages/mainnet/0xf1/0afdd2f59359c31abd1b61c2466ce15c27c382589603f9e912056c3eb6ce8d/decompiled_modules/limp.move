module 0xf10afdd2f59359c31abd1b61c2466ce15c27c382589603f9e912056c3eb6ce8d::limp {
    struct LIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIMP>(arg0, 6, b"LIMP", b"LimpDik", x"49742068617070656e7320736d7468696d65732c20646f6e74206265207361642c20776520616c6c20676f2074726f75676874206974206576657279206f6e6e636520696e2061207768696c652e2e0a47657420757273656c6620736f6d65204c696d7044696b20746f6b656e7320746f2063686565722075207570206275642e0a4a6f696e2074686520636f6d6d756e69747920616e64206c65747320676574206861726420746f676574686572206f6e636520616761696e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_219a8eb9af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

