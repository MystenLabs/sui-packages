module 0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs {
    struct MOGUL_DFS has drop {
        dummy_field: bool,
    }

    struct MogulSeason has store, key {
        id: 0x2::object::UID,
        season: 0x2::table::Table<u64, 0x2::object::ID>,
    }

    struct TicketData has copy, drop, store {
        receiver: address,
        budget: u64,
        owned_entities: vector<0x1::string::String>,
    }

    struct Season has store, key {
        id: 0x2::object::UID,
        pre_season_date: u64,
        start_date: u64,
        end_date: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        player_joined: 0x2::table::Table<address, PlayerInfo>,
        player_budget_cap: u64,
        total_budget_distributed: u64,
        entities: 0x2::table::Table<0x1::string::String, MogulEntity>,
        season_treasury: 0x2::balance::Balance<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>,
        is_paused: bool,
    }

    struct PlayerInfo has store {
        player_address: address,
        budget: 0x2::balance::Balance<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>,
        owned_entities: vector<0x1::string::String>,
        last_tx_ts: u64,
    }

    struct MogulEntity has drop, store {
        imdb_id: 0x1::string::String,
        movie_name: 0x1::string::String,
        name: 0x1::string::String,
        entity_type: 0x1::string::String,
        entity_cost: u64,
        release_date_in_ms: u64,
        is_enabled: bool,
    }

    struct EntitySoldEvent has copy, drop {
        player_address: address,
        season_id: 0x2::object::ID,
        unique_id: 0x1::string::String,
        entity_cost: u64,
    }

    struct EntityStatusChangedEvent has copy, drop {
        unique_id: 0x1::string::String,
        is_enabled: bool,
    }

    struct EntityCostUpdatedEvent has copy, drop {
        unique_id: 0x1::string::String,
        imdb_id: 0x1::string::String,
        movie_name: 0x1::string::String,
        name: 0x1::string::String,
        entity_type: 0x1::string::String,
        entity_cost: u64,
    }

    struct PlayerJoinedEvent has copy, drop {
        player_address: address,
        season_id: 0x2::object::ID,
    }

    struct CoinMintedEvent has copy, drop {
        amount: u64,
    }

    struct CoinBurnedEvent has copy, drop {
        amount: u64,
    }

    struct SeasonStartDateUpdatedEvent has copy, drop {
        season_pre_season_date: u64,
        season_start_date: u64,
    }

    struct SeasonEndDateUpdatedEvent has copy, drop {
        season_end_date: u64,
    }

    struct SeasonTreasuryUpdatedEvent has copy, drop {
        season_treasury: u64,
    }

    struct SeasonPlayerBudgetCapUpdatedEvent has copy, drop {
        player_budget_cap: u64,
    }

    struct EntityUpdatedEvent has copy, drop {
        unique_id: 0x1::string::String,
        imdb_id: 0x1::string::String,
        movie_name: 0x1::string::String,
        name: 0x1::string::String,
        entity_type: 0x1::string::String,
        release_date_in_ms: u64,
    }

    struct EntityRemovedEvent has copy, drop {
        unique_id: 0x1::string::String,
    }

    struct EntityBoughtEvent has copy, drop {
        player_address: address,
        season_id: 0x2::object::ID,
        unique_id: 0x1::string::String,
        entity_cost: u64,
    }

    struct SeasonAddedEvent has copy, drop {
        season_number: u64,
        season_name: 0x1::string::String,
        season_description: 0x1::string::String,
        season_pre_season_date: u64,
        season_start_date: u64,
        season_end_date: u64,
        is_paused: bool,
    }

    struct StudioBudgetAddedEvent has copy, drop {
        player_address: address,
        budget_added: u64,
    }

    struct EntityAddedEvent has copy, drop {
        unique_id: 0x1::string::String,
        imdb_id: 0x1::string::String,
        movie_name: 0x1::string::String,
        name: 0x1::string::String,
        entity_type: 0x1::string::String,
        entity_cost: u64,
    }

    struct SeasonTreasuryWithdrawnEvent has copy, drop {
        withdrawn_amount: u64,
    }

    struct PlayerBudgetWithdrawnEvent has copy, drop {
        player_address: address,
        budget: u64,
    }

    struct SeasonStatusToggledEvent has copy, drop {
        is_paused: bool,
    }

    struct UserBalanceUpdatedEvent has copy, drop {
        player_address: address,
        balance: u128,
    }

    struct TotalBudgetDistributedUpdatedEvent has copy, drop {
        total_budget_distributed: u128,
    }

    public fun add_entity(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::OperatorCap, arg1: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::OperatorCapsBag, arg2: &mut Season, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: 0x1::string::String, arg9: u64, arg10: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version) {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg10);
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::is_operator(arg0, arg1);
        assert!(!0x2::table::contains<0x1::string::String, MogulEntity>(&arg2.entities, arg8), 11);
        let v0 = MogulEntity{
            imdb_id            : arg3,
            movie_name         : arg4,
            name               : arg5,
            entity_type        : arg6,
            entity_cost        : arg7,
            release_date_in_ms : arg9,
            is_enabled         : true,
        };
        0x2::table::add<0x1::string::String, MogulEntity>(&mut arg2.entities, arg8, v0);
        let v1 = EntityAddedEvent{
            unique_id   : arg8,
            imdb_id     : arg3,
            movie_name  : arg4,
            name        : arg5,
            entity_type : arg6,
            entity_cost : arg7,
        };
        0x2::event::emit<EntityAddedEvent>(v1);
    }

    fun add_points_in_total_budget_distributed(arg0: &mut Season, arg1: u128) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, u128>(&mut arg0.id, b"total_budget_distributed");
        *v0 = *v0 + arg1;
    }

    fun add_points_in_user_balance(arg0: &mut Season, arg1: address, arg2: u128) {
        let v0 = 0x2::dynamic_field::borrow_mut<address, u128>(&mut arg0.id, arg1);
        *v0 = *v0 + arg2;
    }

    public fun add_season(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::AdminCap, arg1: &mut MogulSeason, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg10);
        assert!(!0x2::table::contains<u64, 0x2::object::ID>(&arg1.season, arg2), 1);
        assert!(arg5 <= arg6, 2);
        assert!(arg6 < arg7, 23);
        assert!(arg6 > 0x2::clock::timestamp_ms(arg9), 3);
        let v0 = Season{
            id                       : 0x2::object::new(arg12),
            pre_season_date          : arg5,
            start_date               : arg6,
            end_date                 : arg7,
            name                     : arg3,
            description              : arg4,
            player_joined            : 0x2::table::new<address, PlayerInfo>(arg12),
            player_budget_cap        : arg8,
            total_budget_distributed : 0,
            entities                 : 0x2::table::new<0x1::string::String, MogulEntity>(arg12),
            season_treasury          : 0x2::balance::zero<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(),
            is_paused                : arg11,
        };
        0x2::table::add<u64, 0x2::object::ID>(&mut arg1.season, arg2, 0x2::object::id<Season>(&v0));
        0x2::dynamic_field::add<vector<u8>, u128>(&mut v0.id, b"total_budget_distributed", 0);
        0x2::dynamic_field::add<vector<u8>, u128>(&mut v0.id, b"season_treasury", 0);
        0x2::transfer::public_share_object<Season>(v0);
        let v1 = SeasonAddedEvent{
            season_number          : arg2,
            season_name            : arg3,
            season_description     : arg4,
            season_pre_season_date : arg5,
            season_start_date      : arg6,
            season_end_date        : arg7,
            is_paused              : arg11,
        };
        0x2::event::emit<SeasonAddedEvent>(v1);
    }

    public fun add_tickets(arg0: &mut 0x829da0ffcd021c5df97c06cd5b10de273eb51ade2a4518558da6b164b84fcfd4::mogul::MogulCentral, arg1: &mut 0x829da0ffcd021c5df97c06cd5b10de273eb51ade2a4518558da6b164b84fcfd4::ticket::TicketRegistry, arg2: u64, arg3: u64, arg4: &mut Season, arg5: address, arg6: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg6);
        let v0 = 0x2::table::borrow<address, PlayerInfo>(&arg4.player_joined, arg5);
        let v1 = TicketData{
            receiver       : arg5,
            budget         : 0x2::balance::value<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(&v0.budget),
            owned_entities : v0.owned_entities,
        };
        0x829da0ffcd021c5df97c06cd5b10de273eb51ade2a4518558da6b164b84fcfd4::ticket::give_ticket<TicketData>(arg1, arg0, arg2, 0x1::string::utf8(b"MOGUL_DFS"), v1, arg3, arg5, arg7);
    }

    public fun admin_burn(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::AdminCap, arg1: &mut 0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::CoinRegistry, arg2: 0x2::coin::Coin<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>, arg3: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version) {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg3);
        let v0 = CoinBurnedEvent{amount: 0x2::coin::value<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(&arg2)};
        0x2::event::emit<CoinBurnedEvent>(v0);
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::burn_token(arg1, arg2);
    }

    public fun admin_mint(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::AdminCap, arg1: &mut 0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::CoinRegistry, arg2: u64, arg3: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN> {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg3);
        let v0 = CoinMintedEvent{amount: arg2};
        0x2::event::emit<CoinMintedEvent>(v0);
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::mint_token(arg1, arg2, arg4)
    }

    public fun buy_entity(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::OperatorCap, arg1: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::OperatorCapsBag, arg2: &0x829da0ffcd021c5df97c06cd5b10de273eb51ade2a4518558da6b164b84fcfd4::mogul::MogulCentral, arg3: &mut Season, arg4: address, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version) {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg7);
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::is_operator(arg0, arg1);
        assert!(!arg3.is_paused, 21);
        assert!(0x829da0ffcd021c5df97c06cd5b10de273eb51ade2a4518558da6b164b84fcfd4::mogul::studio_exists(arg2, arg4), 4);
        assert!(0x2::table::contains<0x1::string::String, MogulEntity>(&arg3.entities, arg5), 12);
        assert!(0x2::table::borrow<0x1::string::String, MogulEntity>(&arg3.entities, arg5).is_enabled, 22);
        validate_season_timelines(arg3, arg6);
        migrate_player_data(arg3, arg4);
        let v0 = 0x2::table::borrow_mut<address, PlayerInfo>(&mut arg3.player_joined, arg4);
        let v1 = 0x2::table::borrow<0x1::string::String, MogulEntity>(&arg3.entities, arg5).entity_cost;
        assert!(!0x1::vector::contains<0x1::string::String>(&v0.owned_entities, &arg5), 15);
        assert!(*0x2::dynamic_field::borrow<address, u128>(&arg3.id, arg4) >= (v1 as u128), 13);
        0x1::vector::push_back<0x1::string::String>(&mut v0.owned_entities, arg5);
        let v2 = 0x2::dynamic_field::borrow_mut<vector<u8>, u128>(&mut arg3.id, b"season_treasury");
        *v2 = *v2 + (v1 as u128);
        v0.last_tx_ts = 0x2::clock::timestamp_ms(arg6);
        remove_points_from_user_balance(arg3, arg4, (v1 as u128));
        let v3 = EntityBoughtEvent{
            player_address : arg4,
            season_id      : 0x2::object::id<Season>(arg3),
            unique_id      : arg5,
            entity_cost    : v1,
        };
        0x2::event::emit<EntityBoughtEvent>(v3);
    }

    public fun change_entity_status(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::OperatorCap, arg1: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::OperatorCapsBag, arg2: &mut Season, arg3: 0x1::string::String, arg4: bool, arg5: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version) {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg5);
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::is_operator(arg0, arg1);
        assert!(0x2::table::contains<0x1::string::String, MogulEntity>(&arg2.entities, arg3), 12);
        0x2::table::borrow_mut<0x1::string::String, MogulEntity>(&mut arg2.entities, arg3).is_enabled = arg4;
        let v0 = EntityStatusChangedEvent{
            unique_id  : arg3,
            is_enabled : arg4,
        };
        0x2::event::emit<EntityStatusChangedEvent>(v0);
    }

    public fun change_season_status(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::AdminCap, arg1: &mut Season, arg2: bool, arg3: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version) {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg3);
        arg1.is_paused = arg2;
        let v0 = SeasonStatusToggledEvent{is_paused: arg2};
        0x2::event::emit<SeasonStatusToggledEvent>(v0);
    }

    public fun get_current_season_number(arg0: &MogulSeason) : u64 {
        0x2::table::length<u64, 0x2::object::ID>(&arg0.season)
    }

    public fun get_entity_cost(arg0: &Season, arg1: 0x1::string::String) : u64 {
        0x2::table::borrow<0x1::string::String, MogulEntity>(&arg0.entities, arg1).entity_cost
    }

    public fun get_entity_details(arg0: &Season, arg1: 0x1::string::String) : (0x1::string::String, 0x1::string::String, u64, u64, bool) {
        let v0 = 0x2::table::borrow<0x1::string::String, MogulEntity>(&arg0.entities, arg1);
        (v0.name, v0.entity_type, v0.entity_cost, v0.release_date_in_ms, v0.is_enabled)
    }

    public fun get_number_of_players_joined(arg0: &Season) : u64 {
        0x2::table::length<address, PlayerInfo>(&arg0.player_joined)
    }

    public fun get_number_of_seasons_created(arg0: &MogulSeason) : u64 {
        0x2::table::length<u64, 0x2::object::ID>(&arg0.season)
    }

    public fun get_player_budget_cap(arg0: &Season) : u64 {
        arg0.player_budget_cap
    }

    public fun get_player_remaining_budget(arg0: &Season, arg1: address) : u64 {
        0x2::balance::value<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(&0x2::table::borrow<address, PlayerInfo>(&arg0.player_joined, arg1).budget)
    }

    public fun get_player_remaining_budget_df(arg0: &Season, arg1: address) : u128 {
        *0x2::dynamic_field::borrow<address, u128>(&arg0.id, arg1)
    }

    public fun get_season_metadata(arg0: &Season) : (u64, u64, 0x1::string::String, 0x1::string::String, u64) {
        (arg0.start_date, arg0.end_date, arg0.name, arg0.description, arg0.pre_season_date)
    }

    public fun get_season_treasury_amount(arg0: &Season) : u64 {
        0x2::balance::value<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(&arg0.season_treasury)
    }

    public fun get_season_treasury_amount_df(arg0: &Season) : u128 {
        *0x2::dynamic_field::borrow<vector<u8>, u128>(&arg0.id, b"season_treasury")
    }

    public fun get_total_budget_distributed(arg0: &Season) : u64 {
        arg0.total_budget_distributed
    }

    public fun get_total_budget_distributed_df(arg0: &Season) : u128 {
        *0x2::dynamic_field::borrow<vector<u8>, u128>(&arg0.id, b"total_budget_distributed")
    }

    public fun get_user_migration_status(arg0: &Season, arg1: address) : bool {
        0x2::dynamic_field::exists_<address>(&arg0.id, arg1)
    }

    fun init(arg0: MOGUL_DFS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<MOGUL_DFS>(arg0, arg1);
        let v0 = MogulSeason{
            id     : 0x2::object::new(arg1),
            season : 0x2::table::new<u64, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<MogulSeason>(v0);
    }

    public fun join_season(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::OperatorCap, arg1: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::OperatorCapsBag, arg2: &mut 0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::CoinRegistry, arg3: &0x829da0ffcd021c5df97c06cd5b10de273eb51ade2a4518558da6b164b84fcfd4::mogul::MogulCentral, arg4: &mut Season, arg5: address, arg6: &0x2::clock::Clock, arg7: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg7);
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::is_operator(arg0, arg1);
        assert!(!arg4.is_paused, 21);
        assert!(0x829da0ffcd021c5df97c06cd5b10de273eb51ade2a4518558da6b164b84fcfd4::mogul::studio_exists(arg3, arg5), 4);
        assert!(!0x2::table::contains<address, PlayerInfo>(&arg4.player_joined, arg5), 5);
        assert!(arg4.pre_season_date < 0x2::clock::timestamp_ms(arg6), 10);
        assert!(arg4.end_date > 0x2::clock::timestamp_ms(arg6), 9);
        let v0 = PlayerInfo{
            player_address : arg5,
            budget         : 0x2::balance::zero<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(),
            owned_entities : 0x1::vector::empty<0x1::string::String>(),
            last_tx_ts     : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::balance::join<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(&mut v0.budget, 0x2::coin::into_balance<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::mint_token(arg2, arg4.player_budget_cap, arg8)));
        0x2::table::add<address, PlayerInfo>(&mut arg4.player_joined, arg5, v0);
        arg4.total_budget_distributed = arg4.total_budget_distributed + arg4.player_budget_cap;
        let v1 = PlayerJoinedEvent{
            player_address : arg5,
            season_id      : 0x2::object::id<Season>(arg4),
        };
        0x2::event::emit<PlayerJoinedEvent>(v1);
    }

    public fun join_season_v2(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::OperatorCap, arg1: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::OperatorCapsBag, arg2: &0x829da0ffcd021c5df97c06cd5b10de273eb51ade2a4518558da6b164b84fcfd4::mogul::MogulCentral, arg3: &mut Season, arg4: address, arg5: &0x2::clock::Clock, arg6: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version) {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg6);
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::is_operator(arg0, arg1);
        assert!(!arg3.is_paused, 21);
        assert!(0x829da0ffcd021c5df97c06cd5b10de273eb51ade2a4518558da6b164b84fcfd4::mogul::studio_exists(arg2, arg4), 4);
        assert!(!0x2::table::contains<address, PlayerInfo>(&arg3.player_joined, arg4), 5);
        assert!(arg3.pre_season_date < 0x2::clock::timestamp_ms(arg5), 10);
        assert!(arg3.end_date > 0x2::clock::timestamp_ms(arg5), 9);
        let v0 = PlayerInfo{
            player_address : arg4,
            budget         : 0x2::balance::zero<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(),
            owned_entities : 0x1::vector::empty<0x1::string::String>(),
            last_tx_ts     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::dynamic_field::add<address, u128>(&mut arg3.id, arg4, (arg3.player_budget_cap as u128));
        0x2::table::add<address, PlayerInfo>(&mut arg3.player_joined, arg4, v0);
        let v1 = (arg3.player_budget_cap as u128);
        add_points_in_total_budget_distributed(arg3, v1);
        let v2 = PlayerJoinedEvent{
            player_address : arg4,
            season_id      : 0x2::object::id<Season>(arg3),
        };
        0x2::event::emit<PlayerJoinedEvent>(v2);
    }

    fun migrate_player_data(arg0: &mut Season, arg1: address) {
        if (!0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            0x2::dynamic_field::add<address, u128>(&mut arg0.id, arg1, (0x2::balance::value<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(&0x2::table::borrow<address, PlayerInfo>(&arg0.player_joined, arg1).budget) as u128));
        };
    }

    public fun migrate_season_data(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::AdminCap, arg1: &mut Season, arg2: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version) {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg2);
        0x2::dynamic_field::add<vector<u8>, u128>(&mut arg1.id, b"total_budget_distributed", (arg1.total_budget_distributed as u128));
        0x2::dynamic_field::add<vector<u8>, u128>(&mut arg1.id, b"season_treasury", (0x2::balance::value<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(&arg1.season_treasury) as u128));
    }

    public fun mint_budget(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::OperatorCap, arg1: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::OperatorCapsBag, arg2: &mut 0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::CoinRegistry, arg3: &0x829da0ffcd021c5df97c06cd5b10de273eb51ade2a4518558da6b164b84fcfd4::mogul::MogulCentral, arg4: &mut Season, arg5: address, arg6: u64, arg7: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg7);
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::is_operator(arg0, arg1);
        assert!(!arg4.is_paused, 21);
        assert!(0x829da0ffcd021c5df97c06cd5b10de273eb51ade2a4518558da6b164b84fcfd4::mogul::studio_exists(arg3, arg5), 4);
        assert!(arg6 > 0, 7);
        assert!(0x2::table::contains<address, PlayerInfo>(&arg4.player_joined, arg5), 6);
        0x2::balance::join<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(&mut 0x2::table::borrow_mut<address, PlayerInfo>(&mut arg4.player_joined, arg5).budget, 0x2::coin::into_balance<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::mint_token(arg2, arg6, arg8)));
        arg4.total_budget_distributed = arg4.total_budget_distributed + arg6;
        let v0 = StudioBudgetAddedEvent{
            player_address : arg5,
            budget_added   : arg6,
        };
        0x2::event::emit<StudioBudgetAddedEvent>(v0);
    }

    public fun mint_budget_v2(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::OperatorCap, arg1: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::OperatorCapsBag, arg2: &0x829da0ffcd021c5df97c06cd5b10de273eb51ade2a4518558da6b164b84fcfd4::mogul::MogulCentral, arg3: &mut Season, arg4: address, arg5: u64, arg6: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version) {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg6);
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::is_operator(arg0, arg1);
        assert!(!arg3.is_paused, 21);
        assert!(0x829da0ffcd021c5df97c06cd5b10de273eb51ade2a4518558da6b164b84fcfd4::mogul::studio_exists(arg2, arg4), 4);
        assert!(arg5 > 0, 7);
        assert!(0x2::table::contains<address, PlayerInfo>(&arg3.player_joined, arg4), 6);
        migrate_player_data(arg3, arg4);
        add_points_in_user_balance(arg3, arg4, (arg5 as u128));
        add_points_in_total_budget_distributed(arg3, (arg5 as u128));
        let v0 = StudioBudgetAddedEvent{
            player_address : arg4,
            budget_added   : arg5,
        };
        0x2::event::emit<StudioBudgetAddedEvent>(v0);
    }

    public fun remove_entity(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::AdminCap, arg1: &mut Season, arg2: 0x1::string::String, arg3: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version) {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg3);
        assert!(0x2::table::contains<0x1::string::String, MogulEntity>(&arg1.entities, arg2), 12);
        0x2::table::remove<0x1::string::String, MogulEntity>(&mut arg1.entities, arg2);
        let v0 = EntityRemovedEvent{unique_id: arg2};
        0x2::event::emit<EntityRemovedEvent>(v0);
    }

    fun remove_points_from_user_balance(arg0: &mut Season, arg1: address, arg2: u128) {
        let v0 = 0x2::dynamic_field::borrow_mut<address, u128>(&mut arg0.id, arg1);
        *v0 = *v0 - arg2;
    }

    public fun sell_entity(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::OperatorCap, arg1: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::OperatorCapsBag, arg2: &0x829da0ffcd021c5df97c06cd5b10de273eb51ade2a4518558da6b164b84fcfd4::mogul::MogulCentral, arg3: &mut Season, arg4: address, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: u64, arg8: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version) {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg8);
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::is_operator(arg0, arg1);
        assert!(!arg3.is_paused, 21);
        assert!(0x829da0ffcd021c5df97c06cd5b10de273eb51ade2a4518558da6b164b84fcfd4::mogul::studio_exists(arg2, arg4), 4);
        assert!(0x2::table::contains<0x1::string::String, MogulEntity>(&arg3.entities, arg5), 12);
        validate_season_timelines(arg3, arg6);
        migrate_player_data(arg3, arg4);
        let v0 = 0x2::table::borrow_mut<address, PlayerInfo>(&mut arg3.player_joined, arg4);
        let v1 = 0x2::table::borrow<0x1::string::String, MogulEntity>(&arg3.entities, arg5).entity_cost;
        assert!(0x1::vector::contains<0x1::string::String>(&v0.owned_entities, &arg5), 8);
        let (_, v3) = 0x1::vector::index_of<0x1::string::String>(&v0.owned_entities, &arg5);
        0x1::vector::remove<0x1::string::String>(&mut v0.owned_entities, v3);
        let v4 = 0x2::dynamic_field::borrow_mut<vector<u8>, u128>(&mut arg3.id, b"season_treasury");
        *v4 = *v4 - (arg7 as u128);
        v0.last_tx_ts = 0x2::clock::timestamp_ms(arg6);
        add_points_in_user_balance(arg3, arg4, (arg7 as u128));
        let v5 = EntitySoldEvent{
            player_address : arg4,
            season_id      : 0x2::object::id<Season>(arg3),
            unique_id      : arg5,
            entity_cost    : v1,
        };
        0x2::event::emit<EntitySoldEvent>(v5);
    }

    public fun update_entity_cost(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::OperatorCap, arg1: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::OperatorCapsBag, arg2: &mut Season, arg3: 0x1::string::String, arg4: u64, arg5: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version) {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg5);
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::is_operator(arg0, arg1);
        assert!(0x2::table::contains<0x1::string::String, MogulEntity>(&arg2.entities, arg3), 12);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, MogulEntity>(&mut arg2.entities, arg3);
        v0.entity_cost = arg4;
        let v1 = EntityCostUpdatedEvent{
            unique_id   : arg3,
            imdb_id     : v0.imdb_id,
            movie_name  : v0.movie_name,
            name        : v0.name,
            entity_type : v0.entity_type,
            entity_cost : arg4,
        };
        0x2::event::emit<EntityCostUpdatedEvent>(v1);
    }

    public fun update_entity_details(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::AdminCap, arg1: &mut Season, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version) {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg8);
        assert!(0x2::table::contains<0x1::string::String, MogulEntity>(&arg1.entities, arg2), 12);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, MogulEntity>(&mut arg1.entities, arg2);
        v0.imdb_id = arg3;
        v0.movie_name = arg4;
        v0.name = arg5;
        v0.entity_type = arg6;
        v0.release_date_in_ms = arg7;
        let v1 = EntityUpdatedEvent{
            unique_id          : arg2,
            imdb_id            : arg3,
            movie_name         : arg4,
            name               : arg5,
            entity_type        : arg6,
            release_date_in_ms : arg7,
        };
        0x2::event::emit<EntityUpdatedEvent>(v1);
    }

    public fun update_season_end_date(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::AdminCap, arg1: &mut Season, arg2: u64, arg3: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version, arg4: &0x2::clock::Clock) {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg3);
        assert!(arg2 > arg1.start_date, 2);
        assert!(arg2 > 0x2::clock::timestamp_ms(arg4), 2);
        arg1.end_date = arg2;
        let v0 = SeasonEndDateUpdatedEvent{season_end_date: arg2};
        0x2::event::emit<SeasonEndDateUpdatedEvent>(v0);
    }

    public fun update_season_player_budget_cap(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::AdminCap, arg1: &mut Season, arg2: u64, arg3: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version) {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg3);
        assert!(arg2 > 0, 7);
        arg1.player_budget_cap = arg2;
        let v0 = SeasonPlayerBudgetCapUpdatedEvent{player_budget_cap: arg2};
        0x2::event::emit<SeasonPlayerBudgetCapUpdatedEvent>(v0);
    }

    public fun update_season_start_date(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::AdminCap, arg1: &mut Season, arg2: u64, arg3: u64, arg4: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version, arg5: &0x2::clock::Clock) {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg4);
        assert!(arg2 <= arg3, 2);
        assert!(arg3 < arg1.end_date, 2);
        assert!(arg3 > 0x2::clock::timestamp_ms(arg5), 3);
        assert!(arg1.start_date > 0x2::clock::timestamp_ms(arg5), 19);
        arg1.pre_season_date = arg2;
        arg1.start_date = arg3;
        let v0 = SeasonStartDateUpdatedEvent{
            season_pre_season_date : arg2,
            season_start_date      : arg3,
        };
        0x2::event::emit<SeasonStartDateUpdatedEvent>(v0);
    }

    public fun update_season_total_budget_distributed_v2(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::AdminCap, arg1: &mut Season, arg2: u128, arg3: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version) {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg3);
        assert!(arg2 > 0, 18);
        *0x2::dynamic_field::borrow_mut<vector<u8>, u128>(&mut arg1.id, b"total_budget_distributed") = arg2;
        let v0 = TotalBudgetDistributedUpdatedEvent{total_budget_distributed: arg2};
        0x2::event::emit<TotalBudgetDistributedUpdatedEvent>(v0);
    }

    public fun update_season_treasury(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::AdminCap, arg1: &mut Season, arg2: 0x2::coin::Coin<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>, arg3: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version) {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg3);
        assert!(0x2::coin::value<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(&arg2) > 0, 18);
        0x2::balance::join<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(&mut arg1.season_treasury, 0x2::coin::into_balance<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(arg2));
        let v0 = SeasonTreasuryUpdatedEvent{season_treasury: 0x2::balance::value<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(&arg1.season_treasury)};
        0x2::event::emit<SeasonTreasuryUpdatedEvent>(v0);
    }

    public fun update_season_treasury_v2(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::AdminCap, arg1: &mut Season, arg2: u128, arg3: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version) {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg3);
        assert!(arg2 > 0, 18);
        *0x2::dynamic_field::borrow_mut<vector<u8>, u128>(&mut arg1.id, b"season_treasury") = arg2;
        let v0 = SeasonTreasuryUpdatedEvent{season_treasury: (arg2 as u64)};
        0x2::event::emit<SeasonTreasuryUpdatedEvent>(v0);
    }

    public fun update_user_balance_v2(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::AdminCap, arg1: &mut Season, arg2: address, arg3: u128, arg4: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version) {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg4);
        assert!(arg3 > 0, 18);
        assert!(0x2::table::contains<address, PlayerInfo>(&arg1.player_joined, arg2), 6);
        *0x2::dynamic_field::borrow_mut<address, u128>(&mut arg1.id, arg2) = arg3;
        let v0 = UserBalanceUpdatedEvent{
            player_address : arg2,
            balance        : arg3,
        };
        0x2::event::emit<UserBalanceUpdatedEvent>(v0);
    }

    fun validate_season_timelines(arg0: &Season, arg1: &0x2::clock::Clock) {
        assert!(arg0.pre_season_date < 0x2::clock::timestamp_ms(arg1), 10);
        assert!(arg0.end_date > 0x2::clock::timestamp_ms(arg1), 9);
    }

    public fun withdraw_funds_from_player_budget(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::AdminCap, arg1: &mut Season, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN> {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg4);
        assert!(0x2::clock::timestamp_ms(arg3) > arg1.end_date, 17);
        assert!(0x2::table::contains<address, PlayerInfo>(&arg1.player_joined, arg2), 6);
        assert!(0x2::balance::value<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(&0x2::table::borrow<address, PlayerInfo>(&arg1.player_joined, arg2).budget) > 0, 13);
        let v0 = 0x2::balance::withdraw_all<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(&mut 0x2::table::borrow_mut<address, PlayerInfo>(&mut arg1.player_joined, arg2).budget);
        let v1 = PlayerBudgetWithdrawnEvent{
            player_address : arg2,
            budget         : 0x2::balance::value<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(&v0),
        };
        0x2::event::emit<PlayerBudgetWithdrawnEvent>(v1);
        0x2::coin::from_balance<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(v0, arg5)
    }

    public fun withdraw_funds_from_treasury(arg0: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::role::AdminCap, arg1: &mut Season, arg2: &0x2::clock::Clock, arg3: &0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::Version, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN> {
        0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::version::validate_version(arg3);
        assert!(0x2::clock::timestamp_ms(arg2) > arg1.end_date, 17);
        assert!(0x2::balance::value<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(&arg1.season_treasury) > 0, 16);
        let v0 = 0x2::balance::withdraw_all<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(&mut arg1.season_treasury);
        let v1 = SeasonTreasuryWithdrawnEvent{withdrawn_amount: 0x2::balance::value<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(&v0)};
        0x2::event::emit<SeasonTreasuryWithdrawnEvent>(v1);
        0x2::coin::from_balance<0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin::MOGUL_DFS_COIN>(v0, arg4)
    }

    // decompiled from Move bytecode v6
}

