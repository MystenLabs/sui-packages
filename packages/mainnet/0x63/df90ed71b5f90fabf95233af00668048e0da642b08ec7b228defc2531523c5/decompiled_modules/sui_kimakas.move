module 0x63df90ed71b5f90fabf95233af00668048e0da642b08ec7b228defc2531523c5::sui_kimakas {
    struct SUI_KIMAKAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_KIMAKAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_KIMAKAS>(arg0, 6, b"SUIKIMAKAS", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_KIMAKAS>>(v1);
        0x2::coin::mint_and_transfer<SUI_KIMAKAS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_KIMAKAS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

