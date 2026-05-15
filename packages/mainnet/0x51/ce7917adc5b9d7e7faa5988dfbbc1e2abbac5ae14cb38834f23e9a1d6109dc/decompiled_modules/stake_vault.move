module 0x51ce7917adc5b9d7e7faa5988dfbbc1e2abbac5ae14cb38834f23e9a1d6109dc::stake_vault {
    struct Vault has key {
        id: 0x2::object::UID,
        total_staked: u64,
        pending_yield: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct StakeReceipt has store, key {
        id: 0x2::object::UID,
        owner: address,
        principal_mist: u64,
        deposit_ts_ms: u64,
        unlock_ts_ms: 0x1::option::Option<u64>,
        staked_sui: 0x3::staking_pool::StakedSui,
    }

    struct Deposited has copy, drop {
        staker: address,
        amount_mist: u64,
        receipt_id: 0x2::object::ID,
    }

    struct UnstakeRequested has copy, drop {
        staker: address,
        receipt_id: 0x2::object::ID,
        unlock_ts_ms: u64,
    }

    struct Withdrawn has copy, drop {
        staker: address,
        amount_mist: u64,
    }

    entry fun add_yield(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pending_yield, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    entry fun deposit(arg0: &mut Vault, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 >= 1000000000, 4);
        arg0.total_staked = arg0.total_staked + v0;
        let v1 = StakeReceipt{
            id             : 0x2::object::new(arg4),
            owner          : 0x2::tx_context::sender(arg4),
            principal_mist : v0,
            deposit_ts_ms  : 0x2::clock::timestamp_ms(arg3),
            unlock_ts_ms   : 0x1::option::none<u64>(),
            staked_sui     : 0x3::sui_system::request_add_stake_non_entry(arg1, arg2, @0xa608b66f7ae2201286f7dd07a8b073cde7955b35056629636a6c9b3f5275f384, arg4),
        };
        let v2 = Deposited{
            staker      : 0x2::tx_context::sender(arg4),
            amount_mist : v0,
            receipt_id  : 0x2::object::id<StakeReceipt>(&v1),
        };
        0x2::event::emit<Deposited>(v2);
        0x2::transfer::transfer<StakeReceipt>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun harvest_yield(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pending_yield, 0x2::balance::value<0x2::sui::SUI>(&arg0.pending_yield)), arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id            : 0x2::object::new(arg0),
            total_staked  : 0,
            pending_yield : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public fun pending_yield_amount(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pending_yield)
    }

    public fun receipt_owner(arg0: &StakeReceipt) : address {
        arg0.owner
    }

    public fun receipt_principal(arg0: &StakeReceipt) : u64 {
        arg0.principal_mist
    }

    entry fun request_unstake(arg0: &mut StakeReceipt, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        assert!(0x1::option::is_none<u64>(&arg0.unlock_ts_ms), 3);
        let v0 = 0x2::clock::timestamp_ms(arg1) + 86400000;
        arg0.unlock_ts_ms = 0x1::option::some<u64>(v0);
        let v1 = UnstakeRequested{
            staker       : 0x2::tx_context::sender(arg2),
            receipt_id   : 0x2::object::id<StakeReceipt>(arg0),
            unlock_ts_ms : v0,
        };
        0x2::event::emit<UnstakeRequested>(v1);
    }

    public fun total_staked(arg0: &Vault) : u64 {
        arg0.total_staked
    }

    entry fun withdraw(arg0: &mut Vault, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: StakeReceipt, arg3: &mut 0x51ce7917adc5b9d7e7faa5988dfbbc1e2abbac5ae14cb38834f23e9a1d6109dc::loyalty_tracker::LoyaltyRecord, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.owner == 0x2::tx_context::sender(arg5), 1);
        assert!(0x2::clock::timestamp_ms(arg4) >= *0x1::option::borrow<u64>(&arg2.unlock_ts_ms), 2);
        let StakeReceipt {
            id             : v0,
            owner          : _,
            principal_mist : v2,
            deposit_ts_ms  : _,
            unlock_ts_ms   : _,
            staked_sui     : v5,
        } = arg2;
        0x2::object::delete(v0);
        let v6 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, v5, arg5);
        let v7 = 0x2::balance::value<0x2::sui::SUI>(&v6);
        if (v7 > v2) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.pending_yield, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v7 - v2));
            let v8 = if (arg0.total_staked >= v2) {
                arg0.total_staked - v2
            } else {
                0
            };
            arg0.total_staked = v8;
            0x51ce7917adc5b9d7e7faa5988dfbbc1e2abbac5ae14cb38834f23e9a1d6109dc::loyalty_tracker::reset(arg3, arg4, arg5);
            let v9 = Withdrawn{
                staker      : 0x2::tx_context::sender(arg5),
                amount_mist : v2,
            };
            0x2::event::emit<Withdrawn>(v9);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg5), 0x2::tx_context::sender(arg5));
        } else {
            let v10 = if (arg0.total_staked >= v2) {
                arg0.total_staked - v2
            } else {
                0
            };
            arg0.total_staked = v10;
            0x51ce7917adc5b9d7e7faa5988dfbbc1e2abbac5ae14cb38834f23e9a1d6109dc::loyalty_tracker::reset(arg3, arg4, arg5);
            let v11 = Withdrawn{
                staker      : 0x2::tx_context::sender(arg5),
                amount_mist : v7,
            };
            0x2::event::emit<Withdrawn>(v11);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg5), 0x2::tx_context::sender(arg5));
        };
    }

    // decompiled from Move bytecode v7
}

