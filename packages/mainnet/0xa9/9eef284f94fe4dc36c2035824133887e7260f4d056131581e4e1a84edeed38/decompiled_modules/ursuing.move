module 0xa99eef284f94fe4dc36c2035824133887e7260f4d056131581e4e1a84edeed38::ursuing {
    struct URSUING has drop {
        dummy_field: bool,
    }

    fun init(arg0: URSUING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<URSUING>(arg0, 6, b"URSUING", b"Ursuing on Sui", b"The only bear you'll love in a bear market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeice3mjdysbflz67gnneqt36fiq7dcfh36kfmvo6sb4m2qo4zub3zq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<URSUING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<URSUING>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

