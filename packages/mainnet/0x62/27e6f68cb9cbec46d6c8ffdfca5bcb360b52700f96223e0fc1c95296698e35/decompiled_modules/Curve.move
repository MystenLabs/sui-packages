module 0x6227e6f68cb9cbec46d6c8ffdfca5bcb360b52700f96223e0fc1c95296698e35::Curve {
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

