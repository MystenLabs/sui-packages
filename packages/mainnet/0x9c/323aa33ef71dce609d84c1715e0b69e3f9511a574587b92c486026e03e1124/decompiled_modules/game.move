module 0x9c323aa33ef71dce609d84c1715e0b69e3f9511a574587b92c486026e03e1124::game {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct GameInfo has key {
        id: 0x2::object::UID,
        version: u8,
        balance: 0x2::balance::Balance<0x9c323aa33ef71dce609d84c1715e0b69e3f9511a574587b92c486026e03e1124::tonminer::TONMINER>,
        miner: u64,
        miner_rate: u64,
        map: u64,
        map_base: u64,
        gas_fee: u16,
        woner: address,
        ref1: u16,
        ref2: u16,
        v_ref: u16,
        v_join_fee: u64,
        v_leave_fee: u64,
    }

    struct PlayerInfo has store, key {
        id: 0x2::object::UID,
        telegram_id: u64,
        miner: u64,
        miner_rate: u64,
        map: u64,
        map_base: u64,
        referral: address,
        auto: u16,
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

    struct UpdateMaps has copy, drop, store {
        map_level: u64,
        map_base: u64,
    }

    struct UpdateMiner has copy, drop, store {
        miner_level: u64,
        miner_rate: u64,
    }

    entry fun add_treasury_cap(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: 0x2::coin::TreasuryCap<0x9c323aa33ef71dce609d84c1715e0b69e3f9511a574587b92c486026e03e1124::tonminer::TONMINER>) {
        0x2::dynamic_field::add<0x1::string::String, 0x2::coin::TreasuryCap<0x9c323aa33ef71dce609d84c1715e0b69e3f9511a574587b92c486026e03e1124::tonminer::TONMINER>>(&mut arg1.id, 0x1::string::utf8(b"treasury"), arg2);
    }

    fun calc_claim(arg0: &mut GameInfo, arg1: address, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow<address, PlayerInfo>(&arg0.id, arg1).referral;
        let v1 = 0;
        let v2 = @0x0;
        let v3 = 0;
        let v4 = arg2;
        if (arg3) {
            v4 = arg2 * (10000 - (arg0.gas_fee as u64)) / 10000;
        };
        send_tokens(arg0, arg1, v4, arg4);
        let v5 = arg0.woner;
        let v6 = arg2 * (arg0.gas_fee as u64) / 10000;
        send_tokens(arg0, v5, v6, arg4);
        if (v0 != @0x0 && v0 != arg1 && 0x2::dynamic_object_field::exists_<address>(&arg0.id, v0)) {
            let v7 = arg2 * (arg0.ref1 as u64) / 10000;
            v1 = v7;
            send_tokens(arg0, v0, v7, arg4);
            let v8 = 0x2::dynamic_object_field::borrow<address, PlayerInfo>(&arg0.id, v0).referral;
            v2 = v8;
            if (v8 != @0x0 && v8 != arg1 && 0x2::dynamic_object_field::exists_<address>(&arg0.id, v8)) {
                let v9 = arg2 * (arg0.ref2 as u64) / 10000;
                v3 = v9;
                send_tokens(arg0, v8, v9, arg4);
            };
        };
        let v10 = ClaimToken{
            user_address         : arg1,
            amount_user_received : v4,
            ref1_address         : v0,
            amount_ref1_received : v1,
            ref2_address         : v2,
            amount_ref2_received : v3,
        };
        0x2::event::emit<ClaimToken>(v10);
    }

    public entry fun claim(arg0: &mut GameInfo, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, v0), 5);
        let v1 = 0x2::dynamic_object_field::borrow<address, PlayerInfo>(&arg0.id, v0);
        let v2 = v1.map_base * 100000000;
        0x2::dynamic_object_field::borrow_mut<address, PlayerInfo>(&mut arg0.id, v0).last_claim = 0x2::clock::timestamp_ms(arg1);
        calc_claim(arg0, v0, v2 + v2 * v1.miner_rate / 100, true, arg2);
    }

    public entry fun create_user(arg0: &mut GameInfo, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 2);
        assert!(arg0.woner == 0x2::tx_context::sender(arg9), 4);
        let v0 = 0x1::string::utf8(b"CREATE_USER:");
        let v1 = 0x2::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg1));
        assert!(!0x2::dynamic_object_field::exists_<address>(&arg0.id, arg1), 4);
        let v2 = PlayerInfo{
            id          : 0x2::object::new(arg9),
            telegram_id : arg7,
            miner       : arg3,
            miner_rate  : arg4,
            map         : arg5,
            map_base    : arg6,
            referral    : arg2,
            auto        : 0,
            last_claim  : 0x2::clock::timestamp_ms(arg8),
            next_claim  : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::dynamic_object_field::add<address, PlayerInfo>(&mut arg0.id, arg1, v2);
        let v3 = CreateUser{
            user_address : arg1,
            ref_address  : arg2,
        };
        0x2::event::emit<CreateUser>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v1, v0);
        let v2 = GameInfo{
            id          : 0x2::object::new(arg0),
            version     : 1,
            balance     : 0x2::balance::zero<0x9c323aa33ef71dce609d84c1715e0b69e3f9511a574587b92c486026e03e1124::tonminer::TONMINER>(),
            miner       : 1,
            miner_rate  : 1,
            map         : 1,
            map_base    : 2,
            gas_fee     : 3000,
            woner       : v0,
            ref1        : 2000,
            ref2        : 500,
            v_ref       : 500,
            v_join_fee  : 50000000000,
            v_leave_fee : 50000000000,
        };
        0x2::transfer::share_object<GameInfo>(v2);
    }

    entry fun remove_treasury_cap(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<0x9c323aa33ef71dce609d84c1715e0b69e3f9511a574587b92c486026e03e1124::tonminer::TONMINER>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::coin::TreasuryCap<0x9c323aa33ef71dce609d84c1715e0b69e3f9511a574587b92c486026e03e1124::tonminer::TONMINER>>(&mut arg1.id, 0x1::string::utf8(b"treasury")), 0x2::tx_context::sender(arg2));
    }

    fun send_tokens(arg0: &mut GameInfo, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x9c323aa33ef71dce609d84c1715e0b69e3f9511a574587b92c486026e03e1124::tonminer::TONMINER>(&arg0.balance);
        let v1 = 0;
        if (v0 >= arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x9c323aa33ef71dce609d84c1715e0b69e3f9511a574587b92c486026e03e1124::tonminer::TONMINER>>(0x2::coin::from_balance<0x9c323aa33ef71dce609d84c1715e0b69e3f9511a574587b92c486026e03e1124::tonminer::TONMINER>(0x2::balance::split<0x9c323aa33ef71dce609d84c1715e0b69e3f9511a574587b92c486026e03e1124::tonminer::TONMINER>(&mut arg0.balance, arg2), arg3), arg1);
        } else if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x9c323aa33ef71dce609d84c1715e0b69e3f9511a574587b92c486026e03e1124::tonminer::TONMINER>>(0x2::coin::from_balance<0x9c323aa33ef71dce609d84c1715e0b69e3f9511a574587b92c486026e03e1124::tonminer::TONMINER>(0x2::balance::withdraw_all<0x9c323aa33ef71dce609d84c1715e0b69e3f9511a574587b92c486026e03e1124::tonminer::TONMINER>(&mut arg0.balance), arg3), arg1);
            v1 = arg2 - v0;
        } else {
            v1 = arg2;
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x9c323aa33ef71dce609d84c1715e0b69e3f9511a574587b92c486026e03e1124::tonminer::TONMINER>>(0x2::coin::mint<0x9c323aa33ef71dce609d84c1715e0b69e3f9511a574587b92c486026e03e1124::tonminer::TONMINER>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::coin::TreasuryCap<0x9c323aa33ef71dce609d84c1715e0b69e3f9511a574587b92c486026e03e1124::tonminer::TONMINER>>(&mut arg0.id, 0x1::string::utf8(b"treasury")), v1, arg3), arg1);
        };
    }

    public entry fun set_admin(arg0: &mut GameInfo, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.woner == 0x2::tx_context::sender(arg2), 4);
        arg0.woner = arg1;
    }

    public entry fun set_ref1feed(arg0: &mut GameInfo, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.woner == 0x2::tx_context::sender(arg2), 4);
        arg0.ref1 = arg1;
    }

    public entry fun set_ref2feed(arg0: &mut GameInfo, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.woner == 0x2::tx_context::sender(arg2), 4);
        arg0.ref2 = arg1;
    }

    entry fun update_map_level(arg0: &mut GameInfo, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 2);
        assert!(arg0.woner == 0x2::tx_context::sender(arg4), 4);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, arg1), 5);
        0x2::dynamic_object_field::borrow_mut<address, PlayerInfo>(&mut arg0.id, arg1).map = arg2;
        0x2::dynamic_object_field::borrow_mut<address, PlayerInfo>(&mut arg0.id, arg1).map_base = arg3;
        let v0 = UpdateMaps{
            map_level : arg2,
            map_base  : arg3,
        };
        0x2::event::emit<UpdateMaps>(v0);
    }

    entry fun update_miner_level(arg0: &mut GameInfo, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 2);
        assert!(arg0.woner == 0x2::tx_context::sender(arg4), 4);
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

