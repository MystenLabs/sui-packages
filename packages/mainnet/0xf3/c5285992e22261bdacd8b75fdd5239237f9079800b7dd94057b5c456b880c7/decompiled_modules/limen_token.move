module 0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token {
    struct LIMEN_TOKEN has drop {
        dummy_field: bool,
    }

    struct TokenState has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<LIMEN_TOKEN>,
        admin: address,
        paused: bool,
        total_minted: u64,
        mining_pool: 0x2::balance::Balance<LIMEN_TOKEN>,
        treasury: 0x2::balance::Balance<LIMEN_TOKEN>,
        team_allocation: 0x2::balance::Balance<LIMEN_TOKEN>,
        liquidity_allocation: 0x2::balance::Balance<LIMEN_TOKEN>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        token_state_id: address,
    }

    struct TokenInitialized has copy, drop {
        admin: address,
        total_supply: u64,
    }

    struct TokensMinted has copy, drop {
        recipient: address,
        amount: u64,
        purpose: vector<u8>,
    }

    struct EmergencyPaused has copy, drop {
        paused: bool,
    }

    public fun admin(arg0: &TokenState) : address {
        arg0.admin
    }

    public entry fun allocate_from_treasury(arg0: &AdminCap, arg1: &mut TokenState, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.token_state_id == 0x2::object::uid_to_address(&arg1.id), 2);
        assert!(arg1.admin == 0x2::tx_context::sender(arg4), 2);
        assert!(!arg1.paused, 6);
        assert!(arg3 > 0, 3);
        assert!(0x2::balance::value<LIMEN_TOKEN>(&arg1.treasury) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LIMEN_TOKEN>>(0x2::coin::from_balance<LIMEN_TOKEN>(0x2::balance::split<LIMEN_TOKEN>(&mut arg1.treasury, arg3), arg4), arg2);
        let v0 = TokensMinted{
            recipient : arg2,
            amount    : arg3,
            purpose   : b"treasury_allocation",
        };
        0x2::event::emit<TokensMinted>(v0);
    }

    public entry fun distribute_mining_reward(arg0: &AdminCap, arg1: &mut TokenState, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.token_state_id == 0x2::object::uid_to_address(&arg1.id), 2);
        assert!(arg1.admin == 0x2::tx_context::sender(arg4), 2);
        assert!(!arg1.paused, 6);
        assert!(arg3 > 0, 3);
        assert!(0x2::balance::value<LIMEN_TOKEN>(&arg1.mining_pool) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LIMEN_TOKEN>>(0x2::coin::from_balance<LIMEN_TOKEN>(0x2::balance::split<LIMEN_TOKEN>(&mut arg1.mining_pool, arg3), arg4), arg2);
        let v0 = TokensMinted{
            recipient : arg2,
            amount    : arg3,
            purpose   : b"mining_reward",
        };
        0x2::event::emit<TokensMinted>(v0);
    }

    public entry fun emergency_pause(arg0: &AdminCap, arg1: &mut TokenState, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.token_state_id == 0x2::object::uid_to_address(&arg1.id), 2);
        assert!(arg1.admin == 0x2::tx_context::sender(arg3), 2);
        if (arg1.paused == arg2) {
            return
        };
        arg1.paused = arg2;
        let v0 = EmergencyPaused{paused: arg2};
        0x2::event::emit<EmergencyPaused>(v0);
    }

    public entry fun emergency_team_allocation(arg0: &AdminCap, arg1: &mut TokenState, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.token_state_id == 0x2::object::uid_to_address(&arg1.id), 2);
        assert!(arg1.admin == 0x2::tx_context::sender(arg4), 2);
        assert!(!arg1.paused, 6);
        assert!(arg3 > 0, 3);
        assert!(0x2::balance::value<LIMEN_TOKEN>(&arg1.team_allocation) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LIMEN_TOKEN>>(0x2::coin::from_balance<LIMEN_TOKEN>(0x2::balance::split<LIMEN_TOKEN>(&mut arg1.team_allocation, arg3), arg4), arg2);
        let v0 = TokensMinted{
            recipient : arg2,
            amount    : arg3,
            purpose   : b"team_allocation_emergency",
        };
        0x2::event::emit<TokensMinted>(v0);
    }

    fun init(arg0: LIMEN_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LIMEN_TOKEN>(arg0, 9, b"LIMEN", b"Limen Token", b"Limen Token - Utility token for zkRollup L3 infrastructure", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suigas.xyz/limen-logo.png")), arg1);
        let v3 = v1;
        let v4 = TokenState{
            id                   : 0x2::object::new(arg1),
            treasury_cap         : v3,
            admin                : v0,
            paused               : false,
            total_minted         : 780000000000000000,
            mining_pool          : 0x2::coin::mint_balance<LIMEN_TOKEN>(&mut v3, 624000000000000000),
            treasury             : 0x2::coin::mint_balance<LIMEN_TOKEN>(&mut v3, 78000000000000000),
            team_allocation      : 0x2::coin::mint_balance<LIMEN_TOKEN>(&mut v3, 62400000000000000),
            liquidity_allocation : 0x2::coin::mint_balance<LIMEN_TOKEN>(&mut v3, 15600000000000000),
        };
        let v5 = AdminCap{
            id             : 0x2::object::new(arg1),
            token_state_id : 0x2::object::uid_to_address(&v4.id),
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIMEN_TOKEN>>(v2);
        0x2::transfer::share_object<TokenState>(v4);
        0x2::transfer::transfer<AdminCap>(v5, v0);
        let v6 = TokenInitialized{
            admin        : v0,
            total_supply : 780000000000000000,
        };
        0x2::event::emit<TokenInitialized>(v6);
    }

    public fun is_paused(arg0: &TokenState) : bool {
        arg0.paused
    }

    public fun liquidity_allocation_balance(arg0: &TokenState) : u64 {
        0x2::balance::value<LIMEN_TOKEN>(&arg0.liquidity_allocation)
    }

    public fun mining_pool_balance(arg0: &TokenState) : u64 {
        0x2::balance::value<LIMEN_TOKEN>(&arg0.mining_pool)
    }

    public entry fun release_liquidity_allocation(arg0: &AdminCap, arg1: &mut TokenState, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.token_state_id == 0x2::object::uid_to_address(&arg1.id), 2);
        assert!(arg1.admin == 0x2::tx_context::sender(arg4), 2);
        assert!(!arg1.paused, 6);
        assert!(arg3 > 0, 3);
        assert!(0x2::balance::value<LIMEN_TOKEN>(&arg1.liquidity_allocation) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LIMEN_TOKEN>>(0x2::coin::from_balance<LIMEN_TOKEN>(0x2::balance::split<LIMEN_TOKEN>(&mut arg1.liquidity_allocation, arg3), arg4), arg2);
        let v0 = TokensMinted{
            recipient : arg2,
            amount    : arg3,
            purpose   : b"liquidity_allocation",
        };
        0x2::event::emit<TokensMinted>(v0);
    }

    public fun team_allocation_balance(arg0: &TokenState) : u64 {
        0x2::balance::value<LIMEN_TOKEN>(&arg0.team_allocation)
    }

    public fun token_state_address(arg0: &TokenState) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun total_supply() : u64 {
        780000000000000000
    }

    public fun treasury_balance(arg0: &TokenState) : u64 {
        0x2::balance::value<LIMEN_TOKEN>(&arg0.treasury)
    }

    public entry fun update_admin(arg0: &AdminCap, arg1: &mut TokenState, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.token_state_id == 0x2::object::uid_to_address(&arg1.id), 2);
        assert!(arg1.admin == 0x2::tx_context::sender(arg3), 2);
        assert!(arg2 != @0x0, 3);
        arg1.admin = arg2;
    }

    public fun withdraw_team_allocation(arg0: &AdminCap, arg1: &mut TokenState) : 0x2::balance::Balance<LIMEN_TOKEN> {
        assert!(arg0.token_state_id == 0x2::object::uid_to_address(&arg1.id), 2);
        0x2::balance::split<LIMEN_TOKEN>(&mut arg1.team_allocation, 0x2::balance::value<LIMEN_TOKEN>(&arg1.team_allocation))
    }

    // decompiled from Move bytecode v6
}

