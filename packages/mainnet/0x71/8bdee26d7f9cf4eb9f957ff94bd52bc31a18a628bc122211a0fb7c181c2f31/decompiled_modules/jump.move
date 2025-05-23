module 0x718bdee26d7f9cf4eb9f957ff94bd52bc31a18a628bc122211a0fb7c181c2f31::jump {
    struct JUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUMP>(arg0, 6, b"JUMP", b"SUI JUMP", b"The first online sui game, earn as you jump, eat as you have fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigjteaqugy6cnbcalvcivgatwbrg6zyxqsnvm7gq4kal7gawiug34")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JUMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

