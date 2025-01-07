module 0xe53f5c67a092ae44c58ac7a92d56467fcf182e3d2645d080aa49c3300b5395ac::SNS {
    struct SNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNS>(arg0, 9, b"NS", b"SuiNS Token", b"The native token for the SuiNS Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://token-image.suins.io/icon.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SNS>>(0x2::coin::mint<SNS>(&mut v2, 500000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SNS>>(v2);
    }

    // decompiled from Move bytecode v6
}

