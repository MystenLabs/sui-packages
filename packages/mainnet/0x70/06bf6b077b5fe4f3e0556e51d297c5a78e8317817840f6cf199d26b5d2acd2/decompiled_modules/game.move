module 0x7006bf6b077b5fe4f3e0556e51d297c5a78e8317817840f6cf199d26b5d2acd2::game {
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
        0x2::transfer::transfer<UserInfo>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

