module 0x7eba74121d6b8aac3c1bb27204bbd9a356db8efec7fc779c93fd3dc740127bac::SPCA {
    struct SPCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPCA>(arg0, 9, b"SPCA", b"SPCA", b"SPCA", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPCA>>(v1);
        0x2::coin::mint_and_transfer<SPCA>(&mut v2, 226600000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SPCA>>(v2);
    }

    // decompiled from Move bytecode v6
}

