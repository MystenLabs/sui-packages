module 0x55ac115b4b679af2115c76a1a7fdf8901049beb3372360b98ca1a28558b737b6::sui_dog {
    struct SUI_DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_DOG>(arg0, 6, b"SUIDOG", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_DOG>>(v1);
        0x2::coin::mint_and_transfer<SUI_DOG>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_DOG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

