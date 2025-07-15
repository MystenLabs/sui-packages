module 0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::battle_royale {
    struct BattleRoyale has key {
        id: 0x2::object::UID,
        admin: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        start_time: u64,
        end_time: u64,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        participant_to_coins: 0x2::table::Table<address, vector<address>>,
        max_coins_per_participant: u64,
        mid_battle_registration_enabled: bool,
        coin_to_participant: 0x2::table::Table<address, address>,
        participation_fee: u64,
        br_fee_bps: u64,
        first_place_bps: u64,
        second_place_bps: u64,
        third_place_bps: u64,
        platform_fee_bps: u64,
        is_finalized: bool,
        is_cancelled: bool,
    }

    struct BattleRoyaleManagerRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        managers: 0x2::table::Table<address, bool>,
    }

    struct WinnerRegistry has key {
        id: 0x2::object::UID,
        battle_royale: address,
        winners: 0x2::table::Table<address, WinnerInfo>,
        total_prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        is_fully_claimed: bool,
        claimed_count: u64,
    }

    struct WinnerInfo has copy, drop, store {
        rank: u8,
        prize_amount: u64,
        claimed: bool,
        coin_address: address,
    }

    struct WinnerRegistryCreatedEvent has copy, drop {
        br_address: address,
        registry_address: address,
        first_place_user_address: address,
        first_place_coin_address: address,
        first_place_amount: u64,
        second_place_user_address: address,
        second_place_coin_address: address,
        second_place_amount: u64,
        third_place_user_address: address,
        third_place_coin_address: address,
        third_place_amount: u64,
        total_prize_pool: u64,
    }

    struct PrizeClaimedEvent has copy, drop {
        registry_address: address,
        br_address: address,
        creator_address: address,
        coin_address: address,
        claimer: address,
        rank: u8,
        prize_amount: u64,
    }

    struct BattleRoyaleCreatedEvent has copy, drop {
        br_address: address,
        admin: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        start_time: u64,
        end_time: u64,
        initial_prize_pool: u64,
        participation_fee: u64,
        br_fee_bps: u64,
        first_place_bps: u64,
        second_place_bps: u64,
        third_place_bps: u64,
        platform_fee_bps: u64,
        max_coins_per_participant: u64,
        mid_battle_registration_enabled: bool,
    }

    struct BattleRoyaleCancelledEvent has copy, drop {
        br_address: address,
        admin: address,
        reason: 0x1::string::String,
    }

    struct ParticipantRegisteredEvent has copy, drop {
        br_address: address,
        participant: address,
        participation_fee: u64,
    }

    struct CoinRegisteredEvent has copy, drop {
        br_address: address,
        coin_address: address,
        participant: address,
    }

    struct PrizePoolContributionEvent has copy, drop {
        br_address: address,
        contributor: address,
        amount: u64,
        new_prize_pool: u64,
    }

    struct BattleRoyaleFinalizedEvent has copy, drop {
        br_address: address,
        total_prize_pool: u64,
        admin: address,
    }

    struct BattleRoyaleUpdatedEvent has copy, drop {
        br_address: address,
        admin: address,
        old_max_coins_per_participant: u64,
        new_max_coins_per_participant: u64,
        old_mid_battle_registration_enabled: bool,
        new_mid_battle_registration_enabled: bool,
        old_participation_fee: u64,
        new_participation_fee: u64,
        old_br_fee_bps: u64,
        new_br_fee_bps: u64,
        old_first_place_bps: u64,
        new_first_place_bps: u64,
        old_second_place_bps: u64,
        new_second_place_bps: u64,
        old_third_place_bps: u64,
        new_third_place_bps: u64,
        old_platform_fee_bps: u64,
        new_platform_fee_bps: u64,
    }

    struct TradeFeeToBREvent has copy, drop {
        br_address: address,
        coin_address: address,
        fee_amount: u64,
        new_prize_pool: u64,
    }

    struct BRManagerRegistryCreatedEvent has copy, drop {
        registry_address: address,
        admin: address,
    }

    struct BRManagerGrantedEvent has copy, drop {
        registry_address: address,
        admin: address,
        manager: address,
    }

    struct BRManagerRevokedEvent has copy, drop {
        registry_address: address,
        admin: address,
        manager: address,
    }

    public fun can_manage_br(arg0: &0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::token_launcher::Launchpad, arg1: &BattleRoyaleManagerRegistry, arg2: address) : bool {
        arg2 == 0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::token_launcher::get_admin(arg0) || is_br_manager(arg1, arg2)
    }

    public entry fun cancel_battle_royale(arg0: &0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::token_launcher::Launchpad, arg1: &BattleRoyaleManagerRegistry, arg2: &mut BattleRoyale, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(can_manage_br(arg0, arg1, 0x2::tx_context::sender(arg4)), 12);
        assert!(!arg2.is_finalized && !arg2.is_cancelled, 2);
        arg2.is_cancelled = true;
        let v0 = BattleRoyaleCancelledEvent{
            br_address : 0x2::object::uid_to_address(&arg2.id),
            admin      : arg2.admin,
            reason     : arg3,
        };
        0x2::event::emit<BattleRoyaleCancelledEvent>(v0);
    }

    public entry fun claim_prize(arg0: &mut WinnerRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, WinnerInfo>(&arg0.winners, 0x2::tx_context::sender(arg1)), 10);
        let v0 = 0x2::table::borrow_mut<address, WinnerInfo>(&mut arg0.winners, 0x2::tx_context::sender(arg1));
        assert!(!v0.claimed, 9);
        let v1 = v0.prize_amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.total_prize_pool, v1, arg1), 0x2::tx_context::sender(arg1));
        v0.claimed = true;
        arg0.claimed_count = arg0.claimed_count + 1;
        if (arg0.claimed_count == 0x2::table::length<address, WinnerInfo>(&arg0.winners)) {
            arg0.is_fully_claimed = true;
        };
        let v2 = PrizeClaimedEvent{
            registry_address : 0x2::object::uid_to_address(&arg0.id),
            br_address       : arg0.battle_royale,
            creator_address  : 0x2::tx_context::sender(arg1),
            coin_address     : v0.coin_address,
            claimer          : 0x2::tx_context::sender(arg1),
            rank             : v0.rank,
            prize_amount     : v1,
        };
        0x2::event::emit<PrizeClaimedEvent>(v2);
    }

    public entry fun contribute_to_prize_pool(arg0: &mut BattleRoyale, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_finalized && !arg0.is_cancelled, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = PrizePoolContributionEvent{
            br_address     : 0x2::object::uid_to_address(&arg0.id),
            contributor    : 0x2::tx_context::sender(arg2),
            amount         : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            new_prize_pool : 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<PrizePoolContributionEvent>(v0);
    }

    public fun contribute_trade_fee(arg0: &mut 0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::token_launcher::Launchpad, arg1: &mut BattleRoyale, arg2: address, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &0x2::clock::Clock) {
        if (!is_battle_royale_active(arg1, 0x2::clock::timestamp_ms(arg4))) {
            0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::token_launcher::add_to_treasury(arg0, arg3);
            return
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.prize_pool, arg3);
        let v0 = TradeFeeToBREvent{
            br_address     : 0x2::object::uid_to_address(&arg1.id),
            coin_address   : arg2,
            fee_amount     : 0x2::balance::value<0x2::sui::SUI>(&arg3),
            new_prize_pool : 0x2::balance::value<0x2::sui::SUI>(&arg1.prize_pool),
        };
        0x2::event::emit<TradeFeeToBREvent>(v0);
    }

    public entry fun create_battle_royale(arg0: &0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::token_launcher::Launchpad, arg1: &BattleRoyaleManagerRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(can_manage_br(arg0, arg1, 0x2::tx_context::sender(arg14)), 12);
        assert!(arg5 > arg4, 6);
        assert!(arg10 + arg11 + arg12 == 10000, 6);
        let v0 = BattleRoyale{
            id                              : 0x2::object::new(arg14),
            admin                           : 0x2::tx_context::sender(arg14),
            name                            : arg2,
            description                     : arg3,
            start_time                      : arg4,
            end_time                        : arg5,
            prize_pool                      : 0x2::balance::zero<0x2::sui::SUI>(),
            participant_to_coins            : 0x2::table::new<address, vector<address>>(arg14),
            max_coins_per_participant       : arg6,
            mid_battle_registration_enabled : arg7,
            coin_to_participant             : 0x2::table::new<address, address>(arg14),
            participation_fee               : arg8,
            br_fee_bps                      : arg9,
            first_place_bps                 : arg10,
            second_place_bps                : arg11,
            third_place_bps                 : arg12,
            platform_fee_bps                : arg13,
            is_finalized                    : false,
            is_cancelled                    : false,
        };
        let v1 = BattleRoyaleCreatedEvent{
            br_address                      : 0x2::object::uid_to_address(&v0.id),
            admin                           : 0x2::tx_context::sender(arg14),
            name                            : arg2,
            description                     : arg3,
            start_time                      : arg4,
            end_time                        : arg5,
            initial_prize_pool              : 0,
            participation_fee               : arg8,
            br_fee_bps                      : arg9,
            first_place_bps                 : arg10,
            second_place_bps                : arg11,
            third_place_bps                 : arg12,
            platform_fee_bps                : arg13,
            max_coins_per_participant       : arg6,
            mid_battle_registration_enabled : arg7,
        };
        0x2::event::emit<BattleRoyaleCreatedEvent>(v1);
        0x2::transfer::share_object<BattleRoyale>(v0);
    }

    public entry fun create_br_manager_registry(arg0: &0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::token_launcher::Launchpad, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::token_launcher::get_admin(arg0), 0);
        let v0 = BattleRoyaleManagerRegistry{
            id       : 0x2::object::new(arg1),
            admin    : 0x2::tx_context::sender(arg1),
            managers : 0x2::table::new<address, bool>(arg1),
        };
        let v1 = BRManagerRegistryCreatedEvent{
            registry_address : 0x2::object::uid_to_address(&v0.id),
            admin            : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<BRManagerRegistryCreatedEvent>(v1);
        0x2::transfer::share_object<BattleRoyaleManagerRegistry>(v0);
    }

    public entry fun create_default_battle_royale(arg0: &0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::token_launcher::Launchpad, arg1: &BattleRoyaleManagerRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        create_battle_royale(arg0, arg1, arg2, arg3, arg4, arg5, 1, false, 1000000000, 5000, 5500, 3000, 1500, 1000, arg6);
    }

    public fun does_coin_participate(arg0: &BattleRoyale, arg1: address) : bool {
        0x2::table::contains<address, address>(&arg0.coin_to_participant, arg1)
    }

    public entry fun drain_remaining_funds(arg0: &mut BattleRoyale, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        assert!(arg0.is_finalized || arg0.is_cancelled, 7);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.prize_pool, v0, arg1), arg0.admin);
        };
    }

    public entry fun finalize_battle_royale(arg0: &0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::token_launcher::Launchpad, arg1: &BattleRoyaleManagerRegistry, arg2: &mut BattleRoyale, arg3: address, arg4: address, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(can_manage_br(arg0, arg1, 0x2::tx_context::sender(arg7)), 12);
        assert!(0x2::clock::timestamp_ms(arg6) > arg2.end_time, 3);
        assert!(!arg2.is_finalized, 2);
        assert!(!arg2.is_cancelled, 2);
        assert!(0x2::table::contains<address, address>(&arg2.coin_to_participant, arg3), 5);
        assert!(0x2::table::contains<address, address>(&arg2.coin_to_participant, arg4), 5);
        assert!(0x2::table::contains<address, address>(&arg2.coin_to_participant, arg5), 5);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2.prize_pool);
        let v1 = 0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::utils::as_u64(0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::utils::percentage_of(0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::utils::from_u64(v0), arg2.first_place_bps));
        let v2 = 0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::utils::as_u64(0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::utils::percentage_of(0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::utils::from_u64(v0), arg2.second_place_bps));
        let v3 = 0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::utils::as_u64(0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::utils::percentage_of(0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::utils::from_u64(v0), arg2.third_place_bps));
        assert!(v1 + v2 + v3 <= v0, 11);
        let v4 = *0x2::table::borrow<address, address>(&arg2.coin_to_participant, arg3);
        let v5 = *0x2::table::borrow<address, address>(&arg2.coin_to_participant, arg4);
        let v6 = *0x2::table::borrow<address, address>(&arg2.coin_to_participant, arg5);
        let v7 = WinnerRegistry{
            id               : 0x2::object::new(arg7),
            battle_royale    : 0x2::object::uid_to_address(&arg2.id),
            winners          : 0x2::table::new<address, WinnerInfo>(arg7),
            total_prize_pool : 0x2::balance::zero<0x2::sui::SUI>(),
            is_fully_claimed : false,
            claimed_count    : 0,
        };
        let v8 = WinnerInfo{
            rank         : 1,
            prize_amount : v1,
            claimed      : false,
            coin_address : arg3,
        };
        0x2::table::add<address, WinnerInfo>(&mut v7.winners, v4, v8);
        let v9 = WinnerInfo{
            rank         : 2,
            prize_amount : v2,
            claimed      : false,
            coin_address : arg4,
        };
        0x2::table::add<address, WinnerInfo>(&mut v7.winners, v5, v9);
        let v10 = WinnerInfo{
            rank         : 3,
            prize_amount : v3,
            claimed      : false,
            coin_address : arg5,
        };
        0x2::table::add<address, WinnerInfo>(&mut v7.winners, v6, v10);
        0x2::balance::join<0x2::sui::SUI>(&mut v7.total_prize_pool, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg2.prize_pool));
        arg2.is_finalized = true;
        let v11 = WinnerRegistryCreatedEvent{
            br_address                : 0x2::object::uid_to_address(&arg2.id),
            registry_address          : 0x2::object::uid_to_address(&v7.id),
            first_place_user_address  : v4,
            first_place_coin_address  : arg3,
            first_place_amount        : v1,
            second_place_user_address : v5,
            second_place_coin_address : arg4,
            second_place_amount       : v2,
            third_place_user_address  : v6,
            third_place_coin_address  : arg5,
            third_place_amount        : v3,
            total_prize_pool          : v0,
        };
        0x2::event::emit<WinnerRegistryCreatedEvent>(v11);
        let v12 = BattleRoyaleFinalizedEvent{
            br_address       : 0x2::object::uid_to_address(&arg2.id),
            total_prize_pool : v0,
            admin            : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<BattleRoyaleFinalizedEvent>(v12);
        0x2::transfer::share_object<WinnerRegistry>(v7);
    }

    public fun get_address(arg0: &BattleRoyale) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun get_battle_royale_info(arg0: &BattleRoyale) : (0x1::string::String, 0x1::string::String, address, u64, u64, u64, u64, bool, bool) {
        (arg0.name, arg0.description, arg0.admin, arg0.start_time, arg0.end_time, 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool), arg0.participation_fee, arg0.is_finalized, arg0.is_cancelled)
    }

    public fun get_br_fee_bps(arg0: &BattleRoyale) : u64 {
        arg0.br_fee_bps
    }

    public fun get_end_time(arg0: &BattleRoyale) : u64 {
        arg0.end_time
    }

    public fun get_manager_registry_info(arg0: &BattleRoyaleManagerRegistry) : (address, address) {
        (0x2::object::uid_to_address(&arg0.id), arg0.admin)
    }

    public fun get_prize_distribution(arg0: &BattleRoyale) : (u64, u64, u64, u64) {
        (arg0.first_place_bps, arg0.second_place_bps, arg0.third_place_bps, arg0.platform_fee_bps)
    }

    public fun get_start_time(arg0: &BattleRoyale) : u64 {
        arg0.start_time
    }

    public entry fun grant_br_manager_role(arg0: &0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::token_launcher::Launchpad, arg1: &mut BattleRoyaleManagerRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::token_launcher::get_admin(arg0), 0);
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 0);
        if (0x2::table::contains<address, bool>(&arg1.managers, arg2)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg1.managers, arg2) = true;
        } else {
            0x2::table::add<address, bool>(&mut arg1.managers, arg2, true);
        };
        let v0 = BRManagerGrantedEvent{
            registry_address : 0x2::object::uid_to_address(&arg1.id),
            admin            : 0x2::tx_context::sender(arg3),
            manager          : arg2,
        };
        0x2::event::emit<BRManagerGrantedEvent>(v0);
    }

    public fun is_battle_royale_active(arg0: &BattleRoyale, arg1: u64) : bool {
        arg1 >= arg0.start_time && arg1 <= arg0.end_time
    }

    public fun is_battle_royale_cancelled(arg0: &BattleRoyale) : bool {
        arg0.is_cancelled
    }

    public fun is_battle_royale_finalized(arg0: &BattleRoyale) : bool {
        arg0.is_finalized
    }

    public fun is_battle_royale_open(arg0: &BattleRoyale, arg1: u64) : bool {
        arg1 >= arg0.start_time
    }

    public fun is_br_manager(arg0: &BattleRoyaleManagerRegistry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.managers, arg1) && *0x2::table::borrow<address, bool>(&arg0.managers, arg1)
    }

    public fun is_coin_registered(arg0: &BattleRoyale, arg1: address) : bool {
        0x2::table::contains<address, address>(&arg0.coin_to_participant, arg1)
    }

    public fun is_coin_valid_for_battle_royale(arg0: &BattleRoyale, arg1: address, arg2: u64) : bool {
        if (does_coin_participate(arg0, arg1)) {
            if (is_battle_royale_active(arg0, arg2)) {
                if (!is_battle_royale_finalized(arg0)) {
                    !is_battle_royale_cancelled(arg0)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun register_coin(arg0: &mut BattleRoyale, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_finalized && !arg0.is_cancelled, 2);
        assert!(0x2::clock::timestamp_ms(arg2) <= arg0.end_time, 2);
        assert!(0x2::table::contains<address, vector<address>>(&arg0.participant_to_coins, 0x2::tx_context::sender(arg3)), 8);
        assert!(!0x2::table::contains<address, address>(&arg0.coin_to_participant, arg1), 4);
        assert!(0x1::vector::length<address>(0x2::table::borrow<address, vector<address>>(&arg0.participant_to_coins, 0x2::tx_context::sender(arg3))) < arg0.max_coins_per_participant, 4);
        0x1::vector::push_back<address>(0x2::table::borrow_mut<address, vector<address>>(&mut arg0.participant_to_coins, 0x2::tx_context::sender(arg3)), arg1);
        0x2::table::add<address, address>(&mut arg0.coin_to_participant, arg1, 0x2::tx_context::sender(arg3));
        let v0 = CoinRegisteredEvent{
            br_address   : 0x2::object::uid_to_address(&arg0.id),
            coin_address : arg1,
            participant  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<CoinRegisteredEvent>(v0);
    }

    public fun register_participant_and_split_payment(arg0: &mut 0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::token_launcher::Launchpad, arg1: &mut BattleRoyale, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, bool) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(!arg1.is_finalized && !arg1.is_cancelled, 2);
        assert!(v0 <= arg1.end_time, 2);
        if (v0 > arg1.start_time) {
            assert!(arg1.mid_battle_registration_enabled, 2);
        };
        assert!(!0x2::table::contains<address, vector<address>>(&arg1.participant_to_coins, v1), 4);
        let v2 = arg1.participation_fee;
        let v3 = 0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::token_launcher::get_creation_fee(arg0) + v2;
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v4 >= v3, 1);
        if (v4 > v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v4 - v3, arg4), v1);
        };
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v2, arg4));
        if (arg1.platform_fee_bps > 0) {
            0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::token_launcher::add_to_treasury(arg0, 0x2::balance::split<0x2::sui::SUI>(&mut v5, 0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::utils::as_u64(0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::utils::percentage_of(0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::utils::from_u64(v2), arg1.platform_fee_bps))));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.prize_pool, v5);
        0x2::table::add<address, vector<address>>(&mut arg1.participant_to_coins, v1, 0x1::vector::empty<address>());
        let v6 = ParticipantRegisteredEvent{
            br_address        : 0x2::object::uid_to_address(&arg1.id),
            participant       : v1,
            participation_fee : v2,
        };
        0x2::event::emit<ParticipantRegisteredEvent>(v6);
        (arg2, true)
    }

    public entry fun revoke_br_manager_role(arg0: &0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::token_launcher::Launchpad, arg1: &mut BattleRoyaleManagerRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::token_launcher::get_admin(arg0), 0);
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 0);
        if (0x2::table::contains<address, bool>(&arg1.managers, arg2)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg1.managers, arg2) = false;
        };
        let v0 = BRManagerRevokedEvent{
            registry_address : 0x2::object::uid_to_address(&arg1.id),
            admin            : 0x2::tx_context::sender(arg3),
            manager          : arg2,
        };
        0x2::event::emit<BRManagerRevokedEvent>(v0);
    }

    public fun test_get_DEFAULT_BR_FEE_BPS() : u64 {
        5000
    }

    public fun test_get_DEFAULT_FIRST_PLACE_BPS() : u64 {
        5500
    }

    public fun test_get_DEFAULT_PARTICIPATION_FEE() : u64 {
        1000000000
    }

    public fun test_get_DEFAULT_PLATFORM_FEE_BPS() : u64 {
        1000
    }

    public fun test_get_DEFAULT_SECOND_PLACE_BPS() : u64 {
        3000
    }

    public fun test_get_DEFAULT_THIRD_PLACE_BPS() : u64 {
        1500
    }

    public fun test_get_battle_royale_address(arg0: &BattleRoyale) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun test_get_battle_royale_prize_pool(arg0: &BattleRoyale) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool)
    }

    public entry fun update_battle_royale(arg0: &0x591348c3623082f18e602b29dbd41791e5ca9af8f5f606541e5fa7418b39c131::token_launcher::Launchpad, arg1: &BattleRoyaleManagerRegistry, arg2: &mut BattleRoyale, arg3: u64, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(can_manage_br(arg0, arg1, 0x2::tx_context::sender(arg12)), 12);
        assert!(arg7 + arg8 + arg9 == 10000, 11);
        assert!(!arg2.is_finalized && !arg2.is_cancelled, 2);
        assert!(0x2::clock::timestamp_ms(arg11) < arg2.end_time, 2);
        arg2.max_coins_per_participant = arg3;
        arg2.mid_battle_registration_enabled = arg4;
        arg2.participation_fee = arg5;
        arg2.br_fee_bps = arg6;
        arg2.first_place_bps = arg7;
        arg2.second_place_bps = arg8;
        arg2.third_place_bps = arg9;
        arg2.platform_fee_bps = arg10;
        let v0 = BattleRoyaleUpdatedEvent{
            br_address                          : 0x2::object::uid_to_address(&arg2.id),
            admin                               : 0x2::tx_context::sender(arg12),
            old_max_coins_per_participant       : arg2.max_coins_per_participant,
            new_max_coins_per_participant       : arg3,
            old_mid_battle_registration_enabled : arg2.mid_battle_registration_enabled,
            new_mid_battle_registration_enabled : arg4,
            old_participation_fee               : arg2.participation_fee,
            new_participation_fee               : arg5,
            old_br_fee_bps                      : arg2.br_fee_bps,
            new_br_fee_bps                      : arg6,
            old_first_place_bps                 : arg2.first_place_bps,
            new_first_place_bps                 : arg7,
            old_second_place_bps                : arg2.second_place_bps,
            new_second_place_bps                : arg8,
            old_third_place_bps                 : arg2.third_place_bps,
            new_third_place_bps                 : arg9,
            old_platform_fee_bps                : arg2.platform_fee_bps,
            new_platform_fee_bps                : arg10,
        };
        0x2::event::emit<BattleRoyaleUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

