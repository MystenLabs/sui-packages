module 0xa0d27f556a6842aa7c63c6688a089c2ba83ff1a72463139adfc2a308ebee187e::bch {
    struct BCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCH>(arg0, 6, b"BCH", b"Bitcoin Cash", b"Bitcoin Cash on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_2d72425ca5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

