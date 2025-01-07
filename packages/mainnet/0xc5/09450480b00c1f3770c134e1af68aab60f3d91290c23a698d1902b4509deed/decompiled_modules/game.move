module 0xc509450480b00c1f3770c134e1af68aab60f3d91290c23a698d1902b4509deed::game {
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

    struct CreateUser has copy, drop, store {
        user_address: address,
        ref_address: address,
    }

    public entry fun create_user(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = GameInfo{
            id      : 0x2::object::new(arg1),
            version : 1,
            miner   : 1,
            map     : 1,
            owner   : v0,
            ref     : arg0,
        };
        0x2::transfer::share_object<GameInfo>(v1);
        let v2 = CreateUser{
            user_address : v0,
            ref_address  : arg0,
        };
        0x2::event::emit<CreateUser>(v2);
    }

    // decompiled from Move bytecode v6
}

