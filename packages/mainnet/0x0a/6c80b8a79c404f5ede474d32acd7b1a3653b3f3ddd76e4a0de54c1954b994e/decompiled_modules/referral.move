module 0xa6c80b8a79c404f5ede474d32acd7b1a3653b3f3ddd76e4a0de54c1954b994e::referral {
    struct REFERRAL has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ReferralCreatedEvent has copy, drop {
        referral: address,
        state: u8,
        rewards_total: u64,
        fund_total: u64,
        user_total: u64,
        distribute_time_ms: u64,
    }

    struct ReferralClaimStartedEvent has copy, drop {
        referral: address,
        state: u8,
        rewards_total: u64,
        fund_total: u64,
        user_total: u64,
    }

    struct ReferralClosedEvent has copy, drop {
        referral: address,
        state: u8,
        rewards_total: u64,
        fund_total: u64,
        user_total: u64,
    }

    struct ReferralUserClaimedEvent has copy, drop {
        referral: address,
        state: u8,
        rewards_total: u64,
        fund_total: u64,
        user: address,
        user_claim: u64,
    }

    struct ReferralUpsertEvent has copy, drop {
        referral: address,
        state: u8,
        rewards_total: u64,
        fund_total: u64,
        user_total: u64,
        users: vector<address>,
        rewards: vector<u64>,
    }

    struct ReferralRemovedEvent has copy, drop {
        referral: address,
        state: u8,
        rewards_total: u64,
        fund_total: u64,
        user_total: u64,
        users: vector<address>,
    }

    struct ReferralDepositEvent has copy, drop {
        referral: address,
        more_reward: u64,
        fund_total: u64,
    }

    struct Referral<phantom T0> has store, key {
        id: 0x2::object::UID,
        state: u8,
        fund: 0x2::coin::Coin<T0>,
        rewards: 0x2::table::Table<address, u64>,
        rewards_total: u64,
        distribute_time_ms: u64,
    }

    public entry fun change_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public entry fun claim_reward<T0>(arg0: &mut Referral<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.state == 1, 1001);
        assert!(0x2::table::contains<address, u64>(&arg0.rewards, v0), 1003);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.distribute_time_ms, 1005);
        let v1 = 0x2::table::remove<address, u64>(&mut arg0.rewards, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.fund, v1, arg2), v0);
        arg0.rewards_total = arg0.rewards_total - v1;
        let v2 = ReferralUserClaimedEvent{
            referral      : 0x2::object::id_address<Referral<T0>>(arg0),
            state         : arg0.state,
            rewards_total : arg0.rewards_total,
            fund_total    : 0x2::coin::value<T0>(&arg0.fund),
            user          : v0,
            user_claim    : v1,
        };
        0x2::event::emit<ReferralUserClaimedEvent>(v2);
    }

    public entry fun close_project<T0>(arg0: &AdminCap, arg1: &mut Referral<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state < 2, 1001);
        arg1.state = 2;
        let v0 = ReferralClosedEvent{
            referral      : 0x2::object::id_address<Referral<T0>>(arg1),
            state         : arg1.state,
            rewards_total : arg1.rewards_total,
            fund_total    : 0x2::coin::value<T0>(&arg1.fund),
            user_total    : 0x2::table::length<address, u64>(&arg1.rewards),
        };
        0x2::event::emit<ReferralClosedEvent>(v0);
    }

    public entry fun create_project<T0>(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Referral<T0>{
            id                 : 0x2::object::new(arg2),
            state              : 0,
            fund               : 0x2::coin::zero<T0>(arg2),
            rewards            : 0x2::table::new<address, u64>(arg2),
            rewards_total      : 0,
            distribute_time_ms : arg1,
        };
        let v1 = ReferralCreatedEvent{
            referral           : 0x2::object::id_address<Referral<T0>>(&v0),
            state              : v0.state,
            rewards_total      : v0.rewards_total,
            fund_total         : 0x2::coin::value<T0>(&v0.fund),
            user_total         : 0x2::table::length<address, u64>(&v0.rewards),
            distribute_time_ms : arg1,
        };
        0x2::event::emit<ReferralCreatedEvent>(v1);
        0x2::transfer::share_object<Referral<T0>>(v0);
    }

    public entry fun deposit_project_fund<T0>(arg0: &mut Referral<T0>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1004);
        0x2::coin::join<T0>(&mut arg0.fund, arg1);
        arg0.rewards_total = arg0.rewards_total + v0;
        let v1 = ReferralDepositEvent{
            referral    : 0x2::object::id_address<Referral<T0>>(arg0),
            more_reward : v0,
            fund_total  : 0x2::coin::value<T0>(&arg0.fund),
        };
        0x2::event::emit<ReferralDepositEvent>(v1);
    }

    fun init(arg0: REFERRAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun remove_Referral<T0>(arg0: &AdminCap, arg1: &mut Referral<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state == 0, 1001);
        let v0 = 0x1::vector::length<address>(&arg2);
        let v1 = v0;
        assert!(v0 > 0, 1003);
        while (v1 > 0) {
            v1 = v1 - 1;
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            assert!(0x2::table::contains<address, u64>(&arg1.rewards, v2), 1003);
            let v3 = 0x2::table::remove<address, u64>(&mut arg1.rewards, v2);
            assert!(arg1.rewards_total >= v3, 1003);
            arg1.rewards_total = arg1.rewards_total - v3;
        };
        let v4 = ReferralRemovedEvent{
            referral      : 0x2::object::id_address<Referral<T0>>(arg1),
            state         : arg1.state,
            rewards_total : arg1.rewards_total,
            fund_total    : 0x2::coin::value<T0>(&arg1.fund),
            user_total    : 0x2::table::length<address, u64>(&arg1.rewards),
            users         : arg2,
        };
        0x2::event::emit<ReferralRemovedEvent>(v4);
    }

    public entry fun start_claim_project<T0>(arg0: &AdminCap, arg1: &mut Referral<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state == 0, 1001);
        assert!(arg1.rewards_total <= 0x2::coin::value<T0>(&arg1.fund), 1002);
        arg1.state = 1;
        let v0 = ReferralClaimStartedEvent{
            referral      : 0x2::object::id_address<Referral<T0>>(arg1),
            state         : arg1.state,
            rewards_total : arg1.rewards_total,
            fund_total    : 0x2::coin::value<T0>(&arg1.fund),
            user_total    : 0x2::table::length<address, u64>(&arg1.rewards),
        };
        0x2::event::emit<ReferralClaimStartedEvent>(v0);
    }

    public entry fun update_distribute_time<T0>(arg0: &AdminCap, arg1: u64, arg2: &mut Referral<T0>) {
        arg2.distribute_time_ms = arg1;
    }

    public entry fun upsert_Referral<T0>(arg0: &AdminCap, arg1: &mut Referral<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state == 0, 1001);
        let v0 = 0x1::vector::length<address>(&arg2);
        let v1 = v0;
        assert!(v0 == 0x1::vector::length<u64>(&arg3) && v0 > 0, 1003);
        while (v1 > 0) {
            v1 = v1 - 1;
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            let v3 = *0x1::vector::borrow<u64>(&arg3, v1);
            assert!(v3 > 0, 1003);
            if (0x2::table::contains<address, u64>(&arg1.rewards, v2)) {
                let v4 = 0x2::table::remove<address, u64>(&mut arg1.rewards, v2);
                0x2::table::add<address, u64>(&mut arg1.rewards, v2, v3);
                assert!(arg1.rewards_total >= v4, 1003);
                arg1.rewards_total = 0xea2ef08c61bcfa88f22442782e2769acfcd73f506d1fd96664def94f390b54a2::u256::add_u64(0xea2ef08c61bcfa88f22442782e2769acfcd73f506d1fd96664def94f390b54a2::u256::sub_u64(arg1.rewards_total, v4), v3);
                continue
            };
            0x2::table::add<address, u64>(&mut arg1.rewards, v2, v3);
            arg1.rewards_total = 0xea2ef08c61bcfa88f22442782e2769acfcd73f506d1fd96664def94f390b54a2::u256::add_u64(arg1.rewards_total, v3);
        };
        let v5 = ReferralUpsertEvent{
            referral      : 0x2::object::id_address<Referral<T0>>(arg1),
            state         : arg1.state,
            rewards_total : arg1.rewards_total,
            fund_total    : 0x2::coin::value<T0>(&arg1.fund),
            user_total    : 0x2::table::length<address, u64>(&arg1.rewards),
            users         : arg2,
            rewards       : arg3,
        };
        0x2::event::emit<ReferralUpsertEvent>(v5);
    }

    public entry fun withdraw_project_fund<T0>(arg0: &AdminCap, arg1: &mut Referral<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state == 2, 1001);
        assert!(0x2::coin::value<T0>(&arg1.fund) >= arg2, 1006);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1.fund, arg2, arg4), arg3);
        arg1.rewards_total = arg1.rewards_total - arg2;
    }

    // decompiled from Move bytecode v6
}

