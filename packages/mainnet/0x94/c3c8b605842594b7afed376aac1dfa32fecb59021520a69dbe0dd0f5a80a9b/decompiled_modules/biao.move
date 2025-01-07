module 0x94c3c8b605842594b7afed376aac1dfa32fecb59021520a69dbe0dd0f5a80a9b::biao {
    struct BIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIAO>(arg0, 6, b"BIAO", b"SuiBiaoQing", x"4d656574204269616f71696e672050616e64612c20746865206d6f73742066616d6f757320415349414e204d454d455321210a0a4269616f71696e6720697320746865206d6f73742066616d6f75732070616e646120696e2074686520776f726c6420616e64207468652074727565204f47206f6620415349414e204d454d45532e204269616f71696e67206973207468652050657065206f6620454153542c20616e642068652773206e6f7720726561647920746f20636f6e71756572207468652053554920626c6f636b636861696e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Picsart_24_10_08_02_56_21_578_12c54d5724.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

