module 0x3d3dc872c6f62b344ab182810b6ec4b04bac1d9b1b1572867f9002a7e4d2edde::vesting {
    struct VESTING has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
        deploy_fee: u64,
    }

    struct VestingVault<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        beneficiary: address,
        balance: 0x2::balance::Balance<T0>,
        total_locked: u64,
        claimed: u64,
        cliff_ts_ms: u64,
        cliff_bps: u64,
        linear_start_ms: u64,
        linear_end_ms: u64,
        created_at_ms: u64,
    }

    struct MultiVestingVault<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        balance: 0x2::balance::Balance<T0>,
        total_locked: u64,
        shares: 0x2::vec_map::VecMap<address, u64>,
        claimed: 0x2::vec_map::VecMap<address, u64>,
        cliff_ts_ms: u64,
        cliff_bps: u64,
        linear_start_ms: u64,
        linear_end_ms: u64,
        created_at_ms: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: address,
        creator: address,
        beneficiary: address,
        total_locked: u64,
        cliff_ts_ms: u64,
        cliff_bps: u64,
        linear_start_ms: u64,
        linear_end_ms: u64,
    }

    struct TokensClaimed has copy, drop {
        vault_id: address,
        beneficiary: address,
        amount: u64,
        total_claimed: u64,
    }

    struct FeeUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
    }

    struct MultiVaultCreated has copy, drop {
        vault_id: address,
        creator: address,
        total_locked: u64,
        beneficiary_count: u64,
        cliff_ts_ms: u64,
        cliff_bps: u64,
        linear_start_ms: u64,
        linear_end_ms: u64,
    }

    struct MultiBeneficiaryAdded has copy, drop {
        vault_id: address,
        beneficiary: address,
        share_bps: u64,
        token_amount: u64,
    }

    struct MultiTokensClaimed has copy, drop {
        vault_id: address,
        beneficiary: address,
        amount: u64,
        total_claimed_by_beneficiary: u64,
    }

    public fun beneficiary<T0>(arg0: &VestingVault<T0>) : address {
        arg0.beneficiary
    }

    public fun claim<T0>(arg0: &mut VestingVault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 0);
        let v0 = compute_claimable_internal<T0>(arg0, 0x2::clock::timestamp_ms(arg1));
        assert!(v0 > 0, 2);
        arg0.claimed = arg0.claimed + v0;
        let v1 = TokensClaimed{
            vault_id      : 0x2::object::uid_to_address(&arg0.id),
            beneficiary   : 0x2::tx_context::sender(arg2),
            amount        : v0,
            total_claimed : arg0.claimed,
        };
        0x2::event::emit<TokensClaimed>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun claim_multi<T0>(arg0: &mut MultiVestingVault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_map::contains<address, u64>(&arg0.shares, &v0), 11);
        let v1 = *0x2::vec_map::get<address, u64>(&arg0.claimed, &v0);
        let v2 = (((compute_vested_total(arg0.total_locked, arg0.cliff_ts_ms, arg0.cliff_bps, arg0.linear_start_ms, arg0.linear_end_ms, 0x2::clock::timestamp_ms(arg1)) as u128) * (*0x2::vec_map::get<address, u64>(&arg0.shares, &v0) as u128) / (10000 as u128)) as u64);
        assert!(v2 > v1, 2);
        let v3 = v2 - v1;
        *0x2::vec_map::get_mut<address, u64>(&mut arg0.claimed, &v0) = v1 + v3;
        let v4 = MultiTokensClaimed{
            vault_id                     : 0x2::object::uid_to_address(&arg0.id),
            beneficiary                  : v0,
            amount                       : v3,
            total_claimed_by_beneficiary : v1 + v3,
        };
        0x2::event::emit<MultiTokensClaimed>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v3), arg2), v0);
    }

    public fun claimable<T0>(arg0: &VestingVault<T0>, arg1: &0x2::clock::Clock) : u64 {
        compute_claimable_internal<T0>(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    public fun claimable_multi<T0>(arg0: &MultiVestingVault<T0>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        if (!0x2::vec_map::contains<address, u64>(&arg0.shares, &arg1)) {
            return 0
        };
        let v0 = *0x2::vec_map::get<address, u64>(&arg0.claimed, &arg1);
        let v1 = (((compute_vested_total(arg0.total_locked, arg0.cliff_ts_ms, arg0.cliff_bps, arg0.linear_start_ms, arg0.linear_end_ms, 0x2::clock::timestamp_ms(arg2)) as u128) * (*0x2::vec_map::get<address, u64>(&arg0.shares, &arg1) as u128) / (10000 as u128)) as u64);
        if (v1 > v0) {
            v1 - v0
        } else {
            0
        }
    }

    public fun claimed<T0>(arg0: &VestingVault<T0>) : u64 {
        arg0.claimed
    }

    fun compute_claimable_internal<T0>(arg0: &VestingVault<T0>, arg1: u64) : u64 {
        let v0 = compute_vested_total(arg0.total_locked, arg0.cliff_ts_ms, arg0.cliff_bps, arg0.linear_start_ms, arg0.linear_end_ms, arg1);
        if (v0 > arg0.claimed) {
            v0 - arg0.claimed
        } else {
            0
        }
    }

    fun compute_vested_total(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = 0;
        let v1 = v0;
        let v2 = (((arg0 as u128) * (arg2 as u128) / (10000 as u128)) as u64);
        let v3 = if (v2 > 0) {
            if (arg1 > 0) {
                arg5 >= arg1
            } else {
                false
            }
        } else {
            false
        };
        if (v3) {
            v1 = v0 + v2;
        };
        let v4 = arg0 - v2;
        if (v4 > 0) {
            if (arg3 == arg4) {
                if (arg5 >= arg3) {
                    v1 = v1 + v4;
                };
            } else if (arg5 >= arg4) {
                v1 = v1 + v4;
            } else if (arg5 > arg3) {
                v1 = v1 + (((v4 as u128) * ((arg5 - arg3) as u128) / ((arg4 - arg3) as u128)) as u64);
            };
        };
        if (v1 > arg0) {
            arg0
        } else {
            v1
        }
    }

    public fun create_multi_vault<T0>(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<T0>, arg3: vector<address>, arg4: vector<u64>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.deploy_fee, 4);
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 > 0, 13);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 3);
        assert!((v0 as u64) <= 20, 9);
        let v1 = 0x2::vec_map::empty<address, u64>();
        let v2 = 0x2::vec_map::empty<address, u64>();
        let v3 = 0;
        let v4 = 0;
        while (v4 < v0) {
            let v5 = *0x1::vector::borrow<address>(&arg3, v4);
            let v6 = *0x1::vector::borrow<u64>(&arg4, v4);
            assert!(!0x2::vec_map::contains<address, u64>(&v1, &v5), 12);
            0x2::vec_map::insert<address, u64>(&mut v1, v5, v6);
            0x2::vec_map::insert<address, u64>(&mut v2, v5, 0);
            v3 = v3 + v6;
            v4 = v4 + 1;
        };
        assert!(v3 == 10000, 10);
        assert!(arg6 <= 10000, 3);
        assert!(arg8 >= arg7, 6);
        let v7 = 0x2::coin::value<T0>(&arg2);
        assert!(v7 > 0, 7);
        if (arg5 > 0 && arg6 < 10000) {
            assert!(arg7 >= arg5, 6);
        };
        let v8 = 0x2::clock::timestamp_ms(arg9);
        let v9 = if (arg6 == 10000) {
            arg5
        } else {
            arg8
        };
        assert!(v9 > v8, 8);
        let v10 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::split<0x2::sui::SUI>(&mut v10, arg0.deploy_fee));
        if (0x2::balance::value<0x2::sui::SUI>(&v10) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v10, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v10);
        };
        let v11 = 0x2::object::new(arg10);
        let v12 = 0x2::object::uid_to_address(&v11);
        let v13 = MultiVaultCreated{
            vault_id          : v12,
            creator           : 0x2::tx_context::sender(arg10),
            total_locked      : v7,
            beneficiary_count : (v0 as u64),
            cliff_ts_ms       : arg5,
            cliff_bps         : arg6,
            linear_start_ms   : arg7,
            linear_end_ms     : arg8,
        };
        0x2::event::emit<MultiVaultCreated>(v13);
        let v14 = 0;
        while (v14 < v0) {
            let v15 = *0x1::vector::borrow<u64>(&arg4, v14);
            let v16 = MultiBeneficiaryAdded{
                vault_id     : v12,
                beneficiary  : *0x1::vector::borrow<address>(&arg3, v14),
                share_bps    : v15,
                token_amount : (((v7 as u128) * (v15 as u128) / (10000 as u128)) as u64),
            };
            0x2::event::emit<MultiBeneficiaryAdded>(v16);
            v14 = v14 + 1;
        };
        let v17 = MultiVestingVault<T0>{
            id              : v11,
            creator         : 0x2::tx_context::sender(arg10),
            balance         : 0x2::coin::into_balance<T0>(arg2),
            total_locked    : v7,
            shares          : v1,
            claimed         : v2,
            cliff_ts_ms     : arg5,
            cliff_bps       : arg6,
            linear_start_ms : arg7,
            linear_end_ms   : arg8,
            created_at_ms   : v8,
        };
        0x2::transfer::share_object<MultiVestingVault<T0>>(v17);
    }

    public fun create_vault<T0>(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.deploy_fee, 4);
        assert!(arg5 <= 10000, 3);
        assert!(arg7 >= arg6, 6);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 7);
        if (arg4 > 0 && arg5 < 10000) {
            assert!(arg6 >= arg4, 6);
        };
        let v1 = 0x2::clock::timestamp_ms(arg8);
        let v2 = if (arg5 == 10000) {
            arg4
        } else {
            arg7
        };
        assert!(v2 > v1, 8);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::split<0x2::sui::SUI>(&mut v3, arg0.deploy_fee));
        if (0x2::balance::value<0x2::sui::SUI>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg9), 0x2::tx_context::sender(arg9));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
        };
        let v4 = 0x2::object::new(arg9);
        let v5 = VestingVault<T0>{
            id              : v4,
            creator         : 0x2::tx_context::sender(arg9),
            beneficiary     : arg3,
            balance         : 0x2::coin::into_balance<T0>(arg2),
            total_locked    : v0,
            claimed         : 0,
            cliff_ts_ms     : arg4,
            cliff_bps       : arg5,
            linear_start_ms : arg6,
            linear_end_ms   : arg7,
            created_at_ms   : v1,
        };
        let v6 = VaultCreated{
            vault_id        : 0x2::object::uid_to_address(&v4),
            creator         : 0x2::tx_context::sender(arg9),
            beneficiary     : arg3,
            total_locked    : v0,
            cliff_ts_ms     : arg4,
            cliff_bps       : arg5,
            linear_start_ms : arg6,
            linear_end_ms   : arg7,
        };
        0x2::event::emit<VaultCreated>(v6);
        0x2::transfer::share_object<VestingVault<T0>>(v5);
    }

    public fun creator<T0>(arg0: &VestingVault<T0>) : address {
        arg0.creator
    }

    public fun deploy_fee(arg0: &Treasury) : u64 {
        arg0.deploy_fee
    }

    fun init(arg0: VESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        let v2 = Treasury{
            id         : 0x2::object::new(arg1),
            balance    : 0x2::balance::zero<0x2::sui::SUI>(),
            admin      : v0,
            deploy_fee : 10000000000,
        };
        0x2::transfer::share_object<Treasury>(v2);
    }

    public fun multi_beneficiary_count<T0>(arg0: &MultiVestingVault<T0>) : u64 {
        0x2::vec_map::length<address, u64>(&arg0.shares)
    }

    public fun multi_creator<T0>(arg0: &MultiVestingVault<T0>) : address {
        arg0.creator
    }

    public fun multi_remaining_balance<T0>(arg0: &MultiVestingVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun multi_total_locked<T0>(arg0: &MultiVestingVault<T0>) : u64 {
        arg0.total_locked
    }

    public fun remaining_balance<T0>(arg0: &VestingVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun total_locked<T0>(arg0: &VestingVault<T0>) : u64 {
        arg0.total_locked
    }

    public fun transfer_admin(arg0: AdminCap, arg1: &mut Treasury, arg2: address) {
        arg1.admin = arg2;
        0x2::transfer::public_transfer<AdminCap>(arg0, arg2);
    }

    public fun update_deploy_fee(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64) {
        arg1.deploy_fee = arg2;
        let v0 = FeeUpdated{
            old_fee : arg1.deploy_fee,
            new_fee : arg2,
        };
        0x2::event::emit<FeeUpdated>(v0);
    }

    public fun withdraw_fees(arg0: &AdminCap, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v0), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    // decompiled from Move bytecode v7
}

