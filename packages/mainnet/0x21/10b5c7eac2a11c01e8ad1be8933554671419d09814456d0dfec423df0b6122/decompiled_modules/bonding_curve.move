module 0x2110b5c7eac2a11c01e8ad1be8933554671419d09814456d0dfec423df0b6122::bonding_curve {
    struct BONDING_CURVE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BondingCurve<phantom T0> has store, key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        token_balance: 0x2::balance::Balance<T0>,
        virtual_sui_amt: u64,
        target_supply_threshold: u64,
        swap_fee: u64,
        listing_fee: u64,
        migration_fee: u64,
        is_active: bool,
        creator: address,
        migration_target: u64,
    }

    struct BuyEvent has copy, drop, store {
        bonding_curve_id: 0x2::object::ID,
        issuer: address,
        amount_in: u64,
        amount_out: u64,
        price: u64,
    }

    struct SellEvent has copy, drop, store {
        bonding_curve_id: 0x2::object::ID,
        issuer: address,
        amount_in: u64,
        amount_out: u64,
        price: u64,
    }

    struct BondingCurveCreatedEvent has copy, drop, store {
        bonding_curve_id: 0x2::object::ID,
        issuer: address,
        treasury_cap: 0x2::object::ID,
        coin_metadata: 0x2::object::ID,
        migration_target: u64,
    }

    public fun buy<T0>(arg0: &mut BondingCurve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 4);
        let v0 = 0x2::tx_context::sender(arg4);
        let (v1, v2) = get_token_in_pool<T0>(arg0);
        let v3 = get_token_receive(arg2 - take_fee(arg0.swap_fee, arg2), v1 + arg0.virtual_sui_amt, v2);
        assert!(v3 >= arg3, 1);
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v4, arg2));
        let (v5, v6) = get_token_in_pool<T0>(arg0);
        if (v6 + v3 <= arg0.target_supply_threshold) {
            arg0.is_active = false;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.token_balance, v3, arg4), v0);
        return_back_or_delete<0x2::sui::SUI>(v4, arg4);
        let v7 = BuyEvent{
            bonding_curve_id : 0x2::object::id<BondingCurve<T0>>(arg0),
            issuer           : v0,
            amount_in        : arg2,
            amount_out       : v3,
            price            : ((((v5 as u128) + (arg0.virtual_sui_amt as u128)) * 1000000000000 / (v6 as u128)) as u64),
        };
        0x2::event::emit<BuyEvent>(v7);
    }

    public fun create_bonding_curve<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: &0x2::coin::CoinMetadata<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::get_decimals<T0>(arg1) == 9, 2);
        let v0 = BondingCurve<T0>{
            id                      : 0x2::object::new(arg3),
            sui_balance             : 0x2::balance::zero<0x2::sui::SUI>(),
            token_balance           : 0x2::coin::mint_balance<T0>(arg0, 1000000000000000000),
            virtual_sui_amt         : 1000000000000,
            target_supply_threshold : 300000000000000000,
            swap_fee                : 1,
            listing_fee             : 1000000000,
            migration_fee           : 3000000000,
            is_active               : true,
            creator                 : 0x2::tx_context::sender(arg3),
            migration_target        : arg2,
        };
        let v1 = BondingCurveCreatedEvent{
            bonding_curve_id : 0x2::object::id<BondingCurve<T0>>(&v0),
            issuer           : 0x2::tx_context::sender(arg3),
            treasury_cap     : 0x2::object::id<0x2::coin::TreasuryCap<T0>>(arg0),
            coin_metadata    : 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg1),
            migration_target : arg2,
        };
        0x2::event::emit<BondingCurveCreatedEvent>(v1);
        0x2::transfer::public_share_object<BondingCurve<T0>>(v0);
    }

    fun get_token_in_pool<T0>(arg0: &BondingCurve<T0>) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<T0>(&arg0.token_balance))
    }

    fun get_token_receive(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128);
        ((v0 * (arg2 as u128) / ((arg1 as u128) + v0)) as u64)
    }

    fun init(arg0: BONDING_CURVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    fun return_back_or_delete<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun sell<T0>(arg0: &mut BondingCurve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 4);
        let v0 = 0x2::tx_context::sender(arg4);
        let (v1, v2) = get_token_in_pool<T0>(arg0);
        let v3 = get_token_receive(arg2, v2, v1 + arg0.virtual_sui_amt);
        assert!(v3 >= arg3, 1);
        let v4 = v3 - take_fee(arg0.swap_fee, v3);
        let v5 = 0x2::coin::into_balance<T0>(arg1);
        0x2::balance::join<T0>(&mut arg0.token_balance, 0x2::balance::split<T0>(&mut v5, arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, v4, arg4), v0);
        return_back_or_delete<T0>(v5, arg4);
        let (v6, v7) = get_token_in_pool<T0>(arg0);
        let v8 = SellEvent{
            bonding_curve_id : 0x2::object::id<BondingCurve<T0>>(arg0),
            issuer           : v0,
            amount_in        : arg2,
            amount_out       : v4,
            price            : ((((v6 as u128) + (arg0.virtual_sui_amt as u128)) * 1000000000000 / (v7 as u128)) as u64),
        };
        0x2::event::emit<SellEvent>(v8);
    }

    fun take_fee(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 100
    }

    public entry fun withdraw_for_migration<T0>(arg0: &mut BondingCurve<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), arg2), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.token_balance, 0x2::balance::value<T0>(&arg0.token_balance), arg2), arg1);
    }

    // decompiled from Move bytecode v6
}

