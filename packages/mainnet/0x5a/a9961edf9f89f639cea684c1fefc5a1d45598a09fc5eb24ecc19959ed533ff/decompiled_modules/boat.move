module 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat {
    struct BOAT has drop {
        dummy_field: bool,
    }

    struct BOATPool has key {
        id: 0x2::object::UID,
        is_locked: bool,
        boat_coin: 0x2::object_bag::ObjectBag,
        bonding_curves: 0x2::object_bag::ObjectBag,
    }

    struct BondingCurve<phantom T0> has store, key {
        id: 0x2::object::UID,
        maximum_boat_supply: u64,
        reserve: 0x2::balance::Balance<T0>,
        total_minted_boat: u64,
        kind: 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::bonding_curve::LinearBondingCurve,
    }

    public fun total_supply(arg0: &BOATPool) : u64 {
        0x2::coin::total_supply<BOAT>(0x2::object_bag::borrow<vector<u8>, 0x2::coin::TreasuryCap<BOAT>>(&arg0.boat_coin, b"treasury_cap"))
    }

    fun new(arg0: 0x2::coin::TreasuryCap<BOAT>, arg1: 0x2::coin::CoinMetadata<BOAT>, arg2: &mut 0x2::tx_context::TxContext) : BOATPool {
        let v0 = 0x2::object_bag::new(arg2);
        0x2::object_bag::add<vector<u8>, 0x2::coin::TreasuryCap<BOAT>>(&mut v0, b"treasury_cap", arg0);
        0x2::object_bag::add<vector<u8>, 0x2::coin::CoinMetadata<BOAT>>(&mut v0, b"coin_metadata", arg1);
        let v1 = 0x2::object_bag::new(arg2);
        let v2 = BondingCurve<0x2::sui::SUI>{
            id                  : 0x2::object::new(arg2),
            maximum_boat_supply : 18446744073709551615,
            reserve             : 0x2::balance::zero<0x2::sui::SUI>(),
            total_minted_boat   : 0,
            kind                : 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::bonding_curve::ilbc(0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::utils::precision_scalar() / 1),
        };
        0x2::object_bag::add<0x1::type_name::TypeName, BondingCurve<0x2::sui::SUI>>(&mut v1, 0x1::type_name::get<0x2::sui::SUI>(), v2);
        BOATPool{
            id             : 0x2::object::new(arg2),
            is_locked      : false,
            boat_coin      : v0,
            bonding_curves : v1,
        }
    }

    public fun add_bonding_curve<T0>(arg0: &mut BOATPool, arg1: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::admin::AdminCap, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = BondingCurve<T0>{
            id                  : 0x2::object::new(arg3),
            maximum_boat_supply : 18446744073709551615,
            reserve             : 0x2::balance::zero<T0>(),
            total_minted_boat   : 0,
            kind                : 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::bonding_curve::ilbc(arg2),
        };
        0x2::object_bag::add<0x1::type_name::TypeName, BondingCurve<T0>>(&mut arg0.bonding_curves, 0x1::type_name::get<T0>(), v0);
    }

    public fun buy_boat<T0>(arg0: &mut BOATPool, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64) : 0x2::balance::Balance<BOAT> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!arg0.is_locked, 9223372706870067207);
        assert!(v0 != 0x1::type_name::get<BOAT>(), 9223372711164903429);
        assert!(exists_for_token<T0>(arg0), 9223372715459739651);
        let v1 = 0x2::object_bag::borrow_mut<0x1::type_name::TypeName, BondingCurve<T0>>(&mut arg0.bonding_curves, v0);
        v1.total_minted_boat = v1.total_minted_boat + arg2;
        if (v1.total_minted_boat > v1.maximum_boat_supply) {
            abort 9223372762704248833
        };
        0x2::balance::join<T0>(&mut v1.reserve, 0x2::balance::split<T0>(arg1, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::bonding_curve::how_many_y_to_spend_to_mint_x(v1.kind, v1.total_minted_boat, arg2)));
        0x2::coin::mint_balance<BOAT>(0x2::object_bag::borrow_mut<vector<u8>, 0x2::coin::TreasuryCap<BOAT>>(&mut arg0.boat_coin, b"treasury_cap"), arg2)
    }

    public fun buy_max_boat<T0>(arg0: &mut BOATPool, arg1: &mut 0x2::balance::Balance<T0>) : 0x2::balance::Balance<BOAT> {
        let v0 = price_in_boat<T0>(arg0, 0x2::balance::value<T0>(arg1));
        buy_boat<T0>(arg0, arg1, v0)
    }

    public fun exists_for_token<T0>(arg0: &BOATPool) : bool {
        0x2::object_bag::contains<0x1::type_name::TypeName>(&arg0.bonding_curves, 0x1::type_name::get<T0>())
    }

    fun init(arg0: BOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOAT>(arg0, 9, b"BOAT", b"BOAT", b"Utility token for boat.fun", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = new(v3, v2, arg1);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::event::emit_boat_pool_created(0x1::type_name::into_string(0x1::type_name::get<BOAT>()), 0x2::object::id<0x2::coin::TreasuryCap<BOAT>>(&v3), 0x2::object::id<0x2::coin::CoinMetadata<BOAT>>(&v2), 0x2::object::id<BOATPool>(&v4), 0x2::object::id<0x2::object_bag::ObjectBag>(&v4.bonding_curves));
        0x2::transfer::share_object<BOATPool>(v4);
    }

    public(friend) fun lock_trading(arg0: &mut BOATPool) {
        arg0.is_locked = true;
    }

    public fun one_full_boat() : u64 {
        0x1::u64::pow(10, 9)
    }

    public fun price_for_one_boat<T0>(arg0: &BOATPool) : u256 {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<BOAT>()) {
            return 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::utils::precision_scalar()
        };
        assert!(exists_for_token<T0>(arg0), 9223373278100455427);
        let v1 = 0x2::object_bag::borrow<0x1::type_name::TypeName, BondingCurve<T0>>(&arg0.bonding_curves, v0);
        (0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::bonding_curve::how_many_x_to_mint_for_y(v1.kind, v1.total_minted_boat, one_full_boat()) as u256) * 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::utils::precision_scalar() / (one_full_boat() as u256)
    }

    public fun price_in_boat<T0>(arg0: &BOATPool, arg1: u64) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<BOAT>()) {
            return arg1
        };
        assert!(exists_for_token<T0>(arg0), 9223373183611174915);
        let v1 = 0x2::object_bag::borrow<0x1::type_name::TypeName, BondingCurve<T0>>(&arg0.bonding_curves, v0);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::bonding_curve::how_many_x_to_mint_for_y(v1.kind, v1.total_minted_boat, arg1)
    }

    public fun sell_boat<T0>(arg0: &mut BOATPool, arg1: 0x2::balance::Balance<BOAT>) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!arg0.is_locked, 9223372874373791751);
        assert!(v0 != 0x1::type_name::get<BOAT>(), 9223372878668627973);
        assert!(exists_for_token<T0>(arg0), 9223372882963464195);
        let v1 = 0x2::balance::value<BOAT>(&arg1);
        0x2::balance::decrease_supply<BOAT>(0x2::coin::supply_mut<BOAT>(0x2::object_bag::borrow_mut<vector<u8>, 0x2::coin::TreasuryCap<BOAT>>(&mut arg0.boat_coin, b"treasury_cap")), arg1);
        let v2 = 0x2::object_bag::borrow_mut<0x1::type_name::TypeName, BondingCurve<T0>>(&mut arg0.bonding_curves, v0);
        v2.total_minted_boat = v2.total_minted_boat - v1;
        0x2::balance::split<T0>(&mut v2.reserve, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::bonding_curve::how_many_y_to_receive_to_burn_x(v2.kind, v2.total_minted_boat, v1))
    }

    public fun set_bonding_curve_maximum_boat_supply<T0>(arg0: &mut BOATPool, arg1: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::admin::AdminCap, arg2: u64) {
        0x2::object_bag::borrow_mut<0x1::type_name::TypeName, BondingCurve<T0>>(&mut arg0.bonding_curves, 0x1::type_name::get<T0>()).maximum_boat_supply = arg2;
    }

    public(friend) fun unlock_trading(arg0: &mut BOATPool) {
        arg0.is_locked = false;
    }

    // decompiled from Move bytecode v6
}

