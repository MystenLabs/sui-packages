module 0x40ddb0c249211e69210814191d17f9018880b0b3a34d82d6188507334a3b2ba::wolf {
    struct WOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLF>(arg0, 6, b"WOLF", b"Land Wolf On Sui", b"The Ultimate WOLF Experience On Sui | So Good! - Landwolf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGOWEB_768x768_efc924c29a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

