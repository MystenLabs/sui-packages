module 0x5ed9b36264cfcb9d5270fb9add7fcf077dacab4292d890d758fb3106272e7d7c::froggy {
    struct FROGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGY>(arg0, 6, b"FROGGY", b"SuiFroggies", b"next memecoin multi bagger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibd3zad4f34sbgreqfaq6qhlgj2vk7glwn6jw26votdbs3g6t6434")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FROGGY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

