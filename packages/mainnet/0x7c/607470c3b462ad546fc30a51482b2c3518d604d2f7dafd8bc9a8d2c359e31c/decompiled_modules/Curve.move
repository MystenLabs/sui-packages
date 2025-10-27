module 0x7c607470c3b462ad546fc30a51482b2c3518d604d2f7dafd8bc9a8d2c359e31c::Curve {
    struct CURVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CURVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CURVE>(arg0, 9, b"CURVE", b"Curve", b"hello", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1867707152384557056/OC193jSQ_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CURVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CURVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

