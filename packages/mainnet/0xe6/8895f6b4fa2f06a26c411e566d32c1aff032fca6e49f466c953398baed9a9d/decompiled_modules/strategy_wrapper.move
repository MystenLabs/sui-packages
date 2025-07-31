module 0xe68895f6b4fa2f06a26c411e566d32c1aff032fca6e49f466c953398baed9a9d::strategy_wrapper {
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
        assert!(arg0.version == 1, 1);
        assert!(arg1.wrapped_cap_id == 0x2::object::id<WrappedObligationCap<T0>>(arg0), 3);
        assert!(0x2::tx_context::sender(arg2) == arg0.relayer_address, 3);
        assert!(0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(&arg0.inner_cap), 4);
        let v0 = 0x1::option::extract<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(&mut arg0.inner_cap);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&v0);
        let v2 = 0x2::tx_context::sender(arg2);
        let v3 = BorrowReceipt<T0>{
            wrapped_cap_id : 0x2::object::id<WrappedObligationCap<T0>>(arg0),
            borrower       : v2,
        };
        let v4 = BorrowedObligationCap{
            wrapped_cap_id : 0x2::object::id_address<WrappedObligationCap<T0>>(arg0),
            obligation_id  : 0x2::object::id_to_address(&v1),
            borrower       : v2,
        };
        0x2::event::emit<BorrowedObligationCap>(v4);
        (v0, v3)
    }

    public(friend) fun borrow_uid<T0>(arg0: &StrategyOwnerCap<T0>) : &0x2::object::UID {
        assert_current_version<T0>(arg0);
        &arg0.id
    }

    public(friend) fun borrow_uid_mut<T0>(arg0: &mut StrategyOwnerCap<T0>) : &mut 0x2::object::UID {
        assert_version_and_upgrade<T0>(arg0);
        &mut arg0.id
    }

    public fun convert_back_to_strategy_cap<T0>(arg0: WrappedObligationCap<T0>, arg1: RelayerCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : StrategyOwnerCap<T0> {
        assert!(arg0.version == 1, 1);
        assert!(arg1.wrapped_cap_id == 0x2::object::id<WrappedObligationCap<T0>>(&arg0), 3);
        assert!(0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(&arg0.inner_cap), 4);
        let WrappedObligationCap {
            id              : v0,
            version         : _,
            inner_cap       : v2,
            strategy_type   : v3,
            relayer_address : _,
        } = arg0;
        let RelayerCap {
            id             : v5,
            wrapped_cap_id : _,
            strategy_type  : _,
        } = arg1;
        0x2::object::delete(v0);
        0x2::object::delete(v5);
        StrategyOwnerCap<T0>{
            id            : 0x2::object::new(arg2),
            version       : 1,
            inner_cap     : 0x1::option::destroy_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(v2),
            strategy_type : v3,
        }
    }

    public fun convert_to_wrapped_cap<T0>(arg0: StrategyOwnerCap<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (WrappedObligationCap<T0>, RelayerCap<T0>) {
        let v0 = &mut arg0;
        assert_version_and_upgrade<T0>(v0);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.inner_cap);
        let StrategyOwnerCap {
            id            : v2,
            version       : _,
            inner_cap     : v4,
            strategy_type : v5,
        } = arg0;
        0x2::object::delete(v2);
        let v6 = WrappedObligationCap<T0>{
            id              : 0x2::object::new(arg2),
            version         : 1,
            inner_cap       : 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(v4),
            strategy_type   : v5,
            relayer_address : arg1,
        };
        let v7 = RelayerCap<T0>{
            id             : 0x2::object::new(arg2),
            wrapped_cap_id : 0x2::object::id<WrappedObligationCap<T0>>(&v6),
            strategy_type  : v5,
        };
        let v8 = ConvertedToWrappedCap{
            strategy_cap_id : 0x2::object::id_address<StrategyOwnerCap<T0>>(&arg0),
            wrapped_cap_id  : 0x2::object::id_address<WrappedObligationCap<T0>>(&v6),
            relayer_cap_id  : 0x2::object::id_address<RelayerCap<T0>>(&v7),
            obligation_id   : 0x2::object::id_to_address(&v1),
            strategy_type   : v5,
            relayer_address : arg1,
        };
        0x2::event::emit<ConvertedToWrappedCap>(v8);
        (v6, v7)
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

    public fun deposit_liquidity_and_deposit_into_obligation<T0, T1>(arg0: &StrategyOwnerCap<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_current_version<T0>(arg0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg1, arg2, &arg0.inner_cap, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg1, arg2, arg3, arg4, arg5), arg5);
        0x2::coin::zero<T0>(arg5)
    }

    public(friend) fun eject<T0>(arg0: StrategyOwnerCap<T0>, arg1: &0x2::tx_context::TxContext) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0> {
        let v0 = &mut arg0;
        assert_version_and_upgrade<T0>(v0);
        let StrategyOwnerCap {
            id            : v1,
            version       : _,
            inner_cap     : v3,
            strategy_type : _,
        } = arg0;
        let v5 = v3;
        let v6 = v1;
        let v7 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&v5);
        0x2::object::delete(v6);
        let v8 = EjectedInnerCap{
            cap_id        : 0x2::object::uid_to_address(&v6),
            obligation_id : 0x2::object::id_to_address(&v7),
        };
        0x2::event::emit<EjectedInnerCap>(v8);
        v5
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
        arg0 == 1 || arg0 == 2
    }

    public fun mint_ctokens<T0, T1>(arg0: &StrategyOwnerCap<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>> {
        assert_current_version<T0>(arg0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg1, arg2, arg3, arg4, arg5)
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
        assert!(arg0.version == 1, 1);
        assert!(arg2.wrapped_cap_id == 0x2::object::id<WrappedObligationCap<T0>>(arg0), 3);
        assert!(0x2::tx_context::sender(arg3) == arg2.borrower, 3);
        assert!(0x1::option::is_none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(&arg0.inner_cap), 5);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg1);
        0x1::option::fill<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(&mut arg0.inner_cap, arg1);
        let BorrowReceipt {
            wrapped_cap_id : _,
            borrower       : v2,
        } = arg2;
        let v3 = ReturnedObligationCap{
            wrapped_cap_id : 0x2::object::id_address<WrappedObligationCap<T0>>(arg0),
            obligation_id  : 0x2::object::id_to_address(&v0),
            borrower       : v2,
        };
        0x2::event::emit<ReturnedObligationCap>(v3);
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

    // decompiled from Move bytecode v6
}

