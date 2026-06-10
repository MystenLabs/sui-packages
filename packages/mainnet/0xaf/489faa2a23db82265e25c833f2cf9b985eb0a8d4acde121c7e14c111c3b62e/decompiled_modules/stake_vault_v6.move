module 0xaf489faa2a23db82265e25c833f2cf9b985eb0a8d4acde121c7e14c111c3b62e::stake_vault_v6 {
    struct VaultV6 has key {
        id: 0x2::object::UID,
        ha_balance: 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>,
        total_principal: u64,
        pending_rewards: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct VaultV6AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakeReceiptV6 has store, key {
        id: 0x2::object::UID,
        owner: address,
        principal_mist: u64,
        deposit_ts_ms: u64,
    }

    struct StakedV6 has copy, drop {
        owner: address,
        principal_mist: u64,
        ha_locked: u64,
        ts_ms: u64,
        receipt_id: 0x2::object::ID,
    }

    struct UnstakedV6 has copy, drop {
        owner: address,
        principal_mist: u64,
        ha_released: u64,
        ts_ms: u64,
    }

    struct HarvestedV6 has copy, drop {
        surplus_ha: u64,
        rate_scaled: u64,
        total_principal: u64,
        ts_ms: u64,
    }

    struct RewardsDepositedV6 has copy, drop {
        amount_mist: u64,
        ts_ms: u64,
    }

    public entry fun deposit_rewards(arg0: &mut VaultV6, arg1: &VaultV6AdminCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pending_rewards, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v0 = RewardsDepositedV6{
            amount_mist : 0x2::coin::value<0x2::sui::SUI>(&arg2),
            ts_ms       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RewardsDepositedV6>(v0);
    }

    fun ha_for_sui_ceil(arg0: u64, arg1: u128) : u64 {
        ((((arg0 as u128) * 1000000 + arg1 - 1) / arg1) as u64)
    }

    public fun ha_held(arg0: &VaultV6) : u64 {
        0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg0.ha_balance)
    }

    public entry fun harvest(arg0: &mut VaultV6, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &VaultV6AdminCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = rate_scaled(arg1);
        let v1 = required_ha(arg0.total_principal, v0);
        let v2 = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg0.ha_balance);
        assert!(v2 > v1, 3);
        let v3 = v2 - v1;
        assert!(v3 >= 10000000, 3);
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::interface::request_unstake_delay(arg1, arg3, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0x2::balance::split<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.ha_balance, v3), arg4), arg4);
        assert!(0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg0.ha_balance) >= ha_for_sui_ceil(arg0.total_principal, v0), 5);
        let v4 = HarvestedV6{
            surplus_ha      : v3,
            rate_scaled     : (v0 as u64),
            total_principal : arg0.total_principal,
            ts_ms           : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<HarvestedV6>(v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultV6{
            id              : 0x2::object::new(arg0),
            ha_balance      : 0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(),
            total_principal : 0,
            pending_rewards : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<VaultV6>(v0);
        let v1 = VaultV6AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<VaultV6AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun pending_rewards_value(arg0: &VaultV6) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pending_rewards)
    }

    fun rate_scaled(arg0: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u128 {
        let v0 = (0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg0) as u128);
        assert!(v0 >= 1000000, 4);
        v0
    }

    public fun receipt_owner(arg0: &StakeReceiptV6) : address {
        arg0.owner
    }

    public fun receipt_principal(arg0: &StakeReceiptV6) : u64 {
        arg0.principal_mist
    }

    public entry fun request_unstake(arg0: &mut VaultV6, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: StakeReceiptV6, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg2.owner == v0, 1);
        let StakeReceiptV6 {
            id             : v1,
            owner          : _,
            principal_mist : v3,
            deposit_ts_ms  : _,
        } = arg2;
        0x2::object::delete(v1);
        let v5 = ha_for_sui_ceil(v3, rate_scaled(arg1));
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::interface::request_unstake_delay(arg1, arg3, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0x2::balance::split<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.ha_balance, v5), arg4), arg4);
        arg0.total_principal = arg0.total_principal - v3;
        let v6 = UnstakedV6{
            owner          : v0,
            principal_mist : v3,
            ha_released    : v5,
            ts_ms          : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<UnstakedV6>(v6);
    }

    fun required_ha(arg0: u64, arg1: u128) : u64 {
        ((((ha_for_sui_ceil(arg0, arg1) as u128) * (10000 + 10) + 9999) / 10000) as u64)
    }

    public entry fun stake(arg0: &mut VaultV6, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 >= 1000000000, 2);
        let v1 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_stake_coin(arg1, arg2, arg3, @0x0, arg5);
        0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.ha_balance, 0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v1));
        arg0.total_principal = arg0.total_principal + v0;
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = StakeReceiptV6{
            id             : 0x2::object::new(arg5),
            owner          : v2,
            principal_mist : v0,
            deposit_ts_ms  : v3,
        };
        0x2::transfer::transfer<StakeReceiptV6>(v4, v2);
        let v5 = StakedV6{
            owner          : v2,
            principal_mist : v0,
            ha_locked      : 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v1),
            ts_ms          : v3,
            receipt_id     : 0x2::object::id<StakeReceiptV6>(&v4),
        };
        0x2::event::emit<StakedV6>(v5);
    }

    public fun total_principal(arg0: &VaultV6) : u64 {
        arg0.total_principal
    }

    public fun withdraw_rewards(arg0: &mut VaultV6, arg1: &VaultV6AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pending_rewards, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

