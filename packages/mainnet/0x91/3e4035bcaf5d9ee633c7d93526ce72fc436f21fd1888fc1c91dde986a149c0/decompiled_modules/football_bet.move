module 0x6b87562d476c6df385cc76d01116daec64b418a3422fe0c7f413a4ba6bf27c5f::football_bet {
    struct Match has key {
        id: 0x2::object::UID,
        admin: address,
        league_code: vector<u8>,
        season_code: vector<u8>,
        match_time: u64,
        home_team_code: vector<u8>,
        away_team_code: vector<u8>,
        status: u8,
        home_favored: bool,
        handicap_x2: u64,
        home_pool_total: u64,
        away_pool_total: u64,
        locked_home_pool_total: u64,
        locked_away_pool_total: u64,
        payout_pool: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        outcome: u8,
        home_score: u64,
        away_score: u64,
    }

    struct AdminList has key {
        id: 0x2::object::UID,
        owner: address,
        admins: vector<address>,
        treasury: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
    }

    struct Bet has store, key {
        id: 0x2::object::UID,
        match_id: 0x2::object::ID,
        bettor: address,
        side: u8,
        amount: u64,
    }

    struct MatchCreated has copy, drop {
        match_id: 0x2::object::ID,
        admin: address,
        match_time: u64,
        home_favored: bool,
        handicap_x2: u64,
    }

    struct MatchUpdated has copy, drop {
        match_id: 0x2::object::ID,
        admin: address,
        match_time: u64,
        home_favored: bool,
        handicap_x2: u64,
    }

    struct BetPlaced has copy, drop {
        match_id: 0x2::object::ID,
        bet_id: 0x2::object::ID,
        bettor: address,
        side: u8,
        amount: u64,
        home_pool_total: u64,
        away_pool_total: u64,
    }

    struct MatchClosed has copy, drop {
        match_id: 0x2::object::ID,
        locked_home_pool_total: u64,
        locked_away_pool_total: u64,
    }

    struct MatchSettled has copy, drop {
        match_id: 0x2::object::ID,
        home_score: u64,
        away_score: u64,
        outcome: u8,
    }

    struct MatchCancelled has copy, drop {
        match_id: 0x2::object::ID,
        admin: address,
    }

    struct OddsUpdated has copy, drop {
        match_id: 0x2::object::ID,
        home_pool_total: u64,
        away_pool_total: u64,
        home_odds_x1e4: u64,
        away_odds_x1e4: u64,
        locked: bool,
    }

    struct AdminAdded has copy, drop {
        admin_list_id: 0x2::object::ID,
        admin: address,
    }

    struct AdminListCreated has copy, drop {
        admin_list_id: 0x2::object::ID,
        owner: address,
    }

    struct AdminRemoved has copy, drop {
        admin_list_id: 0x2::object::ID,
        admin: address,
    }

    struct FeeWithdrawn has copy, drop {
        admin_list_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct BetClaimed has copy, drop {
        match_id: 0x2::object::ID,
        bet_id: 0x2::object::ID,
        bettor: address,
        payout: u64,
    }

    public fun add_admin(arg0: &mut AdminList, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 7);
        assert!(!0x1::vector::contains<address>(&arg0.admins, &arg1), 8);
        0x1::vector::push_back<address>(&mut arg0.admins, arg1);
        let v0 = AdminAdded{
            admin_list_id : 0x2::object::id<AdminList>(arg0),
            admin         : arg1,
        };
        0x2::event::emit<AdminAdded>(v0);
    }

    fun calc_fee(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 10000
    }

    public fun cancel_match(arg0: &AdminList, arg1: &mut Match, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admins, &v0), 0);
        assert!(arg1.status == 0, 1);
        arg1.status = 1;
        arg1.locked_home_pool_total = arg1.home_pool_total;
        arg1.locked_away_pool_total = arg1.away_pool_total;
        arg1.outcome = 2;
        let v1 = MatchCancelled{
            match_id : 0x2::object::id<Match>(arg1),
            admin    : v0,
        };
        0x2::event::emit<MatchCancelled>(v1);
    }

    public fun claim(arg0: Bet, arg1: &mut Match, arg2: &mut AdminList, arg3: &mut 0x2::tx_context::TxContext) {
        let Bet {
            id       : v0,
            match_id : v1,
            bettor   : v2,
            side     : v3,
            amount   : v4,
        } = arg0;
        let v5 = v0;
        assert!(arg1.status == 2, 3);
        assert!(v1 == 0x2::object::id<Match>(arg1), 6);
        let v6 = win_result_units(arg1, 0);
        let v7 = push_result_units(arg1);
        let v8 = win_result_units(arg1, 1);
        let v9 = push_result_units(arg1);
        let v10 = mul_div_floor(arg1.locked_home_pool_total, v6, 2) + mul_div_floor(arg1.locked_away_pool_total, v8, 2);
        let v11 = if (v10 == 0) {
            v4
        } else {
            let v12 = if (v3 == 0) {
                v6
            } else {
                v8
            };
            let v13 = if (v3 == 0) {
                v7
            } else {
                v9
            };
            let v14 = mul_div_floor(v4, v12, 2);
            let v15 = if (v14 == 0) {
                0
            } else {
                v14 * (arg1.locked_home_pool_total + arg1.locked_away_pool_total - mul_div_floor(arg1.locked_home_pool_total, v7, 2) + mul_div_floor(arg1.locked_away_pool_total, v9, 2)) / v10
            };
            mul_div_floor(v4, v13, 2) + v15
        };
        if (v11 > 0) {
            assert!(100 <= 10000, 10);
            let v16 = calc_fee(v11, 100);
            if (v16 > 0) {
                0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg2.treasury, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.payout_pool, v16));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.payout_pool, v11 - v16), arg3), v2);
        };
        let v17 = BetClaimed{
            match_id : v1,
            bet_id   : 0x2::object::uid_to_inner(&v5),
            bettor   : v2,
            payout   : v11,
        };
        0x2::event::emit<BetClaimed>(v17);
        0x2::object::delete(v5);
    }

    public fun close_match(arg0: &AdminList, arg1: &mut Match, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admins, &v0), 0);
        assert!(arg1.status == 0, 1);
        arg1.status = 1;
        arg1.locked_home_pool_total = arg1.home_pool_total;
        arg1.locked_away_pool_total = arg1.away_pool_total;
        let v1 = MatchClosed{
            match_id               : 0x2::object::id<Match>(arg1),
            locked_home_pool_total : arg1.locked_home_pool_total,
            locked_away_pool_total : arg1.locked_away_pool_total,
        };
        0x2::event::emit<MatchClosed>(v1);
        let v2 = OddsUpdated{
            match_id        : 0x2::object::id<Match>(arg1),
            home_pool_total : arg1.locked_home_pool_total,
            away_pool_total : arg1.locked_away_pool_total,
            home_odds_x1e4  : implied_odds_x1e4(arg1, 0),
            away_odds_x1e4  : implied_odds_x1e4(arg1, 1),
            locked          : true,
        };
        0x2::event::emit<OddsUpdated>(v2);
    }

    public fun create_admin_list(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminList{
            id       : 0x2::object::new(arg0),
            owner    : v0,
            admins   : 0x1::vector::empty<address>(),
            treasury : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
        };
        0x1::vector::push_back<address>(&mut v1.admins, v0);
        let v2 = AdminListCreated{
            admin_list_id : 0x2::object::id<AdminList>(&v1),
            owner         : v0,
        };
        0x2::event::emit<AdminListCreated>(v2);
        0x2::transfer::share_object<AdminList>(v1);
    }

    public fun create_match(arg0: &AdminList, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: bool, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x1::vector::contains<address>(&arg0.admins, &v0), 0);
        let v1 = Match{
            id                     : 0x2::object::new(arg8),
            admin                  : v0,
            league_code            : arg1,
            season_code            : arg2,
            match_time             : arg3,
            home_team_code         : arg4,
            away_team_code         : arg5,
            status                 : 0,
            home_favored           : arg6,
            handicap_x2            : arg7,
            home_pool_total        : 0,
            away_pool_total        : 0,
            locked_home_pool_total : 0,
            locked_away_pool_total : 0,
            payout_pool            : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            outcome                : 3,
            home_score             : 0,
            away_score             : 0,
        };
        let v2 = MatchCreated{
            match_id     : 0x2::object::id<Match>(&v1),
            admin        : v0,
            match_time   : arg3,
            home_favored : arg6,
            handicap_x2  : arg7,
        };
        0x2::event::emit<MatchCreated>(v2);
        0x2::transfer::share_object<Match>(v1);
    }

    public fun fee_bps() : (u64, u64) {
        (100, 100)
    }

    public fun implied_odds_x1e4(arg0: &Match, arg1: u8) : u64 {
        assert!(arg1 == 0 || arg1 == 1, 4);
        let v0 = if (arg0.status == 0) {
            arg0.home_pool_total
        } else {
            arg0.locked_home_pool_total
        };
        let v1 = if (arg0.status == 0) {
            arg0.away_pool_total
        } else {
            arg0.locked_away_pool_total
        };
        let v2 = if (arg1 == 0) {
            v0
        } else {
            v1
        };
        if (v2 == 0) {
            0
        } else {
            (v0 + v1) * 10000 / v2
        }
    }

    public fun is_admin(arg0: &AdminList, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.admins, &arg1)
    }

    public fun match_state(arg0: &Match) : (u8, u64, bool, u64, u64, u64, u64, u64, u8, u64, u64) {
        (arg0.status, arg0.match_time, arg0.home_favored, arg0.handicap_x2, arg0.home_pool_total, arg0.away_pool_total, arg0.locked_home_pool_total, arg0.locked_away_pool_total, arg0.outcome, arg0.home_score, arg0.away_score)
    }

    fun mul_div_floor(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 * arg1 / arg2
    }

    public fun place_bet(arg0: &mut AdminList, arg1: &mut Match, arg2: u8, arg3: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &mut 0x2::tx_context::TxContext) : Bet {
        assert!(arg1.status == 0, 1);
        assert!(arg2 == 0 || arg2 == 1, 4);
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3);
        assert!(v0 > 0, 5);
        assert!(100 <= 10000, 10);
        let v1 = calc_fee(v0, 100);
        if (v1 > 0) {
            0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.treasury, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg3, v1, arg4)));
        };
        let v2 = v0 - v1;
        if (arg2 == 0) {
            arg1.home_pool_total = arg1.home_pool_total + v2;
        } else {
            arg1.away_pool_total = arg1.away_pool_total + v2;
        };
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.payout_pool, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3));
        let v3 = Bet{
            id       : 0x2::object::new(arg4),
            match_id : 0x2::object::id<Match>(arg1),
            bettor   : 0x2::tx_context::sender(arg4),
            side     : arg2,
            amount   : v2,
        };
        let v4 = BetPlaced{
            match_id        : v3.match_id,
            bet_id          : 0x2::object::id<Bet>(&v3),
            bettor          : v3.bettor,
            side            : v3.side,
            amount          : v3.amount,
            home_pool_total : arg1.home_pool_total,
            away_pool_total : arg1.away_pool_total,
        };
        0x2::event::emit<BetPlaced>(v4);
        let v5 = OddsUpdated{
            match_id        : v3.match_id,
            home_pool_total : arg1.home_pool_total,
            away_pool_total : arg1.away_pool_total,
            home_odds_x1e4  : implied_odds_x1e4(arg1, 0),
            away_odds_x1e4  : implied_odds_x1e4(arg1, 1),
            locked          : false,
        };
        0x2::event::emit<OddsUpdated>(v5);
        v3
    }

    fun push_result_units(arg0: &Match) : u64 {
        let (v0, v1) = score_lhs_rhs_x4_for_settlement(arg0.home_score, arg0.away_score, arg0.home_favored, arg0.handicap_x2);
        if (v0 == v1) {
            2
        } else if (v0 > v1) {
            if (v0 - v1 == 1) {
                1
            } else {
                0
            }
        } else if (v1 - v0 == 1) {
            1
        } else {
            0
        }
    }

    public fun remove_admin(arg0: &mut AdminList, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 7);
        assert!(0x1::vector::contains<address>(&arg0.admins, &arg1), 9);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.admins)) {
            if (*0x1::vector::borrow<address>(&arg0.admins, v0) == arg1) {
                0x1::vector::swap_remove<address>(&mut arg0.admins, v0);
                let v1 = AdminRemoved{
                    admin_list_id : 0x2::object::id<AdminList>(arg0),
                    admin         : arg1,
                };
                0x2::event::emit<AdminRemoved>(v1);
                break
            };
            v0 = v0 + 1;
        };
    }

    fun score_lhs_rhs_x4_for_settlement(arg0: u64, arg1: u64, arg2: bool, arg3: u64) : (u64, u64) {
        if (arg2) {
            (arg0 * 4, arg1 * 4 + arg3)
        } else {
            (arg0 * 4 + arg3, arg1 * 4)
        }
    }

    public fun settle_match(arg0: &AdminList, arg1: &mut Match, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x1::vector::contains<address>(&arg0.admins, &v0), 0);
        assert!(arg1.status == 1, 2);
        let (v1, v2) = score_lhs_rhs_x4_for_settlement(arg2, arg3, arg1.home_favored, arg1.handicap_x2);
        let v3 = if (v1 > v2) {
            0
        } else if (v1 < v2) {
            1
        } else {
            2
        };
        arg1.status = 2;
        arg1.outcome = v3;
        arg1.home_score = arg2;
        arg1.away_score = arg3;
        let v4 = MatchSettled{
            match_id   : 0x2::object::id<Match>(arg1),
            home_score : arg2,
            away_score : arg3,
            outcome    : v3,
        };
        0x2::event::emit<MatchSettled>(v4);
    }

    public fun update_match(arg0: &AdminList, arg1: &mut Match, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: bool, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x1::vector::contains<address>(&arg0.admins, &v0), 0);
        assert!(arg1.status == 0, 1);
        arg1.league_code = arg2;
        arg1.season_code = arg3;
        arg1.match_time = arg4;
        arg1.home_team_code = arg5;
        arg1.away_team_code = arg6;
        arg1.home_favored = arg7;
        arg1.handicap_x2 = arg8;
        let v1 = MatchUpdated{
            match_id     : 0x2::object::id<Match>(arg1),
            admin        : v0,
            match_time   : arg4,
            home_favored : arg7,
            handicap_x2  : arg8,
        };
        0x2::event::emit<MatchUpdated>(v1);
    }

    fun win_result_units(arg0: &Match, arg1: u8) : u64 {
        let (v0, v1) = score_lhs_rhs_x4_for_settlement(arg0.home_score, arg0.away_score, arg0.home_favored, arg0.handicap_x2);
        if (arg1 == 0) {
            if (v0 > v1) {
                if (v0 - v1 >= 2) {
                    2
                } else {
                    1
                }
            } else {
                0
            }
        } else if (v1 > v0) {
            if (v1 - v0 >= 2) {
                2
            } else {
                1
            }
        } else {
            0
        }
    }

    public fun withdraw_fees(arg0: &mut AdminList, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.treasury, arg1), arg2), arg0.owner);
        let v0 = FeeWithdrawn{
            admin_list_id : 0x2::object::id<AdminList>(arg0),
            owner         : arg0.owner,
            amount        : arg1,
        };
        0x2::event::emit<FeeWithdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

