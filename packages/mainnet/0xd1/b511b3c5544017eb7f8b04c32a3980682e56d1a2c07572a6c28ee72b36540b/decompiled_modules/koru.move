module 0xd1b511b3c5544017eb7f8b04c32a3980682e56d1a2c07572a6c28ee72b36540b::koru {
    struct KORU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KORU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KORU>(arg0, 6, b"KORU", b"Koru", b"Koru is more than just a meme coin it's a movement on the SUI blockchain designed for fun, community, and innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058289_ab60ac066b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KORU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KORU>>(v1);
    }

    // decompiled from Move bytecode v6
}

