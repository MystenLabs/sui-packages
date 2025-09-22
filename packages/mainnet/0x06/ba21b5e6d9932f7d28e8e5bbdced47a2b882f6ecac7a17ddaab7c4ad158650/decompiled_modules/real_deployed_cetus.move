module 0x6ba21b5e6d9932f7d28e8e5bbdced47a2b882f6ecac7a17ddaab7c4ad158650::real_deployed_cetus {
    struct FeeCollectorConfig has store, key {
        id: 0x2::object::UID,
        admin: address,
        burn_percentage: u64,
        marketing_percentage: u64,
        reflection_percentage: u64,
        marketing_wallet: address,
        reflection_wallet: address,
    }

    public fun call_deployed_cetus_collect_fee<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        execute_deployed_cetus_call<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public entry fun collect_and_distribute_from_deployed_cetus<T0, T1>(arg0: &FeeCollectorConfig, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.burn_percentage + arg0.marketing_percentage + arg0.reflection_percentage == 100, 0);
        let (v0, v1) = call_deployed_cetus_collect_fee<T0, T1>(arg1, arg2, arg3, arg4);
        let v2 = 0x2::coin::from_balance<T0>(v0, arg4);
        let v3 = 0x2::coin::from_balance<T1>(v1, arg4);
        if (0x2::coin::value<T0>(&v2) > 0) {
            distribute_token<T0>(v2, arg0, arg4);
        } else {
            0x2::coin::destroy_zero<T0>(v2);
        };
        if (0x2::coin::value<T1>(&v3) > 0) {
            distribute_token<T1>(v3, arg0, arg4);
        } else {
            0x2::coin::destroy_zero<T1>(v3);
        };
    }

    public entry fun collect_from_pool_script<T0, T1>(arg0: &FeeCollectorConfig, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = pool_script_collect_fee<T0, T1>(arg1, arg2, arg3, arg4);
        distribute_collected_balances<T0, T1>(arg0, v0, v1, arg4);
    }

    public fun distribute_collected_balances<T0, T1>(arg0: &FeeCollectorConfig, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T0>(arg1, arg3);
        let v1 = 0x2::coin::from_balance<T1>(arg2, arg3);
        if (0x2::coin::value<T0>(&v0) > 0) {
            distribute_token<T0>(v0, arg0, arg3);
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        if (0x2::coin::value<T1>(&v1) > 0) {
            distribute_token<T1>(v1, arg0, arg3);
        } else {
            0x2::coin::destroy_zero<T1>(v1);
        };
    }

    public entry fun distribute_deployed_contract_fees<T0, T1>(arg0: &FeeCollectorConfig, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg1) > 0) {
            distribute_token<T0>(arg1, arg0, arg3);
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
        if (0x2::coin::value<T1>(&arg2) > 0) {
            distribute_token<T1>(arg2, arg0, arg3);
        } else {
            0x2::coin::destroy_zero<T1>(arg2);
        };
    }

    fun distribute_token<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &FeeCollectorConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v0 * arg1.burn_percentage / 100, arg2), @0x0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v0 * arg1.marketing_percentage / 100, arg2), arg1.marketing_wallet);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v0 * arg1.reflection_percentage / 100, arg2), arg1.reflection_wallet);
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    fun execute_deployed_cetus_call<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
    }

    public fun get_config(arg0: &FeeCollectorConfig) : (u64, u64, u64, address, address) {
        (arg0.burn_percentage, arg0.marketing_percentage, arg0.reflection_percentage, arg0.marketing_wallet, arg0.reflection_wallet)
    }

    public fun get_deployed_contract_address() : address {
        @0xb2db7142fa83210a7d78d9c12ac49c043b3cbbd482224fea6e3da00aa5a5ae2d
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeCollectorConfig{
            id                    : 0x2::object::new(arg0),
            admin                 : 0x2::tx_context::sender(arg0),
            burn_percentage       : 50,
            marketing_percentage  : 30,
            reflection_percentage : 20,
            marketing_wallet      : @0x68518b69e0deeda44f738fc6986e9cf5ff810f78011ec6674bbe9a32770e8f5c,
            reflection_wallet     : @0x9bddab4e436885512b4d03ef64ca6ddaa87b00ec8c605cbcb680d29fbf60af9,
        };
        0x2::transfer::share_object<FeeCollectorConfig>(v0);
    }

    fun pool_script_collect_fee<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
    }

    public entry fun update_config(arg0: &mut FeeCollectorConfig, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 3);
        assert!(arg1 + arg2 + arg3 == 100, 0);
        arg0.burn_percentage = arg1;
        arg0.marketing_percentage = arg2;
        arg0.reflection_percentage = arg3;
        arg0.marketing_wallet = arg4;
        arg0.reflection_wallet = arg5;
    }

    // decompiled from Move bytecode v6
}

