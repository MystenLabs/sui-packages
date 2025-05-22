module 0x301b41ed46f4264da472871ce66c72098c6414567a0392746bafee1e3c45062::pmon {
    struct PMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PMON>(arg0, 6, b"PMON", b"PokeMoni", b"The Power of Pocket Monsters on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia7u4j6xzbew4we437fzufob2xp5hfybrhzisdci3ojaejxusd2f4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

