module 0x117927c04faffcb30b9f71fc7cbbf239828e269b0e9f05ac032c4de8b7557f04::hammy {
    struct HAMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMMY>(arg0, 6, b"HAMMY", b"HAMMY the HAMSTER", b"His name is Hammy, spelled any way he doesn't care, He used to be a hair model but he went bald at 17 and now he is retired.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic67c7w6klfs3mr37xxjexs6yve7tnnwjhjfdqylapbqjt3ykdoy4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAMMY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

