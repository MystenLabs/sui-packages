module 0x706943bcc39046ba3334f95cc814d43b8e5f67c3b4b99794143dd1fadaebf6ef::something {
    struct SOMETHING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOMETHING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 6;
        let (v1, v2, v3) = 0x2::coin::create_regulated_currency_v2<SOMETHING>(arg0, v0, b"SOMETHING", b"", b"", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v4 = v1;
        0x2::coin::mint_and_transfer<SOMETHING>(&mut v4, 1000000000 * 0x1::u64::pow(10, v0), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SOMETHING>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOMETHING>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SOMETHING>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

