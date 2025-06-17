module 0xaea3ca006371cdcb240159c0aeced8ff9dbc540af1afba733e45dbb7f8be6ff::sumo {
    struct SUMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMO>(arg0, 6, b"SuMo", b"Crazy Sui Monsters", b"The first family of crazy monsters devouring memecoins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihk2mx5ubu3cegzmz3h7aixsiznznjmstwvxuad65efremkbsjuwy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUMO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

