module 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault {
    struct VaultCap has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct Vault<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        vt_treasury_cap: 0x2::coin::TreasuryCap<T2>,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        pool_id: 0x2::object::ID,
        target_leverage: u64,
        a_index: u8,
        b_index: u8,
        withdrawal_fees: u64,
        slippage_up: u128,
        slippage_down: u128,
        collected_fees: 0x2::balance::Balance<T0>,
        swap_routes: 0x2::table::Table<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>,
    }

    public fun a_index<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u8 {
        arg0.a_index
    }

    public(friend) fun account_cap<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap {
        &arg0.account_cap
    }

    public(friend) fun add_swap_route<T0, T1, T2, T3>(arg0: &mut Vault<T0, T1, T2>, arg1: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>) {
        let v0 = 0x1::type_name::get<T3>();
        if (0x2::table::contains<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&arg0.swap_routes, v0)) {
            let v1 = 0x2::table::remove<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&mut arg0.swap_routes, v0);
            while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v1)) {
                let (_, _) = 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::unwrap(0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut v1));
            };
            0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(v1);
        };
        0x2::table::add<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&mut arg0.swap_routes, v0, arg1);
    }

    public(friend) fun assert_vault_cap<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &VaultCap) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1, T2>>(arg0), 0);
    }

    public fun b_index<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u8 {
        arg0.b_index
    }

    public(friend) fun burn_vt<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>) {
        0x2::coin::burn<T2>(&mut arg0.vt_treasury_cap, arg1);
    }

    public(friend) fun collect_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.collected_fees, arg1);
    }

    public(friend) fun deposit<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<T0>(arg9, arg3, arg4, arg0.a_index, arg1, arg6, arg7, &arg0.account_cap);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::borrow_with_account_cap<T1>(arg9, arg8, arg3, arg5, arg0.b_index, arg2, arg7, &arg0.account_cap)
    }

    public fun fee_scaling() : u64 {
        1000000
    }

    public fun get_swap_route<T0, T1, T2, T3>(arg0: &Vault<T0, T1, T2>) : vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value> {
        *0x2::table::borrow<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(&arg0.swap_routes, 0x1::type_name::get<T3>())
    }

    public fun info<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : (u64, u64) {
        (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg1, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg3, arg0.a_index, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap)) as u64)), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T1>(arg2, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg3, arg0.b_index, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap)) as u64)))
    }

    public(friend) fun initialize<T0, T1, T2>(arg0: 0x2::coin::TreasuryCap<T2>, arg1: 0x2::object::ID, arg2: u64, arg3: u8, arg4: u8, arg5: u128, arg6: u128, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Vault<T0, T1, T2>{
            id              : 0x2::object::new(arg8),
            vt_treasury_cap : arg0,
            account_cap     : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg8),
            pool_id         : arg1,
            target_leverage : arg2,
            a_index         : arg3,
            b_index         : arg4,
            withdrawal_fees : arg7,
            slippage_up     : arg5,
            slippage_down   : arg6,
            collected_fees  : 0x2::balance::zero<T0>(),
            swap_routes     : 0x2::table::new<0x1::type_name::TypeName, vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>>(arg8),
        };
        let v1 = 0x2::object::id<Vault<T0, T1, T2>>(&v0);
        let v2 = VaultCap{
            id       : 0x2::object::new(arg8),
            vault_id : v1,
        };
        0x2::transfer::share_object<Vault<T0, T1, T2>>(v0);
        0x2::transfer::transfer<VaultCap>(v2, 0x2::tx_context::sender(arg8));
        v1
    }

    public fun leverage<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        arg0.target_leverage
    }

    public fun leverage_scaling() : u64 {
        1000000
    }

    public(friend) fun mint_vt<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x2::coin::mint<T2>(&mut arg0.vt_treasury_cap, arg1, arg2)
    }

    public fun pool_id<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun slippage<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : (u128, u128) {
        (arg0.slippage_up, arg0.slippage_down)
    }

    public fun slippage_scaling() : u128 {
        18446744073709551616
    }

    public fun total_vt_supply<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::coin::total_supply<T2>(&arg0.vt_treasury_cap)
    }

    public(friend) fun update_withdrawal_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) {
        arg0.withdrawal_fees = arg1;
    }

    public(friend) fun withdraw<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::balance::destroy_zero<T1>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::repay_with_account_cap<T1>(arg9, arg8, arg3, arg5, arg0.b_index, arg1, arg7, &arg0.account_cap));
        0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<T0>(arg9, arg8, arg3, arg4, arg0.a_index, arg2, arg6, arg7, &arg0.account_cap), arg10)
    }

    public(friend) fun withdraw_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.collected_fees, arg1)
    }

    public fun withdrawal_fees<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : (u64, u64) {
        (arg0.withdrawal_fees, 1000000)
    }

    // decompiled from Move bytecode v6
}

