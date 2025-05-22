module 0xe4f64eb5bb9b498f9c08e67c7e3dfc912774a2fbbb9752b3ad4b0ea5c9b4bad2::doggy {
    struct DOGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGY>(arg0, 6, b"DOGGY", b"Dogy", b"The Techy Meme Dog from the Future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieattprp7r5huele7osjlvpprrwyg5zdbm3jbtptmvqfg3fu7xx4u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGGY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

