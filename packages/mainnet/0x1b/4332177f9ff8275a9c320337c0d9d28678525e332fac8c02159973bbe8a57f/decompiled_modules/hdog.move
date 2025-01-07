module 0x1b4332177f9ff8275a9c320337c0d9d28678525e332fac8c02159973bbe8a57f::hdog {
    struct HDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDOG>(arg0, 6, b"HDOG", b"HOPDOG", b"Welcome to Hopdog community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730969381915.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

