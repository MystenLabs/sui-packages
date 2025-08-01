module 0x2a4860dfa01949c0518022b0ef127dcd86481242d7217db299aceb6becb61046::fofar {
    struct FOFAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOFAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOFAR>(arg0, 6, b"FOFAR", b"Fofar Coin", b"Fofar first appeared in Matt Furie's Boy's Club, giving Landwolf explicit details about his personal body art.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaxxw5wbok7ow63dn7xirblqfc5ap2wbhewehr3fojuhtlh5bgcau")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOFAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FOFAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

