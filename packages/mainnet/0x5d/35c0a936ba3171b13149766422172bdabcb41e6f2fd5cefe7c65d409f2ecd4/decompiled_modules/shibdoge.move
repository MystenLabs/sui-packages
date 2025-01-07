module 0x5d35c0a936ba3171b13149766422172bdabcb41e6f2fd5cefe7c65d409f2ecd4::shibdoge {
    struct SHIBDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBDOGE>(arg0, 6, b"SHIBDOGE", b"SHIB DOGE", b"TWO DOGS ARE BETTER THAN ONE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241028_180918_014_f95264d757.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

