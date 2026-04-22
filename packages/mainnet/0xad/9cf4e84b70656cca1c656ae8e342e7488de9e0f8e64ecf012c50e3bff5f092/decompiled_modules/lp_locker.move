module 0xad9cf4e84b70656cca1c656ae8e342e7488de9e0f8e64ecf012c50e3bff5f092::lp_locker {
    struct LockedPosition has key {
        id: 0x2::object::UID,
        position: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position,
        fee_recipient: address,
        locked_by: address,
        meme_token_id: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PositionLocked has copy, drop {
        locker_id: 0x2::object::ID,
        meme_token_id: u64,
        fee_recipient: address,
        locked_by: address,
    }

    struct FeesCollected has copy, drop {
        locker_id: 0x2::object::ID,
        meme_token_id: u64,
        fee_amount_a: u64,
        fee_amount_b: u64,
        recipient: address,
    }

    struct FeeRecipientUpdated has copy, drop {
        locker_id: 0x2::object::ID,
        old_recipient: address,
        new_recipient: address,
    }

    public entry fun collect_fees<T0, T1>(arg0: &mut LockedPosition, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &arg0.position, true);
        let v2 = 0x2::coin::from_balance<T0>(v0, arg4);
        let v3 = 0x2::coin::from_balance<T1>(v1, arg4);
        let v4 = 0x2::coin::value<T0>(&v2);
        let v5 = 0x2::coin::value<T1>(&v3);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, arg0.fee_recipient);
        } else {
            0x2::coin::destroy_zero<T0>(v2);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, arg0.fee_recipient);
        } else {
            0x2::coin::destroy_zero<T1>(v3);
        };
        let v6 = FeesCollected{
            locker_id     : 0x2::object::uid_to_inner(&arg0.id),
            meme_token_id : arg0.meme_token_id,
            fee_amount_a  : v4,
            fee_amount_b  : v5,
            recipient     : arg0.fee_recipient,
        };
        0x2::event::emit<FeesCollected>(v6);
    }

    public fun fee_recipient(arg0: &LockedPosition) : address {
        arg0.fee_recipient
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun lock_position(arg0: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = LockedPosition{
            id            : 0x2::object::new(arg3),
            position      : arg0,
            fee_recipient : arg1,
            locked_by     : 0x2::tx_context::sender(arg3),
            meme_token_id : arg2,
        };
        let v1 = PositionLocked{
            locker_id     : 0x2::object::uid_to_inner(&v0.id),
            meme_token_id : arg2,
            fee_recipient : arg1,
            locked_by     : v0.locked_by,
        };
        0x2::event::emit<PositionLocked>(v1);
        0x2::transfer::share_object<LockedPosition>(v0);
    }

    public fun locked_by(arg0: &LockedPosition) : address {
        arg0.locked_by
    }

    public fun meme_token_id(arg0: &LockedPosition) : u64 {
        arg0.meme_token_id
    }

    public entry fun set_fee_recipient(arg0: &AdminCap, arg1: &mut LockedPosition, arg2: address) {
        arg1.fee_recipient = arg2;
        let v0 = FeeRecipientUpdated{
            locker_id     : 0x2::object::uid_to_inner(&arg1.id),
            old_recipient : arg1.fee_recipient,
            new_recipient : arg2,
        };
        0x2::event::emit<FeeRecipientUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

