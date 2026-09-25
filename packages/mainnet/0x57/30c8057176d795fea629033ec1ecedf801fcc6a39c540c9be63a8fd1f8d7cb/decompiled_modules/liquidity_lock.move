module 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::liquidity_lock {
    struct LockedLiquidity<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        source_pool_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        token_is_a: bool,
        position: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position,
        creation_cap: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap,
        surplus_a: 0x2::balance::Balance<T0>,
        surplus_b: 0x2::balance::Balance<T1>,
    }

    public(friend) fun cetus_pool_id<T0, T1>(arg0: &LockedLiquidity<T0, T1>) : 0x2::object::ID {
        arg0.cetus_pool_id
    }

    public(friend) fun collect_fees<T0, T1>(arg0: &LockedLiquidity<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == arg0.cetus_pool_id, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &arg0.position, true)
    }

    public fun creator_lp_fee_bps() : u64 {
        7000
    }

    public(friend) fun freeze_forever<T0, T1>(arg0: 0x2::object::ID, arg1: bool, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg2);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg2) > 0, 0);
        let v1 = LockedLiquidity<T0, T1>{
            id             : 0x2::object::new(arg6),
            source_pool_id : arg0,
            cetus_pool_id  : v0,
            token_is_a     : arg1,
            position       : arg2,
            creation_cap   : arg3,
            surplus_a      : arg4,
            surplus_b      : arg5,
        };
        0x2::transfer::freeze_object<LockedLiquidity<T0, T1>>(v1);
        (v0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg2), 0x2::object::id<LockedLiquidity<T0, T1>>(&v1))
    }

    public(friend) fun position_id<T0, T1>(arg0: &LockedLiquidity<T0, T1>) : 0x2::object::ID {
        0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position)
    }

    public(friend) fun source_pool_id<T0, T1>(arg0: &LockedLiquidity<T0, T1>) : 0x2::object::ID {
        arg0.source_pool_id
    }

    public fun split_lp_fee(arg0: u64) : (u64, u64) {
        let v0 = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::math::mul_div(arg0, 7000, 10000);
        (v0, arg0 - v0)
    }

    public(friend) fun token_is_a<T0, T1>(arg0: &LockedLiquidity<T0, T1>) : bool {
        arg0.token_is_a
    }

    // decompiled from Move bytecode v7
}

