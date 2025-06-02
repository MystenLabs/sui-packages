module 0xc1f9a268ac3a40aa8d3b9a5ebcadafd5f6e5fbf829eeeeb7bb9b7e6cebabac3::coin {
    fun mint(arg0: &mut 0x2::coin::TreasuryCap<0x2b8b8a0142ee8b8f62dbb487c2590fd14a91ebd381513f5daf0a8d3648b75940::USDC::USDC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2b8b8a0142ee8b8f62dbb487c2590fd14a91ebd381513f5daf0a8d3648b75940::USDC::USDC>>(0x2::coin::mint<0x2b8b8a0142ee8b8f62dbb487c2590fd14a91ebd381513f5daf0a8d3648b75940::USDC::USDC>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun mint_1000(arg0: &mut 0x2::coin::TreasuryCap<0x2b8b8a0142ee8b8f62dbb487c2590fd14a91ebd381513f5daf0a8d3648b75940::USDC::USDC>, arg1: &mut 0x2::tx_context::TxContext) {
        mint(arg0, 1000000000, arg1);
    }

    public entry fun mint_1_000_000(arg0: &mut 0x2::coin::TreasuryCap<0x2b8b8a0142ee8b8f62dbb487c2590fd14a91ebd381513f5daf0a8d3648b75940::USDC::USDC>, arg1: &mut 0x2::tx_context::TxContext) {
        mint(arg0, 1000000000000, arg1);
    }

    public entry fun mint_1_000_000_000(arg0: &mut 0x2::coin::TreasuryCap<0x2b8b8a0142ee8b8f62dbb487c2590fd14a91ebd381513f5daf0a8d3648b75940::USDC::USDC>, arg1: &mut 0x2::tx_context::TxContext) {
        mint(arg0, 1000000000000000, arg1);
    }

    // decompiled from Move bytecode v6
}

