module 0x764ddf846fe13616f6d7a60ac1da321b53129d7cc88ad1bcc4ac0b71f7ecc868::lesgold {
    struct LESGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LESGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LESGOLD>(arg0, 6, b"LESGOLD", b"LES GOLD", b"Just Les from Hardcore Pawn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeig6vfuuamumqnirxgvc3khtprje5t4ji6szruoys2yfkgn4wy3wlm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LESGOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LESGOLD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

