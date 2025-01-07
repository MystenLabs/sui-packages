module 0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    struct BorrowEventV2 has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        borrow_fee: u64,
        time: u64,
    }

    public fun borrow<T0>(arg0: &0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::version::Version, arg1: &mut 0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::obligation::Obligation, arg2: &0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::obligation::ObligationKey, arg3: &mut 0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::market::Market, arg4: &0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::version::assert_current_version(arg0);
        assert!(0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::whitelist::is_address_allowed(0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::market::uid(arg3), 0x2::tx_context::sender(arg8)), 0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::error::whitelist_error());
        assert!(0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::obligation::borrow_locked(arg1) == false, 0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::error::obligation_locked());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::market::is_base_asset_active(arg3, v0), 0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::error::base_asset_not_active_error());
        let v1 = 0x2::clock::timestamp_ms(arg7) / 1000;
        0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::obligation::assert_key_match(arg1, arg2);
        assert!(!0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::obligation::has_coin_x_as_collateral(arg1, v0), 0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::error::unable_to_borrow_a_collateral_coin());
        assert!(arg5 > 0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::interest_model::min_borrow_amount(0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::market::interest_model(arg3, v0)), 0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::error::borrow_too_small_error());
        0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::market::handle_outflow<T0>(arg3, arg5, v1);
        let v2 = 0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::market::handle_borrow<T0>(arg3, arg5, v1);
        0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::obligation::init_debt(arg1, arg3, v0);
        0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::obligation::accrue_interests_and_rewards(arg1, arg3);
        assert!(arg5 <= 0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::borrow_withdraw_evaluator::max_borrow_amount<T0>(arg1, arg3, arg4, arg6, arg7), 0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::error::borrow_too_much_error());
        0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::obligation::increase_debt(arg1, v0, arg5);
        let v3 = 0x1::fixed_point32::multiply_u64(arg5, *0x2::dynamic_field::borrow<0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::market::uid(arg3), 0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::market_dynamic_keys::borrow_fee_key(0x1::type_name::get<T0>())));
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v3), arg8), *0x2::dynamic_field::borrow<0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::market_dynamic_keys::BorrowFeeRecipientKey, address>(0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::market::uid(arg3), 0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::market_dynamic_keys::borrow_fee_recipient_key()));
        };
        let v4 = BorrowEventV2{
            borrower   : 0x2::tx_context::sender(arg8),
            obligation : 0x2::object::id<0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::obligation::Obligation>(arg1),
            asset      : v0,
            amount     : arg5,
            borrow_fee : v3,
            time       : v1,
        };
        0x2::event::emit<BorrowEventV2>(v4);
        0x2::coin::from_balance<T0>(v2, arg8)
    }

    public entry fun borrow_entry<T0>(arg0: &0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::version::Version, arg1: &mut 0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::obligation::Obligation, arg2: &0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::obligation::ObligationKey, arg3: &mut 0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::market::Market, arg4: &0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

