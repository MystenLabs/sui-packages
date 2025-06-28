module 0xf138c2711c34da4c1185c265fdacd33f9ce04a9e2c8f3fef6bdcb912d33a171a::Black_Box {
    struct BLACK_BOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACK_BOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACK_BOX>(arg0, 9, b"BBOX", b"Black Box", b"what's in the black box?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/9a00cfeb-6707-47f5-a46a-5f4031dfaba9.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLACK_BOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACK_BOX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

