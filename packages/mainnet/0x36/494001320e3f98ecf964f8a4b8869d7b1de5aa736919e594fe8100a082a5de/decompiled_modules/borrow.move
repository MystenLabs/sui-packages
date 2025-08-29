module 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public fun borrow<T0>(arg0: &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::version::Version, arg1: &mut 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::obligation::Obligation, arg2: &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::obligation::ObligationKey, arg3: &mut 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::market::Market, arg4: &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::version::assert_current_version(arg0);
        assert!(0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::whitelist::is_address_allowed(0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::market::uid(arg3), 0x2::tx_context::sender(arg8)), 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::error::whitelist_error());
        assert!(0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::obligation::borrow_locked(arg1) == false, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::error::obligation_locked());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::market::is_base_asset_active(arg3, v0), 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::error::base_asset_not_active_error());
        let v1 = 0x2::clock::timestamp_ms(arg7) / 1000;
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::obligation::assert_key_match(arg1, arg2);
        assert!(arg5 > 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::interest_model::min_borrow_amount(0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::market::interest_model(arg3, v0)), 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::error::borrow_too_small_error());
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::market::handle_outflow<T0>(arg3, arg5, v1);
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::obligation::init_debt(arg1, arg3, v0);
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::obligation::accrue_interests_and_rewards(arg1, arg3);
        assert!(arg5 <= 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::borrow_withdraw_evaluator::max_borrow_amount<T0>(arg1, arg3, arg4, arg6, arg7), 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::error::borrow_too_much_error());
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::obligation::increase_debt(arg1, v0, arg5);
        let v2 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg8),
            obligation : 0x2::object::id<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::obligation::Obligation>(arg1),
            asset      : v0,
            amount     : arg5,
            time       : v1,
        };
        0x2::event::emit<BorrowEvent>(v2);
        0x2::coin::from_balance<T0>(0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::market::handle_borrow<T0>(arg3, arg5, v1), arg8)
    }

    public entry fun borrow_entry<T0>(arg0: &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::version::Version, arg1: &mut 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::obligation::Obligation, arg2: &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::obligation::ObligationKey, arg3: &mut 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::market::Market, arg4: &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

