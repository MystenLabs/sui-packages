module 0x44ad097f6a0cb1c7ca0b9474ee8d795a2a46d1024472da852e3435be116d2e47::game {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct GameInfo has key {
        id: 0x2::object::UID,
        version: u8,
        miner: u64,
        map: u64,
        owner: address,
        ref: address,
    }

    struct PlayerInfo has store, key {
        id: 0x2::object::UID,
        miner: u8,
        map: u8,
        referral: address,
    }

    struct CreateUser has copy, drop, store {
        user_address: address,
        ref_address: address,
    }

    public entry fun create_user(arg0: &mut GameInfo, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = PlayerInfo{
            id       : 0x2::object::new(arg2),
            miner    : 1,
            map      : 1,
            referral : arg1,
        };
        0x2::dynamic_object_field::add<address, PlayerInfo>(&mut arg0.id, v0, v1);
        let v2 = CreateUser{
            user_address : v0,
            ref_address  : arg1,
        };
        0x2::event::emit<CreateUser>(v2);
    }

    // decompiled from Move bytecode v6
}

