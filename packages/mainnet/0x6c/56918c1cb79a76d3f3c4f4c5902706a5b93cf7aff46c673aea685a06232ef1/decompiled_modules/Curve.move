module 0x6c56918c1cb79a76d3f3c4f4c5902706a5b93cf7aff46c673aea685a06232ef1::Curve {
    struct CURVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CURVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CURVE>(arg0, 9, b"CURVE", b"Curve", b"hello coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1867707152384557056/OC193jSQ_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CURVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CURVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

