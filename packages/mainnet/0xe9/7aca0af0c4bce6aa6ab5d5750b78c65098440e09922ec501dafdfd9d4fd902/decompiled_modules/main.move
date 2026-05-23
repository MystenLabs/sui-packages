module 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::main {
    struct EstiaPutEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct CashbackToppedEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct VestingClaimedEvent has copy, drop {
        vault: vector<u8>,
        amount: u64,
    }

    public fun cashback(arg0: &mut 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::Central, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA> {
        assert!(0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::version(arg0) == 0, 996);
        assert!(0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::operator(arg0) == 0x2::tx_context::sender(arg2), 200);
        0x2::coin::from_balance<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::split_from_cashback(arg0, arg1), arg2)
    }

    public fun claim_ecosystem_vesting(arg0: &mut 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::Central, arg1: &mut 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::locked_vault::LockedVault, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::version(arg0) == 0, 996);
        assert!(0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::locked_vault::operator(arg1) == 0x2::tx_context::sender(arg3), 200);
        let v0 = 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::locked_vault::take_ecosystem(arg1, arg2);
        let v1 = VestingClaimedEvent{
            vault  : b"ecosystem",
            amount : 0x2::balance::value<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&v0),
        };
        0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::deposit_to_ecosystem(arg0, v0);
        0x2::event::emit<VestingClaimedEvent>(v1);
    }

    public fun claim_incentives_vesting(arg0: &mut 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::Central, arg1: &mut 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::locked_vault::LockedVault, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::version(arg0) == 0, 996);
        assert!(0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::locked_vault::operator(arg1) == 0x2::tx_context::sender(arg3), 200);
        let v0 = 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::locked_vault::take_incentives(arg1, arg2);
        let v1 = VestingClaimedEvent{
            vault  : b"incentives",
            amount : 0x2::balance::value<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&v0),
        };
        0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::deposit_to_incentives(arg0, v0);
        0x2::event::emit<VestingClaimedEvent>(v1);
    }

    public fun claim_team_vesting(arg0: &mut 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::Central, arg1: &mut 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::locked_vault::LockedVault, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::version(arg0) == 0, 996);
        assert!(0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::locked_vault::operator(arg1) == 0x2::tx_context::sender(arg3), 200);
        let v0 = 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::locked_vault::take_team(arg1, arg2);
        let v1 = VestingClaimedEvent{
            vault  : b"team",
            amount : 0x2::balance::value<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&v0),
        };
        0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::deposit_to_team(arg0, v0);
        0x2::event::emit<VestingClaimedEvent>(v1);
    }

    public fun get_estia(arg0: &mut 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::Central, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA> {
        assert!(0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::version(arg0) == 0, 996);
        assert!(0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::operator(arg0) == 0x2::tx_context::sender(arg2), 200);
        0x2::coin::from_balance<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::split_from_main(arg0, arg1), arg2)
    }

    public fun get_from_ecosystem(arg0: &mut 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::Central, arg1: u64, arg2: &0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::admin::AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA> {
        0x2::coin::from_balance<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::take_from_ecosystem(arg0, arg1), arg3)
    }

    public fun get_from_incentives(arg0: &mut 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::Central, arg1: u64, arg2: &0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::admin::AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA> {
        0x2::coin::from_balance<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::take_from_incentives(arg0, arg1), arg3)
    }

    public fun get_from_liquidity(arg0: &mut 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::Central, arg1: u64, arg2: &0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::admin::AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA> {
        0x2::coin::from_balance<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::take_from_liquidity(arg0, arg1), arg3)
    }

    public fun get_from_team(arg0: &mut 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::Central, arg1: u64, arg2: &0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::admin::AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA> {
        0x2::coin::from_balance<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::take_from_team(arg0, arg1), arg3)
    }

    public fun put_estia(arg0: &mut 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::Central, arg1: 0x2::coin::Coin<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>, arg2: &0x2::tx_context::TxContext) {
        assert!(0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::version(arg0) == 0, 996);
        let v0 = EstiaPutEvent{
            user   : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::value<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&arg1),
        };
        0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::deposit_to_main(arg0, 0x2::coin::into_balance<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(arg1));
        0x2::event::emit<EstiaPutEvent>(v0);
    }

    public fun start(arg0: &mut 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::Central, arg1: &mut 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::locked_vault::LockedVault, arg2: &mut 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::presale::PresaleVault, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::admin::AdminCap) {
        assert!(!0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::is_distributed(arg0), 999);
        let v0 = 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::split_from_main(arg0, 83200000000000000);
        let v1 = 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::split_from_main(arg0, 104000000000000000);
        assert!(0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::main_vault_total(arg0) == 0, 998);
        0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::locked_vault::distribute_team(arg1, 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::split_from_main(arg0, 46800000000000000));
        0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::presale::distribute_presale(arg2, 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::split_from_main(arg0, 5200000000000000));
        0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::deposit_to_ecosystem(arg0, 0x2::balance::split<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&mut v0, 2652000000000000));
        0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::deposit_to_incentives(arg0, 0x2::balance::split<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&mut v1, 10400000000000000));
        0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::deposit_to_liquidity(arg0, 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::split_from_main(arg0, 20800000000000000));
        let v2 = (104000000000000000 - 10400000000000000) / 48;
        let v3 = (83200000000000000 - 2652000000000000) / 36;
        0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::deposit_to_cashback(arg0, 0x2::balance::split<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&mut v1, v2));
        0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::deposit_to_ecosystem(arg0, 0x2::balance::split<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&mut v0, v3));
        0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::locked_vault::distribute_ecosystem(arg1, v0);
        0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::locked_vault::distribute_incentives(arg1, v1);
        let v4 = 0x1::vector::empty<u64>();
        let v5 = &mut v4;
        0x1::vector::push_back<u64>(v5, v2);
        0x1::vector::push_back<u64>(v5, v3);
        0x1::vector::push_back<u64>(v5, 46800000000000000 / 36);
        0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::locked_vault::set_data(arg1, v4, vector[1, 1, 0]);
        0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::locked_vault::set_start_date(arg1, arg3, arg4);
        0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::end_distribution(arg0);
    }

    public fun top_up_cashback(arg0: &mut 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::Central, arg1: 0x2::coin::Coin<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>, arg2: &0x2::tx_context::TxContext) {
        assert!(0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::version(arg0) == 0, 996);
        let v0 = CashbackToppedEvent{
            user   : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::value<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(&arg1),
        };
        0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::deposit_to_cashback(arg0, 0x2::coin::into_balance<0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::ESTIA>(arg1));
        0x2::event::emit<CashbackToppedEvent>(v0);
    }

    entry fun upgrade_version(arg0: &mut 0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::Central, arg1: &0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::admin::AdminCap) {
        assert!(0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::version(arg0) < 0, 997);
        0xe97aca0af0c4bce6aa6ab5d5750b78c65098440e09922ec501dafdfd9d4fd902::estia::migrate(arg0, 0);
    }

    // decompiled from Move bytecode v6
}

