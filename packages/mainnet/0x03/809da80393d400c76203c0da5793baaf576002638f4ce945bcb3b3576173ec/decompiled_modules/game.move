module 0x3809da80393d400c76203c0da5793baaf576002638f4ce945bcb3b3576173ec::game {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct TokenAddr has drop {
        dummy_field: bool,
    }

    struct GameInfo has key {
        id: 0x2::object::UID,
        version: u8,
        balance: 0x2::balance::Balance<0x3809da80393d400c76203c0da5793baaf576002638f4ce945bcb3b3576173ec::tonminer::TONMINER>,
        gas_fee: u16,
        owner: address,
        ref1: u16,
        ref2: u16,
        v_ref: u16,
    }

    struct PlayerInfo has store, key {
        id: 0x2::object::UID,
        miner: u64,
        miner_rate: u64,
        map: u64,
        map_base: u64,
        peroid: u64,
        referral: address,
        last_claim: u64,
        next_claim: u64,
    }

    struct CreateUser has copy, drop, store {
        user_address: address,
        ref_address: address,
    }

    struct ClaimToken has copy, drop, store {
        user_address: address,
        amount_user_received: u64,
        ref1_address: address,
        amount_ref1_received: u64,
        ref2_address: address,
        amount_ref2_received: u64,
    }

    struct UpdateRef has copy, drop, store {
        user_address: address,
        new_ref: address,
    }

    struct UpdateMap has copy, drop, store {
        map_level: u64,
        map_base: u64,
    }

    struct UpdateMiner has copy, drop, store {
        miner_level: u64,
        miner_rate: u64,
    }

    entry fun add_treasury_cap(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: 0x2::coin::TreasuryCap<0x3809da80393d400c76203c0da5793baaf576002638f4ce945bcb3b3576173ec::tonminer::TONMINER>) {
        0x2::dynamic_field::add<0x1::string::String, 0x2::coin::TreasuryCap<0x3809da80393d400c76203c0da5793baaf576002638f4ce945bcb3b3576173ec::tonminer::TONMINER>>(&mut arg1.id, 0x1::string::utf8(b"treasury"), arg2);
    }

    fun calc_claim(arg0: &mut GameInfo, arg1: address, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow<address, PlayerInfo>(&arg0.id, arg1);
        assert!((v0.miner as u64) >= 6, 16);
        let v1 = v0.referral;
        let v2 = 0;
        let v3 = @0x0;
        let v4 = 0;
        let v5 = arg2;
        if (arg3) {
            v5 = arg2 * (10000 - (arg0.gas_fee as u64) / 10000);
        };
        send_tokens(arg0, arg1, v5, arg4);
        let v6 = arg0.owner;
        let v7 = arg2 * (arg0.gas_fee as u64) / 10000;
        send_tokens(arg0, v6, v7, arg4);
        if (v1 != @0x0 && v1 != arg1 && 0x2::dynamic_object_field::exists_<address>(&arg0.id, v1)) {
            let v8 = arg2 * (arg0.ref1 as u64) / 10000;
            v2 = v8;
            send_tokens(arg0, v1, v8, arg4);
            let v9 = 0x2::dynamic_object_field::borrow<address, PlayerInfo>(&arg0.id, v1).referral;
            v3 = v9;
            if (v9 != @0x0 && v9 != arg1 && 0x2::dynamic_object_field::exists_<address>(&arg0.id, v9)) {
                let v10 = arg2 * (arg0.ref2 as u64) / 10000;
                v4 = v10;
                send_tokens(arg0, v9, v10, arg4);
            };
        };
        let v11 = ClaimToken{
            user_address         : arg1,
            amount_user_received : v5,
            ref1_address         : v1,
            amount_ref1_received : v2,
            ref2_address         : v3,
            amount_ref2_received : v4,
        };
        0x2::event::emit<ClaimToken>(v11);
    }

    public entry fun claim(arg0: &mut GameInfo, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, v0), 5);
        let v1 = 0x2::dynamic_object_field::borrow<address, PlayerInfo>(&arg0.id, v0);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        assert!(v2 >= (v1.next_claim as u64), 6);
        let v3 = v1.map_base * 1000000000;
        0x2::dynamic_object_field::borrow_mut<address, PlayerInfo>(&mut arg0.id, v0).last_claim = v2;
        0x2::dynamic_object_field::borrow_mut<address, PlayerInfo>(&mut arg0.id, v0).next_claim = v2 + v1.peroid * 60 * 1000;
        calc_claim(arg0, v0, v3 + v3 * v1.miner_rate / 100, true, arg2);
    }

    entry fun create_user(arg0: &mut GameInfo, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 2);
        assert!(arg0.owner == 0x2::tx_context::sender(arg8), 4);
        let v0 = 0x1::string::utf8(b"CREATE_USER:");
        let v1 = 0x2::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg1));
        assert!(!0x2::dynamic_object_field::exists_<address>(&arg0.id, arg1), 4);
        let v2 = PlayerInfo{
            id         : 0x2::object::new(arg8),
            miner      : arg3,
            miner_rate : arg4,
            map        : arg5,
            map_base   : arg6,
            peroid     : arg7,
            referral   : arg2,
            last_claim : 0,
            next_claim : 0,
        };
        0x2::dynamic_object_field::add<address, PlayerInfo>(&mut arg0.id, arg1, v2);
        send_tokens(arg0, arg1, 100000, arg8);
        let v3 = CreateUser{
            user_address : arg1,
            ref_address  : arg2,
        };
        0x2::event::emit<CreateUser>(v3);
    }

    entry fun feed_gas(arg0: &mut GameInfo, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 4);
        arg0.gas_fee = arg1;
    }

    entry fun feed_ref1(arg0: &mut GameInfo, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 4);
        arg0.ref1 = arg1;
    }

    entry fun feed_ref2(arg0: &mut GameInfo, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 4);
        arg0.ref2 = arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v1, v0);
        let v2 = GameInfo{
            id      : 0x2::object::new(arg0),
            version : 1,
            balance : 0x2::balance::zero<0x3809da80393d400c76203c0da5793baaf576002638f4ce945bcb3b3576173ec::tonminer::TONMINER>(),
            gas_fee : 3000,
            owner   : v0,
            ref1    : 2000,
            ref2    : 500,
            v_ref   : 500,
        };
        0x2::transfer::share_object<GameInfo>(v2);
    }

    entry fun remove_treasury_cap(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<0x3809da80393d400c76203c0da5793baaf576002638f4ce945bcb3b3576173ec::tonminer::TONMINER>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::coin::TreasuryCap<0x3809da80393d400c76203c0da5793baaf576002638f4ce945bcb3b3576173ec::tonminer::TONMINER>>(&mut arg1.id, 0x1::string::utf8(b"treasury")), 0x2::tx_context::sender(arg2));
    }

    fun send_tokens(arg0: &mut GameInfo, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x3809da80393d400c76203c0da5793baaf576002638f4ce945bcb3b3576173ec::tonminer::TONMINER>(&arg0.balance);
        let v1 = 0;
        if (v0 >= arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x3809da80393d400c76203c0da5793baaf576002638f4ce945bcb3b3576173ec::tonminer::TONMINER>>(0x2::coin::from_balance<0x3809da80393d400c76203c0da5793baaf576002638f4ce945bcb3b3576173ec::tonminer::TONMINER>(0x2::balance::split<0x3809da80393d400c76203c0da5793baaf576002638f4ce945bcb3b3576173ec::tonminer::TONMINER>(&mut arg0.balance, arg2), arg3), arg1);
        } else if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x3809da80393d400c76203c0da5793baaf576002638f4ce945bcb3b3576173ec::tonminer::TONMINER>>(0x2::coin::from_balance<0x3809da80393d400c76203c0da5793baaf576002638f4ce945bcb3b3576173ec::tonminer::TONMINER>(0x2::balance::withdraw_all<0x3809da80393d400c76203c0da5793baaf576002638f4ce945bcb3b3576173ec::tonminer::TONMINER>(&mut arg0.balance), arg3), arg1);
            v1 = arg2 - v0;
        } else {
            v1 = arg2;
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x3809da80393d400c76203c0da5793baaf576002638f4ce945bcb3b3576173ec::tonminer::TONMINER>>(0x2::coin::mint<0x3809da80393d400c76203c0da5793baaf576002638f4ce945bcb3b3576173ec::tonminer::TONMINER>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::coin::TreasuryCap<0x3809da80393d400c76203c0da5793baaf576002638f4ce945bcb3b3576173ec::tonminer::TONMINER>>(&mut arg0.id, 0x1::string::utf8(b"treasury")), v1, arg3), arg1);
        };
    }

    entry fun set_admin(arg0: &mut GameInfo, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 4);
        arg0.owner = arg1;
    }

    entry fun update_map(arg0: &mut GameInfo, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 2);
        assert!(arg0.owner == 0x2::tx_context::sender(arg5), 4);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, arg1), 5);
        0x2::dynamic_object_field::borrow_mut<address, PlayerInfo>(&mut arg0.id, arg1).next_claim = 0x2::dynamic_object_field::borrow<address, PlayerInfo>(&arg0.id, arg1).last_claim + arg4 * 60 * 1000;
        0x2::dynamic_object_field::borrow_mut<address, PlayerInfo>(&mut arg0.id, arg1).map = arg2;
        0x2::dynamic_object_field::borrow_mut<address, PlayerInfo>(&mut arg0.id, arg1).map_base = arg3;
        0x2::dynamic_object_field::borrow_mut<address, PlayerInfo>(&mut arg0.id, arg1).peroid = arg4;
        let v0 = UpdateMap{
            map_level : arg2,
            map_base  : arg3,
        };
        0x2::event::emit<UpdateMap>(v0);
    }

    public entry fun update_miner(arg0: &mut GameInfo, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 2);
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 4);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, arg1), 5);
        0x2::dynamic_object_field::borrow_mut<address, PlayerInfo>(&mut arg0.id, arg1).miner = arg2;
        0x2::dynamic_object_field::borrow_mut<address, PlayerInfo>(&mut arg0.id, arg1).miner_rate = arg3;
        let v0 = UpdateMiner{
            miner_level : arg2,
            miner_rate  : arg3,
        };
        0x2::event::emit<UpdateMiner>(v0);
    }

    entry fun update_ref(arg0: &mut GameInfo, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 != arg1, 17);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, v0), 5);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, arg1), 11);
        0x2::dynamic_object_field::borrow_mut<address, PlayerInfo>(&mut arg0.id, v0).referral = arg1;
        let v1 = UpdateRef{
            user_address : v0,
            new_ref      : arg1,
        };
        0x2::event::emit<UpdateRef>(v1);
    }

    // decompiled from Move bytecode v6
}

