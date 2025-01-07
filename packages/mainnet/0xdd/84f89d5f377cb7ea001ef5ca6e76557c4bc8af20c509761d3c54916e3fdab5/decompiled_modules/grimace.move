module 0xdd84f89d5f377cb7ea001ef5ca6e76557c4bc8af20c509761d3c54916e3fdab5::grimace {
    struct GRIMACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRIMACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRIMACE>(arg0, 6, b"GRIMACE", b"Grimace on Sui", b"Grimace is a character of McDonald, a purple, chubby monster with a large mouth and two small hands.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1_300x300_5ee4784c7e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRIMACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRIMACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

