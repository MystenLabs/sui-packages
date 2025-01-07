module 0xee2720ebd52aad857e6920944c75f681fed9eef8531f55a206fc9fb8e5ffe0c4::game {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct TokenAddr has drop {
        dummy_field: bool,
    }

    struct GameInfo has key {
        id: 0x2::object::UID,
        version: u8,
        balance: 0x2::balance::Balance<0xee2720ebd52aad857e6920944c75f681fed9eef8531f55a206fc9fb8e5ffe0c4::tonminer::TONMINER>,
        gas_fee: u16,
        owner: address,
        ref1: u16,
        ref2: u16,
        v_ref: u16,
        reward_level: u64,
    }

    struct PlayerInfo has store, key {
        id: 0x2::object::UID,
        miner_level: u64,
        miner_speed: u64,
        map_level: u64,
        map_reward: u64,
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
        map_reward: u64,
    }

    struct UpdateMiner has copy, drop, store {
        miner_level: u64,
        miner_speed: u64,
    }

    entry fun add_treasury_cap(arg0: &mut GameInfo, arg1: 0x2::coin::TreasuryCap<0xee2720ebd52aad857e6920944c75f681fed9eef8531f55a206fc9fb8e5ffe0c4::tonminer::TONMINER>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 4);
        0x2::dynamic_field::add<0x1::string::String, 0x2::coin::TreasuryCap<0xee2720ebd52aad857e6920944c75f681fed9eef8531f55a206fc9fb8e5ffe0c4::tonminer::TONMINER>>(&mut arg0.id, 0x1::string::utf8(b"treasury"), arg1);
    }

    fun calc_claim(arg0: &mut GameInfo, arg1: address, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow<address, PlayerInfo>(&arg0.id, arg1).referral;
        let v1 = 0;
        let v2 = @0x0;
        let v3 = 0;
        let v4 = arg2;
        if (arg3) {
            v4 = arg2 * (100 - (arg0.gas_fee as u64)) / 100;
        };
        send_tokens(arg0, arg1, v4, arg4);
        let v5 = arg0.owner;
        send_tokens(arg0, v5, arg2 * 1 / 100, arg4);
        if (v0 != @0x0 && v0 != arg1 && 0x2::dynamic_object_field::exists_<address>(&arg0.id, v0)) {
            let v6 = arg2 * (arg0.ref1 as u64) / 100;
            v1 = v6;
            send_tokens(arg0, v0, v6, arg4);
            let v7 = 0x2::dynamic_object_field::borrow<address, PlayerInfo>(&arg0.id, v0).referral;
            v2 = v7;
            if (v7 != @0x0 && v7 != arg1 && 0x2::dynamic_object_field::exists_<address>(&arg0.id, v7)) {
                let v8 = arg2 * (arg0.ref2 as u64) / 100;
                v3 = v8;
                send_tokens(arg0, v7, v8, arg4);
            };
        };
        let v9 = ClaimToken{
            user_address         : arg1,
            amount_user_received : v4,
            ref1_address         : v0,
            amount_ref1_received : v1,
            ref2_address         : v2,
            amount_ref2_received : v3,
        };
        0x2::event::emit<ClaimToken>(v9);
    }

    public entry fun claim(arg0: &mut GameInfo, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, v0), 5);
        let v1 = 0x2::dynamic_object_field::borrow<address, PlayerInfo>(&arg0.id, v0);
        assert!((v1.miner_level as u64) >= arg0.reward_level, 16);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        assert!(v2 >= (v1.next_claim as u64), 6);
        0x2::dynamic_object_field::borrow_mut<address, PlayerInfo>(&mut arg0.id, v0).last_claim = v2;
        0x2::dynamic_object_field::borrow_mut<address, PlayerInfo>(&mut arg0.id, v0).next_claim = v2 + v1.peroid * 60 * 1000;
        calc_claim(arg0, v0, v1.map_reward * 10000000 * (100 + v1.miner_speed), true, arg2);
    }

    entry fun create_user(arg0: &mut GameInfo, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 2);
        assert!(arg0.owner == 0x2::tx_context::sender(arg8), 4);
        let v0 = 0x1::string::utf8(b"CREATE_USER:");
        let v1 = 0x2::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg1));
        assert!(!0x2::dynamic_object_field::exists_<address>(&arg0.id, arg1), 4);
        let v2 = PlayerInfo{
            id          : 0x2::object::new(arg8),
            miner_level : arg3,
            miner_speed : arg4,
            map_level   : arg5,
            map_reward  : arg6,
            peroid      : arg7,
            referral    : arg2,
            last_claim  : 0,
            next_claim  : 0,
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
            id           : 0x2::object::new(arg0),
            version      : 1,
            balance      : 0x2::balance::zero<0xee2720ebd52aad857e6920944c75f681fed9eef8531f55a206fc9fb8e5ffe0c4::tonminer::TONMINER>(),
            gas_fee      : 1,
            owner        : v0,
            ref1         : 5,
            ref2         : 1,
            v_ref        : 500,
            reward_level : 6,
        };
        0x2::transfer::share_object<GameInfo>(v2);
    }

    entry fun remove_treasury_cap(arg0: &mut GameInfo, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 4);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<0xee2720ebd52aad857e6920944c75f681fed9eef8531f55a206fc9fb8e5ffe0c4::tonminer::TONMINER>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::coin::TreasuryCap<0xee2720ebd52aad857e6920944c75f681fed9eef8531f55a206fc9fb8e5ffe0c4::tonminer::TONMINER>>(&mut arg0.id, 0x1::string::utf8(b"treasury")), 0x2::tx_context::sender(arg1));
    }

    fun send_tokens(arg0: &mut GameInfo, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0xee2720ebd52aad857e6920944c75f681fed9eef8531f55a206fc9fb8e5ffe0c4::tonminer::TONMINER>(&arg0.balance);
        let v1 = 0;
        if (v0 >= arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xee2720ebd52aad857e6920944c75f681fed9eef8531f55a206fc9fb8e5ffe0c4::tonminer::TONMINER>>(0x2::coin::from_balance<0xee2720ebd52aad857e6920944c75f681fed9eef8531f55a206fc9fb8e5ffe0c4::tonminer::TONMINER>(0x2::balance::split<0xee2720ebd52aad857e6920944c75f681fed9eef8531f55a206fc9fb8e5ffe0c4::tonminer::TONMINER>(&mut arg0.balance, arg2), arg3), arg1);
        } else if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xee2720ebd52aad857e6920944c75f681fed9eef8531f55a206fc9fb8e5ffe0c4::tonminer::TONMINER>>(0x2::coin::from_balance<0xee2720ebd52aad857e6920944c75f681fed9eef8531f55a206fc9fb8e5ffe0c4::tonminer::TONMINER>(0x2::balance::withdraw_all<0xee2720ebd52aad857e6920944c75f681fed9eef8531f55a206fc9fb8e5ffe0c4::tonminer::TONMINER>(&mut arg0.balance), arg3), arg1);
            v1 = arg2 - v0;
        } else {
            v1 = arg2;
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xee2720ebd52aad857e6920944c75f681fed9eef8531f55a206fc9fb8e5ffe0c4::tonminer::TONMINER>>(0x2::coin::mint<0xee2720ebd52aad857e6920944c75f681fed9eef8531f55a206fc9fb8e5ffe0c4::tonminer::TONMINER>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::coin::TreasuryCap<0xee2720ebd52aad857e6920944c75f681fed9eef8531f55a206fc9fb8e5ffe0c4::tonminer::TONMINER>>(&mut arg0.id, 0x1::string::utf8(b"treasury")), v1, arg3), arg1);
        };
    }

    entry fun setMintLevel(arg0: &mut GameInfo, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 4);
        arg0.reward_level = arg1;
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
        0x2::dynamic_object_field::borrow_mut<address, PlayerInfo>(&mut arg0.id, arg1).map_level = arg2;
        0x2::dynamic_object_field::borrow_mut<address, PlayerInfo>(&mut arg0.id, arg1).map_reward = arg3;
        0x2::dynamic_object_field::borrow_mut<address, PlayerInfo>(&mut arg0.id, arg1).peroid = arg4;
        let v0 = UpdateMap{
            map_level  : arg2,
            map_reward : arg3,
        };
        0x2::event::emit<UpdateMap>(v0);
    }

    public entry fun update_miner(arg0: &mut GameInfo, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 2);
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 4);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, arg1), 5);
        0x2::dynamic_object_field::borrow_mut<address, PlayerInfo>(&mut arg0.id, arg1).miner_level = arg2;
        0x2::dynamic_object_field::borrow_mut<address, PlayerInfo>(&mut arg0.id, arg1).miner_speed = arg3;
        let v0 = UpdateMiner{
            miner_level : arg2,
            miner_speed : arg3,
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

