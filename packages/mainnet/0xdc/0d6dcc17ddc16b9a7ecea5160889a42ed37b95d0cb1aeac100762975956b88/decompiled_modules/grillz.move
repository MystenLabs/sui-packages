module 0xdc0d6dcc17ddc16b9a7ecea5160889a42ed37b95d0cb1aeac100762975956b88::grillz {
    struct GRILLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRILLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRILLZ>(arg0, 6, b"Grillz", x"4772696c6c696e67e280992026204368696c6c696ee28099", x"4772696c6c696ee280992026204368696c6c696ee280992062616279", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732219430500.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRILLZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRILLZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

