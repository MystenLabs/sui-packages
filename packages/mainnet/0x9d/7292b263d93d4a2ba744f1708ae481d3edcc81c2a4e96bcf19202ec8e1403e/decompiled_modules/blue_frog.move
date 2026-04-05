module 0x9d7292b263d93d4a2ba744f1708ae481d3edcc81c2a4e96bcf19202ec8e1403e::blue_frog {
    struct BLUE_FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE_FROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE_FROG>(arg0, 9, b"BLUE FROG", b"Blue Frog", b"just a frog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775350265083-213a3784e0eecceadd56b03a5468ad33.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BLUE_FROG>>(0x2::coin::mint<BLUE_FROG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUE_FROG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE_FROG>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

