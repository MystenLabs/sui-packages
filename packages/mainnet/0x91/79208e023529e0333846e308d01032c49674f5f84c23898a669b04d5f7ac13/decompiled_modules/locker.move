module 0x9179208e023529e0333846e308d01032c49674f5f84c23898a669b04d5f7ac13::locker {
    struct LockedPosition has key {
        id: 0x2::object::UID,
        position: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position,
        pool_id: 0x2::object::ID,
        fee_recipient: address,
    }

    public fun collect_fee<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &LockedPosition, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg2.fee_recipient, 1);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == arg2.pool_id, 2);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg0, arg1, &arg2.position, true);
        send_balance<T0>(v0, arg2.fee_recipient, arg3);
        send_balance<T1>(v1, arg2.fee_recipient, arg3);
    }

    public fun lock_position(arg0: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LockedPosition{
            id            : 0x2::object::new(arg2),
            position      : arg0,
            pool_id       : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg0),
            fee_recipient : arg1,
        };
        0x2::transfer::share_object<LockedPosition>(v0);
    }

    fun send_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        };
    }

    // decompiled from Move bytecode v7
}

