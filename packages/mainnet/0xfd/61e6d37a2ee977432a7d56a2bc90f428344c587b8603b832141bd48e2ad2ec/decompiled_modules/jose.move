module 0xfd61e6d37a2ee977432a7d56a2bc90f428344c587b8603b832141bd48e2ad2ec::jose {
    struct JOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOSE>(arg0, 6, b"JOSE", b"JOSELITO", b"Joselito the ugly and quirky dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicwrxvvlq4lcgqzh6wqnkuo4te46njrxuedv4gamfjur7icmq7cri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOSE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

