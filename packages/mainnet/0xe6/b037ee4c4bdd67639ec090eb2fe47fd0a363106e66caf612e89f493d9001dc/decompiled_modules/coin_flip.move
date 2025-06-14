module 0xe6b037ee4c4bdd67639ec090eb2fe47fd0a363106e66caf612e89f493d9001dc::coin_flip {
    struct COIN_FLIP has drop {
        dummy_field: bool,
    }

    struct CoinSide has copy, drop, store {
        is_heads: bool,
    }

    struct TokenConfig has copy, drop, store {
        enabled: bool,
        min_bet_amount: u64,
        max_bet_amount: u64,
    }

    struct Game<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        bet_amount: u64,
        creator_choice: CoinSide,
        balance: 0x2::balance::Balance<T0>,
        created_at_ms: u64,
        token_type: 0x1::type_name::TypeName,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GameConfig has key {
        id: 0x2::object::UID,
        admin_cap_id: address,
        fee_percentage: u64,
        treasury_address: address,
        is_paused: bool,
        max_games_per_transaction: u64,
        whitelisted_tokens: 0x2::table::Table<0x1::type_name::TypeName, TokenConfig>,
    }

    struct GameCreated has copy, drop {
        game_id: address,
        creator: address,
        bet_amount: u64,
        creator_choice_heads: bool,
        token_type: 0x1::type_name::TypeName,
        created_at_ms: u64,
    }

    struct GameJoined has copy, drop {
        game_id: address,
        creator: address,
        creator_choice_heads: bool,
        joiner: address,
        joiner_choice_heads: bool,
        winner: address,
        bet_amount: u64,
        loser: address,
        total_pot: u64,
        winner_payout: u64,
        fee_collected: u64,
        coin_flip_result_heads: bool,
        token_type: 0x1::type_name::TypeName,
    }

    struct GameCancelled has copy, drop {
        game_id: address,
        creator: address,
        refund_amount: u64,
        token_type: 0x1::type_name::TypeName,
    }

    struct ConfigUpdated has copy, drop {
        admin: address,
        fee_percentage: u64,
        is_paused: bool,
        treasury_address: address,
        max_games_per_transaction: u64,
    }

    public entry fun add_whitelisted_token<T0>(arg0: &AdminCap, arg1: &mut GameConfig, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        validate_admin_cap(arg0, arg1);
        assert!(arg2 > 0, 1);
        assert!(arg2 <= arg3, 1);
        let v0 = TokenConfig{
            enabled        : true,
            min_bet_amount : arg2,
            max_bet_amount : arg3,
        };
        0x2::table::add<0x1::type_name::TypeName, TokenConfig>(&mut arg1.whitelisted_tokens, 0x1::type_name::get<T0>(), v0);
    }

    public entry fun cancel_game<T0>(arg0: Game<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 5);
        let Game {
            id             : v0,
            creator        : v1,
            bet_amount     : v2,
            creator_choice : _,
            balance        : v4,
            created_at_ms  : _,
            token_type     : v6,
        } = arg0;
        let v7 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg1), v1);
        let v8 = GameCancelled{
            game_id       : 0x2::object::uid_to_address(&v7),
            creator       : v1,
            refund_amount : v2,
            token_type    : v6,
        };
        0x2::event::emit<GameCancelled>(v8);
        0x2::object::delete(v7);
    }

    public entry fun create_game<T0>(arg0: 0x2::coin::Coin<T0>, arg1: bool, arg2: &GameConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.is_paused, 10);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, TokenConfig>(&arg2.whitelisted_tokens, v0), 14);
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, TokenConfig>(&arg2.whitelisted_tokens, v0);
        assert!(v1.enabled, 14);
        let v2 = 0x2::coin::value<T0>(&arg0);
        assert!(v2 > 0, 1);
        assert!(v2 >= v1.min_bet_amount, 8);
        assert!(v2 <= v1.max_bet_amount, 9);
        let v3 = 0x2::tx_context::sender(arg4);
        let v4 = CoinSide{is_heads: arg1};
        let v5 = 0x2::clock::timestamp_ms(arg3);
        let v6 = Game<T0>{
            id             : 0x2::object::new(arg4),
            creator        : v3,
            bet_amount     : v2,
            creator_choice : v4,
            balance        : 0x2::coin::into_balance<T0>(arg0),
            created_at_ms  : v5,
            token_type     : v0,
        };
        let v7 = GameCreated{
            game_id              : 0x2::object::uid_to_address(&v6.id),
            creator              : v3,
            bet_amount           : v2,
            creator_choice_heads : arg1,
            token_type           : v0,
            created_at_ms        : v5,
        };
        0x2::event::emit<GameCreated>(v7);
        0x2::transfer::share_object<Game<T0>>(v6);
    }

    fun execute_secure_game<T0>(arg0: Game<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: address, arg3: &mut 0x2::random::RandomGenerator, arg4: &GameConfig, arg5: &mut 0x2::tx_context::TxContext) {
        let Game {
            id             : v0,
            creator        : v1,
            bet_amount     : v2,
            creator_choice : v3,
            balance        : v4,
            created_at_ms  : _,
            token_type     : v6,
        } = arg0;
        let v7 = v3;
        let v8 = v0;
        let v9 = v4;
        0x2::balance::join<T0>(&mut v9, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, v2, arg5)));
        let v10 = 0x2::random::generate_bool(arg3);
        let (v11, v12) = if (v10 == v7.is_heads) {
            (v1, arg2)
        } else {
            (arg2, v1)
        };
        let v13 = 0x2::balance::value<T0>(&v9);
        let v14 = v13 * arg4.fee_percentage / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v9, v14), arg5), arg4.treasury_address);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v9, arg5), v11);
        let v15 = GameJoined{
            game_id                : 0x2::object::uid_to_address(&v8),
            creator                : v1,
            creator_choice_heads   : v7.is_heads,
            joiner                 : arg2,
            joiner_choice_heads    : !v7.is_heads,
            winner                 : v11,
            bet_amount             : v2,
            loser                  : v12,
            total_pot              : v13,
            winner_payout          : v13 - v14,
            fee_collected          : v14,
            coin_flip_result_heads : v10,
            token_type             : v6,
        };
        0x2::event::emit<GameJoined>(v15);
        0x2::object::delete(v8);
    }

    public fun get_fee_percentage(arg0: &GameConfig) : u64 {
        arg0.fee_percentage
    }

    public fun get_game_info<T0>(arg0: &Game<T0>) : (address, u64, bool, u64) {
        (arg0.creator, arg0.bet_amount, arg0.creator_choice.is_heads, arg0.created_at_ms)
    }

    public fun get_max_games_per_transaction(arg0: &GameConfig) : u64 {
        arg0.max_games_per_transaction
    }

    public fun get_token_bet_limits<T0>(arg0: &GameConfig) : (u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, TokenConfig>(&arg0.whitelisted_tokens, v0)) {
            let v3 = 0x2::table::borrow<0x1::type_name::TypeName, TokenConfig>(&arg0.whitelisted_tokens, v0);
            (v3.min_bet_amount, v3.max_bet_amount)
        } else {
            (0, 0)
        }
    }

    public fun get_token_config<T0>(arg0: &GameConfig) : (bool, u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, TokenConfig>(&arg0.whitelisted_tokens, v0)) {
            let v4 = 0x2::table::borrow<0x1::type_name::TypeName, TokenConfig>(&arg0.whitelisted_tokens, v0);
            (v4.enabled, v4.min_bet_amount, v4.max_bet_amount)
        } else {
            (false, 0, 0)
        }
    }

    public fun get_treasury_address(arg0: &GameConfig) : address {
        arg0.treasury_address
    }

    public fun get_whitelisted_tokens(arg0: &GameConfig) : &0x2::table::Table<0x1::type_name::TypeName, TokenConfig> {
        &arg0.whitelisted_tokens
    }

    fun init(arg0: COIN_FLIP, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<COIN_FLIP>(&arg0), 6);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = 0x2::table::new<0x1::type_name::TypeName, TokenConfig>(arg1);
        let v3 = TokenConfig{
            enabled        : true,
            min_bet_amount : 200000000,
            max_bet_amount : 1000000000000,
        };
        0x2::table::add<0x1::type_name::TypeName, TokenConfig>(&mut v2, 0x1::type_name::get<0x2::sui::SUI>(), v3);
        let v4 = GameConfig{
            id                        : 0x2::object::new(arg1),
            admin_cap_id              : 0x2::object::uid_to_address(&v0.id),
            fee_percentage            : 250,
            treasury_address          : v1,
            is_paused                 : false,
            max_games_per_transaction : 100,
            whitelisted_tokens        : v2,
        };
        0x2::transfer::transfer<AdminCap>(v0, v1);
        0x2::transfer::share_object<GameConfig>(v4);
    }

    public fun is_contract_paused(arg0: &GameConfig) : bool {
        arg0.is_paused
    }

    public fun is_token_whitelisted<T0>(arg0: &GameConfig) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::table::contains<0x1::type_name::TypeName, TokenConfig>(&arg0.whitelisted_tokens, v0) && 0x2::table::borrow<0x1::type_name::TypeName, TokenConfig>(&arg0.whitelisted_tokens, v0).enabled
    }

    entry fun join_games<T0>(arg0: vector<Game<T0>>, arg1: 0x2::coin::Coin<T0>, arg2: &GameConfig, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::vector::length<Game<T0>>(&arg0);
        assert!(!arg2.is_paused, 10);
        assert!(v1 > 0, 2);
        assert!(v1 <= arg2.max_games_per_transaction, 11);
        let v2 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, TokenConfig>(&arg2.whitelisted_tokens, v2), 14);
        assert!(0x2::table::borrow<0x1::type_name::TypeName, TokenConfig>(&arg2.whitelisted_tokens, v2).enabled, 14);
        let v3 = 0;
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::borrow<Game<T0>>(&arg0, v4);
            assert!(v0 != v5.creator, 3);
            assert!(v5.token_type == v2, 15);
            v3 = v3 + v5.bet_amount;
            v4 = v4 + 1;
        };
        assert!(0x2::coin::value<T0>(&arg1) >= v3, 4);
        let v6 = 0x2::random::new_generator(arg3, arg4);
        while (!0x1::vector::is_empty<Game<T0>>(&arg0)) {
            let v7 = &mut arg1;
            let v8 = &mut v6;
            execute_secure_game<T0>(0x1::vector::pop_back<Game<T0>>(&mut arg0), v7, v0, v8, arg2, arg4);
        };
        0x1::vector::destroy_empty<Game<T0>>(arg0);
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
    }

    public entry fun remove_whitelisted_token<T0>(arg0: &AdminCap, arg1: &mut GameConfig, arg2: &mut 0x2::tx_context::TxContext) {
        validate_admin_cap(arg0, arg1);
        0x2::table::remove<0x1::type_name::TypeName, TokenConfig>(&mut arg1.whitelisted_tokens, 0x1::type_name::get<T0>());
    }

    public entry fun set_pause_state(arg0: &AdminCap, arg1: &mut GameConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        validate_admin_cap(arg0, arg1);
        arg1.is_paused = arg2;
        let v0 = ConfigUpdated{
            admin                     : 0x2::tx_context::sender(arg3),
            fee_percentage            : arg1.fee_percentage,
            is_paused                 : arg1.is_paused,
            treasury_address          : arg1.treasury_address,
            max_games_per_transaction : arg1.max_games_per_transaction,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public entry fun set_token_enabled<T0>(arg0: &AdminCap, arg1: &mut GameConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        validate_admin_cap(arg0, arg1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, TokenConfig>(&arg1.whitelisted_tokens, v0), 14);
        0x2::table::borrow_mut<0x1::type_name::TypeName, TokenConfig>(&mut arg1.whitelisted_tokens, v0).enabled = arg2;
    }

    public entry fun update_fee_percentage(arg0: &AdminCap, arg1: &mut GameConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        validate_admin_cap(arg0, arg1);
        assert!(arg2 <= 10000, 7);
        arg1.fee_percentage = arg2;
        let v0 = ConfigUpdated{
            admin                     : 0x2::tx_context::sender(arg3),
            fee_percentage            : arg1.fee_percentage,
            is_paused                 : arg1.is_paused,
            treasury_address          : arg1.treasury_address,
            max_games_per_transaction : arg1.max_games_per_transaction,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public entry fun update_max_games_per_transaction(arg0: &AdminCap, arg1: &mut GameConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        validate_admin_cap(arg0, arg1);
        assert!(arg2 > 0, 12);
        assert!(arg2 <= 1000, 12);
        arg1.max_games_per_transaction = arg2;
        let v0 = ConfigUpdated{
            admin                     : 0x2::tx_context::sender(arg3),
            fee_percentage            : arg1.fee_percentage,
            is_paused                 : arg1.is_paused,
            treasury_address          : arg1.treasury_address,
            max_games_per_transaction : arg1.max_games_per_transaction,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public entry fun update_token_limits<T0>(arg0: &AdminCap, arg1: &mut GameConfig, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        validate_admin_cap(arg0, arg1);
        assert!(arg2 > 0, 1);
        assert!(arg2 <= arg3, 1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, TokenConfig>(&arg1.whitelisted_tokens, v0), 14);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, TokenConfig>(&mut arg1.whitelisted_tokens, v0);
        v1.min_bet_amount = arg2;
        v1.max_bet_amount = arg3;
    }

    public entry fun update_treasury_address(arg0: &AdminCap, arg1: &mut GameConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        validate_admin_cap(arg0, arg1);
        assert!(arg2 != @0x0, 13);
        arg1.treasury_address = arg2;
        let v0 = ConfigUpdated{
            admin                     : 0x2::tx_context::sender(arg3),
            fee_percentage            : arg1.fee_percentage,
            is_paused                 : arg1.is_paused,
            treasury_address          : arg1.treasury_address,
            max_games_per_transaction : arg1.max_games_per_transaction,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    fun validate_admin_cap(arg0: &AdminCap, arg1: &GameConfig) {
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.admin_cap_id, 6);
    }

    // decompiled from Move bytecode v6
}

