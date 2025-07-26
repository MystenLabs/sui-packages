module 0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::ydUsd {
    struct MintBurnCap has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<YDUSD>,
        whitelisted_collateral: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct RedemptionRequestReceipt<phantom T0> has key {
        id: 0x2::object::UID,
        redeemable_ydUsd: 0x2::balance::Balance<YDUSD>,
        collateral_amount: u64,
        redemption_timestamp: u64,
    }

    struct YDUSD has drop {
        dummy_field: bool,
    }

    struct CollateralManagerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Minted has copy, drop {
        minter: address,
        collateral_coin: 0x1::type_name::TypeName,
        collateral_amount_in: u64,
        amount_ydusd_minted: u64,
    }

    struct Redeemed has copy, drop {
        redeemer: address,
        token_redeemed: 0x1::type_name::TypeName,
        amount_redeemed: u64,
    }

    struct RedemptionRequestCreated has copy, drop {
        amount: u64,
        redemption_timestamp: u64,
    }

    public fun mint<T0>(arg0: &mut MintBurnCap, arg1: &mut 0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::StrategyManager, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<YDUSD> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert_collateral_whitelisted<T0>(arg0);
        assert_in_more_than_min(v0);
        0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::deposit_to_buffer<T0>(arg2, arg1);
        let v1 = Minted{
            minter               : 0x2::tx_context::sender(arg3),
            collateral_coin      : 0x1::type_name::get<T0>(),
            collateral_amount_in : v0,
            amount_ydusd_minted  : v0,
        };
        0x2::event::emit<Minted>(v1);
        0x2::coin::mint<YDUSD>(&mut arg0.cap, v0, arg3)
    }

    public fun update_yield_accrued(arg0: &MintBurnCap, arg1: &mut 0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::StrategyManager) {
        0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::update_yield_accrued(arg1, 0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::get_total_collateral_value(arg1) - get_total_supply(arg0));
    }

    fun assert_collateral_whitelisted<T0>(arg0: &MintBurnCap) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelisted_collateral, &v0), 13906835424178995203);
    }

    fun assert_in_more_than_min(arg0: u64) {
        assert!(arg0 > 1000000, 13906835449948930053);
    }

    fun assert_sufficient_buffer<T0>(arg0: &0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::StrategyManager, arg1: u64) {
        assert!(0x2::balance::value<T0>(0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::get_buffer_read_only<T0>(arg0)) > arg1, 13906835492898340863);
    }

    fun assert_timestamp_passed(arg0: u64, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) > arg0, 13906835514373177343);
    }

    public fun fullfill_redemption_request<T0>(arg0: RedemptionRequestReceipt<T0>, arg1: &mut 0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::StrategyManager, arg2: &mut MintBurnCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let RedemptionRequestReceipt {
            id                   : v0,
            redeemable_ydUsd     : v1,
            collateral_amount    : v2,
            redemption_timestamp : v3,
        } = arg0;
        assert_timestamp_passed(v3, arg3);
        assert_sufficient_buffer<T0>(arg1, v2);
        0x2::object::delete(v0);
        0x2::coin::burn<YDUSD>(&mut arg2.cap, 0x2::coin::from_balance<YDUSD>(v1, arg4));
        let v4 = Redeemed{
            redeemer        : 0x2::tx_context::sender(arg4),
            token_redeemed  : 0x1::type_name::get<T0>(),
            amount_redeemed : v2,
        };
        0x2::event::emit<Redeemed>(v4);
        0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::withdraw_from_buffer<T0>(v2, arg1, arg4)
    }

    public fun get_total_supply(arg0: &MintBurnCap) : u64 {
        0x2::coin::total_supply<YDUSD>(&arg0.cap)
    }

    public fun get_whitelisted_collateral(arg0: &MintBurnCap) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.whitelisted_collateral
    }

    fun init(arg0: YDUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CollateralManagerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<CollateralManagerCap>(v0, 0x2::tx_context::sender(arg1));
        let (v1, v2) = 0x2::coin::create_currency<YDUSD>(arg0, 6, b"ydUSD", b"Ydor USD", b"Ydor USD unlocks utility for stablecoins in money markets", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YDUSD>>(v2);
        let v3 = MintBurnCap{
            id                     : 0x2::object::new(arg1),
            cap                    : v1,
            whitelisted_collateral : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::public_share_object<MintBurnCap>(v3);
    }

    public fun initiate_redemption<T0>(arg0: 0x2::coin::Coin<YDUSD>, arg1: &mut 0x2::tx_context::TxContext, arg2: &0x2::clock::Clock) : RedemptionRequestReceipt<T0> {
        let v0 = 0x2::coin::value<YDUSD>(&arg0);
        assert_in_more_than_min(v0);
        let v1 = 0x2::clock::timestamp_ms(arg2) + 86400000;
        let v2 = RedemptionRequestReceipt<T0>{
            id                   : 0x2::object::new(arg1),
            redeemable_ydUsd     : 0x2::coin::into_balance<YDUSD>(arg0),
            collateral_amount    : v0,
            redemption_timestamp : v1,
        };
        let v3 = RedemptionRequestCreated{
            amount               : v0,
            redemption_timestamp : v1,
        };
        0x2::event::emit<RedemptionRequestCreated>(v3);
        v2
    }

    public fun is_collateral_whitelisted<T0>(arg0: &MintBurnCap) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelisted_collateral, &v0)
    }

    public fun offboard_collateral<T0>(arg0: &CollateralManagerCap, arg1: &mut MintBurnCap, arg2: &mut 0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::StrategyManager, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.whitelisted_collateral, &v0);
        0x2::coin::from_balance<T0>(0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::destroy_collateral_buffer<T0>(arg2), arg3)
    }

    public fun onboard_collateral<T0>(arg0: &CollateralManagerCap, arg1: &mut MintBurnCap, arg2: &mut 0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::StrategyManager) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.whitelisted_collateral, 0x1::type_name::get<T0>());
        0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager::create_collateral_buffer<T0>(arg2);
    }

    // decompiled from Move bytecode v6
}

