module 0x457ffea4909043b582bd6b2573c54a04736be3d12e4c5f4c4b16805a04c46118::ttt {
    struct TTT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TTT>, arg1: 0x2::coin::Coin<TTT>) {
        0x2::coin::burn<TTT>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<TTT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TTT> {
        0x2::coin::mint<TTT>(arg0, arg1, arg2)
    }

    fun init(arg0: TTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTT>(arg0, 6, b"TTT", b"TT", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1762099227518vspd.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTT>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<TTT>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TTT> {
        assert!(0x2::coin::total_supply<TTT>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<TTT>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

