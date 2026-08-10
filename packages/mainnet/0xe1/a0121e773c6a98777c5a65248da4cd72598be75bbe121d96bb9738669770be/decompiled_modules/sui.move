module 0xe1a0121e773c6a98777c5a65248da4cd72598be75bbe121d96bb9738669770be::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 9, b"SUI", b"Fake SUI (PoC)", b"NOT real SUI. PoC token to test coin-type matching. Type is 0x<pkg>::sui::SUI, not 0x2::sui::SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.invalid/fake-sui")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI>>(0x2::coin::mint<SUI>(&mut v2, 100000000000000, arg1), @0xc6d2c897e88be11bdfc6cc78b3a53d9b9aa76b9741b37a577e5a52c4b5d2d8ab);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

