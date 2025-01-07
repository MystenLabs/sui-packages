module 0xdc2cc74dc1180532aaa831d6957da0bf4e34f68ead15a3391f5d88856eb13d08::ppuff {
    struct PPUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPUFF>(arg0, 6, b"PPUFF", b"PPPUFFSUI", b"just puff fish like pepe face in middle ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Diseno_sin_titulo_4eeee_8a609c6fa4_8ea4ff8705.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

