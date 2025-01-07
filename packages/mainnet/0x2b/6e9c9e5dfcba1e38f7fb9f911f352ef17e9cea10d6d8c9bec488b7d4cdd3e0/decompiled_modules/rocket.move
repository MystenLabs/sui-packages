module 0x2b6e9c9e5dfcba1e38f7fb9f911f352ef17e9cea10d6d8c9bec488b7d4cdd3e0::rocket {
    struct ROCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKET>(arg0, 6, b"ROCKET", b"RocketPup", b"RocketPup: Dream, Launch, Win!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240908_132720_3c3ca8d15e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROCKET>>(v1);
    }

    // decompiled from Move bytecode v6
}

