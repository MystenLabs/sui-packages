module 0xfffa49c6c4dbf9ab1a9dd15e7fdec2a6c1824148cd9c8013059141fab5978377::suilend_margin_account {
    struct EventNewMarginAccount has copy, drop {
        protected_margin_account_id: 0x2::object::ID,
        protected_margin_account_cap_id: 0x2::object::ID,
        rfq_account_id: 0x2::object::ID,
    }

    struct EventRfqAccountSet has copy, drop {
        protected_margin_account_id: 0x2::object::ID,
        protected_margin_account_cap_id: 0x2::object::ID,
        rfq_account_id: 0x2::object::ID,
    }

    struct ProtectedMarginAccount has key {
        id: 0x2::object::UID,
        obligation_cap: 0x2::borrow::Referent<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>,
        rfq_account_id: 0x2::object::ID,
    }

    struct ProtectedMarginAccountCap has store, key {
        id: 0x2::object::UID,
        protected_margin_account_id: 0x2::object::ID,
    }

    public(friend) fun assert_for_account(arg0: &ProtectedMarginAccount, arg1: &0x3236de80fab6042a0b3a1b89d8c4d12733652727a1d451a5d0470ed17416ca8e::rfq_account::Account) {
        assert!(arg0.rfq_account_id == 0x2::object::id<0x3236de80fab6042a0b3a1b89d8c4d12733652727a1d451a5d0470ed17416ca8e::rfq_account::Account>(arg1), 0);
    }

    fun assert_for_margin_account(arg0: &ProtectedMarginAccountCap, arg1: &ProtectedMarginAccount) {
        assert!(0x2::object::uid_to_inner(&arg1.id) == arg0.protected_margin_account_id, 0);
    }

    public(friend) fun borrow_liquidity<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg0, arg2, arg1, arg4, arg3);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg0, arg2, &v0, arg5, arg6);
            return 0x8de3003dfbbb997a906cb5bdf39a8ff24876ccc07b1e55f9a65462c67fa931c6::any::cast<0x2::coin::Coin<T0>>(0x8de3003dfbbb997a906cb5bdf39a8ff24876ccc07b1e55f9a65462c67fa931c6::any::new<0x2::coin::Coin<0x2::sui::SUI>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg0, arg2, v0, arg6), arg6))
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg0, arg2, arg1, arg4, arg3, arg6)
    }

    public fun borrow_obligation_cap(arg0: &mut ProtectedMarginAccount, arg1: &ProtectedMarginAccountCap) : (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, 0x2::borrow::Borrow) {
        assert_for_margin_account(arg1, arg0);
        0x2::borrow::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&mut arg0.obligation_cap)
    }

    public fun create(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: &0x3236de80fab6042a0b3a1b89d8c4d12733652727a1d451a5d0470ed17416ca8e::rfq_account::AccountCap, arg2: &mut 0x2::tx_context::TxContext) : ProtectedMarginAccountCap {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg0, arg2);
        create_for_obligation_cap(v0, arg1, arg2)
    }

    public fun create_for_obligation_cap(arg0: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: &0x3236de80fab6042a0b3a1b89d8c4d12733652727a1d451a5d0470ed17416ca8e::rfq_account::AccountCap, arg2: &mut 0x2::tx_context::TxContext) : ProtectedMarginAccountCap {
        let (v0, v1) = internal_create_for_obligation_cap(arg0, arg1, arg2);
        0x2::transfer::share_object<ProtectedMarginAccount>(v1);
        v0
    }

    public fun deposit_collateral<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: &mut ProtectedMarginAccount, arg2: &ProtectedMarginAccountCap, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0x2::tx_context::TxContext) {
        assert_for_margin_account(arg2, arg1);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg0);
        let (v1, v2) = 0x2::borrow::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&mut arg1.obligation_cap);
        let v3 = v1;
        deposit_liquidity<T0>(arg0, &v3, v0, arg3, arg4, arg5, arg6);
        0x2::borrow::put_back<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&mut arg1.obligation_cap, v3, v2);
    }

    public(friend) fun deposit_liquidity<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg0, arg2, arg1, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg0, arg2, arg4, arg3, arg6), arg6);
        if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::rebalance_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg0, arg2, arg5, arg6);
        };
    }

    public fun destroy_margin_account(arg0: ProtectedMarginAccount, arg1: ProtectedMarginAccountCap) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL> {
        assert_for_margin_account(&arg1, &arg0);
        let ProtectedMarginAccountCap {
            id                          : v0,
            protected_margin_account_id : _,
        } = arg1;
        0x2::object::delete(v0);
        let ProtectedMarginAccount {
            id             : v2,
            obligation_cap : v3,
            rfq_account_id : _,
        } = arg0;
        0x2::object::delete(v2);
        0x2::borrow::destroy<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(v3)
    }

    fun internal_create_for_obligation_cap(arg0: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: &0x3236de80fab6042a0b3a1b89d8c4d12733652727a1d451a5d0470ed17416ca8e::rfq_account::AccountCap, arg2: &mut 0x2::tx_context::TxContext) : (ProtectedMarginAccountCap, ProtectedMarginAccount) {
        let v0 = ProtectedMarginAccount{
            id             : 0x2::object::new(arg2),
            obligation_cap : 0x2::borrow::new<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(arg0, arg2),
            rfq_account_id : 0x3236de80fab6042a0b3a1b89d8c4d12733652727a1d451a5d0470ed17416ca8e::rfq_account::account_cap_rfq_account_id(arg1),
        };
        let v1 = ProtectedMarginAccountCap{
            id                          : 0x2::object::new(arg2),
            protected_margin_account_id : 0x2::object::uid_to_inner(&v0.id),
        };
        let v2 = EventNewMarginAccount{
            protected_margin_account_id     : 0x2::object::uid_to_inner(&v0.id),
            protected_margin_account_cap_id : 0x2::object::uid_to_inner(&v1.id),
            rfq_account_id                  : 0x3236de80fab6042a0b3a1b89d8c4d12733652727a1d451a5d0470ed17416ca8e::rfq_account::account_cap_rfq_account_id(arg1),
        };
        0x2::event::emit<EventNewMarginAccount>(v2);
        (v1, v0)
    }

    public fun repay_debt_for_margin_account<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: &mut ProtectedMarginAccount, arg2: &ProtectedMarginAccountCap, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_for_margin_account(arg2, arg1);
        let (v0, v1) = 0x2::borrow::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&mut arg1.obligation_cap);
        let v2 = v0;
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::repay<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg0), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(&v2), arg4, &mut arg3, arg5);
        0x2::borrow::put_back<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&mut arg1.obligation_cap, v2, v1);
        if (0x2::coin::value<T0>(&arg3) == 0) {
            0x2::coin::destroy_zero<T0>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg5));
        };
    }

    public fun return_obligation_cap(arg0: &mut ProtectedMarginAccount, arg1: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: 0x2::borrow::Borrow) {
        0x2::borrow::put_back<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&mut arg0.obligation_cap, arg1, arg2);
    }

    public(friend) fun unsafe_borrow_obligation_cap(arg0: &mut ProtectedMarginAccount) : (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, 0x2::borrow::Borrow) {
        0x2::borrow::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&mut arg0.obligation_cap)
    }

    public fun update_rfq_account(arg0: &mut ProtectedMarginAccount, arg1: &ProtectedMarginAccountCap, arg2: &0x3236de80fab6042a0b3a1b89d8c4d12733652727a1d451a5d0470ed17416ca8e::rfq_account::Account) {
        assert_for_margin_account(arg1, arg0);
        arg0.rfq_account_id = 0x2::object::id<0x3236de80fab6042a0b3a1b89d8c4d12733652727a1d451a5d0470ed17416ca8e::rfq_account::Account>(arg2);
        let v0 = EventRfqAccountSet{
            protected_margin_account_id     : 0x2::object::id<ProtectedMarginAccount>(arg0),
            protected_margin_account_cap_id : 0x2::object::id<ProtectedMarginAccountCap>(arg1),
            rfq_account_id                  : 0x2::object::id<0x3236de80fab6042a0b3a1b89d8c4d12733652727a1d451a5d0470ed17416ca8e::rfq_account::Account>(arg2),
        };
        0x2::event::emit<EventRfqAccountSet>(v0);
    }

    public(friend) fun withdraw_collateral<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg0, arg2, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg0, arg2, arg1, arg4, arg3, arg6), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(), arg6);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg0, arg2, &v0, arg5, arg6);
            return 0x8de3003dfbbb997a906cb5bdf39a8ff24876ccc07b1e55f9a65462c67fa931c6::any::cast<0x2::coin::Coin<T0>>(0x8de3003dfbbb997a906cb5bdf39a8ff24876ccc07b1e55f9a65462c67fa931c6::any::new<0x2::coin::Coin<0x2::sui::SUI>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg0, arg2, v0, arg6), arg6))
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg0, arg2, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg0, arg2, arg1, arg4, arg3, arg6), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(), arg6)
    }

    // decompiled from Move bytecode v6
}

