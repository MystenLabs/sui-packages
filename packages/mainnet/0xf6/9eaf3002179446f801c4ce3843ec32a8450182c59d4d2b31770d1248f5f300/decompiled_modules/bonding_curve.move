module 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::bonding_curve {
    struct BondingCurve<phantom T0> has key {
        id: 0x2::object::UID,
        real_t: 0x2::balance::Balance<T0>,
        real_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        virtual_sui: u64,
        virtual_t: u64,
        total_supply: u64,
        sealed: bool,
    }

    public(friend) fun new<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : BondingCurve<T0> {
        let v0 = 0x2::coin::into_balance<T0>(arg0);
        assert!(0x2::balance::value<T0>(&v0) == arg1, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_vault_zero_supply());
        BondingCurve<T0>{
            id           : 0x2::object::new(arg3),
            real_t       : v0,
            real_sui     : 0x2::balance::zero<0x2::sui::SUI>(),
            virtual_sui  : arg2 * 3 / 4,
            virtual_t    : arg1,
            total_supply : arg1,
            sealed       : false,
        }
    }

    public fun current_market_cap_sui<T0>(arg0: &BondingCurve<T0>) : u64 {
        ((((0x2::balance::value<0x2::sui::SUI>(&arg0.real_sui) as u128) + (arg0.virtual_sui as u128)) * (arg0.total_supply as u128) / ((0x2::balance::value<T0>(&arg0.real_t) as u128) + (arg0.virtual_t as u128))) as u64)
    }

    public fun is_sealed<T0>(arg0: &BondingCurve<T0>) : bool {
        arg0.sealed
    }

    public fun real_sui_reserve<T0>(arg0: &BondingCurve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.real_sui)
    }

    public fun real_t_reserve<T0>(arg0: &BondingCurve<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.real_t)
    }

    public(friend) fun seal_and_drain<T0>(arg0: &mut BondingCurve<T0>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(!arg0.sealed, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_bc_sealed());
        arg0.sealed = true;
        (0x2::balance::split<T0>(&mut arg0.real_t, 0x2::balance::value<T0>(&arg0.real_t)), 0x2::balance::split<0x2::sui::SUI>(&mut arg0.real_sui, 0x2::balance::value<0x2::sui::SUI>(&arg0.real_sui)))
    }

    public(friend) fun share<T0>(arg0: BondingCurve<T0>) {
        0x2::transfer::share_object<BondingCurve<T0>>(arg0);
    }

    public fun swap_sui_for_t<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::Vault<T0, 0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.sealed, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_bc_sealed());
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_bc_zero_input());
        let (v1, v2) = 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::tax_rule::apply_tax_bps(v0, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::bonding_curve_tax_bps<T0, 0x2::sui::SUI>(arg1));
        let v3 = (0x2::balance::value<0x2::sui::SUI>(&arg0.real_sui) as u128) + (arg0.virtual_sui as u128);
        let v4 = (0x2::balance::value<T0>(&arg0.real_t) as u128) + (arg0.virtual_t as u128);
        let v5 = ((v4 - v3 * v4 / (v3 + (v1 as u128))) as u64);
        assert!(v5 >= arg3, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_bc_slippage());
        assert!(v5 <= 0x2::balance::value<T0>(&arg0.real_t), 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_bc_insufficient_reserve());
        let v6 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::deposit_payout<T0, 0x2::sui::SUI>(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.real_sui, v6);
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::events::emit_bc_swap(0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::events::new_bc_swap_event(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), 0x2::tx_context::sender(arg5), true, v0, v5, v2, 0x2::balance::value<0x2::sui::SUI>(&arg0.real_sui), 0x2::balance::value<T0>(&arg0.real_t), 0x2::clock::timestamp_ms(arg4)));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.real_t, v5), arg5)
    }

    public fun swap_t_for_sui<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::Vault<T0, 0x2::sui::SUI>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!arg0.sealed, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_bc_sealed());
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_bc_zero_input());
        let v1 = (0x2::balance::value<0x2::sui::SUI>(&arg0.real_sui) as u128) + (arg0.virtual_sui as u128);
        let v2 = (0x2::balance::value<T0>(&arg0.real_t) as u128) + (arg0.virtual_t as u128);
        let v3 = v1 - v1 * v2 / (v2 + (v0 as u128));
        let v4 = (0x2::balance::value<0x2::sui::SUI>(&arg0.real_sui) as u128);
        let v5 = if (v3 > v4) {
            v4
        } else {
            v3
        };
        let v6 = (v5 as u64);
        let (v7, v8) = 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::tax_rule::apply_tax_bps(v6, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::bonding_curve_tax_bps<T0, 0x2::sui::SUI>(arg1));
        assert!(v7 >= arg3, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_bc_slippage());
        0x2::balance::join<T0>(&mut arg0.real_t, 0x2::coin::into_balance<T0>(arg2));
        let v9 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.real_sui, v6);
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault::deposit_payout<T0, 0x2::sui::SUI>(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v9, v8));
        0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::events::emit_bc_swap(0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::events::new_bc_swap_event(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), 0x2::tx_context::sender(arg5), false, v7, v0, v8, 0x2::balance::value<0x2::sui::SUI>(&arg0.real_sui), 0x2::balance::value<T0>(&arg0.real_t), 0x2::clock::timestamp_ms(arg4)));
        0x2::coin::from_balance<0x2::sui::SUI>(v9, arg5)
    }

    public fun total_supply<T0>(arg0: &BondingCurve<T0>) : u64 {
        arg0.total_supply
    }

    public fun virtual_sui<T0>(arg0: &BondingCurve<T0>) : u64 {
        arg0.virtual_sui
    }

    public fun virtual_t<T0>(arg0: &BondingCurve<T0>) : u64 {
        arg0.virtual_t
    }

    // decompiled from Move bytecode v6
}

