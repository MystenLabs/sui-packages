module 0xb7e3fe335f8dcf6a14e380e64869a2f1c810add96b203a4e0b0371379ce73da8::game {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct GameInfo has key {
        id: 0x2::object::UID,
        version: u8,
        balance: 0x2::balance::Balance<0xb7e3fe335f8dcf6a14e380e64869a2f1c810add96b203a4e0b0371379ce73da8::tonminer::TONMINER>,
        miner: u8,
        miner_rate: u8,
        map: u8,
        map_base: u8,
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
        miner: u8,
        miner_rate: u8,
        map: u8,
        map_base: u8,
        referral: address,
    }

    struct CreateUser has copy, drop, store {
        user_address: address,
        ref_address: address,
    }

    entry fun add_treasury_cap(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: 0x2::coin::TreasuryCap<0xb7e3fe335f8dcf6a14e380e64869a2f1c810add96b203a4e0b0371379ce73da8::tonminer::TONMINER>) {
        0x2::dynamic_field::add<0x1::string::String, 0x2::coin::TreasuryCap<0xb7e3fe335f8dcf6a14e380e64869a2f1c810add96b203a4e0b0371379ce73da8::tonminer::TONMINER>>(&mut arg1.id, 0x1::string::utf8(b"treasury"), arg2);
    }

    fun calc_claim(arg0: &mut GameInfo, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow<address, PlayerInfo>(&arg0.id, arg1).referral;
        send_tokens(arg0, arg1, arg2, arg3);
        let v1 = arg0.woner;
        let v2 = arg2 * (arg0.gas_fee as u64) / 10000;
        send_tokens(arg0, v1, v2, arg3);
        if (v0 != @0x0 && v0 != arg1 && 0x2::dynamic_object_field::exists_<address>(&arg0.id, v0)) {
            let v3 = arg2 * (arg0.ref1 as u64) / 10000;
            send_tokens(arg0, v0, v3, arg3);
            let v4 = 0x2::dynamic_object_field::borrow<address, PlayerInfo>(&arg0.id, v0).referral;
            if (v4 != @0x0 && v4 != arg1 && 0x2::dynamic_object_field::exists_<address>(&arg0.id, v4)) {
                let v5 = arg2 * (arg0.ref2 as u64) / 10000;
                send_tokens(arg0, v4, v5, arg3);
            };
        };
    }

    public entry fun claim(arg0: &mut GameInfo, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        calc_claim(arg0, v0, 100000000, arg1);
    }

    public entry fun create_user(arg0: &mut GameInfo, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 2);
        assert!(arg0.woner == 0x2::tx_context::sender(arg3), 4);
        let v0 = 0x1::string::utf8(b"CREATE_USER:");
        let v1 = 0x2::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg1));
        assert!(!0x2::dynamic_object_field::exists_<address>(&arg0.id, arg1), 4);
        let v2 = PlayerInfo{
            id         : 0x2::object::new(arg3),
            miner      : 1,
            miner_rate : 0,
            map        : 1,
            map_base   : 1,
            referral   : arg2,
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
            balance     : 0x2::balance::zero<0xb7e3fe335f8dcf6a14e380e64869a2f1c810add96b203a4e0b0371379ce73da8::tonminer::TONMINER>(),
            miner       : 1,
            miner_rate  : 0,
            map         : 1,
            map_base    : 1,
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
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<0xb7e3fe335f8dcf6a14e380e64869a2f1c810add96b203a4e0b0371379ce73da8::tonminer::TONMINER>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::coin::TreasuryCap<0xb7e3fe335f8dcf6a14e380e64869a2f1c810add96b203a4e0b0371379ce73da8::tonminer::TONMINER>>(&mut arg1.id, 0x1::string::utf8(b"treasury")), 0x2::tx_context::sender(arg2));
    }

    fun send_tokens(arg0: &mut GameInfo, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0xb7e3fe335f8dcf6a14e380e64869a2f1c810add96b203a4e0b0371379ce73da8::tonminer::TONMINER>(&arg0.balance);
        let v1 = 0;
        if (v0 >= arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xb7e3fe335f8dcf6a14e380e64869a2f1c810add96b203a4e0b0371379ce73da8::tonminer::TONMINER>>(0x2::coin::from_balance<0xb7e3fe335f8dcf6a14e380e64869a2f1c810add96b203a4e0b0371379ce73da8::tonminer::TONMINER>(0x2::balance::split<0xb7e3fe335f8dcf6a14e380e64869a2f1c810add96b203a4e0b0371379ce73da8::tonminer::TONMINER>(&mut arg0.balance, arg2), arg3), arg1);
        } else if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xb7e3fe335f8dcf6a14e380e64869a2f1c810add96b203a4e0b0371379ce73da8::tonminer::TONMINER>>(0x2::coin::from_balance<0xb7e3fe335f8dcf6a14e380e64869a2f1c810add96b203a4e0b0371379ce73da8::tonminer::TONMINER>(0x2::balance::withdraw_all<0xb7e3fe335f8dcf6a14e380e64869a2f1c810add96b203a4e0b0371379ce73da8::tonminer::TONMINER>(&mut arg0.balance), arg3), arg1);
            v1 = arg2 - v0;
        } else {
            v1 = arg2;
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xb7e3fe335f8dcf6a14e380e64869a2f1c810add96b203a4e0b0371379ce73da8::tonminer::TONMINER>>(0x2::coin::mint<0xb7e3fe335f8dcf6a14e380e64869a2f1c810add96b203a4e0b0371379ce73da8::tonminer::TONMINER>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::coin::TreasuryCap<0xb7e3fe335f8dcf6a14e380e64869a2f1c810add96b203a4e0b0371379ce73da8::tonminer::TONMINER>>(&mut arg0.id, 0x1::string::utf8(b"treasury")), v1, arg3), arg1);
        };
    }

    public entry fun set_admin(arg0: &mut GameInfo, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.woner == 0x2::tx_context::sender(arg2), 4);
        arg0.woner = arg1;
    }

    // decompiled from Move bytecode v6
}

