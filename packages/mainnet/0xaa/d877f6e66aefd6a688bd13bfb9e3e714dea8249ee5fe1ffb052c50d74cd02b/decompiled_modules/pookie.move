module 0xaad877f6e66aefd6a688bd13bfb9e3e714dea8249ee5fe1ffb052c50d74cd02b::pookie {
    struct POOKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOKIE>(arg0, 6, b"POOKIE", b"POOKIE CAT", b"This fluffy little trader lives for memecoins, chasing charts and pouncing on moonshots all day long. With paws on the keyboard and eyes on the prize, $POOKIE brings charm, chaos, and community to the crypto game. Join the purr-fect journey to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieaznusokp57mt6b6jzlttronqvssuola7yhkwrbws5pwcj2owxna")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOKIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POOKIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

