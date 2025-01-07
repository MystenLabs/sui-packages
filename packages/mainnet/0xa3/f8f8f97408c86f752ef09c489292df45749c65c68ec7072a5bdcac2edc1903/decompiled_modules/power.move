module 0xa3f8f8f97408c86f752ef09c489292df45749c65c68ec7072a5bdcac2edc1903::power {
    struct POWER has drop {
        dummy_field: bool,
    }

    fun init(arg0: POWER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POWER>(arg0, 6, b"POWER", b"American Power", b"With Trump at the helm, America will reclaim its strength, restoring the nation's power on the global stage. He will make America great again, driven by unwavering leadership and bold vision", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trump_70c1943ddd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POWER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POWER>>(v1);
    }

    // decompiled from Move bytecode v6
}

