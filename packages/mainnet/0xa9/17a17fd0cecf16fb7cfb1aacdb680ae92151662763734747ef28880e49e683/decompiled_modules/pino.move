module 0xa917a17fd0cecf16fb7cfb1aacdb680ae92151662763734747ef28880e49e683::pino {
    struct PINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINO>(arg0, 6, b"PINO", b"Puno", b"$PINO is a memecoin with the most eccentric style, has a contemporary haircut and a style model that is a role model for other memecoin generations.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058020_78374c1ac8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

