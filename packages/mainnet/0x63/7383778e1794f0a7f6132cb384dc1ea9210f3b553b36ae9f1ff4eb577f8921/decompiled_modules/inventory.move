module 0x637383778e1794f0a7f6132cb384dc1ea9210f3b553b36ae9f1ff4eb577f8921::inventory {
    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        admin: address,
        pool_id: 0x2::object::ID,
        payment_vault_id: 0x2::object::ID,
        reward_config_id: 0x2::object::ID,
        aec: 0x2::balance::Balance<T0>,
        min_price_microusdc: u64,
        max_gross_usdc: u64,
        max_aec_per_order: u64,
        max_total_aec: u64,
        total_aec_spent: u64,
        paused: bool,
    }

    struct InventoryPaymentCompleted has copy, drop {
        order_id: vector<u8>,
        payer: address,
        buy_usdc: u64,
        aec_distributed: u64,
        pool_id: 0x2::object::ID,
    }

    public fun add_aec<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        0x2::balance::join<T0>(&mut arg0.aec, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun create<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x592db2001ec424e56643aa608054567e3e51cb7f7e17ee9a2b4a69955193827::payment::PaymentVault<T1>, arg2: &0x6e957f725baa33b6b8dd4bb543977ba1c00e1bb9dd4af6562f1f52c76378c372::rewards::RewardConfig, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0 && arg5 > 0, 4);
        assert!(arg6 > 0 && arg7 >= arg6, 4);
        let v0 = Vault<T0, T1>{
            id                  : 0x2::object::new(arg8),
            admin               : 0x2::tx_context::sender(arg8),
            pool_id             : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            payment_vault_id    : 0x2::object::id<0x592db2001ec424e56643aa608054567e3e51cb7f7e17ee9a2b4a69955193827::payment::PaymentVault<T1>>(arg1),
            reward_config_id    : 0x2::object::id<0x6e957f725baa33b6b8dd4bb543977ba1c00e1bb9dd4af6562f1f52c76378c372::rewards::RewardConfig>(arg2),
            aec                 : 0x2::coin::into_balance<T0>(arg3),
            min_price_microusdc : arg4,
            max_gross_usdc      : arg5,
            max_aec_per_order   : arg6,
            max_total_aec       : arg7,
            total_aec_spent     : 0,
            paused              : true,
        };
        0x2::transfer::share_object<Vault<T0, T1>>(v0);
    }

    public fun pay<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x592db2001ec424e56643aa608054567e3e51cb7f7e17ee9a2b4a69955193827::payment::PaymentVault<T1>, arg3: &0x6e957f725baa33b6b8dd4bb543977ba1c00e1bb9dd4af6562f1f52c76378c372::rewards::RewardConfig, arg4: 0x2::coin::Coin<T1>, arg5: address, arg6: u64, arg7: u64, arg8: address, arg9: address, arg10: address, arg11: vector<address>, arg12: address, arg13: vector<u8>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1) == arg0.pool_id, 3);
        assert!(0x2::object::id<0x592db2001ec424e56643aa608054567e3e51cb7f7e17ee9a2b4a69955193827::payment::PaymentVault<T1>>(arg2) == arg0.payment_vault_id, 3);
        assert!(0x2::object::id<0x6e957f725baa33b6b8dd4bb543977ba1c00e1bb9dd4af6562f1f52c76378c372::rewards::RewardConfig>(arg3) == arg0.reward_config_id, 3);
        let v0 = 0x2::coin::value<T1>(&arg4);
        assert!(v0 > 0 && v0 <= arg0.max_gross_usdc, 4);
        let (_, v2, _) = 0x592db2001ec424e56643aa608054567e3e51cb7f7e17ee9a2b4a69955193827::payment::quote_commerce(v0, 0x592db2001ec424e56643aa608054567e3e51cb7f7e17ee9a2b4a69955193827::payment::fee_bps<T1>(arg2), arg6);
        assert!(v2 > 0, 4);
        let (v4, v5, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg1, v2, arg14);
        assert!(arg7 > 0 && v4 >= arg7, 5);
        assert!((v5 as u128) * (10000 as u128) <= (v2 as u128) * (100 as u128), 5);
        assert!((v2 as u128) * 1000000 >= (v4 as u128) * (arg0.min_price_microusdc as u128), 6);
        assert!(v4 <= arg0.max_aec_per_order, 7);
        assert!(arg0.total_aec_spent + v4 <= arg0.max_total_aec, 7);
        assert!(v4 <= 0x2::balance::value<T0>(&arg0.aec), 7);
        0x592db2001ec424e56643aa608054567e3e51cb7f7e17ee9a2b4a69955193827::payment::pay_with_concession<T1>(arg2, arg4, arg5, arg13, arg6, arg15);
        0x6e957f725baa33b6b8dd4bb543977ba1c00e1bb9dd4af6562f1f52c76378c372::rewards::distribute<T0>(arg3, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.aec, v4), arg15), arg8, arg5, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        arg0.total_aec_spent = arg0.total_aec_spent + v4;
        let v7 = InventoryPaymentCompleted{
            order_id        : arg13,
            payer           : 0x2::tx_context::sender(arg15),
            buy_usdc        : v2,
            aec_distributed : v4,
            pool_id         : arg0.pool_id,
        };
        0x2::event::emit<InventoryPaymentCompleted>(v7);
    }

    public fun set_limits<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 1);
        assert!(arg0.paused, 2);
        assert!(arg1 > 0 && arg2 > 0, 4);
        assert!(arg3 > 0 && arg4 >= arg0.total_aec_spent, 4);
        arg0.min_price_microusdc = arg1;
        arg0.max_gross_usdc = arg2;
        arg0.max_aec_per_order = arg3;
        arg0.max_total_aec = arg4;
    }

    public fun set_paused<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.paused = arg1;
    }

    public fun withdraw_aec<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        assert!(arg0.paused, 2);
        assert!(arg1 > 0 && arg1 <= 0x2::balance::value<T0>(&arg0.aec), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.aec, arg1), arg2), arg0.admin);
    }

    // decompiled from Move bytecode v7
}

