module 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::curve {
    struct Curve<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        coin_type: 0x1::ascii::String,
        token_reserve: 0x2::balance::Balance<T0>,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        lp_reserve: 0x2::balance::Balance<T0>,
        virtual_sui: u64,
        virtual_tokens: u64,
        curve_supply: u64,
        fee_bps: u64,
        migration_fee_bps: u64,
        decimals: u8,
        tokens_sold: u64,
        volume_sui: u64,
        buy_count: u64,
        sell_count: u64,
        created_at_ms: u64,
        graduated: bool,
        vault_id: 0x1::option::Option<0x2::object::ID>,
    }

    public(friend) fun new<T0>(arg0: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::Config, arg1: address, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Curve<T0> {
        let v0 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::curve_supply(arg0);
        let v1 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::lp_supply(arg0);
        assert!(0x2::balance::value<T0>(&arg2) == v0 + v1, 3);
        Curve<T0>{
            id                : 0x2::object::new(arg4),
            creator           : arg1,
            coin_type         : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            token_reserve     : arg2,
            sui_reserve       : 0x2::balance::zero<0x2::sui::SUI>(),
            lp_reserve        : 0x2::balance::split<T0>(&mut arg2, v1),
            virtual_sui       : 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::virtual_sui(arg0),
            virtual_tokens    : 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::virtual_tokens(arg0),
            curve_supply      : v0,
            fee_bps           : 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::fee_bps(arg0),
            migration_fee_bps : 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::migration_fee_bps(arg0),
            decimals          : 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::decimals(arg0),
            tokens_sold       : 0,
            volume_sui        : 0,
            buy_count         : 0,
            sell_count        : 0,
            created_at_ms     : 0x2::clock::timestamp_ms(arg3),
            graduated         : false,
            vault_id          : 0x1::option::none<0x2::object::ID>(),
        }
    }

    public fun curve_supply<T0>(arg0: &Curve<T0>) : u64 {
        arg0.curve_supply
    }

    public fun decimals<T0>(arg0: &Curve<T0>) : u8 {
        arg0.decimals
    }

    public fun fee_bps<T0>(arg0: &Curve<T0>) : u64 {
        arg0.fee_bps
    }

    public fun buy<T0>(arg0: &mut Curve<T0>, arg1: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::Config, arg2: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::FeeVault, arg3: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::referral::ReferralRegistry, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: 0x1::option::Option<address>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::assert_active(arg1);
        assert!(!arg0.graduated, 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v0 > 0, 2);
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::referral::resolve_and_bind(arg3, v1, arg6, arg7);
        let v3 = sui_total<T0>(arg0);
        let v4 = token_total<T0>(arg0);
        let v5 = arg0.curve_supply - arg0.tokens_sold;
        let v6 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::mul_bps(v0, arg0.fee_bps);
        let v7 = v6;
        let v8 = v0 - v6;
        let v9 = v8;
        let v10 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::tokens_out(v3, v4, v8);
        let v11 = v10;
        if (v10 > v5) {
            v11 = v5;
            let v12 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::sui_in_for_tokens(v3, v4, v5);
            v9 = v12;
            v7 = gross_from_net(v12, arg0.fee_bps, v0) - v12;
        };
        assert!(v11 >= arg5, 1);
        assert!(v11 > 0, 2);
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::accrue(arg2, 0x2::object::uid_to_inner(&arg0.id), 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg4), v7), v2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg4), v9));
        arg0.tokens_sold = arg0.tokens_sold + v11;
        arg0.volume_sui = arg0.volume_sui + v9;
        arg0.buy_count = arg0.buy_count + 1;
        let v13 = 0x2::coin::take<T0>(&mut arg0.token_reserve, v11, arg8);
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::trade(0x2::object::uid_to_inner(&arg0.id), arg0.coin_type, v1, true, v9, v11, v7, sui_total<T0>(arg0), token_total<T0>(arg0), arg0.curve_supply - arg0.tokens_sold, price_scaled<T0>(arg0), progress_bps<T0>(arg0), v2, 0x2::clock::timestamp_ms(arg7));
        if (arg0.tokens_sold == arg0.curve_supply) {
            finalize_graduation<T0>(arg0, arg7, arg8);
        };
        (v13, arg4)
    }

    public fun buy_to_sender<T0>(arg0: &mut Curve<T0>, arg1: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::Config, arg2: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::FeeVault, arg3: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::referral::ReferralRegistry, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: 0x1::option::Option<address>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = buy<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v2 = v1;
        let v3 = 0x2::tx_context::sender(arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v3);
        if (0x2::coin::value<0x2::sui::SUI>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, v3);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v2);
        };
    }

    public fun coin_type<T0>(arg0: &Curve<T0>) : 0x1::ascii::String {
        arg0.coin_type
    }

    public fun created_at_ms<T0>(arg0: &Curve<T0>) : u64 {
        arg0.created_at_ms
    }

    public fun creator<T0>(arg0: &Curve<T0>) : address {
        arg0.creator
    }

    fun finalize_graduation<T0>(arg0: &mut Curve<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.graduated = true;
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve);
        let v1 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::mul_bps(v0, arg0.migration_fee_bps);
        let v2 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v0 - v1);
        let v3 = 0x2::balance::withdraw_all<T0>(&mut arg0.lp_reserve);
        let v4 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::migration::create_and_share<T0>(0x2::object::uid_to_inner(&arg0.id), arg0.coin_type, arg0.creator, v2, v3, arg0.decimals, arg2);
        arg0.vault_id = 0x1::option::some<0x2::object::ID>(v4);
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::graduated(0x2::object::uid_to_inner(&arg0.id), arg0.coin_type, v4, 0x2::balance::value<0x2::sui::SUI>(&v2), 0x2::balance::value<T0>(&v3), v1, price_scaled<T0>(arg0), 0x2::clock::timestamp_ms(arg1));
    }

    fun gross_from_net(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = ((0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::bps_denom() - arg1) as u128);
        let v1 = ((arg0 as u128) * (0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::bps_denom() as u128) + v0 - 1) / v0;
        if (v1 > (arg2 as u128)) {
            arg2
        } else {
            (v1 as u64)
        }
    }

    public fun id<T0>(arg0: &Curve<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun is_graduated<T0>(arg0: &Curve<T0>) : bool {
        arg0.graduated
    }

    public fun price_scaled<T0>(arg0: &Curve<T0>) : u128 {
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::spot_price_scaled(sui_total<T0>(arg0), token_total<T0>(arg0), arg0.decimals)
    }

    public fun progress_bps<T0>(arg0: &Curve<T0>) : u64 {
        if (arg0.curve_supply == 0) {
            return 10000
        };
        (((arg0.tokens_sold as u128) * 10000 / (arg0.curve_supply as u128)) as u64)
    }

    public fun quote_buy<T0>(arg0: &Curve<T0>, arg1: u64) : (u64, u64, u64, u64) {
        if (arg0.graduated || arg1 == 0) {
            return (0, 0, 0, arg1)
        };
        let v0 = sui_total<T0>(arg0);
        let v1 = token_total<T0>(arg0);
        let v2 = arg0.curve_supply - arg0.tokens_sold;
        let v3 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::mul_bps(arg1, arg0.fee_bps);
        let v4 = v3;
        let v5 = arg1 - v3;
        let v6 = v5;
        let v7 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::tokens_out(v0, v1, v5);
        let v8 = v7;
        if (v7 > v2) {
            v8 = v2;
            let v9 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::sui_in_for_tokens(v0, v1, v2);
            v6 = v9;
            v4 = gross_from_net(v9, arg0.fee_bps, arg1) - v9;
        };
        (v8, v4, v6, arg1 - v6 - v4)
    }

    public fun quote_sell<T0>(arg0: &Curve<T0>, arg1: u64) : (u64, u64, u64) {
        let v0 = if (arg0.graduated) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg1 > arg0.tokens_sold
        };
        if (v0) {
            return (0, 0, 0)
        };
        let v1 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::sui_out(sui_total<T0>(arg0), token_total<T0>(arg0), arg1);
        let v2 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::mul_bps(v1, arg0.fee_bps);
        (v1 - v2, v2, v1)
    }

    public fun sell<T0>(arg0: &mut Curve<T0>, arg1: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::Config, arg2: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::FeeVault, arg3: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::referral::ReferralRegistry, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: 0x1::option::Option<address>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::assert_active(arg1);
        assert!(!arg0.graduated, 0);
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 2);
        assert!(v0 <= arg0.tokens_sold, 3);
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::referral::resolve_and_bind(arg3, v1, arg6, arg7);
        let v3 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::sui_out(sui_total<T0>(arg0), token_total<T0>(arg0), v0);
        assert!(v3 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), 3);
        let v4 = 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::mul_bps(v3, arg0.fee_bps);
        let v5 = v3 - v4;
        assert!(v5 >= arg5, 1);
        0x2::balance::join<T0>(&mut arg0.token_reserve, 0x2::coin::into_balance<T0>(arg4));
        arg0.tokens_sold = arg0.tokens_sold - v0;
        arg0.volume_sui = arg0.volume_sui + v5;
        arg0.sell_count = arg0.sell_count + 1;
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::accrue(arg2, 0x2::object::uid_to_inner(&arg0.id), 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v4), v2);
        0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events::trade(0x2::object::uid_to_inner(&arg0.id), arg0.coin_type, v1, false, v5, v0, v4, sui_total<T0>(arg0), token_total<T0>(arg0), arg0.curve_supply - arg0.tokens_sold, price_scaled<T0>(arg0), progress_bps<T0>(arg0), v2, 0x2::clock::timestamp_ms(arg7));
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_reserve, v5, arg8)
    }

    public fun sell_to_sender<T0>(arg0: &mut Curve<T0>, arg1: &0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::config::Config, arg2: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::fees::FeeVault, arg3: &mut 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::referral::ReferralRegistry, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: 0x1::option::Option<address>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = sell<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg8));
    }

    public(friend) fun share<T0>(arg0: Curve<T0>) {
        0x2::transfer::share_object<Curve<T0>>(arg0);
    }

    public fun share_curve<T0>(arg0: Curve<T0>) {
        0x2::transfer::share_object<Curve<T0>>(arg0);
    }

    public fun sui_raised<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve)
    }

    public fun sui_to_graduate<T0>(arg0: &Curve<T0>) : u64 {
        if (arg0.graduated) {
            return 0
        };
        let v0 = arg0.curve_supply - arg0.tokens_sold;
        if (v0 == 0) {
            return 0
        };
        gross_from_net(0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::math::sui_in_for_tokens(sui_total<T0>(arg0), token_total<T0>(arg0), v0), arg0.fee_bps, 18446744073709551615)
    }

    public fun sui_total<T0>(arg0: &Curve<T0>) : u64 {
        arg0.virtual_sui + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve)
    }

    public(friend) fun take_migration_fee<T0>(arg0: &mut Curve<T0>) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg0.graduated, 4);
        0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_reserve)
    }

    public fun token_total<T0>(arg0: &Curve<T0>) : u64 {
        arg0.virtual_tokens - arg0.tokens_sold
    }

    public fun tokens_remaining<T0>(arg0: &Curve<T0>) : u64 {
        arg0.curve_supply - arg0.tokens_sold
    }

    public fun tokens_sold<T0>(arg0: &Curve<T0>) : u64 {
        arg0.tokens_sold
    }

    public fun trade_count<T0>(arg0: &Curve<T0>) : u64 {
        arg0.buy_count + arg0.sell_count
    }

    public fun vault_id<T0>(arg0: &Curve<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.vault_id
    }

    public fun volume_sui<T0>(arg0: &Curve<T0>) : u64 {
        arg0.volume_sui
    }

    // decompiled from Move bytecode v7
}

