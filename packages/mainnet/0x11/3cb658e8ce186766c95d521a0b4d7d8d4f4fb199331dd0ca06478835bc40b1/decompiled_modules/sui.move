module 0x113cb658e8ce186766c95d521a0b4d7d8d4f4fb199331dd0ca06478835bc40b1::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 6, b"SUI", b"Sui", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

