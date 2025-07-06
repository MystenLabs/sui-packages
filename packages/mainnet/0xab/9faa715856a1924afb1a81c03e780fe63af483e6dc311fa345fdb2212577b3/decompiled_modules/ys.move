module 0xab9faa715856a1924afb1a81c03e780fe63af483e6dc311fa345fdb2212577b3::ys {
    struct YS has drop {
        dummy_field: bool,
    }

    fun init(arg0: YS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YS>(arg0, 6, b"YS", b"Yasuo", b"The best champion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigkyphbkequptq64wih2puhy3lipwhy6mzw22dw7g7tsgikguupoy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

