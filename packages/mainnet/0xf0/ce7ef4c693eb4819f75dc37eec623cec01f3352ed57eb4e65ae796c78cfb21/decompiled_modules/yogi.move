module 0xf0ce7ef4c693eb4819f75dc37eec623cec01f3352ed57eb4e65ae796c78cfb21::yogi {
    struct YOGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOGI>(arg0, 9, b"YOGI", b"yogi", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YOGI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOGI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

