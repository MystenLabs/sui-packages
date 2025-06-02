module 0x95e4f1724c7385cfb620f6c231118fdc2bae3671516ffec432fdd6995841a45e::coin {
    fun mint(arg0: &mut 0x2::coin::TreasuryCap<0xd7ebb02b871ae89f8fd7949388527ded3c49605f962515b0705e6bdbe5caf2ce::USDC::USDC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd7ebb02b871ae89f8fd7949388527ded3c49605f962515b0705e6bdbe5caf2ce::USDC::USDC>>(0x2::coin::mint<0xd7ebb02b871ae89f8fd7949388527ded3c49605f962515b0705e6bdbe5caf2ce::USDC::USDC>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun mint_1000(arg0: &mut 0x2::coin::TreasuryCap<0xd7ebb02b871ae89f8fd7949388527ded3c49605f962515b0705e6bdbe5caf2ce::USDC::USDC>, arg1: &mut 0x2::tx_context::TxContext) {
        mint(arg0, 1000000000, arg1);
    }

    public entry fun mint_1_000_000(arg0: &mut 0x2::coin::TreasuryCap<0xd7ebb02b871ae89f8fd7949388527ded3c49605f962515b0705e6bdbe5caf2ce::USDC::USDC>, arg1: &mut 0x2::tx_context::TxContext) {
        mint(arg0, 1000000000000, arg1);
    }

    public entry fun mint_1_000_000_000(arg0: &mut 0x2::coin::TreasuryCap<0xd7ebb02b871ae89f8fd7949388527ded3c49605f962515b0705e6bdbe5caf2ce::USDC::USDC>, arg1: &mut 0x2::tx_context::TxContext) {
        mint(arg0, 1000000000000000, arg1);
    }

    // decompiled from Move bytecode v6
}

