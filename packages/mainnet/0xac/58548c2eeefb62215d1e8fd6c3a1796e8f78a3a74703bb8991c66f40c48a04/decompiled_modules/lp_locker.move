module 0xac58548c2eeefb62215d1e8fd6c3a1796e8f78a3a74703bb8991c66f40c48a04::lp_locker {
    struct LockedLPPosition<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        position: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position,
        pool_id: 0x2::object::ID,
        fee_recipient: address,
        locked_at: u64,
        bonding_curve_id: 0x2::object::ID,
        is_permanently_locked: bool,
    }

    struct PositionLocked has copy, drop {
        locked_position_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        locked_at: u64,
        fee_recipient: address,
        bonding_curve_id: 0x2::object::ID,
    }

    struct FeeCollected has copy, drop {
        locked_position_id: 0x2::object::ID,
        fee_sui: u64,
        fee_token: u64,
        recipient: address,
    }

    struct RecipientChanged has copy, drop {
        locked_position_id: 0x2::object::ID,
        old_recipient: address,
        new_recipient: address,
    }

    public entry fun collect_lp_fees<T0, T1>(arg0: &mut LockedLPPosition<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fee_recipient != @0x0, 3);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &arg0.position, true);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg3), arg0.fee_recipient);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg3), arg0.fee_recipient);
        let v4 = FeeCollected{
            locked_position_id : 0x2::object::id<LockedLPPosition<T0, T1>>(arg0),
            fee_sui            : 0x2::balance::value<T0>(&v3),
            fee_token          : 0x2::balance::value<T1>(&v2),
            recipient          : arg0.fee_recipient,
        };
        0x2::event::emit<FeeCollected>(v4);
    }

    public entry fun emergency_collect_to_custom_recipient<T0, T1>(arg0: &0xac58548c2eeefb62215d1e8fd6c3a1796e8f78a3a74703bb8991c66f40c48a04::platform_config::AdminCap, arg1: &mut LockedLPPosition<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 != @0x0, 3);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg3, &arg1.position, true);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg5), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg5), arg4);
        let v4 = FeeCollected{
            locked_position_id : 0x2::object::id<LockedLPPosition<T0, T1>>(arg1),
            fee_sui            : 0x2::balance::value<T0>(&v3),
            fee_token          : 0x2::balance::value<T1>(&v2),
            recipient          : arg4,
        };
        0x2::event::emit<FeeCollected>(v4);
    }

    public fun get_bonding_curve_id<T0, T1>(arg0: &LockedLPPosition<T0, T1>) : 0x2::object::ID {
        arg0.bonding_curve_id
    }

    public fun get_fee_recipient<T0, T1>(arg0: &LockedLPPosition<T0, T1>) : address {
        arg0.fee_recipient
    }

    public fun get_locked_at<T0, T1>(arg0: &LockedLPPosition<T0, T1>) : u64 {
        arg0.locked_at
    }

    public fun get_pool_id<T0, T1>(arg0: &LockedLPPosition<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun is_permanently_locked<T0, T1>(arg0: &LockedLPPosition<T0, T1>) : bool {
        arg0.is_permanently_locked
    }

    public fun lock_position_permanent<T0, T1>(arg0: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg1: 0x2::object::ID, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : LockedLPPosition<T0, T1> {
        assert!(arg2 != @0x0, 3);
        let v0 = 0x2::object::new(arg5);
        let v1 = LockedLPPosition<T0, T1>{
            id                    : v0,
            position              : arg0,
            pool_id               : arg1,
            fee_recipient         : arg2,
            locked_at             : arg4,
            bonding_curve_id      : arg3,
            is_permanently_locked : true,
        };
        let v2 = PositionLocked{
            locked_position_id : 0x2::object::uid_to_inner(&v0),
            position_id        : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0),
            pool_id            : arg1,
            locked_at          : arg4,
            fee_recipient      : arg2,
            bonding_curve_id   : arg3,
        };
        0x2::event::emit<PositionLocked>(v2);
        v1
    }

    public entry fun set_fee_recipient<T0, T1>(arg0: &0xac58548c2eeefb62215d1e8fd6c3a1796e8f78a3a74703bb8991c66f40c48a04::platform_config::AdminCap, arg1: &mut LockedLPPosition<T0, T1>, arg2: address) {
        assert!(arg2 != @0x0, 3);
        arg1.fee_recipient = arg2;
        let v0 = RecipientChanged{
            locked_position_id : 0x2::object::id<LockedLPPosition<T0, T1>>(arg1),
            old_recipient      : arg1.fee_recipient,
            new_recipient      : arg2,
        };
        0x2::event::emit<RecipientChanged>(v0);
    }

    public fun share_locked_position<T0, T1>(arg0: LockedLPPosition<T0, T1>) {
        0x2::transfer::share_object<LockedLPPosition<T0, T1>>(arg0);
    }

    // decompiled from Move bytecode v6
}

