module 0xcefa59cdde0de6e99842383caa80badfbf40476fabf203688bfb4a72510b37c::stake {
    struct Stakes has store {
        total_stake: u64,
        stake_table_by_id: 0x2::table::Table<0x2::object::ID, Staked>,
    }

    struct Staked has store, key {
        id: 0x2::object::UID,
        nft: 0x2::object::ID,
        kiosk: 0x2::object::ID,
        cap: 0x2::object::ID,
        start_timestamp: u64,
    }

    struct StakeState has store, key {
        id: 0x2::object::UID,
        stakes: 0x2::table::Table<address, Stakes>,
        duration: u64,
        is_started: bool,
    }

    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    struct StakeEvent has copy, drop {
        kiosk: 0x2::object::ID,
        nft: 0x2::object::ID,
        user_address: address,
        timestamp: u64,
    }

    struct UnstakeEvent has copy, drop {
        kiosk: 0x2::object::ID,
        nft: 0x2::object::ID,
        user_address: address,
        start_timestamp: u64,
        timestamp: u64,
    }

    public entry fun stake(arg0: 0x2::object::ID, arg1: &mut StakeState, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_started, 1);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::is_personal(arg2), 100);
        let v0 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3);
        assert!(0x2::kiosk::has_access(arg2, v0), 101);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        if (!0x2::table::contains<address, Stakes>(&arg1.stakes, 0x2::tx_context::sender(arg5))) {
            let v2 = Stakes{
                total_stake       : 0,
                stake_table_by_id : 0x2::table::new<0x2::object::ID, Staked>(arg5),
            };
            0x2::table::add<address, Stakes>(&mut arg1.stakes, 0x2::tx_context::sender(arg5), v2);
        };
        let v3 = 0x2::table::borrow_mut<address, Stakes>(&mut arg1.stakes, 0x2::tx_context::sender(arg5));
        assert!(!0x2::table::contains<0x2::object::ID, Staked>(&v3.stake_table_by_id, arg0), 102);
        let v4 = Staked{
            id              : 0x2::object::new(arg5),
            nft             : arg0,
            kiosk           : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            cap             : 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg3),
            start_timestamp : v1,
        };
        0x2::dynamic_object_field::add<bool, 0x2::kiosk::PurchaseCap<0xca5fb99af8ee7f40da48ed782107b40c8d669f17b85c76d7af7aec856d430f34::mermaid::Mermaid>>(&mut v4.id, true, 0x2::kiosk::list_with_purchase_cap<0xca5fb99af8ee7f40da48ed782107b40c8d669f17b85c76d7af7aec856d430f34::mermaid::Mermaid>(arg2, v0, arg0, 0, arg5));
        0x2::table::add<0x2::object::ID, Staked>(&mut v3.stake_table_by_id, arg0, v4);
        v3.total_stake = v3.total_stake + 1;
        let v5 = StakeEvent{
            kiosk        : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            nft          : arg0,
            user_address : 0x2::tx_context::sender(arg5),
            timestamp    : v1,
        };
        0x2::event::emit<StakeEvent>(v5);
    }

    public entry fun change_duration(arg0: &OperatorCap, arg1: &mut StakeState, arg2: u64) {
        arg1.duration = arg2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = StakeState{
            id         : 0x2::object::new(arg0),
            stakes     : 0x2::table::new<address, Stakes>(arg0),
            duration   : 1209600000,
            is_started : true,
        };
        0x2::transfer::public_share_object<StakeState>(v1);
    }

    public entry fun start_stake(arg0: &OperatorCap, arg1: &mut StakeState) {
        assert!(!arg1.is_started, 1);
        arg1.is_started = true;
    }

    public entry fun stop_stake(arg0: &OperatorCap, arg1: &mut StakeState) {
        assert!(arg1.is_started, 1);
        arg1.is_started = false;
    }

    public entry fun unstake(arg0: 0x2::object::ID, arg1: &mut StakeState, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::is_personal(arg2), 100);
        assert!(0x2::kiosk::has_access(arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3)), 101);
        assert!(0x2::table::contains<address, Stakes>(&arg1.stakes, 0x2::tx_context::sender(arg5)), 102);
        let v0 = 0x2::table::borrow_mut<address, Stakes>(&mut arg1.stakes, 0x2::tx_context::sender(arg5));
        assert!(0x2::table::contains<0x2::object::ID, Staked>(&v0.stake_table_by_id, arg0), 103);
        let Staked {
            id              : v1,
            nft             : v2,
            kiosk           : v3,
            cap             : _,
            start_timestamp : v5,
        } = 0x2::table::remove<0x2::object::ID, Staked>(&mut v0.stake_table_by_id, arg0);
        let v6 = v1;
        assert!(v3 == 0x2::object::id<0x2::kiosk::Kiosk>(arg2), 104);
        let v7 = 0x2::clock::timestamp_ms(arg4);
        assert!(v5 + arg1.duration < v7, 106);
        assert!(0x2::dynamic_object_field::exists_<bool>(&v6, true), 105);
        0x2::kiosk::return_purchase_cap<0xca5fb99af8ee7f40da48ed782107b40c8d669f17b85c76d7af7aec856d430f34::mermaid::Mermaid>(arg2, 0x2::dynamic_object_field::remove<bool, 0x2::kiosk::PurchaseCap<0xca5fb99af8ee7f40da48ed782107b40c8d669f17b85c76d7af7aec856d430f34::mermaid::Mermaid>>(&mut v6, true));
        0x2::object::delete(v6);
        v0.total_stake = v0.total_stake - 1;
        let v8 = UnstakeEvent{
            kiosk           : v3,
            nft             : v2,
            user_address    : 0x2::tx_context::sender(arg5),
            start_timestamp : v5,
            timestamp       : v7,
        };
        0x2::event::emit<UnstakeEvent>(v8);
    }

    // decompiled from Move bytecode v6
}

