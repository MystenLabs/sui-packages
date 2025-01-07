module 0xc76e053ac3522bae52ba64648fac8e05d3a52fa999eff40adab31449734e6c43::musktaaaaaard {
    struct MUSKTAAAAAARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSKTAAAAAARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSKTAAAAAARD>(arg0, 6, b"MUSKTAAAAAARD", b"Musktaaaaaard", b"Musktaaaaaard!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002565_1ddf256c07.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSKTAAAAAARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSKTAAAAAARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

