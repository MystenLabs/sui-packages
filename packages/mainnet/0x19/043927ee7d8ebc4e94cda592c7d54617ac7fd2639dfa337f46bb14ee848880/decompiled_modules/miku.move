module 0x19043927ee7d8ebc4e94cda592c7d54617ac7fd2639dfa337f46bb14ee848880::miku {
    struct MIKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKU>(arg0, 6, b"MIKU", b"Little Miku", b"First ever MIKU on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifgvnvzxjqcuvah5q7wh6dtr5jtj5p46i557dhrbnqnmbkzbvifly")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MIKU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

