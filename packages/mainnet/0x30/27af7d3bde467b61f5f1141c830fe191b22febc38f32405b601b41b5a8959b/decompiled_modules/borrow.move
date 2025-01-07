module 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public fun borrow<T0>(arg0: &0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::version::Version, arg1: &mut 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::Obligation, arg2: &0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::ObligationKey, arg3: &mut 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::Market, arg4: &0xeeb70882d5ff9c5aacf7e162e467d884b308781feb62d4ceff9224695698be23::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x5426f3642f8bb08fb9fe78d25f543730a30b9a248bcf1bd816c6dd5d650921f2::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::version::assert_current_version(arg0);
        assert!(0x12d776b6619ab63ce6923cfab6d5a89d964655642201b48ea83a91e42000bb92::whitelist::is_address_allowed(0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::uid(arg3), 0x2::tx_context::sender(arg8)), 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::error::whitelist_error());
        assert!(0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::borrow_locked(arg1) == false, 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::error::obligation_locked());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::is_base_asset_active(arg3, v0), 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::error::base_asset_not_active_error());
        let v1 = 0x2::clock::timestamp_ms(arg7) / 1000;
        0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::assert_key_match(arg1, arg2);
        assert!(arg5 > 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::interest_model::min_borrow_amount(0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::interest_model(arg3, v0)), 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::error::borrow_too_small_error());
        0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::handle_outflow<T0>(arg3, arg5, v1);
        0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::init_debt(arg1, arg3, v0);
        0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::accrue_interests_and_rewards(arg1, arg3);
        assert!(arg5 <= 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::borrow_withdraw_evaluator::max_borrow_amount<T0>(arg1, arg3, arg4, arg6, arg7), 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::error::borrow_too_much_error());
        0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::increase_debt(arg1, v0, arg5);
        let v2 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg8),
            obligation : 0x2::object::id<0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::Obligation>(arg1),
            asset      : v0,
            amount     : arg5,
            time       : v1,
        };
        0x2::event::emit<BorrowEvent>(v2);
        0x2::coin::from_balance<T0>(0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::handle_borrow<T0>(arg3, arg5, v1), arg8)
    }

    public entry fun borrow_entry<T0>(arg0: &0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::version::Version, arg1: &mut 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::Obligation, arg2: &0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::ObligationKey, arg3: &mut 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::Market, arg4: &0xeeb70882d5ff9c5aacf7e162e467d884b308781feb62d4ceff9224695698be23::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x5426f3642f8bb08fb9fe78d25f543730a30b9a248bcf1bd816c6dd5d650921f2::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

