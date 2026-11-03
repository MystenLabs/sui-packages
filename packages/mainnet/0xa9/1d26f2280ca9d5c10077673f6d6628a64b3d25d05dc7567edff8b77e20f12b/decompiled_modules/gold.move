module 0xa91d26f2280ca9d5c10077673f6d6628a64b3d25d05dc7567edff8b77e20f12b::gold {
    struct GOLD has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<GOLD>, arg1: 0x2::coin::Coin<GOLD>) {
        0x2::coin::burn<GOLD>(arg0, arg1);
    }

    fun init(arg0: GOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLD>(arg0, 9, b"GOLD", b"NFC", b"GOLDNFC (GOLD) token on Sui. Buy, trade, and sell responsibly. COPYRIGHTS AND TRADEMARKS ALL PROPERTY OF THEIR RESPECTIVE OWNERS. 2026-2096", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiactotu5ocflitrra6kqssfmkfx2rjuvkuadpqujzvt2itkgi33he")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLD>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GOLD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GOLD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

