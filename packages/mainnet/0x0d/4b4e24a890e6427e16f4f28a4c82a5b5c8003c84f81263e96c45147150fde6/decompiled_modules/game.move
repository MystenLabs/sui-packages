module 0xd4b4e24a890e6427e16f4f28a4c82a5b5c8003c84f81263e96c45147150fde6::game {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

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
        last_claim: u64,
    }

    struct CreateUser has copy, drop, store {
        user_address: address,
        ref_address: address,
    }

    entry fun create_user(arg0: &mut GameInfo, arg1: address, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = UserInfo{
            id         : 0x2::object::new(arg4),
            referral   : arg2,
            last_claim : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::dynamic_object_field::add<address, UserInfo>(&mut arg0.id, arg1, v0);
    }

    // decompiled from Move bytecode v6
}

