module 0x4563a00a8d0085b308ea61c2d8072ba4db92dbcc897588b8c0f8146ec3276e79::luffycoin {
    struct LUFFYCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUFFYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUFFYCOIN>(arg0, 6, b"LUFFYCOIN", b"LUFFY", b"LUFFYCOIN - The Future Pirate King of Memecoins. No devil fruits, just real Degens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic7mfsbrhft6it4qnefctt6m4jz5zouo2h4wwnlpqpjczruw3t4be")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUFFYCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUFFYCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

