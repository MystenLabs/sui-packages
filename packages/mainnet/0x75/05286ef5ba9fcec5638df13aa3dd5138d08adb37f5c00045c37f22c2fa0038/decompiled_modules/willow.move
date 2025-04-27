module 0x7505286ef5ba9fcec5638df13aa3dd5138d08adb37f5c00045c37f22c2fa0038::willow {
    struct WILLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILLOW>(arg0, 6, b"WILLOW", b"WILLOW ON SUI", b"WILLOW, New Dapp on sui chain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/willow_820ec8d23d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILLOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

