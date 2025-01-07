module 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault {
    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        vt_treasury_cap: 0x2::coin::TreasuryCap<T1>,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        depost_asset_index: u8,
        withdrawal_fees: u64,
        performance_fees: u64,
        deposits_enabled: bool,
        deposit_limit: u64,
        seed_vt: 0x2::balance::Balance<T1>,
        collected_withdrawal_fees: 0x2::balance::Balance<T0>,
        collected_performance_fees: 0x2::balance::Balance<T0>,
        swap_routes: 0x2::table::Table<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>,
    }

    public(friend) fun new<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::coin::TreasuryCap<T1>, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Vault<T0, T1>{
            id                         : 0x2::object::new(arg13),
            vt_treasury_cap            : arg1,
            account_cap                : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg13),
            depost_asset_index         : arg2,
            withdrawal_fees            : arg3,
            performance_fees           : arg4,
            deposits_enabled           : true,
            deposit_limit              : arg5,
            seed_vt                    : 0x2::balance::zero<T1>(),
            collected_withdrawal_fees  : 0x2::balance::zero<T0>(),
            collected_performance_fees : 0x2::balance::zero<T0>(),
            swap_routes                : 0x2::table::new<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(arg13),
        };
        deposit<T0, T1>(&v0, arg0, arg8, arg9, arg10, arg11, arg12, arg13);
        0x2::balance::join<T1>(&mut v0.seed_vt, 0x2::coin::into_balance<T1>(0x2::coin::mint<T1>(&mut v0.vt_treasury_cap, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::utils::safe_mul_div(0x2::balance::value<T0>(&arg0), 0x1::u64::pow(10, arg7), 0x1::u64::pow(10, arg6)), arg13)));
        0x2::transfer::share_object<Vault<T0, T1>>(v0);
        0x2::object::id<Vault<T0, T1>>(&v0)
    }

    public(friend) fun account_cap<T0, T1>(arg0: &Vault<T0, T1>) : &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap {
        &arg0.account_cap
    }

    public(friend) fun add_swap_route<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>) {
        let v0 = 0x1::type_name::get<T2>();
        if (0x2::table::contains<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&arg0.swap_routes, v0)) {
            let v1 = 0x2::table::remove<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&mut arg0.swap_routes, v0);
            while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v1)) {
                let (_, _) = 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::unwrap(0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut v1));
            };
            0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(v1);
        };
        0x2::table::add<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&mut arg0.swap_routes, v0, arg1);
    }

    public(friend) fun assert_deposits_enabled<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64) {
        assert!(arg0.deposits_enabled && arg1 < arg0.deposit_limit, 0);
    }

    public(friend) fun burn_vt<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::coin::burn<T1>(&mut arg0.vt_treasury_cap, arg1);
    }

    public(friend) fun claim_rewards<T0, T1, T2>(arg0: &Vault<T0, T1>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T2>, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T2>(arg4, arg2, arg3, arg1, arg0.depost_asset_index, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::option_supply(), account_cap<T0, T1>(arg0))
    }

    public(friend) fun collect_performance_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.collected_performance_fees, arg1);
    }

    public(friend) fun collect_withdrawal_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.collected_withdrawal_fees, arg1);
    }

    public(friend) fun deposit<T0, T1>(arg0: &Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = deposited<T0, T1>(arg0, arg3, arg2);
        assert_deposits_enabled<T0, T1>(arg0, v0);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<T0>(arg6, arg2, arg3, arg0.depost_asset_index, 0x2::coin::from_balance<T0>(arg1, arg7), arg4, arg5, account_cap<T0, T1>(arg0));
    }

    public fun deposit_asset_index<T0, T1>(arg0: &Vault<T0, T1>) : u8 {
        arg0.depost_asset_index
    }

    public fun deposited<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : u64 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg1, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg2, arg0.depost_asset_index, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap)) as u64))
    }

    public fun fee_scaling() : u64 {
        1000000
    }

    public fun get_swap_route<T0, T1, T2>(arg0: &Vault<T0, T1>) : vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value> {
        *0x2::table::borrow<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&arg0.swap_routes, 0x1::type_name::get<T2>())
    }

    public(friend) fun mint_vt<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::mint<T1>(&mut arg0.vt_treasury_cap, arg1, arg2)
    }

    public fun performance_fees<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64) {
        (arg0.performance_fees, 1000000)
    }

    public(friend) fun remove_swap_route<T0, T1, T2>(arg0: &mut Vault<T0, T1>) {
        let v0 = 0x1::type_name::get<T2>();
        if (0x2::table::contains<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&arg0.swap_routes, v0)) {
            let v1 = 0x2::table::remove<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&mut arg0.swap_routes, v0);
            while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v1)) {
                let (_, _) = 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::unwrap(0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut v1));
            };
            0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(v1);
        };
    }

    public(friend) fun set_deposit_limit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        arg0.deposit_limit = arg1;
    }

    public(friend) fun set_deposits_enabled<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: bool) {
        arg0.deposits_enabled = arg1;
    }

    public(friend) fun set_performance_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        arg0.performance_fees = arg1;
    }

    public(friend) fun set_withdrawal_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        arg0.withdrawal_fees = arg1;
    }

    public fun total_vt_supply<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::coin::total_supply<T1>(&arg0.vt_treasury_cap)
    }

    public(friend) fun withdraw<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<T0>(arg7, arg6, arg2, arg3, arg0.depost_asset_index, arg1, arg4, arg5, account_cap<T0, T1>(arg0))
    }

    public(friend) fun withdraw_performance_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.collected_performance_fees, arg1)
    }

    public(friend) fun withdraw_withdrawal_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.collected_withdrawal_fees, arg1)
    }

    public fun withdrawal_fees<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64) {
        (arg0.withdrawal_fees, 1000000)
    }

    // decompiled from Move bytecode v6
}

