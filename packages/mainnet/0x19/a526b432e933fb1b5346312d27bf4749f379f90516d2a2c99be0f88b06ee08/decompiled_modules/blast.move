module 0x19a526b432e933fb1b5346312d27bf4749f379f90516d2a2c99be0f88b06ee08::blast {
    struct BLAST has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BLAST>, arg1: 0x2::coin::Coin<BLAST>) : u64 {
        0x2::coin::burn<BLAST>(arg0, arg1)
    }

    fun init(arg0: BLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BLAST>(arg0, 9, 0x1::string::utf8(b"BLAST"), 0x1::string::utf8(b"BLAST"), 0x1::string::utf8(b"BLAST: a fungible token on Sui"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BLAST>>(0x2::coin_registry::finalize<BLAST>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BLAST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        0x2::coin::mint_and_transfer<BLAST>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

