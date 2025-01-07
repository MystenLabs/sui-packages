module 0x490f7579558b297a639dd997c1fee3609b82b63fbbeff35b6602879b0e4c0cdb::game {
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
        let v0 = 0x1::string::utf8(b"CREATE_USER:");
        let v1 = 0x1::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg1));
        let v2 = UserInfo{
            id         : 0x2::object::new(arg4),
            referral   : arg2,
            last_claim : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::dynamic_object_field::add<address, UserInfo>(&mut arg0.id, arg1, v2);
        let v3 = CreateUser{
            user_address : arg1,
            ref_address  : arg2,
        };
        0x2::event::emit<CreateUser>(v3);
    }

    // decompiled from Move bytecode v6
}

