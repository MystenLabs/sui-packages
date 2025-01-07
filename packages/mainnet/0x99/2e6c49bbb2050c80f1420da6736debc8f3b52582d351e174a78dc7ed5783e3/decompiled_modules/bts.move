module 0x992e6c49bbb2050c80f1420da6736debc8f3b52582d351e174a78dc7ed5783e3::bts {
    struct BTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTS>(arg0, 6, b"BTS", b"blubiatsu", b"hamster coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_29_18_29_39_bffe1183d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

