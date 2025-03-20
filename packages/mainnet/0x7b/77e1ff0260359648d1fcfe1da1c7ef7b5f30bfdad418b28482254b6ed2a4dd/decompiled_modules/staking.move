module 0x7b77e1ff0260359648d1fcfe1da1c7ef7b5f30bfdad418b28482254b6ed2a4dd::staking {
    struct STAKING has drop {
        dummy_field: bool,
    }

    struct StakingPoolAuth has key {
        id: 0x2::object::UID,
        pool_count: u64,
        owner: address,
    }

    struct StakingPool has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        balance: 0x2::balance::Balance<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>,
        is_active: bool,
        deactivation_timestamp: u64,
        minimum_stake: u64,
    }

    struct StakingTicket has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        stake_owner: address,
        stake_updates: vector<StakeUpdate>,
        last_claim_timestamp: u64,
    }

    struct StakeUpdate has copy, drop, store {
        timestamp: u64,
        total_staked: u64,
    }

    struct StakingPoolCreatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct StakingTicketMintedEvent has copy, drop {
        ticket_id: 0x2::object::ID,
        stake_owner: address,
        stake_amount: u64,
    }

    struct StakingTicketUpdatedEvent has copy, drop {
        ticket_id: 0x2::object::ID,
        stake_owner: address,
        updated_stake_total: u64,
    }

    struct StakingTicketBurnedEvent has copy, drop {
        ticket_id: 0x2::object::ID,
        stake_owner: address,
    }

    struct StakingRewardClaimedEvent has copy, drop {
        ticket_id: 0x2::object::ID,
        stake_owner: address,
        prev_claim_timestamp: u64,
        this_claim_timestamp: u64,
        stake_updates: vector<StakeUpdate>,
        pool_active: bool,
        pool_deactivation_timestamp: u64,
    }

    fun burn_staking_ticket(arg0: StakingTicket) {
        let v0 = StakingTicketBurnedEvent{
            ticket_id   : 0x2::object::id<StakingTicket>(&arg0),
            stake_owner : arg0.stake_owner,
        };
        0x2::event::emit<StakingTicketBurnedEvent>(v0);
        let StakingTicket {
            id                   : v1,
            pool_id              : _,
            stake_owner          : _,
            stake_updates        : _,
            last_claim_timestamp : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public fun claim_reward(arg0: &0x2::clock::Clock, arg1: &StakingPool, arg2: &mut StakingTicket, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2.stake_owner == 0x2::tx_context::sender(arg3), 1);
        assert!(arg2.pool_id == 0x2::object::id<StakingPool>(arg1), 7);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        arg2.last_claim_timestamp = v0;
        let v1 = StakingRewardClaimedEvent{
            ticket_id                   : 0x2::object::id<StakingTicket>(arg2),
            stake_owner                 : arg2.stake_owner,
            prev_claim_timestamp        : arg2.last_claim_timestamp,
            this_claim_timestamp        : v0,
            stake_updates               : arg2.stake_updates,
            pool_active                 : arg1.is_active,
            pool_deactivation_timestamp : arg1.deactivation_timestamp,
        };
        0x2::event::emit<StakingRewardClaimedEvent>(v1);
    }

    entry fun create_staking_pool(arg0: &mut StakingPoolAuth, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(arg2 > 1000000000, 9);
        arg0.pool_count = arg0.pool_count + 1;
        let v0 = StakingPool{
            id                     : 0x2::object::new(arg3),
            name                   : 0x1::string::utf8(arg1),
            balance                : 0x2::balance::zero<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(),
            is_active              : true,
            deactivation_timestamp : 0,
            minimum_stake          : arg2,
        };
        let v1 = StakingPoolCreatedEvent{
            pool_id : 0x2::object::id<StakingPool>(&v0),
            name    : 0x1::string::utf8(arg1),
        };
        0x2::event::emit<StakingPoolCreatedEvent>(v1);
        0x2::transfer::share_object<StakingPool>(v0);
    }

    public entry fun create_staking_pool_auth(arg0: &0x2::package::Publisher, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<StakingPool>(arg0), 0);
        let v0 = StakingPoolAuth{
            id         : 0x2::object::new(arg2),
            pool_count : 0,
            owner      : arg1,
        };
        0x2::transfer::transfer<StakingPoolAuth>(v0, arg1);
    }

    fun init(arg0: STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<STAKING>(arg0, arg1), v0);
        let v1 = StakingPoolAuth{
            id         : 0x2::object::new(arg1),
            pool_count : 0,
            owner      : v0,
        };
        0x2::transfer::transfer<StakingPoolAuth>(v1, v0);
    }

    public fun is_pool_active(arg0: &StakingPool) : &bool {
        &arg0.is_active
    }

    fun mint_staking_ticket(arg0: &0x2::clock::Clock, arg1: &StakingPool, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : StakingTicket {
        let v0 = StakeUpdate{
            timestamp    : 0x2::clock::timestamp_ms(arg0),
            total_staked : arg3,
        };
        let v1 = 0x1::vector::empty<StakeUpdate>();
        0x1::vector::push_back<StakeUpdate>(&mut v1, v0);
        let v2 = StakingTicket{
            id                   : 0x2::object::new(arg4),
            pool_id              : 0x2::object::id<StakingPool>(arg1),
            stake_owner          : arg2,
            stake_updates        : v1,
            last_claim_timestamp : 0,
        };
        let v3 = StakingTicketMintedEvent{
            ticket_id    : 0x2::object::id<StakingTicket>(&v2),
            stake_owner  : arg2,
            stake_amount : arg3,
        };
        0x2::event::emit<StakingTicketMintedEvent>(v3);
        v2
    }

    public fun pool_total_count(arg0: &StakingPoolAuth) : &u64 {
        &arg0.pool_count
    }

    public fun pool_value(arg0: &StakingPool) : u64 {
        0x2::balance::value<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&arg0.balance)
    }

    fun send_koban_to_pool(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>) {
        let v0 = 0x2::coin::value<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&arg1);
        assert!(arg0.is_active, 2);
        assert!(v0 > 0, 4);
        assert!(v0 >= arg0.minimum_stake, 4);
        0x2::coin::put<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&mut arg0.balance, arg1);
    }

    public fun set_staking_pool_inactive(arg0: &0x2::clock::Clock, arg1: &mut StakingPoolAuth, arg2: &mut StakingPool, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 1);
        arg2.is_active = false;
        arg2.deactivation_timestamp = 0x2::clock::timestamp_ms(arg0);
    }

    public fun set_staking_pool_minimum_stake(arg0: &mut StakingPoolAuth, arg1: &mut StakingPool, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(arg2 > 1000000000, 9);
        arg1.minimum_stake = arg2;
    }

    public entry fun stake_koban_existing_ticket(arg0: &0x2::clock::Clock, arg1: &mut StakingPool, arg2: &mut StakingTicket, arg3: 0x2::coin::Coin<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.stake_owner == 0x2::tx_context::sender(arg4), 1);
        assert!(arg2.pool_id == 0x2::object::id<StakingPool>(arg1), 7);
        send_koban_to_pool(arg1, arg3);
        let v0 = ticket_total_staked(arg2) + 0x2::coin::value<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&arg3);
        ticket_add_stake_update(arg0, arg2, v0);
    }

    public entry fun stake_koban_new_ticket(arg0: &0x2::clock::Clock, arg1: &mut StakingPool, arg2: address, arg3: 0x2::coin::Coin<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>, arg4: &mut 0x2::tx_context::TxContext) {
        send_koban_to_pool(arg1, arg3);
        0x2::transfer::transfer<StakingTicket>(mint_staking_ticket(arg0, arg1, arg2, 0x2::coin::value<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&arg3), arg4), arg2);
    }

    fun ticket_add_stake_update(arg0: &0x2::clock::Clock, arg1: &mut StakingTicket, arg2: u64) {
        let v0 = StakeUpdate{
            timestamp    : 0x2::clock::timestamp_ms(arg0),
            total_staked : arg2,
        };
        0x1::vector::push_back<StakeUpdate>(&mut arg1.stake_updates, v0);
        let v1 = StakingTicketUpdatedEvent{
            ticket_id           : 0x2::object::id<StakingTicket>(arg1),
            stake_owner         : arg1.stake_owner,
            updated_stake_total : arg2,
        };
        0x2::event::emit<StakingTicketUpdatedEvent>(v1);
    }

    public fun ticket_last_claim_timestamp(arg0: &StakingTicket) : u64 {
        arg0.last_claim_timestamp
    }

    fun ticket_last_stake_update(arg0: &StakingTicket) : &StakeUpdate {
        0x1::vector::borrow<StakeUpdate>(&arg0.stake_updates, 0x1::vector::length<StakeUpdate>(&arg0.stake_updates) - 1)
    }

    public fun ticket_owner(arg0: &StakingTicket) : address {
        arg0.stake_owner
    }

    public fun ticket_total_staked(arg0: &StakingTicket) : u64 {
        ticket_last_stake_update(arg0).total_staked
    }

    public entry fun unstake_all_koban(arg0: &0x2::clock::Clock, arg1: &mut StakingPool, arg2: StakingTicket, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.stake_owner == 0x2::tx_context::sender(arg3), 1);
        assert!(arg2.pool_id == 0x2::object::id<StakingPool>(arg1), 7);
        let v0 = ticket_total_staked(&arg2);
        assert!(v0 > 0, 5);
        assert!(0x2::balance::value<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&arg1.balance) >= v0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>>(0x2::coin::take<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&mut arg1.balance, v0, arg3), arg2.stake_owner);
        let v1 = &mut arg2;
        claim_reward(arg0, arg1, v1, arg3);
        burn_staking_ticket(arg2);
    }

    public entry fun unstake_koban(arg0: &0x2::clock::Clock, arg1: &mut StakingPool, arg2: &mut StakingTicket, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.stake_owner == 0x2::tx_context::sender(arg4), 1);
        assert!(arg2.pool_id == 0x2::object::id<StakingPool>(arg1), 7);
        let v0 = 0x2::balance::value<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&arg1.balance);
        let v1 = ticket_total_staked(arg2);
        assert!(arg3 != v1, 8);
        assert!(arg3 > 0, 5);
        assert!(arg3 < v1, 6);
        assert!(v1 - arg3 > arg1.minimum_stake, 4);
        assert!(v0 > 0, 3);
        assert!(v0 >= arg3, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>>(0x2::coin::take<0x8400e7044d360c28dd338111d2aa54ca5bdc960a8d6b60bf3b28e1ca503df3e2::koban::KOBAN>(&mut arg1.balance, arg3, arg4), arg2.stake_owner);
        ticket_add_stake_update(arg0, arg2, v1 - arg3);
    }

    // decompiled from Move bytecode v6
}

