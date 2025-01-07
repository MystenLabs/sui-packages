module 0x13a847fe43b2bb5fa82da0356ec0b9af98881482febc64f9045325dd5bf49a31::ricky {
    struct RICKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICKY>(arg0, 6, b"RICKY", b"RICKY THE PENGUIN", x"484f4c44204f4e544f20594f55522053434152465320414e442048415453204445415220534e4f5720524944455253212042454341555345205249434b59204953204845524520544f20524f434b205355492057495448205452554520534e4f5759204d4f4f4e53484f5420504f54454e5449414c210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2975_977051a2cf_08d4ee1b5e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

