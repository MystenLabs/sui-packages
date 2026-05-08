module 0xd1ca19606862f109f2976318f086f70b4d6692e30348aae9d610bdbb2a429e73::dsdad {
    struct DSDAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSDAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSDAD>(arg0, 6, b"DSDAD", b"aaaaaaaaa", b"AAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiffctnrlk3cnhzdi7eywfxmsns4ac46w2om4xd5lyfhu632itf5ky")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSDAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DSDAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

