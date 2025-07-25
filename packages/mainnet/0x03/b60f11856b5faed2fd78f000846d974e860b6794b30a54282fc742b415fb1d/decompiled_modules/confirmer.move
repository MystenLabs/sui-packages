module 0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::confirmer {
    struct Confirmer has store, key {
        id: 0x2::object::UID,
        fee_tier: 0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::fee_tier::FeeTier,
        nonce_manager: 0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::nonce_manager::NonceManager,
    }

    struct ConfirmSwapEvent has copy, drop {
        quote_id: 0x1::string::String,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        nonce: u64,
    }

    public fun collect_fee<T0>(arg0: &mut Confirmer, arg1: &0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::admin_cap::AdminCap, arg2: &0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::versioned::check_version(arg2);
        0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::fee_tier::collect_fee<T0>(&mut arg0.fee_tier, arg3)
    }

    public fun confirm_swap<T0, T1>(arg0: &mut Confirmer, arg1: &mut 0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::mm_vault::MMVault, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: 0x2::coin::Coin<T0>, arg9: &0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::versioned::Versioned, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::versioned::check_version(arg9);
        assert!(arg3 > 0, 0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::errors::err_incorrect_amount_in());
        assert!(arg4 > 0, 0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::errors::err_incorrect_amount_out());
        assert!(0x2::coin::value<T0>(&arg8) == arg3, 0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::errors::err_incorrect_amount_in());
        assert!(0x2::clock::timestamp_ms(arg10) / 1000 <= arg5, 0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::errors::err_expired());
        0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::nonce_manager::increment_nonce(&mut arg0.nonce_manager, arg6, arg11);
        let v0 = 0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::mm_vault::swap<T0, T1>(arg1, arg2, arg8, arg4, arg5, arg6, arg7, arg9, arg11);
        let v1 = 0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::fee_tier::fee_amount<T0, T1>(&arg0.fee_tier, arg4);
        assert!(0x2::balance::value<T1>(&v0) == arg4, 0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::errors::err_incorrect_amount_out());
        if (v1 > 0) {
            0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::fee_tier::receive_fee<T1>(&mut arg0.fee_tier, 0x2::balance::split<T1>(&mut v0, v1));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v0, arg11), 0x2::tx_context::sender(arg11));
        let v2 = ConfirmSwapEvent{
            quote_id   : arg2,
            from       : 0x1::type_name::get<T0>(),
            target     : 0x1::type_name::get<T1>(),
            amount_in  : arg3,
            amount_out : arg4,
            fee_amount : v1,
            nonce      : arg6,
        };
        0x2::event::emit<ConfirmSwapEvent>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Confirmer{
            id            : 0x2::object::new(arg0),
            fee_tier      : 0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::fee_tier::new_fee_tier(arg0),
            nonce_manager : 0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::nonce_manager::new_nonce_manager(arg0),
        };
        0x2::transfer::public_share_object<Confirmer>(v0);
    }

    public fun set_default_fee_rate(arg0: &mut Confirmer, arg1: u32, arg2: &0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::admin_cap::AdminCap, arg3: &0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::versioned::Versioned) {
        0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::versioned::check_version(arg3);
        0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::fee_tier::set_default_fee_rate(&mut arg0.fee_tier, arg1);
    }

    public fun set_fee_rate<T0, T1>(arg0: &mut Confirmer, arg1: u32, arg2: &0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::admin_cap::AdminCap, arg3: &0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::versioned::Versioned) {
        0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::versioned::check_version(arg3);
        0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::fee_tier::set_fee_rate<T0, T1>(&mut arg0.fee_tier, arg1);
    }

    // decompiled from Move bytecode v6
}

