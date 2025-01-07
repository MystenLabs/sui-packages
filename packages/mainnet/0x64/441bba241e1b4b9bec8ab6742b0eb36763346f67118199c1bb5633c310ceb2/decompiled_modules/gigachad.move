module 0x64441bba241e1b4b9bec8ab6742b0eb36763346f67118199c1bb5633c310ceb2::gigachad {
    struct GIGACHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGACHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGACHAD>(arg0, 6, b"GIGACHAD", b"GIGA", b"The perfect body that leads mankind to defeat alien invaders", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giga_732f26fd47.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGACHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIGACHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

