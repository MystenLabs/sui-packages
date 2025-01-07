module 0x299f9616225788fb9e9580d27f62a537183f994080f091ba84ae85b2a9739444::game {
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

    entry fun create_user(arg0: &mut GameInfo, arg1: address, arg2: address, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 2);
        let v0 = 0x1::string::utf8(b"CREATE_USER:");
        let v1 = 0x1::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg1));
        assert!(!0x2::dynamic_object_field::exists_<address>(&arg0.id, arg1), 4);
        let v2 = UserInfo{
            id         : 0x2::object::new(arg5),
            referral   : arg2,
            last_claim : 0x2::clock::timestamp_ms(arg4),
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

