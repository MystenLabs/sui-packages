module 0xa9b62e57fb4bd9da59b1b22531d1182b48c7d0832cbb9ead0640655523184a3e::blop {
    struct BLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOP>(arg0, 6, b"BLOP", b"Blop", b"just a curious lil blop lurking on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blop_coin_856658ce8a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

