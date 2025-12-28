module 0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::vesting {
    struct VestingContract has store, key {
        id: 0x2::object::UID,
        beneficiary: address,
        total_allocation: u64,
        claimed_amount: u64,
        start_time: u64,
        last_claim: u64,
        active: bool,
    }

    struct VestingManager has store, key {
        id: 0x2::object::UID,
        admin: address,
        token_state_id: address,
        total_team_allocation: u64,
        team_balance: 0x2::balance::Balance<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>,
        contracts: 0x2::table::Table<address, VestingContract>,
    }

    struct VestingContractCreated has copy, drop {
        beneficiary: address,
        total_allocation: u64,
        start_time: u64,
    }

    struct TokensClaimed has copy, drop {
        beneficiary: address,
        amount: u64,
        total_claimed: u64,
        remaining: u64,
    }

    public fun calculate_vested_amount(arg0: &VestingContract, arg1: u64) : u64 {
        let v0 = arg1 - arg0.start_time;
        if (v0 < 31104000) {
            return 0
        };
        if (v0 >= 124416000) {
            return arg0.total_allocation
        };
        let v1 = 124416000 - 31104000;
        if (v1 == 0) {
            return arg0.total_allocation
        };
        let v2 = ((((v0 - 31104000) as u128) * (arg0.total_allocation as u128) / (v1 as u128)) as u64);
        if (v2 > arg0.total_allocation) {
            arg0.total_allocation
        } else {
            v2
        }
    }

    public fun can_claim(arg0: &VestingManager, arg1: address, arg2: u64) : (bool, u64) {
        if (!0x2::table::contains<address, VestingContract>(&arg0.contracts, arg1)) {
            return (false, 0)
        };
        let v0 = 0x2::table::borrow<address, VestingContract>(&arg0.contracts, arg1);
        if (!v0.active) {
            return (false, 0)
        };
        let v1 = calculate_vested_amount(v0, arg2 / 1000) - v0.claimed_amount;
        (v1 > 0, v1)
    }

    public entry fun claim_vested_tokens(arg0: &mut VestingManager, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(0x2::table::contains<address, VestingContract>(&arg0.contracts, v0), 1);
        let v2 = 0x2::table::borrow_mut<address, VestingContract>(&mut arg0.contracts, v0);
        assert!(v2.active, 4);
        assert!(v1 - v2.start_time >= 31104000, 2);
        let v3 = calculate_vested_amount(v2, v1) - v2.claimed_amount;
        assert!(v3 > 0, 3);
        assert!(0x2::balance::value<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>(&arg0.team_balance) >= v3, 3);
        v2.claimed_amount = v2.claimed_amount + v3;
        v2.last_claim = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>>(0x2::coin::from_balance<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>(0x2::balance::split<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>(&mut arg0.team_balance, v3), arg2), v0);
        let v4 = TokensClaimed{
            beneficiary   : v0,
            amount        : v3,
            total_claimed : v2.claimed_amount,
            remaining     : v2.total_allocation - v2.claimed_amount,
        };
        0x2::event::emit<TokensClaimed>(v4);
    }

    public entry fun create_vesting_contract(arg0: &mut VestingManager, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg4), 5);
        assert!(arg2 > 0, 4);
        assert!(!0x2::table::contains<address, VestingContract>(&arg0.contracts, arg1), 4);
        let v0 = VestingContract{
            id               : 0x2::object::new(arg4),
            beneficiary      : arg1,
            total_allocation : arg2,
            claimed_amount   : 0,
            start_time       : arg3,
            last_claim       : arg3,
            active           : true,
        };
        0x2::table::add<address, VestingContract>(&mut arg0.contracts, arg1, v0);
        let v1 = VestingContractCreated{
            beneficiary      : arg1,
            total_allocation : arg2,
            start_time       : arg3,
        };
        0x2::event::emit<VestingContractCreated>(v1);
    }

    public entry fun fund_manager(arg0: &mut VestingManager, arg1: &mut 0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::TokenState, arg2: &0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 5);
        0x2::balance::join<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>(&mut arg0.team_balance, 0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::withdraw_team_allocation(arg2, arg1));
    }

    public fun get_vesting_info(arg0: &VestingManager, arg1: address) : (u64, u64, u64, u64, bool) {
        if (!0x2::table::contains<address, VestingContract>(&arg0.contracts, arg1)) {
            return (0, 0, 0, 0, false)
        };
        let v0 = 0x2::table::borrow<address, VestingContract>(&arg0.contracts, arg1);
        (v0.total_allocation, v0.claimed_amount, v0.start_time, v0.last_claim, v0.active)
    }

    public entry fun init_vesting(arg0: &0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::TokenState, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VestingManager{
            id                    : 0x2::object::new(arg1),
            admin                 : 0x2::tx_context::sender(arg1),
            token_state_id        : 0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::token_state_address(arg0),
            total_team_allocation : 0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::team_allocation_balance(arg0),
            team_balance          : 0x2::balance::zero<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>(),
            contracts             : 0x2::table::new<address, VestingContract>(arg1),
        };
        0x2::transfer::share_object<VestingManager>(v0);
    }

    // decompiled from Move bytecode v6
}

