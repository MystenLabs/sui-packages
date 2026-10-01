module 0xb7a7d2e5009b7d6a3d70442356f8590da945feb12e6338e40da0aaae8e32eea6::uni {
    struct UNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<UNI>(arg0, 6, 0x1::string::utf8(b"UNI"), 0x1::string::utf8(b"Sui Founders Dog"), 0x1::string::utf8(x"4e616d65642061667465722053554920466f756e64657220404576616e77656233e280997320646f6720f09f90be200a4665657320676f20746f206275796261636b2e"), 0x1::string::utf8(b"https://popularsui.xyz/media/591d7abb7cc703e881cdbfe21048dd173172fb31efa73146f060692bf70fb437.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<UNI>>(0x2::coin_registry::finalize<UNI>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

