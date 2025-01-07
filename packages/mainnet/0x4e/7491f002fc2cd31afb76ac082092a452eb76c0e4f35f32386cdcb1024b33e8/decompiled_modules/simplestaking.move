module 0x4e7491f002fc2cd31afb76ac082092a452eb76c0e4f35f32386cdcb1024b33e8::simplestaking {
    struct TokensStaked has copy, drop {
        user: address,
        amount: u64,
    }

    struct TokensUnstaked has copy, drop {
        user: address,
        amount: u64,
    }

    struct StakingProfile<phantom T0> has key {
        id: 0x2::object::UID,
        user: address,
        balance: 0x2::balance::Balance<T0>,
    }

    public entry fun create_staking_profile<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingProfile<T0>{
            id      : 0x2::object::new(arg0),
            user    : 0x2::tx_context::sender(arg0),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::transfer<StakingProfile<T0>>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun stake_coins<T0>(arg0: &mut StakingProfile<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64) {
        assert!(arg2 > 0, 1);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg1), arg2));
        let v0 = TokensStaked{
            user   : arg0.user,
            amount : arg2,
        };
        0x2::event::emit<TokensStaked>(v0);
    }

    public entry fun unstake_coins<T0>(arg0: &mut StakingProfile<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64) {
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg2, 2);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg1), arg2));
        let v0 = TokensUnstaked{
            user   : arg0.user,
            amount : arg2,
        };
        0x2::event::emit<TokensUnstaked>(v0);
    }

    // decompiled from Move bytecode v6
}

