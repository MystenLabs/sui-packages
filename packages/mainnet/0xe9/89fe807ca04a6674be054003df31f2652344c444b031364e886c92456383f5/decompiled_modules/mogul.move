module 0xe989fe807ca04a6674be054003df31f2652344c444b031364e886c92456383f5::mogul {
    struct MOGUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOGUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOGUL>(arg0, 6, b"Mogul", b"Mogul Coin", b"In game currency for The Fantasy League for Hollywood.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicjtxx6dmjj5me365e35eokkl66fviugwkf2aez2qeioe6zurnfcm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOGUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOGUL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

