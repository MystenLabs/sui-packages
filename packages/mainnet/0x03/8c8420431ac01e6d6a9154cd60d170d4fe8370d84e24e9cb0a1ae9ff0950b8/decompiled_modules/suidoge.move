module 0x38c8420431ac01e6d6a9154cd60d170d4fe8370d84e24e9cb0a1ae9ff0950b8::suidoge {
    struct SUIDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOGE>(arg0, 9, b"SuiDOGE", b"Doge On Sui", b"https://telegra.ph/Doge-Coin-On-Sui-10-09", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844150071711203328/hr_qiuC3.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIDOGE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

