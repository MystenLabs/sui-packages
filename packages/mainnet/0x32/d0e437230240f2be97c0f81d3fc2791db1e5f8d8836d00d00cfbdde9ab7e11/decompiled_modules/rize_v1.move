module 0x32d0e437230240f2be97c0f81d3fc2791db1e5f8d8836d00d00cfbdde9ab7e11::rize_v1 {
    struct RizeV1 has key {
        id: 0x2::object::UID,
        withdraw: bool,
    }

    struct RIZE_V1 has drop {
        dummy_field: bool,
    }

    public fun admin_withdraw_balance<T0>(arg0: &RizeV1, arg1: &mut 0x32d0e437230240f2be97c0f81d3fc2791db1e5f8d8836d00d00cfbdde9ab7e11::vault::Vault, arg2: &0x32d0e437230240f2be97c0f81d3fc2791db1e5f8d8836d00d00cfbdde9ab7e11::role::RoleConfig, arg3: u64, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert_withdraw_enabled(arg0);
        0x32d0e437230240f2be97c0f81d3fc2791db1e5f8d8836d00d00cfbdde9ab7e11::role::only_admin(arg2, arg4);
        0x32d0e437230240f2be97c0f81d3fc2791db1e5f8d8836d00d00cfbdde9ab7e11::vault::take_balance<T0>(arg1, arg3)
    }

    public entry fun admin_withdraw_balance_entry<T0>(arg0: &RizeV1, arg1: &mut 0x32d0e437230240f2be97c0f81d3fc2791db1e5f8d8836d00d00cfbdde9ab7e11::vault::Vault, arg2: &0x32d0e437230240f2be97c0f81d3fc2791db1e5f8d8836d00d00cfbdde9ab7e11::role::RoleConfig, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(admin_withdraw_balance<T0>(arg0, arg1, arg2, arg3, arg4), arg4), 0x2::tx_context::sender(arg4));
    }

    public fun admin_withdraw_object<T0: copy + drop + store, T1: store + key>(arg0: &RizeV1, arg1: &mut 0x32d0e437230240f2be97c0f81d3fc2791db1e5f8d8836d00d00cfbdde9ab7e11::vault::Vault, arg2: &0x32d0e437230240f2be97c0f81d3fc2791db1e5f8d8836d00d00cfbdde9ab7e11::role::RoleConfig, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) : T1 {
        assert_withdraw_enabled(arg0);
        0x32d0e437230240f2be97c0f81d3fc2791db1e5f8d8836d00d00cfbdde9ab7e11::role::only_admin(arg2, arg4);
        0x32d0e437230240f2be97c0f81d3fc2791db1e5f8d8836d00d00cfbdde9ab7e11::vault::take_object<T0, T1>(arg1, arg3)
    }

    public entry fun admin_withdraw_object_entry<T0: copy + drop + store, T1: store + key>(arg0: &RizeV1, arg1: &mut 0x32d0e437230240f2be97c0f81d3fc2791db1e5f8d8836d00d00cfbdde9ab7e11::vault::Vault, arg2: &0x32d0e437230240f2be97c0f81d3fc2791db1e5f8d8836d00d00cfbdde9ab7e11::role::RoleConfig, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
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

    public fun receive_coins<T0>(arg0: &mut RizeV1, arg1: &mut 0x32d0e437230240f2be97c0f81d3fc2791db1e5f8d8836d00d00cfbdde9ab7e11::vault::Vault, arg2: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&arg2)) {
            0x32d0e437230240f2be97c0f81d3fc2791db1e5f8d8836d00d00cfbdde9ab7e11::vault::put_balance<T0>(arg1, 0x2::coin::into_balance<T0>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, 0x1::vector::pop_back<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&mut arg2))), arg3);
            v0 = v0 + 1;
        };
    }

    public entry fun setWithdraw(arg0: &mut RizeV1, arg1: &0x32d0e437230240f2be97c0f81d3fc2791db1e5f8d8836d00d00cfbdde9ab7e11::role::RoleConfig, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        0x32d0e437230240f2be97c0f81d3fc2791db1e5f8d8836d00d00cfbdde9ab7e11::role::only_admin(arg1, arg3);
        arg0.withdraw = arg2;
    }

    // decompiled from Move bytecode v6
}

