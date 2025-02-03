module 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault {
    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        obligation_key: 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::ObligationKey,
        leverage: u8,
    }

    struct OwnerKey has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    public fun assert_ownership<T0, T1>(arg0: &OwnerKey, arg1: &Vault<T0, T1>) {
        assert!(arg0.for == 0x2::object::id<Vault<T0, T1>>(arg1), 0);
    }

    public(friend) fun deposit<T0, T1>(arg0: &Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::version::Version, arg3: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::Obligation, arg4: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::Market, arg5: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::x_oracle::XOracle, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::deposit_collateral::deposit_collateral<T0>(arg2, arg3, arg4, arg1, arg9);
        0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::borrow::borrow<T1>(arg2, arg3, &arg0.obligation_key, arg4, arg5, get_adjusted_borrow_amount(arg7, *0x2::dynamic_field::borrow<0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::uid(arg4), 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market_dynamic_keys::borrow_fee_key(0x1::type_name::get<T1>()))), arg6, arg8, arg9)
    }

    fun get_adjusted_borrow_amount(arg0: u64, arg1: 0x1::fixed_point32::FixedPoint32) : u64 {
        let v0 = 1000000000;
        (((arg0 as u256) * (v0 as u256)) as u64) / (v0 - 0x1::fixed_point32::multiply_u64(v0, arg1))
    }

    public fun get_deposit_flash_swap_amount<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64) : u64 {
        arg1 * ((arg0.leverage as u64) - 1)
    }

    public fun get_withdraw_flash_swap_amount<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::Obligation) : u64 {
        let (v0, _) = 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::debt(arg1, 0x1::type_name::get<T1>());
        v0
    }

    public(friend) fun initialize<T0, T1>(arg0: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::version::Version, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : (Vault<T0, T1>, OwnerKey) {
        let (v0, v1, v2) = 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::open_obligation::open_obligation(arg0, arg2);
        0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::open_obligation::return_obligation(arg0, v0, v2);
        let v3 = Vault<T0, T1>{
            id             : 0x2::object::new(arg2),
            obligation_key : v1,
            leverage       : arg1,
        };
        let v4 = OwnerKey{
            id  : 0x2::object::new(arg2),
            for : 0x2::object::id<Vault<T0, T1>>(&v3),
        };
        (v3, v4)
    }

    public fun vault_info<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::Obligation) : (u64, u64, u8) {
        let (v0, _) = 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::debt(arg1, 0x1::type_name::get<T1>());
        (0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::collateral(arg1, 0x1::type_name::get<T0>()), v0, arg0.leverage)
    }

    public(friend) fun withdraw<T0, T1>(arg0: &Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::version::Version, arg3: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::Obligation, arg4: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::Market, arg5: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::accrue_interest::accrue_interest_for_market_and_obligation(arg2, arg4, arg3, arg7);
        0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::repay::repay<T1>(arg2, arg3, arg4, arg1, arg7, arg8);
        0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::withdraw_collateral::withdraw_collateral<T0>(arg2, arg3, &arg0.obligation_key, arg4, arg5, 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::collateral(arg3, 0x1::type_name::get<T0>()), arg6, arg7, arg8)
    }

    // decompiled from Move bytecode v6
}

