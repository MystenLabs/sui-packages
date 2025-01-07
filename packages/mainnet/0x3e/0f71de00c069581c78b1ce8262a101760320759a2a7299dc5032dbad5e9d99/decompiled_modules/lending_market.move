module 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::lending_market {
    struct LendingMarket<phantom T0> has key {
        id: 0x2::object::UID,
        reserves: vector<0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::Reserve<T0>>,
        reserve_treasuries: 0x2::bag::Bag,
        obligations: 0x2::object_bag::ObjectBag,
    }

    struct LendingMarketOwnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct ObligationOwnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        obligation_id: 0x2::object::ID,
    }

    struct Name<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun borrow<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: &ObligationOwnerCap<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::object_bag::borrow_mut<0x2::object::ID, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::obligation::Obligation<T0>>(&mut arg0.obligations, arg1.obligation_id);
        let v1 = 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::obligation::refresh<T0>(v0, &mut arg0.reserves, arg2);
        let v2 = Name<T1>{dummy_field: false};
        let v3 = 0x2::bag::borrow_mut<Name<T1>, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::ReserveTreasury<T0, T1>>(&mut arg0.reserve_treasuries, v2);
        let v4 = 0x1::vector::borrow_mut<0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::Reserve<T0>>(&mut arg0.reserves, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::reserve_id<T0, T1>(v3));
        0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::obligation::borrow<T0, T1>(v1, v0, v4, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::reserve_id<T0, T1>(v3), arg2, arg3);
        0x2::coin::from_balance<T1>(0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::borrow_liquidity<T0, T1>(v4, v3, arg2, arg3), arg4)
    }

    public fun add_reserve<T0, T1>(arg0: &LendingMarketOwnerCap<T0>, arg1: &mut LendingMarket<T0>, arg2: u256, arg3: 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::ReserveConfig, arg4: &0x2::coin::CoinMetadata<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::create_reserve<T0, T1>(arg3, arg4, arg2, arg5, 0x1::vector::length<0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::Reserve<T0>>(&arg1.reserves));
        0x1::vector::push_back<0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::Reserve<T0>>(&mut arg1.reserves, v0);
        let v2 = Name<T1>{dummy_field: false};
        0x2::bag::add<Name<T1>, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::ReserveTreasury<T0, T1>>(&mut arg1.reserve_treasuries, v2, v1);
    }

    public fun create_lending_market<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : LendingMarketOwnerCap<T0> {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 0);
        let v0 = LendingMarket<T0>{
            id                 : 0x2::object::new(arg1),
            reserves           : 0x1::vector::empty<0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::Reserve<T0>>(),
            reserve_treasuries : 0x2::bag::new(arg1),
            obligations        : 0x2::object_bag::new(arg1),
        };
        0x2::transfer::share_object<LendingMarket<T0>>(v0);
        LendingMarketOwnerCap<T0>{id: 0x2::object::new(arg1)}
    }

    public fun create_obligation<T0>(arg0: &mut LendingMarket<T0>, arg1: &mut 0x2::tx_context::TxContext) : ObligationOwnerCap<T0> {
        let v0 = 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::obligation::create_obligation<T0>(0x2::tx_context::sender(arg1), arg1);
        let v1 = ObligationOwnerCap<T0>{
            id            : 0x2::object::new(arg1),
            obligation_id : 0x2::object::id<0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::obligation::Obligation<T0>>(&v0),
        };
        0x2::object_bag::add<0x2::object::ID, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::obligation::Obligation<T0>>(&mut arg0.obligations, 0x2::object::id<0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::obligation::Obligation<T0>>(&v0), v0);
        v1
    }

    public fun deposit_ctokens_into_obligation<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: &ObligationOwnerCap<T0>, arg2: 0x2::coin::Coin<0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::CToken<T0, T1>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Name<T1>{dummy_field: false};
        0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::obligation::deposit<T0, T1>(0x2::object_bag::borrow_mut<0x2::object::ID, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::obligation::Obligation<T0>>(&mut arg0.obligations, arg1.obligation_id), 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::reserve_id<T0, T1>(0x2::bag::borrow_mut<Name<T1>, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::ReserveTreasury<T0, T1>>(&mut arg0.reserve_treasuries, v0)), 0x2::coin::into_balance<0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::CToken<T0, T1>>(arg2));
    }

    public fun deposit_liquidity_and_mint_ctokens<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::CToken<T0, T1>> {
        let v0 = Name<T1>{dummy_field: false};
        let v1 = 0x2::bag::borrow_mut<Name<T1>, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::ReserveTreasury<T0, T1>>(&mut arg0.reserve_treasuries, v0);
        0x2::coin::from_balance<0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::CToken<T0, T1>>(0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::deposit_liquidity_and_mint_ctokens<T0, T1>(0x1::vector::borrow_mut<0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::Reserve<T0>>(&mut arg0.reserves, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::reserve_id<T0, T1>(v1)), v1, 0x2::coin::into_balance<T1>(arg2), arg1), arg3)
    }

    fun find_obligation<T0>(arg0: &mut LendingMarket<T0>, arg1: &ObligationOwnerCap<T0>) : &mut 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::obligation::Obligation<T0> {
        0x2::object_bag::borrow_mut<0x2::object::ID, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::obligation::Obligation<T0>>(&mut arg0.obligations, arg1.obligation_id)
    }

    fun find_reserve<T0, T1>(arg0: &mut LendingMarket<T0>) : (&mut 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::Reserve<T0>, &mut 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::ReserveTreasury<T0, T1>) {
        let v0 = Name<T1>{dummy_field: false};
        let v1 = 0x2::bag::borrow_mut<Name<T1>, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::ReserveTreasury<T0, T1>>(&mut arg0.reserve_treasuries, v0);
        (0x1::vector::borrow_mut<0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::Reserve<T0>>(&mut arg0.reserves, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::reserve_id<T0, T1>(v1)), v1)
    }

    fun get_reserve<T0, T1>(arg0: &LendingMarket<T0>) : (&0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::Reserve<T0>, &0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::ReserveTreasury<T0, T1>) {
        let v0 = Name<T1>{dummy_field: false};
        let v1 = 0x2::bag::borrow<Name<T1>, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::ReserveTreasury<T0, T1>>(&arg0.reserve_treasuries, v0);
        (0x1::vector::borrow<0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::Reserve<T0>>(&arg0.reserves, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::reserve_id<T0, T1>(v1)), v1)
    }

    fun get_reserve_mut<T0, T1>(arg0: &mut LendingMarket<T0>) : (&mut 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::Reserve<T0>, &mut 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::ReserveTreasury<T0, T1>) {
        let v0 = Name<T1>{dummy_field: false};
        let v1 = 0x2::bag::borrow_mut<Name<T1>, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::ReserveTreasury<T0, T1>>(&mut arg0.reserve_treasuries, v0);
        (0x1::vector::borrow_mut<0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::Reserve<T0>>(&mut arg0.reserves, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::reserve_id<T0, T1>(v1)), v1)
    }

    public fun liquidate<T0, T1, T2>(arg0: &mut LendingMarket<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        let v0 = 0x2::object_bag::remove<0x2::object::ID, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        let (v1, v2) = get_reserve<T0, T1>(arg0);
        let (v3, v4) = get_reserve<T0, T2>(arg0);
        let v5 = 0x2::coin::into_balance<T1>(arg3);
        let (v6, v7) = 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::obligation::liquidate<T0, T1, T2>(0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::obligation::refresh<T0>(&mut v0, &mut arg0.reserves, arg2), &mut v0, v1, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::reserve_id<T0, T1>(v2), v3, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::reserve_id<T0, T2>(v4), arg2, &v5);
        let (v8, v9) = get_reserve_mut<T0, T1>(arg0);
        0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::repay_liquidity<T0, T1>(v8, v9, arg2, 0x2::balance::split<T1>(&mut v5, v7));
        let (v10, v11) = get_reserve_mut<T0, T2>(arg0);
        let v12 = 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::redeem_ctokens<T0, T2>(v10, v11, v6, arg2);
        let v13 = 7;
        0x1::debug::print<u64>(&v13);
        let v14 = 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::ctoken_ratio<T0>(v10);
        0x1::debug::print<0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::decimal::Decimal>(&v14);
        0x1::debug::print<0x2::balance::Balance<T2>>(&v12);
        0x2::object_bag::add<0x2::object::ID, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::obligation::Obligation<T0>>(&mut arg0.obligations, 0x2::object::id<0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::obligation::Obligation<T0>>(&v0), v0);
        (0x2::coin::from_balance<T1>(v5, arg4), 0x2::coin::from_balance<T2>(v12, arg4))
    }

    public fun obligation_id<T0>(arg0: &ObligationOwnerCap<T0>) : 0x2::object::ID {
        arg0.obligation_id
    }

    public fun repay<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Name<T1>{dummy_field: false};
        let v1 = 0x2::bag::borrow_mut<Name<T1>, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::ReserveTreasury<T0, T1>>(&mut arg0.reserve_treasuries, v0);
        let v2 = 0x1::vector::borrow_mut<0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::Reserve<T0>>(&mut arg0.reserves, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::reserve_id<T0, T1>(v1));
        0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::obligation::repay<T0>(0x2::object_bag::borrow_mut<0x2::object::ID, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::obligation::Obligation<T0>>(&mut arg0.obligations, arg1), v2, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::reserve_id<T0, T1>(v1), 0x2::coin::value<T1>(&arg3));
        0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::repay_liquidity<T0, T1>(v2, v1, arg2, 0x2::coin::into_balance<T1>(arg3));
    }

    public fun update_reserve_config<T0, T1>(arg0: &LendingMarketOwnerCap<T0>, arg1: &mut LendingMarket<T0>, arg2: 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::ReserveConfig, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = get_reserve_mut<T0, T1>(arg1);
        0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::update_reserve_config<T0>(v0, arg2);
    }

    public fun withdraw<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: &ObligationOwnerCap<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::object_bag::borrow_mut<0x2::object::ID, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::obligation::Obligation<T0>>(&mut arg0.obligations, arg1.obligation_id);
        let v1 = 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::obligation::refresh<T0>(v0, &mut arg0.reserves, arg2);
        let v2 = Name<T1>{dummy_field: false};
        let v3 = 0x2::bag::borrow_mut<Name<T1>, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::ReserveTreasury<T0, T1>>(&mut arg0.reserve_treasuries, v2);
        let v4 = 0x1::vector::borrow_mut<0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::Reserve<T0>>(&mut arg0.reserves, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::reserve_id<T0, T1>(v3));
        0x2::coin::from_balance<T1>(0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::redeem_ctokens<T0, T1>(v4, v3, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::obligation::withdraw<T0, T1>(v1, v0, v4, 0x3e0f71de00c069581c78b1ce8262a101760320759a2a7299dc5032dbad5e9d99::reserve::reserve_id<T0, T1>(v3), arg2, arg3), arg2), arg4)
    }

    // decompiled from Move bytecode v6
}

