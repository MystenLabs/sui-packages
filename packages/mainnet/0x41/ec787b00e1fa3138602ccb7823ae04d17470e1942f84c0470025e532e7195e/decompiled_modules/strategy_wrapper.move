module 0xba97dc73a07638d03d77ad2161484eb21db577edc9cadcd7035fef4b4f2f6fa1::strategy_wrapper {
    struct StrategyOwnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        inner_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
        strategy_type: u8,
    }

    struct WrappedObligationCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        inner_cap: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>,
        strategy_type: u8,
        relayer_address: address,
    }

    struct RelayerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        wrapped_cap_id: 0x2::object::ID,
        strategy_type: u8,
    }

    struct BorrowReceipt<phantom T0> {
        wrapped_cap_id: 0x2::object::ID,
        borrower: address,
    }

    struct CreatedStrategyOwnerCap has copy, drop {
        cap_id: address,
        obligation_id: address,
        strategy_type: u8,
    }

    struct EjectedInnerCap has copy, drop {
        cap_id: address,
        obligation_id: address,
    }

    struct MigratedStrategyOwnerCap has copy, drop {
        cap_id: address,
        old_version: u64,
        new_version: u64,
    }

    struct ConvertedToWrappedCap has copy, drop {
        strategy_cap_id: address,
        wrapped_cap_id: address,
        relayer_cap_id: address,
        obligation_id: address,
        strategy_type: u8,
        relayer_address: address,
    }

    struct BorrowedObligationCap has copy, drop {
        wrapped_cap_id: address,
        obligation_id: address,
        borrower: address,
    }

    struct ReturnedObligationCap has copy, drop {
        wrapped_cap_id: address,
        obligation_id: address,
        borrower: address,
    }

    public fun assert_current_version<T0>(arg0: &StrategyOwnerCap<T0>) {
        assert!(arg0.version == 1, 1);
    }

    fun assert_version_and_upgrade<T0>(arg0: &mut StrategyOwnerCap<T0>) {
        auto_migrate<T0>(arg0);
        assert!(arg0.version == 1, 1);
    }

    fun auto_migrate<T0>(arg0: &mut StrategyOwnerCap<T0>) {
        if (arg0.version < 1) {
            arg0.version = 1;
            let v0 = MigratedStrategyOwnerCap{
                cap_id      : 0x2::object::id_address<StrategyOwnerCap<T0>>(arg0),
                old_version : arg0.version,
                new_version : 1,
            };
            0x2::event::emit<MigratedStrategyOwnerCap>(v0);
        };
    }

    public fun borrow_from_obligation<T0, T1>(arg0: &StrategyOwnerCap<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_current_version<T0>(arg0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow<T0, T1>(arg1, arg2, &arg0.inner_cap, arg3, arg4, arg5)
    }

    public fun borrow_obligation_cap<T0>(arg0: &mut WrappedObligationCap<T0>, arg1: &RelayerCap<T0>, arg2: &0x2::tx_context::TxContext) : (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, BorrowReceipt<T0>) {
        abort 6
    }

    public fun borrow_sui_from_obligation<T0>(arg0: &StrategyOwnerCap<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_current_version<T0>(arg0);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow_request<T0, 0x2::sui::SUI>(arg1, arg2, &arg0.inner_cap, arg3, arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg1, arg2, &v0, arg5, arg6);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg1, arg2, v0, arg6)
    }

    public(friend) fun borrow_uid<T0>(arg0: &StrategyOwnerCap<T0>) : &0x2::object::UID {
        assert_current_version<T0>(arg0);
        &arg0.id
    }

    public(friend) fun borrow_uid_mut<T0>(arg0: &mut StrategyOwnerCap<T0>) : &mut 0x2::object::UID {
        assert_version_and_upgrade<T0>(arg0);
        &mut arg0.id
    }

    public fun claim_rewards<T0, T1>(arg0: &StrategyOwnerCap<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_current_version<T0>(arg0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T1>(arg1, &arg0.inner_cap, arg2, arg3, arg4, arg5, arg6)
    }

    public fun convert_back_to_strategy_cap<T0>(arg0: WrappedObligationCap<T0>, arg1: RelayerCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : StrategyOwnerCap<T0> {
        abort 6
    }

    public fun convert_to_wrapped_cap<T0>(arg0: StrategyOwnerCap<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (WrappedObligationCap<T0>, RelayerCap<T0>) {
        abort 6
    }

    public fun create_strategy_owner_cap<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : StrategyOwnerCap<T0> {
        assert!(is_valid_strategy_type(arg1), 2);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg0, arg2);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&v0);
        let v2 = StrategyOwnerCap<T0>{
            id            : 0x2::object::new(arg2),
            version       : 1,
            inner_cap     : v0,
            strategy_type : arg1,
        };
        let v3 = CreatedStrategyOwnerCap{
            cap_id        : 0x2::object::id_address<StrategyOwnerCap<T0>>(&v2),
            obligation_id : 0x2::object::id_to_address(&v1),
            strategy_type : v2.strategy_type,
        };
        0x2::event::emit<CreatedStrategyOwnerCap>(v3);
        v2
    }

    public fun deposit_ctokens_into_obligation<T0, T1>(arg0: &StrategyOwnerCap<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_current_version<T0>(arg0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg1, arg2, &arg0.inner_cap, arg3, arg4, arg5);
    }

    public fun deposit_liquidity_and_deposit_into_obligation<T0, T1>(arg0: &StrategyOwnerCap<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_current_version<T0>(arg0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg1, arg2, &arg0.inner_cap, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg1, arg2, arg3, arg4, arg5), arg5);
    }

    public fun get_obligation<T0>(arg0: &StrategyOwnerCap<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T0> {
        assert_current_version<T0>(arg0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.inner_cap))
    }

    public fun get_strategy_type<T0>(arg0: &StrategyOwnerCap<T0>) : u8 {
        assert_current_version<T0>(arg0);
        arg0.strategy_type
    }

    public fun get_version<T0>(arg0: &StrategyOwnerCap<T0>) : u64 {
        arg0.version
    }

    public fun inner_cap<T0>(arg0: &StrategyOwnerCap<T0>) : &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0> {
        assert_current_version<T0>(arg0);
        &arg0.inner_cap
    }

    public fun is_valid_strategy_type(arg0: u8) : bool {
        if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 100) {
            true
        } else if (arg0 == 101) {
            true
        } else {
            arg0 > 0 && arg0 <= 30
        }
    }

    public fun mint_ctokens<T0, T1>(arg0: &StrategyOwnerCap<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>> {
        assert_current_version<T0>(arg0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg1, arg2, arg3, arg4, arg5)
    }

    public fun obligation_id<T0>(arg0: &StrategyOwnerCap<T0>) : 0x2::object::ID {
        assert_current_version<T0>(arg0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.inner_cap)
    }

    public fun redeem_ctokens<T0, T1>(arg0: &StrategyOwnerCap<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_current_version<T0>(arg0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg1, arg2, arg3, arg4, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg5)
    }

    public fun relayer_cap_strategy_type<T0>(arg0: &RelayerCap<T0>) : u8 {
        arg0.strategy_type
    }

    public fun relayer_cap_wrapped_id<T0>(arg0: &RelayerCap<T0>) : 0x2::object::ID {
        arg0.wrapped_cap_id
    }

    public fun return_obligation_cap<T0>(arg0: &mut WrappedObligationCap<T0>, arg1: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, arg2: BorrowReceipt<T0>, arg3: &0x2::tx_context::TxContext) {
        abort 6
    }

    public fun withdraw_ctokens_from_obligation<T0, T1>(arg0: &StrategyOwnerCap<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>> {
        assert_current_version<T0>(arg0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg1, arg2, &arg0.inner_cap, arg3, arg4, arg5)
    }

    public fun withdraw_from_obligation_and_redeem<T0, T1>(arg0: &StrategyOwnerCap<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_current_version<T0>(arg0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg1, arg2, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg1, arg2, &arg0.inner_cap, arg3, arg4, arg5), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg5)
    }

    public fun wrapped_cap_is_borrowed<T0>(arg0: &WrappedObligationCap<T0>) : bool {
        0x1::option::is_none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(&arg0.inner_cap)
    }

    public fun wrapped_cap_relayer_address<T0>(arg0: &WrappedObligationCap<T0>) : address {
        arg0.relayer_address
    }

    public fun wrapped_cap_strategy_type<T0>(arg0: &WrappedObligationCap<T0>) : u8 {
        arg0.strategy_type
    }

    public fun wrapped_cap_version<T0>(arg0: &WrappedObligationCap<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

