module 0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco {
    struct TACO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TACO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TACO>>(0x2::coin::mint<TACO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TACO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TACO>(arg0, 9, 0x1::string::utf8(b"TACO"), 0x1::string::utf8(b"TACO"), 0x1::string::utf8(b"TACO is the native token of taco protocol"), 0x1::string::utf8(b"https://example.com/taco.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TACO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TACO>>(0x2::coin_registry::finalize<TACO>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

