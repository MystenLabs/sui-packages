module 0xea43dd2bb26b49f1ef8b83020913945507babc3e8c85c475fbb64361b02d106::game {
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
        let v1 = CreateUser{
            user_address : arg1,
            ref_address  : arg2,
        };
        0x2::event::emit<CreateUser>(v1);
        0x2::transfer::transfer<UserInfo>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

