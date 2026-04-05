module 0x95cc791ce3fa71fff9d034344d0900f149ca4ec1ca018f2e39cbb7f61debae5d::lady {
    struct LADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LADY>(arg0, 6, b"LADY", b"Lady On SUI", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LADY>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LADY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LADY>>(v2);
    }

    // decompiled from Move bytecode v6
}

