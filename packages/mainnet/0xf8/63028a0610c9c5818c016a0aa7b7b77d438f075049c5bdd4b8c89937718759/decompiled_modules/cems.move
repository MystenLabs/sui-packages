module 0xf863028a0610c9c5818c016a0aa7b7b77d438f075049c5bdd4b8c89937718759::cems {
    struct CEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEMS>(arg0, 6, b"CEMS", b"CHEEMS SUI", b"just meme cheems", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_8c23eaf3_14f88f78e3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CEMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

