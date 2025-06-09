module 0x5a30355471c51a35809c5d7bedf7102f430be506cef12d9510c8c0d336604a05::poopy {
    struct POOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOPY>(arg0, 9, b"poop", b"poopy", b"poop it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/1922eafc-f2ef-4f0c-843f-6d2dd4cccf93.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POOPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

