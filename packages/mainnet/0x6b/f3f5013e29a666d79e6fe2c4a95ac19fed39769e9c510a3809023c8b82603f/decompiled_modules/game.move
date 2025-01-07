module 0x6bf3f5013e29a666d79e6fe2c4a95ac19fed39769e9c510a3809023c8b82603f::game {
    struct GameInfo has key {
        id: 0x2::object::UID,
        version: u8,
        gas_fee: u16,
        init_reward: u64,
        ref1: u16,
        ref2: u16,
        v_ref: u16,
        v_join_fee: u64,
        v_leave_fee: u64,
    }

    struct UserInfo has store, key {
        id: 0x2::object::UID,
        referral: address,
    }

    struct CreateUser has copy, drop, store {
        user_address: address,
        ref_address: address,
    }

    entry fun create_user(arg0: &mut GameInfo, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = UserInfo{
            id       : 0x2::object::new(arg3),
            referral : arg2,
        };
        0x2::dynamic_object_field::add<address, UserInfo>(&mut arg0.id, arg1, v0);
    }

    // decompiled from Move bytecode v6
}

