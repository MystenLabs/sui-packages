module 0x467e4f4642c56c51c382f362c4f00a6550903a04bdfe680daef6db048fde1b30::magi {
    struct MAGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGI>(arg0, 6, b"MAGI", b"MAGIKARP", b"Magikarp, a famously useless Pokemon. Only capable of flopping and splashing. This behavior prompted degens to undertake research into it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidfwdsmqsvtkexlxdcqfhitomru5y3gyretj4iy7rqxewe5okfwti")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAGI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

