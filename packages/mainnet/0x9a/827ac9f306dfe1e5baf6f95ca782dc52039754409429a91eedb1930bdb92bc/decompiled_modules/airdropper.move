module 0x9a827ac9f306dfe1e5baf6f95ca782dc52039754409429a91eedb1930bdb92bc::airdropper {
    struct TokensAirdropped has copy, drop {
        destination: address,
        amount: u64,
    }

    public entry fun med_airdrop_tokens_multi_destination<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<u64>(&arg2, v1);
            let v3 = 0x1::vector::borrow<address>(&arg1, v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(0x2::coin::balance_mut<T0>(arg0), *v2, arg3), *v3);
            let v4 = TokensAirdropped{
                destination : *v3,
                amount      : *v2,
            };
            0x2::event::emit<TokensAirdropped>(v4);
            v1 = v1 + 1;
        };
    }

    public entry fun med_airdrop_tokens_single_destination<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::take<T0>(0x2::coin::balance_mut<T0>(arg0), arg2, arg3);
        let v1 = TokensAirdropped{
            destination : arg1,
            amount      : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<TokensAirdropped>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg1);
    }

    public entry fun sui_airdrop_tokens_multi_destination(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<u64>(&arg2, v1);
            let v3 = 0x1::vector::borrow<address>(&arg1, v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg0), *v2, arg3), *v3);
            let v4 = TokensAirdropped{
                destination : *v3,
                amount      : *v2,
            };
            0x2::event::emit<TokensAirdropped>(v4);
            v1 = v1 + 1;
        };
    }

    public entry fun sui_airdrop_tokens_single_destination(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::take<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg0), arg2, arg3);
        let v1 = TokensAirdropped{
            destination : arg1,
            amount      : 0x2::coin::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<TokensAirdropped>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

