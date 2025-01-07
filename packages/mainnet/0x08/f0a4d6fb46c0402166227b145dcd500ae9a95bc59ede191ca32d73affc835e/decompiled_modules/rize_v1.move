module 0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::rize_v1 {
    struct RizeV1 has key {
        id: 0x2::object::UID,
        withdraw: bool,
    }

    struct RIZE_V1 has drop {
        dummy_field: bool,
    }

    public fun admin_withdraw_balance<T0>(arg0: &RizeV1, arg1: &mut 0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::vault::Vault, arg2: &0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::role::RoleConfig, arg3: u64, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert_withdraw_enabled(arg0);
        0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::role::only_admin(arg2, arg4);
        0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::vault::take_balance<T0>(arg1, arg3)
    }

    public entry fun admin_withdraw_balance_entry<T0>(arg0: &RizeV1, arg1: &mut 0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::vault::Vault, arg2: &0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::role::RoleConfig, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(admin_withdraw_balance<T0>(arg0, arg1, arg2, arg3, arg4), arg4), 0x2::tx_context::sender(arg4));
    }

    public fun admin_withdraw_object<T0: copy + drop + store, T1: store + key>(arg0: &RizeV1, arg1: &mut 0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::vault::Vault, arg2: &0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::role::RoleConfig, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) : T1 {
        assert_withdraw_enabled(arg0);
        0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::role::only_admin(arg2, arg4);
        0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::vault::take_object<T0, T1>(arg1, arg3)
    }

    public entry fun admin_withdraw_object_entry<T0: copy + drop + store, T1: store + key>(arg0: &RizeV1, arg1: &mut 0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::vault::Vault, arg2: &0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::role::RoleConfig, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = admin_withdraw_object<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<T1>(v0, 0x2::tx_context::sender(arg4));
    }

    fun assert_withdraw_enabled(arg0: &RizeV1) {
        assert!(is_withdraw_enabled(arg0), 1);
    }

    fun init(arg0: RIZE_V1, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<RIZE_V1>(&arg0), 0);
        let v0 = RizeV1{
            id       : 0x2::object::new(arg1),
            withdraw : false,
        };
        0x2::transfer::share_object<RizeV1>(v0);
    }

    fun is_withdraw_enabled(arg0: &RizeV1) : bool {
        arg0.withdraw
    }

    public fun navi_balance(arg0: &0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::vault::Vault, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: u8) : (u256, u256) {
        0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::navi::balance(arg0, arg1, arg2)
    }

    public fun navi_claim<T0>(arg0: &mut 0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::vault::Vault, arg1: &0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::role::RoleConfig, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::role::only_operator(arg1, arg8);
        0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::vault::put_balance<T0>(arg0, 0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::navi::claim_reward<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7), arg8);
    }

    public fun navi_deposit<T0>(arg0: &mut 0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::vault::Vault, arg1: &0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::role::RoleConfig, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0x2::tx_context::TxContext) {
        0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::role::only_operator(arg1, arg9);
        0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::navi::deposit<T0>(arg0, arg2, arg3, arg4, arg5, 0x2::coin::from_balance<T0>(0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::vault::take_balance<T0>(arg0, arg6), arg9), arg7, arg8);
    }

    public fun navi_setup(arg0: &mut 0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::vault::Vault, arg1: &0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::role::RoleConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::role::only_operator(arg1, arg2);
        0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::navi::setup(arg0, arg2);
    }

    public fun navi_withdraw<T0>(arg0: &mut 0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::vault::Vault, arg1: &0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::role::RoleConfig, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: u64, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0x2::tx_context::TxContext) {
        0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::role::only_operator(arg1, arg10);
        0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::vault::put_balance<T0>(arg0, 0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::navi::withdraw<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), arg10);
    }

    public fun receive_coins<T0>(arg0: &mut RizeV1, arg1: &mut 0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::vault::Vault, arg2: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&arg2)) {
            0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::vault::put_balance<T0>(arg1, 0x2::coin::into_balance<T0>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, 0x1::vector::pop_back<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&mut arg2))), arg3);
            v0 = v0 + 1;
        };
    }

    public entry fun setWithdraw(arg0: &mut RizeV1, arg1: &0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::role::RoleConfig, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        0x8f0a4d6fb46c0402166227b145dcd500ae9a95bc59ede191ca32d73affc835e::role::only_admin(arg1, arg3);
        arg0.withdraw = arg2;
    }

    // decompiled from Move bytecode v6
}

