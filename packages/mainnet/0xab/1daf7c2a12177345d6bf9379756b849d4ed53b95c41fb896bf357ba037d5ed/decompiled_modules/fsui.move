module 0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui {
    struct FSUI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FSUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FSUI>>(0x2::coin::mint<FSUI>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: FSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FSUI>(arg0, 9, 0x1::string::utf8(b"SUI"), 0x1::string::utf8(b"FSUI Coin"), 0x1::string::utf8(b"FSUI Coin (Mock Coin For Testnet) For EVA Protocol"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FSUI>>(0x2::coin_registry::finalize<FSUI>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun register(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<FSUI>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<FSUI>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

