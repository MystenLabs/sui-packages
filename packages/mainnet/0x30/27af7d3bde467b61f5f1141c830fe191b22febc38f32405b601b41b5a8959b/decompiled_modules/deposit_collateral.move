module 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::deposit_collateral {
    struct CollateralDepositEvent has copy, drop {
        provider: address,
        obligation: 0x2::object::ID,
        deposit_asset: 0x1::type_name::TypeName,
        deposit_amount: u64,
    }

    public entry fun deposit_collateral<T0>(arg0: &0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::version::Version, arg1: &mut 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::Obligation, arg2: &mut 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::version::assert_current_version(arg0);
        assert!(0x12d776b6619ab63ce6923cfab6d5a89d964655642201b48ea83a91e42000bb92::whitelist::is_address_allowed(0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::uid(arg2), 0x2::tx_context::sender(arg4)), 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::error::whitelist_error());
        assert!(0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::deposit_collateral_locked(arg1) == false, 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::error::obligation_locked());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::is_collateral_active(arg2, v0), 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::error::collateral_not_active_error());
        assert!(0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::has_risk_model(arg2, v0) == true, 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::error::invalid_collateral_type_error());
        let v1 = CollateralDepositEvent{
            provider       : 0x2::tx_context::sender(arg4),
            obligation     : 0x2::object::id<0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::Obligation>(arg1),
            deposit_asset  : v0,
            deposit_amount : 0x2::coin::value<T0>(&arg3),
        };
        0x2::event::emit<CollateralDepositEvent>(v1);
        0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::handle_add_collateral<T0>(arg2, 0x2::coin::value<T0>(&arg3));
        0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::deposit_collateral<T0>(arg1, 0x2::coin::into_balance<T0>(arg3));
    }

    // decompiled from Move bytecode v6
}

