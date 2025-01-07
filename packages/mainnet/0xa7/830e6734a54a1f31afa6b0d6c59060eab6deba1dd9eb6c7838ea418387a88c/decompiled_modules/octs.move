module 0xa7830e6734a54a1f31afa6b0d6c59060eab6deba1dd9eb6c7838ea418387a88c::octs {
    struct OCTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTS>(arg0, 6, b"OCTS", b"octopuses", b"Dance with the octopus.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_2da4ad7c8e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

