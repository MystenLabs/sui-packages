module 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive {
    struct HIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIVE>(arg0, 6, b"HIVE", b"HIVE", x"484956452069732074686520656e6572677920736f7572636520666f7220647261676f6e2d62656573206e617669676174696e6720746865206d7973746963616c20537569207365617320f09f8c8a20f09f8fb4e2808de298a0efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d1sell8jrx8uwy.cloudfront.net/HiveLogo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

