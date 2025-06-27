module 0xb500760004acc014bd5d919a52e4b9e9bc854086813bb48f5452e1171981a61b::ultra_minimal_atomic_arbitrage {
    public entry fun arb_extreme_minimal(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, 1, arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg1));
    }

    public entry fun arb_proof_of_concept_ultra_minimal(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0, 0x2::coin::value<0x2::sui::SUI>(&arg0) / 1000, arg1);
        0x2::coin::join<0x2::sui::SUI>(&mut v0, arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun arb_sui_usdc_sui_ultra_minimal(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1001);
        let v1 = v0 * 25 / 1000 * 40;
        assert!(v1 > v0, 1002);
        let v2 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v1 - v0, arg1);
        0x2::coin::join<0x2::sui::SUI>(&mut v2, arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

