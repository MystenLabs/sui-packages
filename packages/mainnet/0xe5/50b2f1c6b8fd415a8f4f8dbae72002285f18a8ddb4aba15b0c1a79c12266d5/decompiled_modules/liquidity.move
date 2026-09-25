module 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::liquidity {
    struct ReserveKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Reserve has store {
        position: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        pool: 0x1::option::Option<0x2::object::ID>,
    }

    struct PolSwap {
        index: 0x2::object::ID,
        from: 0x1::type_name::TypeName,
        to: 0x1::type_name::TypeName,
        amount_in: u64,
        min_out: u64,
    }

    struct PolMint {
        index: 0x2::object::ID,
        amount: u64,
        supply: u64,
        remaining: vector<0x1::type_name::TypeName>,
    }

    struct ShareSet has copy, drop {
        index: 0x2::object::ID,
        bps: u64,
    }

    struct ReserveDonated has copy, drop {
        index: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct ReserveSwapped has copy, drop {
        index: 0x2::object::ID,
        from: 0x1::type_name::TypeName,
        to: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
    }

    struct ReserveMinted has copy, drop {
        index: 0x2::object::ID,
        amount: u64,
    }

    struct LiquidityAdded has copy, drop {
        index: 0x2::object::ID,
        pool: 0x2::object::ID,
        sti: u64,
        sui: u64,
        liquidity: u128,
    }

    struct LiquidityRemoved has copy, drop {
        index: 0x2::object::ID,
        pool: 0x2::object::ID,
        sti: u64,
        sui: u64,
    }

    struct FeesCollected has copy, drop {
        index: 0x2::object::ID,
        sti: u64,
        sui: u64,
    }

    struct Released has copy, drop {
        index: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun balance<T0, T1>(arg0: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>) : u64 {
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::pol_balance<T0, T1>(arg0)
    }

    public fun add<T0>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::KeeperCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: u64, arg5: bool, arg6: u128, arg7: u128, arg8: &0x2::clock::Clock) {
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::assert_live<T0>(arg0);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::check_keeper<T0>(arg0, arg1);
        check_pool<T0>(arg0, arg3);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg3);
        assert!(v0 >= arg6 && v0 <= arg7, 206);
        let v1 = position_mut<T0>(arg0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, 0x2::sui::SUI>(arg2, arg3, v1, arg4, arg5, arg8);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, 0x2::sui::SUI>(&v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, 0x2::sui::SUI>(arg2, arg3, 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::pol_take<T0, T0>(arg0, v3), 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::pol_take<T0, 0x2::sui::SUI>(arg0, v4), v2);
        let v5 = LiquidityAdded{
            index     : 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0),
            pool      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg3),
            sti       : v3,
            sui       : v4,
            liquidity : position_liquidity<T0>(arg0),
        };
        0x2::event::emit<LiquidityAdded>(v5);
    }

    public fun burn<T0>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::KeeperCap, arg2: u64) {
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::assert_live<T0>(arg0);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::check_keeper<T0>(arg0, arg1);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::vault_burn<T0>(arg0, 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::pol_take<T0, T0>(arg0, arg2));
        let v0 = Released{
            index  : 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0),
            coin   : 0x1::type_name::with_defining_ids<T0>(),
            amount : arg2,
        };
        0x2::event::emit<Released>(v0);
    }

    fun check_pool<T0>(arg0: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>) {
        let v0 = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::uid<T0>(arg0);
        let v1 = ReserveKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ReserveKey>(v0, v1), 203);
        let v2 = ReserveKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow<ReserveKey, Reserve>(v0, v2);
        assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v3.position), 203);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v3.pool) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg1), 205);
    }

    public fun close<T0>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::GuardianCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::assert_live<T0>(arg0);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::assert_guardian<T0>(arg0, arg1);
        check_pool<T0>(arg0, arg3);
        collect<T0>(arg0, arg2, arg3, arg4);
        let v0 = ReserveKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<ReserveKey, Reserve>(0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::uid_mut<T0>(arg0), v0);
        v1.pool = 0x1::option::none<0x2::object::ID>();
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, 0x2::sui::SUI>(arg2, arg3, 0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v1.position));
    }

    public fun collect<T0>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::assert_live<T0>(arg0);
        check_pool<T0>(arg0, arg2);
        let v0 = ReserveKey{dummy_field: false};
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, 0x2::sui::SUI>(arg1, arg2, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&0x2::dynamic_field::borrow<ReserveKey, Reserve>(0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::uid<T0>(arg0), v0).position), true);
        let v3 = v2;
        let v4 = v1;
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::pol_join<T0, T0>(arg0, v4, arg3);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::pol_join<T0, 0x2::sui::SUI>(arg0, v3, arg3);
        let v5 = FeesCollected{
            index : 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0),
            sti   : 0x2::balance::value<T0>(&v4),
            sui   : 0x2::balance::value<0x2::sui::SUI>(&v3),
        };
        0x2::event::emit<FeesCollected>(v5);
    }

    public fun donate<T0, T1>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::assert_live<T0>(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(is_reserve_coin<T0>(arg0, &v0), 208);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::pol_join<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg1), arg2);
        let v1 = ReserveDonated{
            index  : 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0),
            coin   : v0,
            amount : 0x2::coin::value<T1>(&arg1),
        };
        0x2::event::emit<ReserveDonated>(v1);
    }

    fun is_reserve_coin<T0>(arg0: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: &0x1::type_name::TypeName) : bool {
        if (*arg1 == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            true
        } else if (*arg1 == 0x1::type_name::with_defining_ids<T0>()) {
            true
        } else {
            0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::held_contains<T0>(arg0, arg1)
        }
    }

    public fun mint_begin<T0>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::KeeperCap, arg2: u64) : PolMint {
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::assert_live<T0>(arg0);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::check_keeper<T0>(arg0, arg1);
        assert!(arg2 > 0, 210);
        let v0 = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::supply<T0>(arg0);
        assert!(v0 > 0, 213);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::set_busy<T0>(arg0, true);
        PolMint{
            index     : 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0),
            amount    : arg2,
            supply    : v0,
            remaining : 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::held<T0>(arg0),
        }
    }

    public fun mint_finish<T0>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: PolMint, arg2: &mut 0x2::tx_context::TxContext) {
        let PolMint {
            index     : v0,
            amount    : v1,
            supply    : _,
            remaining : v3,
        } = arg1;
        let v4 = v3;
        assert!(v0 == 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0), 202);
        assert!(0x1::vector::is_empty<0x1::type_name::TypeName>(&v4), 212);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::pol_join<T0, T0>(arg0, 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::vault_mint<T0>(arg0, v1), arg2);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::set_busy<T0>(arg0, false);
        let v5 = ReserveMinted{
            index  : v0,
            amount : v1,
        };
        0x2::event::emit<ReserveMinted>(v5);
    }

    public fun mint_put<T0, T1>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: &mut PolMint) {
        assert!(arg1.index == 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0), 202);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let (v1, v2) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg1.remaining, &v0);
        assert!(v1, 211);
        0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg1.remaining, v2);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::vault_join<T0, T1>(arg0, 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::pol_take<T0, T1>(arg0, mul_div_up(0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::holding<T0, T1>(arg0), arg1.amount, arg1.supply)));
    }

    fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg2 as u128);
        ((((arg0 as u128) * (arg1 as u128) + v0 - 1) / v0) as u64)
    }

    public fun open<T0>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::KeeperCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: u32, arg5: u32, arg6: &mut 0x2::tx_context::TxContext) {
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::assert_live<T0>(arg0);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::check_keeper<T0>(arg0, arg1);
        let v0 = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::uid_mut<T0>(arg0);
        let v1 = ReserveKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ReserveKey>(v0, v1)) {
            let v2 = ReserveKey{dummy_field: false};
            let v3 = Reserve{
                position : 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(),
                pool     : 0x1::option::none<0x2::object::ID>(),
            };
            0x2::dynamic_field::add<ReserveKey, Reserve>(v0, v2, v3);
        };
        let v4 = ReserveKey{dummy_field: false};
        let v5 = 0x2::dynamic_field::borrow_mut<ReserveKey, Reserve>(v0, v4);
        assert!(0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v5.position), 204);
        0x1::option::fill<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v5.position, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, 0x2::sui::SUI>(arg2, arg3, arg4, arg5, arg6));
        v5.pool = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg3));
    }

    public fun pool_id<T0>(arg0: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::uid<T0>(arg0);
        let v1 = ReserveKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ReserveKey>(v0, v1)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        let v2 = ReserveKey{dummy_field: false};
        0x2::dynamic_field::borrow<ReserveKey, Reserve>(v0, v2).pool
    }

    public fun position_liquidity<T0>(arg0: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>) : u128 {
        let v0 = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::uid<T0>(arg0);
        let v1 = ReserveKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ReserveKey>(v0, v1)) {
            return 0
        };
        let v2 = ReserveKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow<ReserveKey, Reserve>(v0, v2);
        if (0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v3.position)) {
            0
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v3.position))
        }
    }

    fun position_mut<T0>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>) : &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        let v0 = ReserveKey{dummy_field: false};
        0x1::option::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut 0x2::dynamic_field::borrow_mut<ReserveKey, Reserve>(0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::uid_mut<T0>(arg0), v0).position)
    }

    public fun release<T0, T1>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::KeeperCap, arg2: u64) {
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::assert_live<T0>(arg0);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::check_keeper<T0>(arg0, arg1);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::vault_join<T0, T1>(arg0, 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::pol_take<T0, T1>(arg0, arg2));
        let v0 = Released{
            index  : 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0),
            coin   : 0x1::type_name::with_defining_ids<T1>(),
            amount : arg2,
        };
        0x2::event::emit<Released>(v0);
    }

    public fun remove<T0>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::GuardianCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::assert_live<T0>(arg0);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::assert_guardian<T0>(arg0, arg1);
        check_pool<T0>(arg0, arg3);
        let v0 = position_mut<T0>(arg0);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, 0x2::sui::SUI>(arg2, arg3, v0, arg4, arg5);
        let v3 = v2;
        let v4 = v1;
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::pol_join<T0, T0>(arg0, v4, arg6);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::pol_join<T0, 0x2::sui::SUI>(arg0, v3, arg6);
        let v5 = LiquidityRemoved{
            index : 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0),
            pool  : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg3),
            sti   : 0x2::balance::value<T0>(&v4),
            sui   : 0x2::balance::value<0x2::sui::SUI>(&v3),
        };
        0x2::event::emit<LiquidityRemoved>(v5);
    }

    public fun set_share<T0>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::GuardianCap, arg2: u64) {
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::assert_live<T0>(arg0);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::assert_guardian<T0>(arg0, arg1);
        assert!(arg2 <= 5000, 201);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::set_pol_share_bps<T0>(arg0, arg2);
        let v0 = ShareSet{
            index : 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0),
            bps   : arg2,
        };
        0x2::event::emit<ShareSet>(v0);
    }

    public fun share_bps<T0>(arg0: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>) : u64 {
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::pol_share_bps<T0>(arg0)
    }

    public fun swap_begin<T0, T1, T2>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::KeeperCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, PolSwap) {
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::assert_live<T0>(arg0);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::check_keeper<T0>(arg0, arg1);
        assert!(arg2 > 0, 210);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0x1::type_name::with_defining_ids<T2>();
        assert!(v0 != v1, 209);
        assert!(v1 == 0x1::type_name::with_defining_ids<0x2::sui::SUI>() || 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::held_contains<T0>(arg0, &v1) && !0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::is_retiring<T0>(arg0, &v1), 209);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::set_busy<T0>(arg0, true);
        let v2 = PolSwap{
            index     : 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0),
            from      : v0,
            to        : v1,
            amount_in : arg2,
            min_out   : arg3,
        };
        (0x2::coin::from_balance<T1>(0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::pol_take<T0, T1>(arg0, arg2), arg4), v2)
    }

    public fun swap_end<T0, T1>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: PolSwap, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let PolSwap {
            index     : v0,
            from      : v1,
            to        : v2,
            amount_in : v3,
            min_out   : v4,
        } = arg1;
        assert!(v0 == 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0), 202);
        assert!(0x1::type_name::with_defining_ids<T1>() == v2, 208);
        let v5 = 0x2::coin::value<T1>(&arg2);
        assert!(v5 >= v4, 207);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::pol_join<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg2), arg3);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::set_busy<T0>(arg0, false);
        let v6 = ReserveSwapped{
            index      : v0,
            from       : v1,
            to         : v2,
            amount_in  : v3,
            amount_out : v5,
        };
        0x2::event::emit<ReserveSwapped>(v6);
    }

    // decompiled from Move bytecode v7
}

