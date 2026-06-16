module 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault {
    struct DistributionTier has copy, drop, store {
        distributed_at_ms: u64,
        interval_ms: u64,
        reward_share: u64,
        accumulated: u64,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        index: u64,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        accumulated_fee: 0x2::balance::Balance<T0>,
        shares: 0x2::table::Table<address, u64>,
        total_shares: u64,
        accumulated_yield: u64,
        checkpointed_f_balance: u64,
        asset: u8,
        storage_id: 0x2::object::ID,
        underlying_decimals: u8,
        min_deposit: u64,
        withdraw_fee: u64,
        last_rate: u64,
        distribution_tiers: vector<DistributionTier>,
        current_round: u64,
    }

    public fun id<T0>(arg0: &Vault<T0>) : 0x2::object::ID {
        0x2::object::id<Vault<T0>>(arg0)
    }

    public(friend) fun new<T0>(arg0: u64, arg1: u8, arg2: 0x2::object::ID, arg3: u8, arg4: u64, arg5: u64, arg6: vector<DistributionTier>, arg7: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : Vault<T0> {
        Vault<T0>{
            id                     : 0x2::object::new(arg9),
            index                  : arg0,
            account_cap            : arg7,
            accumulated_fee        : 0x2::balance::zero<T0>(),
            shares                 : 0x2::table::new<address, u64>(arg9),
            total_shares           : 0,
            accumulated_yield      : 0,
            checkpointed_f_balance : 0,
            asset                  : arg1,
            storage_id             : arg2,
            underlying_decimals    : arg3,
            min_deposit            : arg4,
            withdraw_fee           : arg5,
            last_rate              : arg8,
            distribution_tiers     : arg6,
            current_round          : 0,
        }
    }

    public fun account_owner<T0>(arg0: &Vault<T0>) : address {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap)
    }

    public fun accumulated_fee_value<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.accumulated_fee)
    }

    public fun accumulated_yield<T0>(arg0: &Vault<T0>) : u64 {
        arg0.accumulated_yield
    }

    public(friend) fun add_checkpointed_f_balance<T0>(arg0: &mut Vault<T0>, arg1: u64) {
        arg0.checkpointed_f_balance = arg0.checkpointed_f_balance + arg1;
    }

    public(friend) fun assert_at_or_above_min_deposit<T0>(arg0: &Vault<T0>, arg1: u64) {
        assert!(arg1 >= arg0.min_deposit, 30);
    }

    public(friend) fun assert_nonzero_amount(arg0: u64) {
        assert!(arg0 > 0, 19);
    }

    public(friend) fun assert_round_matches<T0>(arg0: &Vault<T0>, arg1: u64) {
        assert!(arg0.current_round == arg1, 17);
    }

    public(friend) fun assert_storage<T0>(arg0: &Vault<T0>, arg1: 0x2::object::ID) {
        assert!(arg0.storage_id == arg1, 99);
    }

    public(friend) fun assert_synced<T0>(arg0: &Vault<T0>) {
        assert!(arg0.last_rate > 0, 34);
    }

    public(friend) fun assert_tier_due(arg0: bool) {
        assert!(arg0, 35);
    }

    public fun asset<T0>(arg0: &Vault<T0>) : u8 {
        arg0.asset
    }

    public(friend) fun borrow_account_cap<T0>(arg0: &Vault<T0>) : &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap {
        &arg0.account_cap
    }

    public(friend) fun bump_current_round<T0>(arg0: &mut Vault<T0>) : u64 {
        let v0 = arg0.current_round;
        arg0.current_round = v0 + 1;
        v0
    }

    public(friend) fun checkpoint_yield<T0>(arg0: &mut Vault<T0>, arg1: u64) {
        let v0 = if (arg0.last_rate != 0) {
            if (arg1 > arg0.last_rate) {
                arg0.checkpointed_f_balance > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            arg0.accumulated_yield = arg0.accumulated_yield + (((arg0.checkpointed_f_balance as u128) * ((arg1 - arg0.last_rate) as u128) / (0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::constants::exchange_rate_precision() as u128)) as u64);
        };
        arg0.last_rate = arg1;
    }

    public fun checkpointed_f_balance<T0>(arg0: &Vault<T0>) : u64 {
        arg0.checkpointed_f_balance
    }

    public(friend) fun credit_shares<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(&arg0.shares, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.shares, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.shares, arg1, arg2);
        };
        arg0.total_shares = arg0.total_shares + arg2;
    }

    public fun current_round<T0>(arg0: &Vault<T0>) : u64 {
        arg0.current_round
    }

    public(friend) fun debit_shares<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: u64) {
        assert!(0x2::table::contains<address, u64>(&arg0.shares, arg1), 33);
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.shares, arg1);
        assert!(*v0 >= arg2, 33);
        *v0 = *v0 - arg2;
        if (*v0 == 0) {
            0x2::table::remove<address, u64>(&mut arg0.shares, arg1);
        };
        arg0.total_shares = arg0.total_shares - arg2;
    }

    public fun e_insufficient_shares() : u64 {
        33
    }

    public fun e_invalid_fee() : u64 {
        10
    }

    public fun e_invalid_tier_count() : u64 {
        12
    }

    public fun e_invalid_vault_share() : u64 {
        11
    }

    public fun e_nothing_to_claim() : u64 {
        16
    }

    public fun index<T0>(arg0: &Vault<T0>) : u64 {
        arg0.index
    }

    public(friend) fun join_accumulated_fee<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.accumulated_fee, arg1);
    }

    public fun last_rate<T0>(arg0: &Vault<T0>) : u64 {
        arg0.last_rate
    }

    public fun min_deposit<T0>(arg0: &Vault<T0>) : u64 {
        arg0.min_deposit
    }

    public(friend) fun new_tier(arg0: u64, arg1: u64, arg2: u64) : DistributionTier {
        DistributionTier{
            distributed_at_ms : arg0,
            interval_ms       : arg1,
            reward_share      : arg2,
            accumulated       : 0,
        }
    }

    public(friend) fun return_yield<T0>(arg0: &mut Vault<T0>, arg1: u64) {
        arg0.accumulated_yield = arg0.accumulated_yield + arg1;
    }

    public fun scale_index(arg0: u256) : u64 {
        ((arg0 * (0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::constants::exchange_rate_precision() as u256) / 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray()) as u64)
    }

    public fun select_due_tier_index<T0>(arg0: &Vault<T0>, arg1: u64) : (bool, u64) {
        let v0 = false;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<DistributionTier>(&arg0.distribution_tiers)) {
            let v3 = 0x1::vector::borrow<DistributionTier>(&arg0.distribution_tiers, v2);
            let v4 = if (v3.reward_share != 0) {
                if (v3.interval_ms != 0) {
                    v3.distributed_at_ms <= 18446744073709551615 - v3.interval_ms
                } else {
                    false
                }
            } else {
                false
            };
            if (v4) {
                if (arg1 >= v3.distributed_at_ms + v3.interval_ms) {
                    if (!v0) {
                        v0 = true;
                    };
                };
            };
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public(friend) fun set_last_rate_internal<T0>(arg0: &mut Vault<T0>, arg1: u64) {
        arg0.last_rate = arg1;
    }

    public(friend) fun set_withdraw_fee_internal<T0>(arg0: &mut Vault<T0>, arg1: u64) {
        arg0.withdraw_fee = arg1;
    }

    public(friend) fun settle_due_tier<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0.accumulated_yield;
        arg0.accumulated_yield = 0;
        let v1 = 0x1::vector::length<DistributionTier>(&arg0.distribution_tiers);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            let v4 = 0x1::vector::borrow_mut<DistributionTier>(&mut arg0.distribution_tiers, v3);
            let v5 = if (v3 + 1 == v1) {
                v0
            } else {
                (((v0 as u128) * (v4.reward_share as u128) / (0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::constants::percentage_denominator() as u128)) as u64)
            };
            v0 = v0 - v5;
            if (v3 == arg1) {
                v2 = v4.accumulated + v5;
                v4.accumulated = 0;
                v4.distributed_at_ms = arg2;
            } else {
                v4.accumulated = v4.accumulated + v5;
            };
            v3 = v3 + 1;
        };
        v2
    }

    public(friend) fun share<T0>(arg0: Vault<T0>) {
        0x2::transfer::share_object<Vault<T0>>(arg0);
    }

    public fun shares_of<T0>(arg0: &Vault<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.shares, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.shares, arg1)
        } else {
            0
        }
    }

    public fun storage_id<T0>(arg0: &Vault<T0>) : 0x2::object::ID {
        arg0.storage_id
    }

    public(friend) fun sub_checkpointed_f_balance<T0>(arg0: &mut Vault<T0>, arg1: u64) {
        let v0 = if (arg0.checkpointed_f_balance > arg1) {
            arg0.checkpointed_f_balance - arg1
        } else {
            0
        };
        arg0.checkpointed_f_balance = v0;
    }

    public(friend) fun take_accumulated_fee<T0>(arg0: &mut Vault<T0>) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(&arg0.accumulated_fee) > 0, 16);
        0x2::balance::withdraw_all<T0>(&mut arg0.accumulated_fee)
    }

    public fun tier_count<T0>(arg0: &Vault<T0>) : u64 {
        0x1::vector::length<DistributionTier>(&arg0.distribution_tiers)
    }

    public fun tier_distributed_at_ms<T0>(arg0: &Vault<T0>, arg1: u64) : u64 {
        0x1::vector::borrow<DistributionTier>(&arg0.distribution_tiers, arg1).distributed_at_ms
    }

    public fun tier_interval_ms<T0>(arg0: &Vault<T0>, arg1: u64) : u64 {
        0x1::vector::borrow<DistributionTier>(&arg0.distribution_tiers, arg1).interval_ms
    }

    public fun tier_reward_share<T0>(arg0: &Vault<T0>, arg1: u64) : u64 {
        0x1::vector::borrow<DistributionTier>(&arg0.distribution_tiers, arg1).reward_share
    }

    public fun total_shares<T0>(arg0: &Vault<T0>) : u64 {
        arg0.total_shares
    }

    public fun underlying_decimals<T0>(arg0: &Vault<T0>) : u8 {
        arg0.underlying_decimals
    }

    public(friend) fun validate_asset_coin<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8) {
        assert!(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg0, arg1) == 0x1::type_name::into_string(0x1::type_name::get<T0>()), 36);
    }

    public(friend) fun validate_fee(arg0: u64) {
        assert!(arg0 <= 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::constants::percentage_denominator(), 10);
    }

    public(friend) fun validate_shares_sum(arg0: u64) {
        assert!(arg0 == 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::constants::share_denominator(), 11);
    }

    public(friend) fun validate_tier_count(arg0: u64) {
        assert!(arg0 == 2, 12);
    }

    public fun withdraw_fee<T0>(arg0: &Vault<T0>) : u64 {
        arg0.withdraw_fee
    }

    // decompiled from Move bytecode v7
}

