module 0x6ad9db9961ac91045cb6c80107d0a579af98bfcc7f07b860c730f72a95926332::deep {
    struct DEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEP>(arg0, 6, b"DEEP", b"", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://images.deepbook.tech/icon.svg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEEP>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEEP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DEEP>>(v2);
    }

    // decompiled from Move bytecode v6
}

