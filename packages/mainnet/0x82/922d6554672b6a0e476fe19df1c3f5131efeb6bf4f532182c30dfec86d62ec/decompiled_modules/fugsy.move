module 0x82922d6554672b6a0e476fe19df1c3f5131efeb6bf4f532182c30dfec86d62ec::fugsy {
    struct FUGSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUGSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUGSY>(arg0, 6, b"Fugsy", b"FUGSY", x"486520697320736f20637574652c20686973206d61696e20676f616c20697320746f206d616b6520796f752061206261672c206865206973206865726520746f206275696c642061207374726f6e6720636f6d6d756e69747920616e64206c6561726e2068756d616e73206c616e67756167652c206a756d7020696e206f7572206a6f75726e657920746f206d696c6c696f6e7320616e64204255592e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_0e5b16a19b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUGSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUGSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

