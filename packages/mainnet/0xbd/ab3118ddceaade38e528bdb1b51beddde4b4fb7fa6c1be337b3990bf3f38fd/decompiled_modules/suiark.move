module 0xbdab3118ddceaade38e528bdb1b51beddde4b4fb7fa6c1be337b3990bf3f38fd::suiark {
    struct SUIARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIARK>(arg0, 6, b"SUIARK", b"Zoroark On Sui", b"Zoroark On Sui make SUIARK pokemon game great again on Sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifxlhjrape5mhygglgyswsketljaz4egubeeiyek4zy5b4jkfdsju")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIARK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

