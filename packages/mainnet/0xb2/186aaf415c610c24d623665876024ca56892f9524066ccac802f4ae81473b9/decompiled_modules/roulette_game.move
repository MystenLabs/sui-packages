module 0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_game {
    struct RouletteGameCreatedEvent has copy, drop {
        game_id: 0x2::object::ID,
        creator: address,
        player_id: 0x2::object::ID,
        creator_bid_amount: u64,
        started_at: u64,
        coin_type: 0x1::type_name::TypeName,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct RouletteGameStartedEvent has copy, drop {
        game_id: 0x2::object::ID,
        player_address: vector<address>,
        player_id: vector<0x2::object::ID>,
        name: vector<0x1::string::String>,
        image_url: vector<0x1::string::String>,
        bid_amount: u64,
        coin_type: 0x1::type_name::TypeName,
        first_turn: address,
    }

    struct PlayerShotEvent has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        chamber_guess: u64,
        result: bool,
    }

    struct RouletteGameEndedEvent has copy, drop {
        game_id: 0x2::object::ID,
        winner: address,
        eliminated_player: address,
        win_amount: u64,
        winner_player_id: 0x2::object::ID,
        playerId: vector<0x2::object::ID>,
        chamber_remaining: vector<u64>,
        name: vector<0x1::string::String>,
        image_url: vector<0x1::string::String>,
        coin_type: 0x1::type_name::TypeName,
        bid_amount: u64,
    }

    struct RouletteGameCloseEvent has copy, drop {
        game_id: 0x2::object::ID,
        player_address: address,
        player_id: 0x2::object::ID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        bid_amount: u64,
    }

    struct RouletteSessionRegistry has store, key {
        id: 0x2::object::UID,
        total_battles: u64,
        fee_collector: address,
        max_bid_amount: u64,
        max_idle_time: u64,
        max_waiting_time: u64,
        win_fee_percentage: u64,
        active_session: 0x2::table::Table<address, 0x2::object::ID>,
        player_joined_session: 0x2::table::Table<address, 0x2::object::ID>,
        active_session_list: vector<0x2::object::ID>,
        paused: bool,
    }

    struct RewardRegistry has store, key {
        id: 0x2::object::UID,
        allowed_coins: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        allowed_bid_ranges: 0x2::table::Table<0x1::type_name::TypeName, BidRange>,
    }

    struct RouletteSession<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: vector<0x1::string::String>,
        image_url: vector<0x1::string::String>,
        max_idle_time: u64,
        bullet_chamber: u64,
        status: u8,
        current_turn: address,
        chambers_remaining: vector<u64>,
        last_action_time: u64,
        winner: 0x1::option::Option<address>,
        player_one_address: address,
        player_two_address: address,
        player_one_bid_amount: 0x2::balance::Balance<T0>,
        player_two_bid_amount: 0x2::balance::Balance<T0>,
        player_one_count: u64,
        player_two_count: u64,
        player_joined_session_list: vector<address>,
        created_at: u64,
        max_waiting_time: u64,
        game_won_status: u8,
        player_one_choosen_chamber: vector<u64>,
        player_two_choosen_chamber: vector<u64>,
        joined_player_id: vector<0x2::object::ID>,
        coin_type: 0x1::type_name::TypeName,
        player_one_resource_amount: u128,
        player_two_resource_amount: u128,
        player_resource_type: 0x1::string::String,
    }

    struct RouletteCap has store, key {
        id: 0x2::object::UID,
    }

    struct BidRange has copy, drop, store {
        min_bid: u64,
        max_bid: u64,
    }

    fun calculate_and_distribute_winnings<T0>(arg0: &mut RouletteSession<T0>, arg1: &RouletteSessionRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.player_one_bid_amount);
        0x2::balance::join<T0>(&mut v0, 0x2::balance::withdraw_all<T0>(&mut arg0.player_two_bid_amount));
        let v1 = 0x2::balance::value<T0>(&v0);
        let (_, v3) = 0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::utils::try_mul_div_down(v1, arg1.win_fee_percentage, 10000);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0, v3), arg3), arg1.fee_collector);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg3), arg2);
        v1
    }

    fun calculate_win_amount(arg0: u64, arg1: u64, arg2: &RouletteSessionRegistry) : u64 {
        let v0 = arg0 + arg1;
        let (_, v2) = 0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::utils::try_mul_div_down(v0, arg2.win_fee_percentage, 10000);
        v0 - v2
    }

    public fun close_game<T0>(arg0: &RouletteCap, arg1: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::VendettaDVD, arg2: 0x2::object::ID, arg3: &mut RouletteSessionRegistry, arg4: RouletteSession<T0>, arg5: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::Version, arg6: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        validate_vendetta_dvd_player(arg1, arg6, arg2);
        close_game_internal<T0>(arg2, arg3, arg4, arg5, arg7);
    }

    public fun close_game_free<T0>(arg0: &RouletteCap, arg1: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_free_dvd::FreeVendettaDVD, arg2: 0x2::object::ID, arg3: &mut RouletteSessionRegistry, arg4: RouletteSession<T0>, arg5: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::Version, arg6: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        validate_free_dvd_player(arg1, arg6, arg2);
        close_game_internal<T0>(arg2, arg3, arg4, arg5, arg7);
    }

    fun close_game_internal<T0>(arg0: 0x2::object::ID, arg1: &mut RouletteSessionRegistry, arg2: RouletteSession<T0>, arg3: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::validate_version(arg3, 1);
        assert!(!arg1.paused, 19);
        assert!(arg2.status == 0, 1);
        assert!(arg2.player_one_address == 0x2::tx_context::sender(arg4), 6);
        assert!(arg2.player_two_address == @0x0, 8);
        0x2::table::remove<address, 0x2::object::ID>(&mut arg1.active_session, arg2.player_one_address);
        remove_from_active_session_list(arg1, 0x2::object::id<RouletteSession<T0>>(&arg2));
        let RouletteSession {
            id                         : v0,
            name                       : v1,
            image_url                  : v2,
            max_idle_time              : _,
            bullet_chamber             : _,
            status                     : _,
            current_turn               : _,
            chambers_remaining         : _,
            last_action_time           : _,
            winner                     : _,
            player_one_address         : v10,
            player_two_address         : _,
            player_one_bid_amount      : v12,
            player_two_bid_amount      : v13,
            player_one_count           : _,
            player_two_count           : _,
            player_joined_session_list : _,
            created_at                 : _,
            max_waiting_time           : _,
            game_won_status            : _,
            player_one_choosen_chamber : _,
            player_two_choosen_chamber : _,
            joined_player_id           : _,
            coin_type                  : _,
            player_one_resource_amount : _,
            player_two_resource_amount : _,
            player_resource_type       : _,
        } = arg2;
        let v27 = v12;
        let v28 = v2;
        let v29 = v1;
        let v30 = v0;
        let v31 = RouletteGameCloseEvent{
            game_id        : 0x2::object::uid_to_inner(&v30),
            player_address : v10,
            player_id      : arg0,
            name           : *0x1::vector::borrow<0x1::string::String>(&v29, 0),
            image_url      : *0x1::vector::borrow<0x1::string::String>(&v28, 0),
            bid_amount     : 0x2::balance::value<T0>(&v27),
        };
        0x2::event::emit<RouletteGameCloseEvent>(v31);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v27, arg4), v10);
        0x2::balance::destroy_zero<T0>(v13);
        0x2::object::delete(v30);
    }

    public fun game_withdraw<T0>(arg0: &RouletteCap, arg1: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::VendettaDVD, arg2: 0x2::object::ID, arg3: &mut RouletteSessionRegistry, arg4: &mut RouletteSession<T0>, arg5: &0x2::clock::Clock, arg6: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::Version, arg7: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        validate_vendetta_dvd_player(arg1, arg7, arg2);
        game_withdraw_internal<T0>(arg2, arg3, arg4, arg5, arg6, arg8);
    }

    public fun game_withdraw_free<T0>(arg0: &RouletteCap, arg1: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_free_dvd::FreeVendettaDVD, arg2: 0x2::object::ID, arg3: &mut RouletteSessionRegistry, arg4: &mut RouletteSession<T0>, arg5: &0x2::clock::Clock, arg6: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::Version, arg7: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        validate_free_dvd_player(arg1, arg7, arg2);
        game_withdraw_internal<T0>(arg2, arg3, arg4, arg5, arg6, arg8);
    }

    fun game_withdraw_internal<T0>(arg0: 0x2::object::ID, arg1: &mut RouletteSessionRegistry, arg2: &mut RouletteSession<T0>, arg3: &0x2::clock::Clock, arg4: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::validate_version(arg4, 1);
        assert!(!arg1.paused, 19);
        assert!(arg2.status == 1, 3);
        assert!(0x2::clock::timestamp_ms(arg3) > arg2.last_action_time + arg2.max_idle_time, 10);
        assert!(arg2.game_won_status == 0 || arg2.game_won_status == 2, 17);
        arg2.game_won_status = 2;
        let v0 = @0x0;
        let v1 = @0x0;
        let v2 = 0x2::object::id_from_address(@0x0);
        let v3 = @0x0;
        let v4 = @0x0;
        if (arg2.current_turn != 0x2::tx_context::sender(arg5) && arg2.player_one_address == 0x2::tx_context::sender(arg5)) {
            v0 = arg2.player_one_address;
            0x2::table::remove<address, 0x2::object::ID>(&mut arg1.active_session, arg2.player_one_address);
            arg2.winner = 0x1::option::some<address>(arg2.player_one_address);
            v1 = arg2.player_one_address;
            v2 = *0x1::vector::borrow<0x2::object::ID>(&arg2.joined_player_id, 0);
            v3 = arg2.player_two_address;
            v4 = arg2.player_one_address;
        } else if (arg2.current_turn != 0x2::tx_context::sender(arg5) && arg2.player_two_address == 0x2::tx_context::sender(arg5)) {
            v0 = arg2.player_two_address;
            0x2::table::remove<address, 0x2::object::ID>(&mut arg1.player_joined_session, arg2.player_two_address);
            arg2.winner = 0x1::option::some<address>(arg2.player_two_address);
            v1 = arg2.player_two_address;
            v2 = *0x1::vector::borrow<0x2::object::ID>(&arg2.joined_player_id, 1);
            v3 = arg2.player_one_address;
            v4 = arg2.player_two_address;
        } else if (arg2.current_turn == 0x2::tx_context::sender(arg5) && arg2.player_one_address == 0x2::tx_context::sender(arg5)) {
            0x2::table::remove<address, 0x2::object::ID>(&mut arg1.active_session, arg2.player_one_address);
            v0 = arg2.player_one_address;
            v3 = arg2.player_one_address;
            v4 = arg2.player_two_address;
            v2 = *0x1::vector::borrow<0x2::object::ID>(&arg2.joined_player_id, 1);
        } else if (arg2.current_turn == 0x2::tx_context::sender(arg5) && arg2.player_two_address == 0x2::tx_context::sender(arg5)) {
            0x2::table::remove<address, 0x2::object::ID>(&mut arg1.player_joined_session, arg2.player_two_address);
            v0 = arg2.player_two_address;
            v3 = arg2.player_two_address;
            v4 = arg2.player_one_address;
            v2 = *0x1::vector::borrow<0x2::object::ID>(&arg2.joined_player_id, 0);
        };
        if (v0 != @0x0) {
            remove_from_player_list<T0>(arg2, v0);
        };
        if (v1 != @0x0) {
            calculate_and_distribute_winnings<T0>(arg2, arg1, v1, arg5);
        };
        if (0x1::vector::is_empty<address>(&arg2.player_joined_session_list)) {
            remove_from_active_session_list(arg1, 0x2::object::id<RouletteSession<T0>>(arg2));
            let v5 = 0x1::vector::empty<0x2::object::ID>();
            let v6 = &mut v5;
            0x1::vector::push_back<0x2::object::ID>(v6, *0x1::vector::borrow<0x2::object::ID>(&arg2.joined_player_id, 0));
            0x1::vector::push_back<0x2::object::ID>(v6, *0x1::vector::borrow<0x2::object::ID>(&arg2.joined_player_id, 1));
            let v7 = 0x1::vector::empty<0x1::string::String>();
            let v8 = &mut v7;
            0x1::vector::push_back<0x1::string::String>(v8, *0x1::vector::borrow<0x1::string::String>(&arg2.name, 0));
            0x1::vector::push_back<0x1::string::String>(v8, *0x1::vector::borrow<0x1::string::String>(&arg2.name, 1));
            let v9 = 0x1::vector::empty<0x1::string::String>();
            let v10 = &mut v9;
            0x1::vector::push_back<0x1::string::String>(v10, *0x1::vector::borrow<0x1::string::String>(&arg2.image_url, 0));
            0x1::vector::push_back<0x1::string::String>(v10, *0x1::vector::borrow<0x1::string::String>(&arg2.image_url, 0));
            let v11 = RouletteGameEndedEvent{
                game_id           : 0x2::object::id<RouletteSession<T0>>(arg2),
                winner            : v4,
                eliminated_player : v3,
                win_amount        : calculate_win_amount(0x2::balance::value<T0>(&arg2.player_one_bid_amount), 0x2::balance::value<T0>(&arg2.player_two_bid_amount), arg1),
                winner_player_id  : v2,
                playerId          : v5,
                chamber_remaining : arg2.chambers_remaining,
                name              : v7,
                image_url         : v9,
                coin_type         : arg2.coin_type,
                bid_amount        : 0x2::balance::value<T0>(&arg2.player_one_bid_amount),
            };
            0x2::event::emit<RouletteGameEndedEvent>(v11);
        };
    }

    public fun get_active_session_list(arg0: &RouletteSessionRegistry) : vector<0x2::object::ID> {
        arg0.active_session_list
    }

    public fun get_bid_range<T0>(arg0: &RewardRegistry) : vector<u64> {
        let v0 = 0x2::table::borrow<0x1::type_name::TypeName, BidRange>(&arg0.allowed_bid_ranges, 0x1::type_name::get<T0>());
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, v0.min_bid);
        0x1::vector::push_back<u64>(v2, v0.max_bid);
        v1
    }

    public fun get_bullet_chamber<T0>(arg0: &RouletteSession<T0>) : u64 {
        arg0.bullet_chamber
    }

    public fun get_current_turn<T0>(arg0: &RouletteSession<T0>) : address {
        arg0.current_turn
    }

    public fun get_fee_collector(arg0: &RouletteSessionRegistry) : address {
        arg0.fee_collector
    }

    public fun get_max_bid_amount(arg0: &RouletteSessionRegistry) : u64 {
        arg0.max_bid_amount
    }

    public fun get_max_idle_time<T0>(arg0: &RouletteSession<T0>) : u64 {
        arg0.max_idle_time
    }

    public fun get_paused_state(arg0: &RouletteSessionRegistry) : bool {
        arg0.paused
    }

    public fun get_player_one_address<T0>(arg0: &RouletteSession<T0>) : address {
        arg0.player_one_address
    }

    public fun get_player_one_bid_amount<T0>(arg0: &RouletteSession<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.player_one_bid_amount)
    }

    public fun get_player_two_address<T0>(arg0: &RouletteSession<T0>) : address {
        arg0.player_two_address
    }

    public fun get_player_two_bid_amount<T0>(arg0: &RouletteSession<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.player_two_bid_amount)
    }

    public fun get_registry_max_idle_time(arg0: &RouletteSessionRegistry) : u64 {
        arg0.max_idle_time
    }

    public fun get_status<T0>(arg0: &RouletteSession<T0>) : u8 {
        arg0.status
    }

    public fun get_total_chambers_remaining<T0>(arg0: &RouletteSession<T0>) : u64 {
        6 - 0x1::vector::length<u64>(&arg0.chambers_remaining)
    }

    public fun get_win_fee_percentage(arg0: &RouletteSessionRegistry) : u64 {
        arg0.win_fee_percentage
    }

    public fun get_winner<T0>(arg0: &RouletteSession<T0>) : address {
        *0x1::option::borrow<address>(&arg0.winner)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RouletteSessionRegistry{
            id                    : 0x2::object::new(arg0),
            total_battles         : 0,
            fee_collector         : @0x0,
            max_bid_amount        : 200000000000,
            max_idle_time         : 120000,
            max_waiting_time      : 600000,
            win_fee_percentage    : 200,
            active_session        : 0x2::table::new<address, 0x2::object::ID>(arg0),
            player_joined_session : 0x2::table::new<address, 0x2::object::ID>(arg0),
            active_session_list   : 0x1::vector::empty<0x2::object::ID>(),
            paused                : true,
        };
        let v1 = RewardRegistry{
            id                 : 0x2::object::new(arg0),
            allowed_coins      : 0x2::table::new<0x1::type_name::TypeName, bool>(arg0),
            allowed_bid_ranges : 0x2::table::new<0x1::type_name::TypeName, BidRange>(arg0),
        };
        0x2::transfer::public_share_object<RouletteSessionRegistry>(v0);
        0x2::transfer::public_share_object<RewardRegistry>(v1);
    }

    public fun is_coin_allowed<T0>(arg0: &RewardRegistry) : bool {
        0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.allowed_coins, 0x1::type_name::get<T0>())
    }

    public fun join_and_start_game<T0>(arg0: &RouletteCap, arg1: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::VendettaDVD, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::object::ID, arg5: &mut RouletteSessionRegistry, arg6: &RewardRegistry, arg7: &mut RouletteSession<T0>, arg8: 0x2::coin::Coin<T0>, arg9: &0x2::random::Random, arg10: &0x2::clock::Clock, arg11: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::Version, arg12: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::Version, arg13: &mut 0x2::tx_context::TxContext) {
        validate_vendetta_dvd_player(arg1, arg12, arg4);
        join_and_start_game_internal<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg13);
    }

    public fun join_and_start_game_free<T0>(arg0: &RouletteCap, arg1: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_free_dvd::FreeVendettaDVD, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::object::ID, arg5: &mut RouletteSessionRegistry, arg6: &RewardRegistry, arg7: &mut RouletteSession<T0>, arg8: 0x2::coin::Coin<T0>, arg9: &0x2::random::Random, arg10: &0x2::clock::Clock, arg11: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::Version, arg12: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::Version, arg13: &mut 0x2::tx_context::TxContext) {
        validate_free_dvd_player(arg1, arg12, arg4);
        join_and_start_game_internal<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg13);
    }

    fun join_and_start_game_internal<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x2::object::ID, arg3: &mut RouletteSessionRegistry, arg4: &RewardRegistry, arg5: &mut RouletteSession<T0>, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::random::Random, arg8: &0x2::clock::Clock, arg9: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::validate_version(arg9, 1);
        assert!(!arg3.paused, 19);
        let v0 = 0x2::coin::value<T0>(&arg6);
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&arg4.allowed_coins, 0x1::type_name::get<T0>()), 11);
        assert!(v0 == 0x2::balance::value<T0>(&arg5.player_one_bid_amount), 0);
        assert!(arg5.status == 0, 7);
        assert!(arg5.player_two_address == @0x0, 8);
        assert!(arg5.player_one_address != 0x2::tx_context::sender(arg10) && !0x2::table::contains<address, 0x2::object::ID>(&arg3.player_joined_session, 0x2::tx_context::sender(arg10)), 2);
        assert!(0x2::clock::timestamp_ms(arg8) <= arg5.created_at + arg5.max_waiting_time, 16);
        let v1 = 0x2::random::new_generator(arg7, arg10);
        0x1::vector::push_back<0x1::string::String>(&mut arg5.name, arg0);
        0x1::vector::push_back<0x1::string::String>(&mut arg5.image_url, arg1);
        arg5.bullet_chamber = 0x2::random::generate_u64_in_range(&mut v1, 1, 6);
        0x1::vector::push_back<0x2::object::ID>(&mut arg5.joined_player_id, arg2);
        arg5.status = 1;
        arg5.last_action_time = 0x2::clock::timestamp_ms(arg8);
        arg5.player_two_address = 0x2::tx_context::sender(arg10);
        let v2 = if (0x2::random::generate_bool(&mut v1)) {
            arg5.player_one_address
        } else {
            arg5.player_two_address
        };
        arg5.current_turn = v2;
        0x2::table::add<address, 0x2::object::ID>(&mut arg3.player_joined_session, arg5.player_two_address, 0x2::object::id<RouletteSession<T0>>(arg5));
        0x1::vector::push_back<address>(&mut arg5.player_joined_session_list, 0x2::tx_context::sender(arg10));
        0x2::balance::join<T0>(&mut arg5.player_two_bid_amount, 0x2::coin::into_balance<T0>(arg6));
        arg3.total_battles = arg3.total_battles + 1;
        let v3 = 0x1::vector::empty<address>();
        let v4 = &mut v3;
        0x1::vector::push_back<address>(v4, arg5.player_one_address);
        0x1::vector::push_back<address>(v4, arg5.player_two_address);
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x2::object::ID>(v6, *0x1::vector::borrow<0x2::object::ID>(&arg5.joined_player_id, 0));
        0x1::vector::push_back<0x2::object::ID>(v6, *0x1::vector::borrow<0x2::object::ID>(&arg5.joined_player_id, 1));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, *0x1::vector::borrow<0x1::string::String>(&arg5.name, 0));
        0x1::vector::push_back<0x1::string::String>(v8, *0x1::vector::borrow<0x1::string::String>(&arg5.name, 1));
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, *0x1::vector::borrow<0x1::string::String>(&arg5.image_url, 0));
        0x1::vector::push_back<0x1::string::String>(v10, *0x1::vector::borrow<0x1::string::String>(&arg5.image_url, 1));
        let v11 = RouletteGameStartedEvent{
            game_id        : 0x2::object::id<RouletteSession<T0>>(arg5),
            player_address : v3,
            player_id      : v5,
            name           : v7,
            image_url      : v9,
            bid_amount     : v0,
            coin_type      : arg5.coin_type,
            first_turn     : arg5.current_turn,
        };
        0x2::event::emit<RouletteGameStartedEvent>(v11);
    }

    public fun leave_game<T0>(arg0: &RouletteCap, arg1: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::VendettaDVD, arg2: 0x2::object::ID, arg3: &mut RouletteSessionRegistry, arg4: &mut RouletteSession<T0>, arg5: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::Version, arg6: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        validate_vendetta_dvd_player(arg1, arg6, arg2);
        leave_game_internal<T0>(arg2, arg3, arg4, arg5, arg7);
    }

    public fun leave_game_free<T0>(arg0: &RouletteCap, arg1: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_free_dvd::FreeVendettaDVD, arg2: 0x2::object::ID, arg3: &mut RouletteSessionRegistry, arg4: &mut RouletteSession<T0>, arg5: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::Version, arg6: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        validate_free_dvd_player(arg1, arg6, arg2);
        leave_game_internal<T0>(arg2, arg3, arg4, arg5, arg7);
    }

    fun leave_game_internal<T0>(arg0: 0x2::object::ID, arg1: &mut RouletteSessionRegistry, arg2: &mut RouletteSession<T0>, arg3: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::validate_version(arg3, 1);
        assert!(!arg1.paused, 19);
        assert!(arg2.status == 1, 3);
        arg2.game_won_status = 1;
        let v0 = @0x0;
        let v1 = false;
        let v2 = 0x2::object::id_from_address(@0x0);
        let v3 = @0x0;
        if (arg2.player_one_address == 0x2::tx_context::sender(arg4) && 0x1::option::is_none<address>(&arg2.winner)) {
            0x2::table::remove<address, 0x2::object::ID>(&mut arg1.active_session, arg2.player_one_address);
            v0 = arg2.player_one_address;
            arg2.winner = 0x1::option::some<address>(arg2.player_two_address);
            v3 = arg2.player_two_address;
            v2 = *0x1::vector::borrow<0x2::object::ID>(&arg2.joined_player_id, 1);
        } else if (arg2.player_two_address == 0x2::tx_context::sender(arg4) && 0x1::option::is_none<address>(&arg2.winner)) {
            0x2::table::remove<address, 0x2::object::ID>(&mut arg1.player_joined_session, arg2.player_two_address);
            v0 = arg2.player_two_address;
            arg2.winner = 0x1::option::some<address>(arg2.player_one_address);
            v3 = arg2.player_one_address;
            v2 = *0x1::vector::borrow<0x2::object::ID>(&arg2.joined_player_id, 0);
        } else if (arg2.player_one_address == 0x2::tx_context::sender(arg4) && 0x1::option::is_some<address>(&arg2.winner)) {
            0x2::table::remove<address, 0x2::object::ID>(&mut arg1.active_session, arg2.player_one_address);
            v0 = arg2.player_one_address;
            v1 = true;
            let v4 = *0x1::option::borrow<address>(&arg2.winner);
            v3 = v4;
            let v5 = if (v4 == arg2.player_one_address) {
                *0x1::vector::borrow<0x2::object::ID>(&arg2.joined_player_id, 0)
            } else {
                *0x1::vector::borrow<0x2::object::ID>(&arg2.joined_player_id, 1)
            };
            v2 = v5;
        } else if (arg2.player_two_address == 0x2::tx_context::sender(arg4) && 0x1::option::is_some<address>(&arg2.winner)) {
            0x2::table::remove<address, 0x2::object::ID>(&mut arg1.player_joined_session, arg2.player_two_address);
            v0 = arg2.player_two_address;
            v1 = true;
            let v6 = *0x1::option::borrow<address>(&arg2.winner);
            v3 = v6;
            let v7 = if (v6 == arg2.player_one_address) {
                *0x1::vector::borrow<0x2::object::ID>(&arg2.joined_player_id, 0)
            } else {
                *0x1::vector::borrow<0x2::object::ID>(&arg2.joined_player_id, 1)
            };
            v2 = v7;
        };
        if (v0 != @0x0) {
            remove_from_player_list<T0>(arg2, v0);
        };
        if (v1 && 0x1::option::is_some<address>(&arg2.winner)) {
            remove_from_active_session_list(arg1, 0x2::object::id<RouletteSession<T0>>(arg2));
            let v8 = *0x1::option::borrow<address>(&arg2.winner);
            calculate_and_distribute_winnings<T0>(arg2, arg1, v8, arg4);
        };
        if (!v1) {
            let v9 = 0x1::vector::empty<0x2::object::ID>();
            let v10 = &mut v9;
            0x1::vector::push_back<0x2::object::ID>(v10, *0x1::vector::borrow<0x2::object::ID>(&arg2.joined_player_id, 0));
            0x1::vector::push_back<0x2::object::ID>(v10, *0x1::vector::borrow<0x2::object::ID>(&arg2.joined_player_id, 1));
            let v11 = 0x1::vector::empty<0x1::string::String>();
            let v12 = &mut v11;
            0x1::vector::push_back<0x1::string::String>(v12, *0x1::vector::borrow<0x1::string::String>(&arg2.name, 0));
            0x1::vector::push_back<0x1::string::String>(v12, *0x1::vector::borrow<0x1::string::String>(&arg2.name, 1));
            let v13 = 0x1::vector::empty<0x1::string::String>();
            let v14 = &mut v13;
            0x1::vector::push_back<0x1::string::String>(v14, *0x1::vector::borrow<0x1::string::String>(&arg2.image_url, 0));
            0x1::vector::push_back<0x1::string::String>(v14, *0x1::vector::borrow<0x1::string::String>(&arg2.image_url, 0));
            let v15 = RouletteGameEndedEvent{
                game_id           : 0x2::object::id<RouletteSession<T0>>(arg2),
                winner            : v3,
                eliminated_player : v0,
                win_amount        : calculate_win_amount(0x2::balance::value<T0>(&arg2.player_one_bid_amount), 0x2::balance::value<T0>(&arg2.player_two_bid_amount), arg1),
                winner_player_id  : v2,
                playerId          : v9,
                chamber_remaining : arg2.chambers_remaining,
                name              : v11,
                image_url         : v13,
                coin_type         : arg2.coin_type,
                bid_amount        : 0x2::balance::value<T0>(&arg2.player_one_bid_amount),
            };
            0x2::event::emit<RouletteGameEndedEvent>(v15);
        };
    }

    public fun mint_roulette_cap(arg0: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::OperatorCap, arg1: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::OperatorCapsBag, arg2: &mut 0x2::tx_context::TxContext) {
        0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::is_operator(arg0, arg1);
        let v0 = RouletteCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<RouletteCap>(v0, 0x2::tx_context::sender(arg2));
    }

    fun remove_from_active_session_list(arg0: &mut RouletteSessionRegistry, arg1: 0x2::object::ID) {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.active_session_list, &arg1);
        if (v0) {
            0x1::vector::remove<0x2::object::ID>(&mut arg0.active_session_list, v1);
        };
    }

    fun remove_from_player_list<T0>(arg0: &mut RouletteSession<T0>, arg1: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.player_joined_session_list, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.player_joined_session_list, v1);
        };
    }

    entry fun set_allowed_coins<T0>(arg0: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::OperatorCap, arg1: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::OperatorCapsBag, arg2: &mut RewardRegistry) {
        0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::is_operator(arg0, arg1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, bool>(&arg2.allowed_coins, v0) && !0x2::table::contains<0x1::type_name::TypeName, BidRange>(&arg2.allowed_bid_ranges, v0), 12);
        0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg2.allowed_coins, v0, true);
        let v1 = BidRange{
            min_bid : 100000000,
            max_bid : 200000000000,
        };
        0x2::table::add<0x1::type_name::TypeName, BidRange>(&mut arg2.allowed_bid_ranges, v0, v1);
    }

    entry fun set_fee_collector(arg0: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::OperatorCap, arg1: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::OperatorCapsBag, arg2: &mut RouletteSessionRegistry, arg3: address) {
        0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::is_operator(arg0, arg1);
        arg2.fee_collector = arg3;
    }

    entry fun set_max_bid_amount(arg0: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::OperatorCap, arg1: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::OperatorCapsBag, arg2: &mut RouletteSessionRegistry, arg3: u64) {
        0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::is_operator(arg0, arg1);
        arg2.max_bid_amount = arg3;
    }

    entry fun set_max_idle_time(arg0: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::OperatorCap, arg1: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::OperatorCapsBag, arg2: &mut RouletteSessionRegistry, arg3: u64) {
        0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::is_operator(arg0, arg1);
        arg2.max_idle_time = arg3;
    }

    entry fun set_win_fee_percentage(arg0: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::OperatorCap, arg1: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::OperatorCapsBag, arg2: &mut RouletteSessionRegistry, arg3: u64) {
        0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::is_operator(arg0, arg1);
        arg2.win_fee_percentage = arg3;
    }

    public fun shoot<T0>(arg0: &RouletteCap, arg1: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::VendettaDVD, arg2: 0x2::object::ID, arg3: &mut RouletteSessionRegistry, arg4: &mut RouletteSession<T0>, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::Version, arg8: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        validate_vendetta_dvd_player(arg1, arg8, arg2);
        shoot_internal<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg9);
    }

    public fun shoot_free<T0>(arg0: &RouletteCap, arg1: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_free_dvd::FreeVendettaDVD, arg2: 0x2::object::ID, arg3: &mut RouletteSessionRegistry, arg4: &mut RouletteSession<T0>, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::Version, arg8: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        validate_free_dvd_player(arg1, arg8, arg2);
        shoot_internal<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg9);
    }

    fun shoot_internal<T0>(arg0: 0x2::object::ID, arg1: &mut RouletteSessionRegistry, arg2: &mut RouletteSession<T0>, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::validate_version(arg5, 1);
        assert!(!arg1.paused, 19);
        assert!(arg2.status == 1, 3);
        assert!(arg2.current_turn == 0x2::tx_context::sender(arg6), 9);
        assert!(0x1::option::is_none<address>(&arg2.winner), 4);
        assert!(0x1::vector::length<u64>(&arg2.chambers_remaining) > 0, 5);
        assert!(0x2::clock::timestamp_ms(arg4) <= arg2.last_action_time + arg2.max_idle_time, 10);
        let v0 = 0x2::random::new_generator(arg3, arg6);
        let v1 = 0x1::vector::remove<u64>(&mut arg2.chambers_remaining, 0x2::random::generate_u64_in_range(&mut v0, 0, 0x1::vector::length<u64>(&arg2.chambers_remaining) - 1));
        arg2.last_action_time = 0x2::clock::timestamp_ms(arg4);
        if (v1 == arg2.bullet_chamber) {
            arg2.status = 2;
            arg2.game_won_status = 3;
            let v2 = if (arg2.current_turn == arg2.player_one_address) {
                0x1::vector::push_back<u64>(&mut arg2.player_one_choosen_chamber, v1);
                arg2.winner = 0x1::option::some<address>(arg2.player_two_address);
                arg2.player_two_address
            } else {
                0x1::vector::push_back<u64>(&mut arg2.player_two_choosen_chamber, v1);
                arg2.winner = 0x1::option::some<address>(arg2.player_one_address);
                arg2.player_one_address
            };
            let v3 = calculate_and_distribute_winnings<T0>(arg2, arg1, v2, arg6);
            0x2::table::remove<address, 0x2::object::ID>(&mut arg1.active_session, arg2.player_one_address);
            0x2::table::remove<address, 0x2::object::ID>(&mut arg1.player_joined_session, arg2.player_two_address);
            remove_from_active_session_list(arg1, 0x2::object::id<RouletteSession<T0>>(arg2));
            while (0x1::vector::length<address>(&arg2.player_joined_session_list) > 0) {
                0x1::vector::pop_back<address>(&mut arg2.player_joined_session_list);
            };
            let v4 = if (arg2.current_turn == arg2.player_one_address) {
                *0x1::vector::borrow<0x2::object::ID>(&arg2.joined_player_id, 1)
            } else {
                *0x1::vector::borrow<0x2::object::ID>(&arg2.joined_player_id, 0)
            };
            let v5 = 0x1::vector::empty<0x2::object::ID>();
            let v6 = &mut v5;
            0x1::vector::push_back<0x2::object::ID>(v6, *0x1::vector::borrow<0x2::object::ID>(&arg2.joined_player_id, 0));
            0x1::vector::push_back<0x2::object::ID>(v6, *0x1::vector::borrow<0x2::object::ID>(&arg2.joined_player_id, 1));
            let v7 = 0x1::vector::empty<0x1::string::String>();
            let v8 = &mut v7;
            0x1::vector::push_back<0x1::string::String>(v8, *0x1::vector::borrow<0x1::string::String>(&arg2.name, 0));
            0x1::vector::push_back<0x1::string::String>(v8, *0x1::vector::borrow<0x1::string::String>(&arg2.name, 1));
            let v9 = 0x1::vector::empty<0x1::string::String>();
            let v10 = &mut v9;
            0x1::vector::push_back<0x1::string::String>(v10, *0x1::vector::borrow<0x1::string::String>(&arg2.image_url, 0));
            0x1::vector::push_back<0x1::string::String>(v10, *0x1::vector::borrow<0x1::string::String>(&arg2.image_url, 1));
            let v11 = RouletteGameEndedEvent{
                game_id           : 0x2::object::id<RouletteSession<T0>>(arg2),
                winner            : v2,
                eliminated_player : 0x2::tx_context::sender(arg6),
                win_amount        : v3,
                winner_player_id  : v4,
                playerId          : v5,
                chamber_remaining : arg2.chambers_remaining,
                name              : v7,
                image_url         : v9,
                coin_type         : arg2.coin_type,
                bid_amount        : 0x2::balance::value<T0>(&arg2.player_one_bid_amount),
            };
            0x2::event::emit<RouletteGameEndedEvent>(v11);
            let v12 = PlayerShotEvent{
                game_id       : 0x2::object::id<RouletteSession<T0>>(arg2),
                player        : 0x2::tx_context::sender(arg6),
                chamber_guess : v1,
                result        : true,
            };
            0x2::event::emit<PlayerShotEvent>(v12);
        } else {
            if (arg2.current_turn == arg2.player_one_address) {
                arg2.current_turn = arg2.player_two_address;
                arg2.player_one_count = arg2.player_one_count + 1;
                0x1::vector::push_back<u64>(&mut arg2.player_one_choosen_chamber, v1);
            } else {
                arg2.current_turn = arg2.player_one_address;
                arg2.player_two_count = arg2.player_two_count + 1;
                0x1::vector::push_back<u64>(&mut arg2.player_two_choosen_chamber, v1);
            };
            let v13 = PlayerShotEvent{
                game_id       : 0x2::object::id<RouletteSession<T0>>(arg2),
                player        : 0x2::tx_context::sender(arg6),
                chamber_guess : v1,
                result        : false,
            };
            0x2::event::emit<PlayerShotEvent>(v13);
        };
    }

    public fun start_session<T0>(arg0: &RouletteCap, arg1: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::VendettaDVD, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::object::ID, arg5: &mut RouletteSessionRegistry, arg6: &RewardRegistry, arg7: &0x2::clock::Clock, arg8: 0x2::coin::Coin<T0>, arg9: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::Version, arg10: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::Version, arg11: &mut 0x2::tx_context::TxContext) {
        validate_vendetta_dvd_player(arg1, arg10, arg4);
        start_session_internal<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11);
    }

    public fun start_session_free<T0>(arg0: &RouletteCap, arg1: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_free_dvd::FreeVendettaDVD, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::object::ID, arg5: &mut RouletteSessionRegistry, arg6: &RewardRegistry, arg7: &0x2::clock::Clock, arg8: 0x2::coin::Coin<T0>, arg9: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::Version, arg10: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::Version, arg11: &mut 0x2::tx_context::TxContext) {
        validate_free_dvd_player(arg1, arg10, arg4);
        start_session_internal<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11);
    }

    fun start_session_internal<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x2::object::ID, arg3: &mut RouletteSessionRegistry, arg4: &RewardRegistry, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<T0>, arg7: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::roulette_version::validate_version(arg7, 1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!arg3.paused, 19);
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&arg4.allowed_coins, v0), 11);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg3.active_session, 0x2::tx_context::sender(arg8)) && !0x2::table::contains<address, 0x2::object::ID>(&arg3.player_joined_session, 0x2::tx_context::sender(arg8)), 15);
        let v1 = 0x2::coin::value<T0>(&arg6);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, BidRange>(&arg4.allowed_bid_ranges, v0);
        assert!(v1 >= v2.min_bid && v1 <= v2.max_bid, 0);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v3, arg0);
        let v4 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v4, arg1);
        let v5 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v5, 0x2::tx_context::sender(arg8));
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v6, arg2);
        let v7 = RouletteSession<T0>{
            id                         : 0x2::object::new(arg8),
            name                       : v3,
            image_url                  : v4,
            max_idle_time              : arg3.max_idle_time,
            bullet_chamber             : 0,
            status                     : 0,
            current_turn               : @0x0,
            chambers_remaining         : vector[1, 2, 3, 4, 5, 6],
            last_action_time           : 0,
            winner                     : 0x1::option::none<address>(),
            player_one_address         : 0x2::tx_context::sender(arg8),
            player_two_address         : @0x0,
            player_one_bid_amount      : 0x2::coin::into_balance<T0>(arg6),
            player_two_bid_amount      : 0x2::balance::zero<T0>(),
            player_one_count           : 0,
            player_two_count           : 0,
            player_joined_session_list : v5,
            created_at                 : 0x2::clock::timestamp_ms(arg5),
            max_waiting_time           : arg3.max_waiting_time,
            game_won_status            : 0,
            player_one_choosen_chamber : 0x1::vector::empty<u64>(),
            player_two_choosen_chamber : 0x1::vector::empty<u64>(),
            joined_player_id           : v6,
            coin_type                  : v0,
            player_one_resource_amount : 0,
            player_two_resource_amount : 0,
            player_resource_type       : 0x1::string::utf8(b""),
        };
        0x2::table::add<address, 0x2::object::ID>(&mut arg3.active_session, 0x2::tx_context::sender(arg8), 0x2::object::id<RouletteSession<T0>>(&v7));
        0x1::vector::push_back<0x2::object::ID>(&mut arg3.active_session_list, 0x2::object::id<RouletteSession<T0>>(&v7));
        let v8 = RouletteGameCreatedEvent{
            game_id            : 0x2::object::id<RouletteSession<T0>>(&v7),
            creator            : 0x2::tx_context::sender(arg8),
            player_id          : arg2,
            creator_bid_amount : v1,
            started_at         : 0x2::clock::timestamp_ms(arg5),
            coin_type          : v0,
            name               : arg0,
            image_url          : arg1,
        };
        0x2::event::emit<RouletteGameCreatedEvent>(v8);
        0x2::transfer::share_object<RouletteSession<T0>>(v7);
    }

    public fun status<T0>(arg0: &RouletteSession<T0>) : u8 {
        arg0.status
    }

    entry fun toggle_pause(arg0: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::OperatorCap, arg1: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::OperatorCapsBag, arg2: &mut RouletteSessionRegistry) {
        0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::is_operator(arg0, arg1);
        arg2.paused = !arg2.paused;
    }

    entry fun unset_allowed_coins<T0>(arg0: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::OperatorCap, arg1: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::OperatorCapsBag, arg2: &mut RewardRegistry) {
        0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::is_operator(arg0, arg1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&arg2.allowed_coins, v0) && 0x2::table::contains<0x1::type_name::TypeName, BidRange>(&arg2.allowed_bid_ranges, v0), 13);
        0x2::table::remove<0x1::type_name::TypeName, bool>(&mut arg2.allowed_coins, v0);
        0x2::table::remove<0x1::type_name::TypeName, BidRange>(&mut arg2.allowed_bid_ranges, v0);
    }

    entry fun update_allowed_max_range<T0>(arg0: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::OperatorCap, arg1: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::OperatorCapsBag, arg2: u64, arg3: &mut RewardRegistry) {
        0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::is_operator(arg0, arg1);
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, BidRange>(&mut arg3.allowed_bid_ranges, 0x1::type_name::get<T0>());
        assert!(arg2 > v0.min_bid, 18);
        v0.max_bid = arg2;
    }

    entry fun update_allowed_min_range<T0>(arg0: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::OperatorCap, arg1: &0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::OperatorCapsBag, arg2: u64, arg3: &mut RewardRegistry) {
        0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::role::is_operator(arg0, arg1);
        assert!(arg2 >= 0, 18);
        0x2::table::borrow_mut<0x1::type_name::TypeName, BidRange>(&mut arg3.allowed_bid_ranges, 0x1::type_name::get<T0>()).min_bid = arg2;
    }

    fun validate_free_dvd_player(arg0: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_free_dvd::FreeVendettaDVD, arg1: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::Version, arg2: 0x2::object::ID) {
        0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_free_dvd::is_valid_player(arg0, arg1, arg2);
    }

    fun validate_vendetta_dvd_player(arg0: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::VendettaDVD, arg1: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::Version, arg2: 0x2::object::ID) {
        0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::is_valid_players(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

