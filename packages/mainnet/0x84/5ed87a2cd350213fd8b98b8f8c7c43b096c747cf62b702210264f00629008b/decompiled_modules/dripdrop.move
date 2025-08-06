module 0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::dripdrop {
    struct DripDrop<phantom T0> has key {
        id: 0x2::object::UID,
        games: 0x2::object_table::ObjectTable<address, Game<T0>>,
        player_statistics: 0x2::object_table::ObjectTable<address, PlayerStatistics<T0>>,
        fees: 0x2::balance::Balance<T0>,
        percentage_fee: u64,
        minimum_bet: u64,
        escrow: 0x2::balance::Balance<T0>,
        won: 0x2::balance::Balance<T0>,
        claimable_winnings: 0x2::table::Table<address, u64>,
    }

    struct Game<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        creator_commitment: vector<u8>,
        creator_choice: u8,
        bet_amount: u64,
        second_player: 0x1::option::Option<address>,
        created_at: u64,
        joined_at: 0x1::option::Option<u64>,
        winner: 0x1::option::Option<address>,
    }

    struct PlayerStatistics<phantom T0> has store, key {
        id: 0x2::object::UID,
        player: address,
        games_as_creator: u64,
        games_as_joiner: u64,
        games_lost: u64,
        games_won: u64,
        total_lost: u64,
        total_won: u64,
        current_win_streak: u64,
        best_win_streak: u64,
        last_updated_at: u64,
    }

    struct GameCreatedEvent<phantom T0> has copy, drop {
        game_id: address,
        creator: address,
        bet_amount: u64,
        creator_choice: u8,
        created_at: u64,
        num_games: u64,
    }

    struct GameCancelledEvent<phantom T0> has copy, drop {
        game_id: address,
        creator: address,
        refund_amount: u64,
        cancelled_at: u64,
    }

    struct GameResolvedEvent<phantom T0> has copy, drop {
        game_id: address,
        creator: address,
        second_player: address,
        result: u8,
        winner: address,
        total_played: u64,
        fees_collected: u64,
        nft_earnings: u64,
        resolved_at: u64,
    }

    struct WinningsClaimedEvent<phantom T0> has copy, drop {
        player: address,
        amount: u64,
        claimed_at: u64,
    }

    struct FeesClaimedEvent<phantom T0> has copy, drop {
        total_fees: u64,
        distributed_fees: u64,
        remaining_fees: u64,
        claimed_at: u64,
    }

    struct MinimumBetUpdatedEvent<phantom T0> has copy, drop {
        old_amount: u64,
        new_amount: u64,
        updated_at: u64,
    }

    struct PercentageFeeUpdatedEvent<phantom T0> has copy, drop {
        old_percentage: u64,
        new_percentage: u64,
        updated_at: u64,
    }

    struct PlayerStatisticsResetEvent<phantom T0> has copy, drop {
        player: address,
        reset_at: u64,
    }

    struct DRIPDROP has drop {
        dummy_field: bool,
    }

    public(friend) entry fun cancel_game<T0>(arg0: &0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::state::State, arg1: &mut DripDrop<T0>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::state::assert_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::object_table::contains<address, Game<T0>>(&arg1.games, arg2), 5);
        let v1 = 0x2::object_table::remove<address, Game<T0>>(&mut arg1.games, arg2);
        assert!(0x1::option::is_none<address>(&v1.winner), 0);
        assert!(v0 == v1.creator, 1);
        let v2 = GameCancelledEvent<T0>{
            game_id       : arg2,
            creator       : v1.creator,
            refund_amount : v1.bet_amount,
            cancelled_at  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<GameCancelledEvent<T0>>(v2);
        let Game {
            id                 : v3,
            creator            : _,
            creator_commitment : _,
            creator_choice     : _,
            bet_amount         : _,
            second_player      : _,
            created_at         : _,
            joined_at          : _,
            winner             : _,
        } = v1;
        0x2::object::delete(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.escrow, v1.bet_amount), arg4), v0);
    }

    public(friend) entry fun claim_fees<T0>(arg0: &0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::state::State, arg1: &mut DripDrop<T0>, arg2: &0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::earners::Earners, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::state::assert_not_paused(arg0);
        let v0 = 0x2::balance::value<T0>(&arg1.fees);
        if (v0 > 0) {
            let v1 = 0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::earners::distribute_fees<T0>(arg2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.fees, v0), arg4), arg3, arg4);
            let v2 = 0x2::coin::value<T0>(&v1);
            let v3 = FeesClaimedEvent<T0>{
                total_fees       : v0,
                distributed_fees : v0 - v2,
                remaining_fees   : v2,
                claimed_at       : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<FeesClaimedEvent<T0>>(v3);
            if (v2 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg4));
            } else {
                0x2::coin::destroy_zero<T0>(v1);
            };
        };
    }

    public(friend) entry fun claim_winnings<T0>(arg0: &0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::state::State, arg1: &mut DripDrop<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::state::assert_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, u64>(&arg1.claimable_winnings, v0), 7);
        let v1 = 0x2::table::remove<address, u64>(&mut arg1.claimable_winnings, v0);
        assert!(v1 > 0, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.won, v1), arg3), v0);
        let v2 = WinningsClaimedEvent<T0>{
            player     : v0,
            amount     : v1,
            claimed_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<WinningsClaimedEvent<T0>>(v2);
    }

    public(friend) entry fun create_games<T0>(arg0: &0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::state::State, arg1: &0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::tokens::TokenRegistry, arg2: &mut DripDrop<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u8, arg7: u64, arg8: 0x2::coin::Coin<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::state::assert_not_paused(arg0);
        assert!(arg7 > 0 && arg7 <= 100, 6);
        assert!(arg6 <= 1, 3);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::tokens::is_token_whitelisted(arg1, &v0), 8);
        let v1 = x"000c087edbdb4b4b17708fd5acbec22083e8758a36ac953cab4b0d28b72dbd28";
        assert!(0x2::ecvrf::ecvrf_verify(&arg4, &arg3, &v1, &arg5), 2);
        let v2 = 0x2::coin::value<T0>(&arg8) / arg7;
        assert!(v2 >= arg2.minimum_bet, 4);
        let v3 = 0x2::tx_context::sender(arg10);
        let v4 = 0x2::clock::timestamp_ms(arg9);
        let v5 = 0x2::coin::into_balance<T0>(arg8);
        let v6 = 0;
        while (v6 < arg7) {
            let v7 = if (v6 == arg7 - 1) {
                0x2::balance::value<T0>(&v5)
            } else {
                v2
            };
            assert!(v7 > 0, 4);
            let v8 = 0x2::object::new(arg10);
            let v9 = 0x2::object::uid_to_address(&v8);
            let v10 = GameCreatedEvent<T0>{
                game_id        : v9,
                creator        : v3,
                bet_amount     : v7,
                creator_choice : arg6,
                created_at     : v4,
                num_games      : arg7,
            };
            0x2::event::emit<GameCreatedEvent<T0>>(v10);
            let v11 = Game<T0>{
                id                 : v8,
                creator            : v3,
                creator_commitment : arg4,
                creator_choice     : arg6,
                bet_amount         : v7,
                second_player      : 0x1::option::none<address>(),
                created_at         : v4,
                joined_at          : 0x1::option::none<u64>(),
                winner             : 0x1::option::none<address>(),
            };
            0x2::object_table::add<address, Game<T0>>(&mut arg2.games, v9, v11);
            0x2::balance::join<T0>(&mut arg2.escrow, 0x2::balance::split<T0>(&mut v5, v7));
            v6 = v6 + 1;
        };
        0x2::balance::destroy_zero<T0>(v5);
    }

    public(friend) fun game_exists<T0>(arg0: &DripDrop<T0>, arg1: address) : bool {
        0x2::object_table::contains<address, Game<T0>>(&arg0.games, arg1)
    }

    public(friend) fun get_bet_amount<T0>(arg0: &Game<T0>) : u64 {
        arg0.bet_amount
    }

    public(friend) fun get_claimable_winnings<T0>(arg0: &DripDrop<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.claimable_winnings, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.claimable_winnings, arg1)
        } else {
            0
        }
    }

    public(friend) fun get_created_at<T0>(arg0: &Game<T0>) : u64 {
        arg0.created_at
    }

    public(friend) fun get_creator<T0>(arg0: &Game<T0>) : address {
        arg0.creator
    }

    public(friend) fun get_creator_choice<T0>(arg0: &Game<T0>) : u8 {
        arg0.creator_choice
    }

    public(friend) fun get_creator_commitment<T0>(arg0: &Game<T0>) : &vector<u8> {
        &arg0.creator_commitment
    }

    public(friend) fun get_fees_amount<T0>(arg0: &DripDrop<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.fees)
    }

    public(friend) fun get_game<T0>(arg0: &DripDrop<T0>, arg1: address) : &Game<T0> {
        0x2::object_table::borrow<address, Game<T0>>(&arg0.games, arg1)
    }

    public(friend) fun get_joined_at<T0>(arg0: &Game<T0>) : 0x1::option::Option<u64> {
        arg0.joined_at
    }

    public(friend) fun get_minimum_bet<T0>(arg0: &DripDrop<T0>) : u64 {
        arg0.minimum_bet
    }

    public(friend) fun get_percentage_fee<T0>(arg0: &DripDrop<T0>) : u64 {
        arg0.percentage_fee
    }

    public(friend) fun get_player_best_win_streak<T0>(arg0: &DripDrop<T0>, arg1: address) : u64 {
        if (has_player_stats<T0>(arg0, arg1)) {
            get_player_stats<T0>(arg0, arg1).best_win_streak
        } else {
            0
        }
    }

    public(friend) fun get_player_current_win_streak<T0>(arg0: &DripDrop<T0>, arg1: address) : u64 {
        if (has_player_stats<T0>(arg0, arg1)) {
            get_player_stats<T0>(arg0, arg1).current_win_streak
        } else {
            0
        }
    }

    public(friend) fun get_player_games_as_creator<T0>(arg0: &DripDrop<T0>, arg1: address) : u64 {
        if (has_player_stats<T0>(arg0, arg1)) {
            get_player_stats<T0>(arg0, arg1).games_as_creator
        } else {
            0
        }
    }

    public(friend) fun get_player_games_as_joiner<T0>(arg0: &DripDrop<T0>, arg1: address) : u64 {
        if (has_player_stats<T0>(arg0, arg1)) {
            get_player_stats<T0>(arg0, arg1).games_as_joiner
        } else {
            0
        }
    }

    public(friend) fun get_player_games_lost<T0>(arg0: &DripDrop<T0>, arg1: address) : u64 {
        if (has_player_stats<T0>(arg0, arg1)) {
            get_player_stats<T0>(arg0, arg1).games_lost
        } else {
            0
        }
    }

    public(friend) fun get_player_games_won<T0>(arg0: &DripDrop<T0>, arg1: address) : u64 {
        if (has_player_stats<T0>(arg0, arg1)) {
            get_player_stats<T0>(arg0, arg1).games_won
        } else {
            0
        }
    }

    public(friend) fun get_player_stats<T0>(arg0: &DripDrop<T0>, arg1: address) : &PlayerStatistics<T0> {
        0x2::object_table::borrow<address, PlayerStatistics<T0>>(&arg0.player_statistics, arg1)
    }

    public(friend) fun get_player_stats_mut<T0>(arg0: &mut DripDrop<T0>, arg1: address) : &mut PlayerStatistics<T0> {
        0x2::object_table::borrow_mut<address, PlayerStatistics<T0>>(&mut arg0.player_statistics, arg1)
    }

    public(friend) fun get_player_total_lost<T0>(arg0: &DripDrop<T0>, arg1: address) : u64 {
        if (has_player_stats<T0>(arg0, arg1)) {
            get_player_stats<T0>(arg0, arg1).total_lost
        } else {
            0
        }
    }

    public(friend) fun get_player_total_won<T0>(arg0: &DripDrop<T0>, arg1: address) : u64 {
        if (has_player_stats<T0>(arg0, arg1)) {
            get_player_stats<T0>(arg0, arg1).total_won
        } else {
            0
        }
    }

    public(friend) fun get_second_player<T0>(arg0: &Game<T0>) : 0x1::option::Option<address> {
        arg0.second_player
    }

    public(friend) fun get_winner<T0>(arg0: &Game<T0>) : 0x1::option::Option<address> {
        arg0.winner
    }

    public(friend) fun has_claimable_winnings<T0>(arg0: &DripDrop<T0>, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.claimable_winnings, arg1) && *0x2::table::borrow<address, u64>(&arg0.claimable_winnings, arg1) > 0
    }

    public(friend) fun has_player_stats<T0>(arg0: &DripDrop<T0>, arg1: address) : bool {
        0x2::object_table::contains<address, PlayerStatistics<T0>>(&arg0.player_statistics, arg1)
    }

    fun init(arg0: DRIPDROP, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<DRIPDROP>(&arg0), 9);
        let v0 = DripDrop<0x2::sui::SUI>{
            id                 : 0x2::object::new(arg1),
            games              : 0x2::object_table::new<address, Game<0x2::sui::SUI>>(arg1),
            player_statistics  : 0x2::object_table::new<address, PlayerStatistics<0x2::sui::SUI>>(arg1),
            fees               : 0x2::balance::zero<0x2::sui::SUI>(),
            percentage_fee     : 500,
            minimum_bet        : 100000000,
            escrow             : 0x2::balance::zero<0x2::sui::SUI>(),
            won                : 0x2::balance::zero<0x2::sui::SUI>(),
            claimable_winnings : 0x2::table::new<address, u64>(arg1),
        };
        0x2::transfer::share_object<DripDrop<0x2::sui::SUI>>(v0);
    }

    public(friend) entry fun initialize_dripdrop<T0>(arg0: &0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::Admins, arg1: &mut 0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::tokens::TokenRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = DripDrop<T0>{
            id                 : 0x2::object::new(arg6),
            games              : 0x2::object_table::new<address, Game<T0>>(arg6),
            player_statistics  : 0x2::object_table::new<address, PlayerStatistics<T0>>(arg6),
            fees               : 0x2::balance::zero<T0>(),
            percentage_fee     : arg2,
            minimum_bet        : arg3,
            escrow             : 0x2::balance::zero<T0>(),
            won                : 0x2::balance::zero<T0>(),
            claimable_winnings : 0x2::table::new<address, u64>(arg6),
        };
        0x2::transfer::share_object<DripDrop<T0>>(v0);
        0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::tokens::whitelist_token<T0>(arg0, arg1, arg5, arg6);
        0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::nft_earnings::initialize_nft_earnings<T0>(arg0, arg4, arg6);
    }

    public(friend) fun is_resolved<T0>(arg0: &Game<T0>) : bool {
        0x1::option::is_some<address>(&arg0.winner)
    }

    public(friend) entry fun join_game<T0>(arg0: &0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::Owner, arg1: &0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::state::State, arg2: &mut DripDrop<T0>, arg3: &mut 0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::nft_earnings::NftEarnings<T0>, arg4: address, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: 0x2::coin::Coin<T0>, arg9: &0x2::random::Random, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::state::assert_not_paused(arg1);
        let v0 = 0x2::tx_context::sender(arg11);
        assert!(0x2::object_table::contains<address, Game<T0>>(&arg2.games, arg4), 10);
        let v1 = 0x2::object_table::borrow_mut<address, Game<T0>>(&mut arg2.games, arg4);
        assert!(0x1::option::is_none<address>(&v1.second_player), 1);
        assert!(0x1::option::is_none<address>(&v1.winner), 0);
        assert!(v0 != v1.creator, 1);
        let v2 = 0x2::coin::value<T0>(&arg8);
        assert!(v2 == v1.bet_amount, 4);
        let v3 = x"000c087edbdb4b4b17708fd5acbec22083e8758a36ac953cab4b0d28b72dbd28";
        assert!(0x2::ecvrf::ecvrf_verify(&arg6, &arg5, &v3, &arg7), 2);
        v1.second_player = 0x1::option::some<address>(v0);
        v1.joined_at = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg10));
        let v4 = 0x2::random::new_generator(arg9, arg11);
        let v5 = (*0x1::vector::borrow<u8>(&v1.creator_commitment, 0x2::random::generate_u64(&mut v4) % 0x1::vector::length<u8>(&v1.creator_commitment)) ^ *0x1::vector::borrow<u8>(&arg6, 0x2::random::generate_u64(&mut v4) % 0x1::vector::length<u8>(&arg6))) % 2;
        let (v6, v7) = if (v5 == v1.creator_choice) {
            (v1.creator, v0)
        } else {
            (v0, v1.creator)
        };
        v1.winner = 0x1::option::some<address>(v6);
        let v8 = v2 * arg2.percentage_fee / 10000;
        let v9 = v1.bet_amount * arg2.percentage_fee / 10000;
        let v10 = v1.bet_amount - v9;
        let v11 = 0x2::coin::split<T0>(&mut arg8, v8, arg11);
        let v12 = 0x2::balance::split<T0>(&mut arg2.escrow, v9);
        let v13 = 0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::nft_earnings::get_total_percentage<T0>(arg3);
        let v14 = v8 * v13 / 10000;
        let v15 = v9 * v13 / 10000;
        if (v14 + v15 > 0) {
            let v16 = 0x2::coin::split<T0>(&mut v11, v14, arg11);
            0x2::coin::join<T0>(&mut v16, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v12, v15), arg11));
            0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::nft_earnings::add_earnings<T0>(arg3, arg0, v16, arg10, arg11);
        };
        0x2::balance::join<T0>(&mut arg2.fees, 0x2::coin::into_balance<T0>(v11));
        0x2::balance::join<T0>(&mut arg2.fees, v12);
        0x2::coin::join<T0>(&mut arg8, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.escrow, v10), arg11));
        0x2::balance::join<T0>(&mut arg2.won, 0x2::coin::into_balance<T0>(arg8));
        if (0x2::table::contains<address, u64>(&arg2.claimable_winnings, v6)) {
            0x2::table::add<address, u64>(&mut arg2.claimable_winnings, v6, 0x2::table::remove<address, u64>(&mut arg2.claimable_winnings, v6) + 0x2::coin::value<T0>(&arg8));
        } else {
            0x2::table::add<address, u64>(&mut arg2.claimable_winnings, v6, 0x2::coin::value<T0>(&arg8));
        };
        let v17 = 0x2::clock::timestamp_ms(arg10);
        if (!0x2::object_table::contains<address, PlayerStatistics<T0>>(&arg2.player_statistics, v6)) {
            let v18 = PlayerStatistics<T0>{
                id                 : 0x2::object::new(arg11),
                player             : v6,
                games_as_creator   : 0,
                games_as_joiner    : 0,
                games_lost         : 0,
                games_won          : 0,
                total_lost         : 0,
                total_won          : 0,
                current_win_streak : 0,
                best_win_streak    : 0,
                last_updated_at    : 0,
            };
            0x2::object_table::add<address, PlayerStatistics<T0>>(&mut arg2.player_statistics, v6, v18);
        };
        let v19 = 0x2::object_table::borrow_mut<address, PlayerStatistics<T0>>(&mut arg2.player_statistics, v6);
        if (v6 == v1.creator) {
            v19.games_as_creator = v19.games_as_creator + 1;
        } else {
            v19.games_as_joiner = v19.games_as_joiner + 1;
        };
        v19.games_won = v19.games_won + 1;
        v19.total_won = v19.total_won + v10 - v8;
        v19.current_win_streak = v19.current_win_streak + 1;
        if (v19.current_win_streak > v19.best_win_streak) {
            v19.best_win_streak = v19.current_win_streak;
        };
        v19.last_updated_at = v17;
        if (!0x2::object_table::contains<address, PlayerStatistics<T0>>(&arg2.player_statistics, v7)) {
            let v20 = PlayerStatistics<T0>{
                id                 : 0x2::object::new(arg11),
                player             : v7,
                games_as_creator   : 0,
                games_as_joiner    : 0,
                games_lost         : 0,
                games_won          : 0,
                total_lost         : 0,
                total_won          : 0,
                current_win_streak : 0,
                best_win_streak    : 0,
                last_updated_at    : 0,
            };
            0x2::object_table::add<address, PlayerStatistics<T0>>(&mut arg2.player_statistics, v7, v20);
        };
        let v21 = 0x2::object_table::borrow_mut<address, PlayerStatistics<T0>>(&mut arg2.player_statistics, v7);
        if (v7 == v1.creator) {
            v21.games_as_creator = v21.games_as_creator + 1;
        } else {
            v21.games_as_joiner = v21.games_as_joiner + 1;
        };
        v21.games_lost = v21.games_lost + 1;
        v21.total_lost = v21.total_lost + v2;
        v21.current_win_streak = 0;
        v21.last_updated_at = v17;
        let v22 = GameResolvedEvent<T0>{
            game_id        : arg4,
            creator        : v1.creator,
            second_player  : *0x1::option::borrow<address>(&v1.second_player),
            result         : v5,
            winner         : v6,
            total_played   : v2 + v10,
            fees_collected : v8 + v9,
            nft_earnings   : v14 + v15,
            resolved_at    : v17,
        };
        0x2::event::emit<GameResolvedEvent<T0>>(v22);
    }

    public(friend) entry fun reset_player_statistics<T0>(arg0: &0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::Owner, arg1: &mut DripDrop<T0>, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::assert_is_owner(arg0, 0x2::tx_context::sender(arg4));
        if (0x2::object_table::contains<address, PlayerStatistics<T0>>(&arg1.player_statistics, arg2)) {
            let PlayerStatistics {
                id                 : v0,
                player             : _,
                games_as_creator   : _,
                games_as_joiner    : _,
                games_lost         : _,
                games_won          : _,
                total_lost         : _,
                total_won          : _,
                current_win_streak : _,
                best_win_streak    : _,
                last_updated_at    : _,
            } = 0x2::object_table::remove<address, PlayerStatistics<T0>>(&mut arg1.player_statistics, arg2);
            0x2::object::delete(v0);
        };
        let v11 = PlayerStatisticsResetEvent<T0>{
            player   : arg2,
            reset_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PlayerStatisticsResetEvent<T0>>(v11);
    }

    public(friend) entry fun set_minimum_bet<T0>(arg0: &mut DripDrop<T0>, arg1: &0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::Admins, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::assert_is_admin(arg1, 0x2::tx_context::sender(arg4));
        arg0.minimum_bet = arg2;
        let v0 = MinimumBetUpdatedEvent<T0>{
            old_amount : arg0.minimum_bet,
            new_amount : arg2,
            updated_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MinimumBetUpdatedEvent<T0>>(v0);
    }

    public(friend) entry fun set_percentage_fee<T0>(arg0: &mut DripDrop<T0>, arg1: &0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::Admins, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x20610d4d1f037809b5ea9fd9fd6102fe9a649eb6d0f16903d8b14d5dfc9769c4::admins::assert_is_admin(arg1, 0x2::tx_context::sender(arg4));
        assert!(arg2 <= 10000, 11);
        arg0.percentage_fee = arg2;
        let v0 = PercentageFeeUpdatedEvent<T0>{
            old_percentage : arg0.percentage_fee,
            new_percentage : arg2,
            updated_at     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PercentageFeeUpdatedEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

