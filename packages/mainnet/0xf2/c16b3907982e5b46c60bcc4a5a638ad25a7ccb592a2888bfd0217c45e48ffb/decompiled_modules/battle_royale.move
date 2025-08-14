module 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::battle_royale {
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
        open_buy_at: 0x1::option::Option<u64>,
        open_sell_at: 0x1::option::Option<u64>,
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

    struct ParticipantWinnerInfo has copy, drop, store {
        rank: u64,
        percentage_bps: u64,
        prize_amount: u64,
        claimed: bool,
    }

    struct ParticipantWinnerRegistry has key {
        id: 0x2::object::UID,
        battle_royale: address,
        winners: 0x2::table::Table<address, ParticipantWinnerInfo>,
        total_winners: u64,
        total_prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        is_fully_claimed: bool,
        claimed_count: u64,
    }

    struct WinnerRegistryCreatedEvent has copy, drop {
        br_address: address,
        registry_address: address,
        first_place_user_address: address,
        first_place_coin_address: address,
        first_place_amount: u64,
        second_place_user_address: address,
        second_place_coin_address: 0x1::option::Option<address>,
        second_place_amount: u64,
        third_place_user_address: address,
        third_place_coin_address: 0x1::option::Option<address>,
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

    struct ParticipantWinnerRegistryCreatedEvent has copy, drop {
        br_address: address,
        registry_address: address,
        winner_addresses: vector<address>,
        winner_ranks: vector<u64>,
        winner_percentages: vector<u64>,
        winner_amounts: vector<u64>,
        total_winners: u64,
        total_prize_pool: u64,
    }

    struct ParticipantPrizeClaimedEvent has copy, drop {
        registry_address: address,
        br_address: address,
        winner_address: address,
        claimer: address,
        rank: u64,
        percentage_bps: u64,
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
        open_buy_at: 0x1::option::Option<u64>,
        open_sell_at: 0x1::option::Option<u64>,
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
        old_open_buy_at: 0x1::option::Option<u64>,
        new_open_buy_at: 0x1::option::Option<u64>,
        old_open_sell_at: 0x1::option::Option<u64>,
        new_open_sell_at: 0x1::option::Option<u64>,
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

    public fun can_manage_br(arg0: &0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &BattleRoyaleManagerRegistry, arg2: address) : bool {
        arg2 == 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_admin(arg0) || is_br_manager(arg1, arg2)
    }

    public entry fun cancel_battle_royale(arg0: &0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &BattleRoyaleManagerRegistry, arg2: &mut BattleRoyale, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
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

    public entry fun claim_prize_from_participant_registry(arg0: &mut ParticipantWinnerRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, ParticipantWinnerInfo>(&arg0.winners, v0), 10);
        let v1 = 0x2::table::borrow_mut<address, ParticipantWinnerInfo>(&mut arg0.winners, v0);
        assert!(!v1.claimed, 9);
        let v2 = v1.prize_amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.total_prize_pool, v2, arg1), v0);
        v1.claimed = true;
        arg0.claimed_count = arg0.claimed_count + 1;
        if (arg0.claimed_count == arg0.total_winners) {
            arg0.is_fully_claimed = true;
        };
        let v3 = ParticipantPrizeClaimedEvent{
            registry_address : 0x2::object::uid_to_address(&arg0.id),
            br_address       : arg0.battle_royale,
            winner_address   : v0,
            claimer          : v0,
            rank             : v1.rank,
            percentage_bps   : v1.percentage_bps,
            prize_amount     : v2,
        };
        0x2::event::emit<ParticipantPrizeClaimedEvent>(v3);
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

    public fun contribute_trade_fee(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut BattleRoyale, arg2: address, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &0x2::clock::Clock) {
        if (!is_battle_royale_active(arg1, 0x2::clock::timestamp_ms(arg4))) {
            0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_treasury(arg0, arg3);
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

    public entry fun create_battle_royale(arg0: &0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &BattleRoyaleManagerRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: 0x1::option::Option<u64>, arg15: 0x1::option::Option<u64>, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(can_manage_br(arg0, arg1, 0x2::tx_context::sender(arg16)), 12);
        assert!(arg5 > arg4, 6);
        assert!(arg10 + arg11 + arg12 == 10000, 6);
        assert!(arg13 <= 10000, 17);
        assert!(arg9 <= 10000, 17);
        let v0 = BattleRoyale{
            id                              : 0x2::object::new(arg16),
            admin                           : 0x2::tx_context::sender(arg16),
            name                            : arg2,
            description                     : arg3,
            start_time                      : arg4,
            end_time                        : arg5,
            prize_pool                      : 0x2::balance::zero<0x2::sui::SUI>(),
            participant_to_coins            : 0x2::table::new<address, vector<address>>(arg16),
            max_coins_per_participant       : arg6,
            mid_battle_registration_enabled : arg7,
            coin_to_participant             : 0x2::table::new<address, address>(arg16),
            participation_fee               : arg8,
            br_fee_bps                      : arg9,
            first_place_bps                 : arg10,
            second_place_bps                : arg11,
            third_place_bps                 : arg12,
            platform_fee_bps                : arg13,
            is_finalized                    : false,
            is_cancelled                    : false,
            open_buy_at                     : arg15,
            open_sell_at                    : arg14,
        };
        let v1 = BattleRoyaleCreatedEvent{
            br_address                      : 0x2::object::uid_to_address(&v0.id),
            admin                           : 0x2::tx_context::sender(arg16),
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
            open_buy_at                     : arg15,
            open_sell_at                    : arg14,
        };
        0x2::event::emit<BattleRoyaleCreatedEvent>(v1);
        0x2::transfer::share_object<BattleRoyale>(v0);
    }

    public entry fun create_br_manager_registry(arg0: &0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_admin(arg0), 0);
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

    public entry fun create_default_battle_royale(arg0: &0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &BattleRoyaleManagerRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: &mut 0x2::tx_context::TxContext) {
        create_battle_royale(arg0, arg1, arg2, arg3, arg4, arg5, 1, false, 1000000000, 5000, 5500, 3000, 1500, 1000, arg7, arg6, arg8);
    }

    public entry fun drain_remaining_funds(arg0: &mut BattleRoyale, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        assert!(arg0.is_finalized || arg0.is_cancelled, 7);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.prize_pool, v0, arg1), arg0.admin);
        };
    }

    public entry fun finalize_battle_royale(arg0: &0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &BattleRoyaleManagerRegistry, arg2: &mut BattleRoyale, arg3: address, arg4: 0x1::option::Option<address>, arg5: 0x1::option::Option<address>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(can_manage_br(arg0, arg1, 0x2::tx_context::sender(arg7)), 12);
        assert!(0x2::clock::timestamp_ms(arg6) > arg2.end_time, 3);
        assert!(!arg2.is_finalized, 2);
        assert!(!arg2.is_cancelled, 2);
        assert!(0x2::table::contains<address, address>(&arg2.coin_to_participant, arg3), 5);
        let v0 = 0x1::option::is_some<address>(&arg4);
        let v1 = 0x1::option::is_some<address>(&arg5);
        if (v0) {
            assert!(0x2::table::contains<address, address>(&arg2.coin_to_participant, *0x1::option::borrow<address>(&arg4)), 5);
        };
        if (v1) {
            assert!(0x2::table::contains<address, address>(&arg2.coin_to_participant, *0x1::option::borrow<address>(&arg5)), 5);
        };
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg2.prize_pool);
        let v3 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::percentage_of(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v2), arg2.first_place_bps));
        let v4 = 0;
        if (v0) {
            v4 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::percentage_of(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v2), arg2.second_place_bps));
        };
        let v5 = 0;
        if (v1) {
            v5 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::percentage_of(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v2), arg2.third_place_bps));
        };
        assert!(v3 + v4 + v5 <= v2, 11);
        let v6 = *0x2::table::borrow<address, address>(&arg2.coin_to_participant, arg3);
        let v7 = @0x0;
        if (v0) {
            v7 = *0x2::table::borrow<address, address>(&arg2.coin_to_participant, *0x1::option::borrow<address>(&arg4));
        };
        let v8 = @0x0;
        if (v1) {
            v8 = *0x2::table::borrow<address, address>(&arg2.coin_to_participant, *0x1::option::borrow<address>(&arg5));
        };
        let v9 = WinnerRegistry{
            id               : 0x2::object::new(arg7),
            battle_royale    : 0x2::object::uid_to_address(&arg2.id),
            winners          : 0x2::table::new<address, WinnerInfo>(arg7),
            total_prize_pool : 0x2::balance::zero<0x2::sui::SUI>(),
            is_fully_claimed : false,
            claimed_count    : 0,
        };
        let v10 = WinnerInfo{
            rank         : 1,
            prize_amount : v3,
            claimed      : false,
            coin_address : arg3,
        };
        0x2::table::add<address, WinnerInfo>(&mut v9.winners, v6, v10);
        if (v0) {
            let v11 = WinnerInfo{
                rank         : 2,
                prize_amount : v4,
                claimed      : false,
                coin_address : *0x1::option::borrow<address>(&arg4),
            };
            0x2::table::add<address, WinnerInfo>(&mut v9.winners, v7, v11);
        };
        if (v1) {
            let v12 = WinnerInfo{
                rank         : 3,
                prize_amount : v5,
                claimed      : false,
                coin_address : *0x1::option::borrow<address>(&arg5),
            };
            0x2::table::add<address, WinnerInfo>(&mut v9.winners, v8, v12);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut v9.total_prize_pool, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg2.prize_pool));
        arg2.is_finalized = true;
        let v13 = WinnerRegistryCreatedEvent{
            br_address                : 0x2::object::uid_to_address(&arg2.id),
            registry_address          : 0x2::object::uid_to_address(&v9.id),
            first_place_user_address  : v6,
            first_place_coin_address  : arg3,
            first_place_amount        : v3,
            second_place_user_address : v7,
            second_place_coin_address : arg4,
            second_place_amount       : v4,
            third_place_user_address  : v8,
            third_place_coin_address  : arg5,
            third_place_amount        : v5,
            total_prize_pool          : v2,
        };
        0x2::event::emit<WinnerRegistryCreatedEvent>(v13);
        let v14 = BattleRoyaleFinalizedEvent{
            br_address       : 0x2::object::uid_to_address(&arg2.id),
            total_prize_pool : v2,
            admin            : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<BattleRoyaleFinalizedEvent>(v14);
        0x2::transfer::share_object<WinnerRegistry>(v9);
    }

    public entry fun finalize_battle_royale_with_participants(arg0: &0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &BattleRoyaleManagerRegistry, arg2: &mut BattleRoyale, arg3: vector<address>, arg4: vector<u64>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(can_manage_br(arg0, arg1, 0x2::tx_context::sender(arg6)), 12);
        assert!(0x2::clock::timestamp_ms(arg5) > arg2.end_time, 3);
        assert!(!arg2.is_finalized, 2);
        assert!(!arg2.is_cancelled, 2);
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 > 0, 14);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 15);
        let v1 = 0;
        while (v1 < v0) {
            assert!(0x2::table::contains<address, vector<address>>(&arg2.participant_to_coins, *0x1::vector::borrow<address>(&arg3, v1)), 8);
            v1 = v1 + 1;
        };
        let v2 = 0;
        v1 = 0;
        while (v1 < v0) {
            v2 = v2 + *0x1::vector::borrow<u64>(&arg4, v1);
            v1 = v1 + 1;
        };
        assert!(v2 == 10000, 16);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg2.prize_pool);
        let v4 = 0x1::vector::empty<u64>();
        v1 = 0;
        while (v1 < v0) {
            0x1::vector::push_back<u64>(&mut v4, 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::percentage_of(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v3), *0x1::vector::borrow<u64>(&arg4, v1))));
            v1 = v1 + 1;
        };
        let v5 = ParticipantWinnerRegistry{
            id               : 0x2::object::new(arg6),
            battle_royale    : 0x2::object::uid_to_address(&arg2.id),
            winners          : 0x2::table::new<address, ParticipantWinnerInfo>(arg6),
            total_winners    : v0,
            total_prize_pool : 0x2::balance::zero<0x2::sui::SUI>(),
            is_fully_claimed : false,
            claimed_count    : 0,
        };
        let v6 = 0x1::vector::empty<u64>();
        v1 = 0;
        while (v1 < v0) {
            let v7 = v1 + 1;
            0x1::vector::push_back<u64>(&mut v6, v7);
            let v8 = ParticipantWinnerInfo{
                rank           : v7,
                percentage_bps : *0x1::vector::borrow<u64>(&arg4, v1),
                prize_amount   : *0x1::vector::borrow<u64>(&v4, v1),
                claimed        : false,
            };
            0x2::table::add<address, ParticipantWinnerInfo>(&mut v5.winners, *0x1::vector::borrow<address>(&arg3, v1), v8);
            v1 = v1 + 1;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut v5.total_prize_pool, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg2.prize_pool));
        arg2.is_finalized = true;
        let v9 = ParticipantWinnerRegistryCreatedEvent{
            br_address         : 0x2::object::uid_to_address(&arg2.id),
            registry_address   : 0x2::object::uid_to_address(&v5.id),
            winner_addresses   : arg3,
            winner_ranks       : v6,
            winner_percentages : arg4,
            winner_amounts     : v4,
            total_winners      : v0,
            total_prize_pool   : v3,
        };
        0x2::event::emit<ParticipantWinnerRegistryCreatedEvent>(v9);
        let v10 = BattleRoyaleFinalizedEvent{
            br_address       : 0x2::object::uid_to_address(&arg2.id),
            total_prize_pool : v3,
            admin            : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<BattleRoyaleFinalizedEvent>(v10);
        0x2::transfer::share_object<ParticipantWinnerRegistry>(v5);
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

    public fun get_open_buy_at(arg0: &BattleRoyale) : 0x1::option::Option<u64> {
        arg0.open_buy_at
    }

    public fun get_open_sell_at(arg0: &BattleRoyale) : 0x1::option::Option<u64> {
        arg0.open_sell_at
    }

    public fun get_participation_fee(arg0: &BattleRoyale) : u64 {
        arg0.participation_fee
    }

    public fun get_prize_distribution(arg0: &BattleRoyale) : (u64, u64, u64, u64) {
        (arg0.first_place_bps, arg0.second_place_bps, arg0.third_place_bps, arg0.platform_fee_bps)
    }

    public entry fun grant_br_manager_role(arg0: &0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut BattleRoyaleManagerRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_admin(arg0) || 0x2::tx_context::sender(arg3) == arg1.admin, 0);
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

    public fun is_br_manager(arg0: &BattleRoyaleManagerRegistry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.managers, arg1) && *0x2::table::borrow<address, bool>(&arg0.managers, arg1)
    }

    public fun is_coin_registered(arg0: &BattleRoyale, arg1: address) : bool {
        0x2::table::contains<address, address>(&arg0.coin_to_participant, arg1)
    }

    public fun is_coin_valid_for_battle_royale(arg0: &BattleRoyale, arg1: address, arg2: u64) : bool {
        if (0x2::table::contains<address, address>(&arg0.coin_to_participant, arg1)) {
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

    public(friend) fun register_participant_and_split_payment(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut BattleRoyale, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, bool) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(!arg1.is_finalized && !arg1.is_cancelled, 2);
        assert!(v0 <= arg1.end_time, 2);
        if (v0 > arg1.start_time) {
            assert!(arg1.mid_battle_registration_enabled, 2);
        };
        assert!(!0x2::table::contains<address, vector<address>>(&arg1.participant_to_coins, v1), 4);
        let v2 = arg1.participation_fee;
        let v3 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_creation_fee(arg0) + v2;
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v4 >= v3, 1);
        if (v4 > v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v4 - v3, arg4), v1);
        };
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v2, arg4));
        if (arg1.platform_fee_bps > 0) {
            assert!(arg1.platform_fee_bps <= 10000, 17);
            let v6 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::percentage_of_round_up(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v2), arg1.platform_fee_bps));
            if (v6 > 0 && v6 <= 0x2::balance::value<0x2::sui::SUI>(&v5)) {
                0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_treasury(arg0, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v6));
            };
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.prize_pool, v5);
        0x2::table::add<address, vector<address>>(&mut arg1.participant_to_coins, v1, 0x1::vector::empty<address>());
        let v7 = ParticipantRegisteredEvent{
            br_address        : 0x2::object::uid_to_address(&arg1.id),
            participant       : v1,
            participation_fee : v2,
        };
        0x2::event::emit<ParticipantRegisteredEvent>(v7);
        (arg2, true)
    }

    public entry fun register_participant_only(arg0: &mut 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut BattleRoyale, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::is_emergency_paused(arg0), 13);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(!arg1.is_finalized && !arg1.is_cancelled, 2);
        assert!(v0 <= arg1.end_time, 2);
        if (v0 > arg1.start_time) {
            assert!(arg1.mid_battle_registration_enabled, 2);
        };
        assert!(!0x2::table::contains<address, vector<address>>(&arg1.participant_to_coins, v1), 4);
        let v2 = arg1.participation_fee;
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v3 >= v2, 1);
        if (v3 > v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v3 - v2, arg4), v1);
        };
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        if (arg1.platform_fee_bps > 0) {
            assert!(arg1.platform_fee_bps <= 10000, 17);
            let v5 = 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::as_u64(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::percentage_of_round_up(0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils::from_u64(v2), arg1.platform_fee_bps));
            if (v5 > 0 && v5 <= 0x2::balance::value<0x2::sui::SUI>(&v4)) {
                0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::add_to_treasury(arg0, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v5));
            };
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.prize_pool, v4);
        0x2::table::add<address, vector<address>>(&mut arg1.participant_to_coins, v1, 0x1::vector::empty<address>());
        let v6 = ParticipantRegisteredEvent{
            br_address        : 0x2::object::uid_to_address(&arg1.id),
            participant       : v1,
            participation_fee : v2,
        };
        0x2::event::emit<ParticipantRegisteredEvent>(v6);
    }

    public entry fun revoke_br_manager_role(arg0: &0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &mut BattleRoyaleManagerRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::get_admin(arg0) || 0x2::tx_context::sender(arg3) == arg1.admin, 0);
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

    public entry fun update_battle_royale(arg0: &0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::token_launcher::Launchpad, arg1: &BattleRoyaleManagerRegistry, arg2: &mut BattleRoyale, arg3: u64, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: 0x1::option::Option<u64>, arg12: 0x1::option::Option<u64>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(can_manage_br(arg0, arg1, 0x2::tx_context::sender(arg14)), 12);
        assert!(arg7 + arg8 + arg9 == 10000, 11);
        assert!(arg10 <= 10000, 17);
        assert!(arg6 <= 10000, 17);
        assert!(!arg2.is_finalized && !arg2.is_cancelled, 2);
        assert!(0x2::clock::timestamp_ms(arg13) < arg2.end_time, 2);
        let v0 = 0x1::option::none<u64>();
        if (0x1::option::is_some<u64>(&arg2.open_buy_at)) {
            v0 = arg2.open_buy_at;
        };
        let v1 = 0x1::option::none<u64>();
        if (0x1::option::is_some<u64>(&arg2.open_sell_at)) {
            v1 = arg2.open_sell_at;
        };
        arg2.max_coins_per_participant = arg3;
        arg2.mid_battle_registration_enabled = arg4;
        arg2.participation_fee = arg5;
        arg2.br_fee_bps = arg6;
        arg2.first_place_bps = arg7;
        arg2.second_place_bps = arg8;
        arg2.third_place_bps = arg9;
        arg2.platform_fee_bps = arg10;
        arg2.open_buy_at = arg11;
        arg2.open_sell_at = arg12;
        let v2 = BattleRoyaleUpdatedEvent{
            br_address                          : 0x2::object::uid_to_address(&arg2.id),
            admin                               : 0x2::tx_context::sender(arg14),
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
            old_open_buy_at                     : v0,
            new_open_buy_at                     : arg11,
            old_open_sell_at                    : v1,
            new_open_sell_at                    : arg12,
        };
        0x2::event::emit<BattleRoyaleUpdatedEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

