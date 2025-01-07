module 0x667dc294d900ba967bf96b14a41217d788fc7ad2f2d85b1eb1ebf5dd12b7060c::game {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct GameInfo has key {
        id: 0x2::object::UID,
        version: u8,
        balance: 0x2::balance::Balance<0x667dc294d900ba967bf96b14a41217d788fc7ad2f2d85b1eb1ebf5dd12b7060c::tonminer::TONMINER>,
        miner: u8,
        map: u8,
        gas_fee: u16,
        ref1: u16,
        ref2: u16,
        v_ref: u16,
        v_join_fee: u64,
        v_leave_fee: u64,
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

    entry fun add_treasury_cap(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: 0x2::coin::TreasuryCap<0x667dc294d900ba967bf96b14a41217d788fc7ad2f2d85b1eb1ebf5dd12b7060c::tonminer::TONMINER>) {
        0x2::dynamic_field::add<0x1::string::String, 0x2::coin::TreasuryCap<0x667dc294d900ba967bf96b14a41217d788fc7ad2f2d85b1eb1ebf5dd12b7060c::tonminer::TONMINER>>(&mut arg1.id, 0x1::string::utf8(b"treasury"), arg2);
    }

    public entry fun claim(arg0: &mut GameInfo, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x667dc294d900ba967bf96b14a41217d788fc7ad2f2d85b1eb1ebf5dd12b7060c::tonminer::TONMINER>>(0x2::coin::from_balance<0x667dc294d900ba967bf96b14a41217d788fc7ad2f2d85b1eb1ebf5dd12b7060c::tonminer::TONMINER>(0x2::balance::split<0x667dc294d900ba967bf96b14a41217d788fc7ad2f2d85b1eb1ebf5dd12b7060c::tonminer::TONMINER>(&mut arg0.balance, 1000000), arg1), 0x2::tx_context::sender(arg1));
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GameInfo{
            id          : 0x2::object::new(arg0),
            version     : 1,
            balance     : 0x2::balance::zero<0x667dc294d900ba967bf96b14a41217d788fc7ad2f2d85b1eb1ebf5dd12b7060c::tonminer::TONMINER>(),
            miner       : 1,
            map         : 1,
            gas_fee     : 3000,
            ref1        : 2000,
            ref2        : 500,
            v_ref       : 500,
            v_join_fee  : 50000000000,
            v_leave_fee : 50000000000,
        };
        0x2::transfer::share_object<GameInfo>(v1);
    }

    entry fun remove_treasury_cap(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<0x667dc294d900ba967bf96b14a41217d788fc7ad2f2d85b1eb1ebf5dd12b7060c::tonminer::TONMINER>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::coin::TreasuryCap<0x667dc294d900ba967bf96b14a41217d788fc7ad2f2d85b1eb1ebf5dd12b7060c::tonminer::TONMINER>>(&mut arg1.id, 0x1::string::utf8(b"treasury")), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

