module 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::random_vault {
    struct RANDOM_VAULT has drop {
        dummy_field: bool,
    }

    struct RandomVault has key {
        id: 0x2::object::UID,
        version: u64,
        config: 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::config::Config,
        current_round: u64,
        history_rounds: 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::TableQueue<Round>,
        fees: 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>,
        paused: bool,
    }

    struct Round has store {
        vault: 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>,
        users: 0x2::table::Table<address, UserInfo>,
        user_addresses: 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::TableQueue<address>,
        number: u64,
        start_time: u64,
        end_time: u64,
        prize_pot: u64,
        total_deposit: u64,
        winners: vector<Winner>,
        total_share: u128,
    }

    struct UserInfo has store {
        total_amount: u64,
        withdrawed_amount: u64,
        account: address,
        share: u128,
        last_deposit_time: u64,
    }

    struct Winner has copy, drop, store {
        account: address,
        hasui_amount: u64,
    }

    struct WinnerTicket has key {
        id: 0x2::object::UID,
        round: u64,
        rank: u64,
        amount: u64,
        expire_time: u64,
        claimed: bool,
    }

    struct UserDraw has copy, drop {
        account: address,
        share: u128,
    }

    struct VersionUpdated has copy, drop {
        old: u64,
        new: u64,
    }

    struct PrizeRecovered has copy, drop {
        from_round: u64,
        to_round: u64,
        amount: u64,
    }

    struct PrizeCollected has copy, drop {
        user: address,
        amount: u64,
    }

    struct UserDeposited has copy, drop {
        user: address,
        round: u64,
        ts: u64,
        sui_amount: u64,
        hasui_amount: u64,
    }

    struct UserWithdrawed has copy, drop {
        user: address,
        round: u64,
        ts: u64,
        sui_amount: u64,
        hasui_amount: u64,
        fee_amount: u64,
    }

    struct RoundCreated has copy, drop {
        number: u64,
        start_time: u64,
        end_time: u64,
    }

    struct RoundClosed has copy, drop {
        number: u64,
        start_time: u64,
        end_time: u64,
        prize_pot: u64,
        total_deposit: u64,
        winners: vector<Winner>,
        user_count: u64,
        left_prizes: u64,
        total_share: u128,
    }

    struct TicketClaimed has copy, drop {
        id: 0x2::object::ID,
        round: u64,
        rank: u64,
        user: address,
        amount: u64,
    }

    struct StateChanged has copy, drop {
        paused: bool,
    }

    public fun claim(arg0: &mut RandomVault, arg1: &0x2::clock::Clock, arg2: &mut WinnerTicket, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        assert_version(arg0);
        assert!(!arg0.paused, 2);
        assert!(!arg2.claimed, 7);
        assert!(arg2.expire_time >= 0x2::clock::timestamp_ms(arg1) / 1000, 8);
        arg2.claimed = true;
        let v0 = TicketClaimed{
            id     : 0x2::object::id<WinnerTicket>(arg2),
            round  : arg2.round,
            rank   : arg2.rank,
            user   : 0x2::tx_context::sender(arg3),
            amount : arg2.amount,
        };
        0x2::event::emit<TicketClaimed>(v0);
        0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0x2::balance::split<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow_mut<Round>(&mut arg0.history_rounds, arg2.round - 1).vault, arg2.amount), arg3)
    }

    fun add_round(arg0: &mut RandomVault, arg1: Round) {
        arg0.current_round = arg0.current_round + 1;
        arg1.number = arg0.current_round;
        let v0 = RoundCreated{
            number     : arg1.number,
            start_time : arg1.start_time,
            end_time   : arg1.end_time,
        };
        0x2::event::emit<RoundCreated>(v0);
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::push_back<Round>(&mut arg0.history_rounds, arg1);
    }

    public fun assert_version(arg0: &RandomVault) {
        assert!(arg0.version == 0, 0);
    }

    public(friend) fun clear_round_record(arg0: &mut RandomVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.paused, 2);
        while (0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::is_empty<Round>(&arg0.history_rounds)) {
            let v0 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow_mut<Round>(&mut arg0.history_rounds, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::head<Round>(&arg0.history_rounds));
            if (0x2::clock::timestamp_ms(arg1) / 1000 < v0.end_time + 5184000) {
                break
            };
            if (0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v0.vault) == 0) {
                destroy_round(0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::pop_front<Round>(&mut arg0.history_rounds));
            };
        };
    }

    public(friend) fun collect_expired_prize(arg0: &mut RandomVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.paused, 2);
        let v0 = 0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>();
        let v1 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::head<Round>(&arg0.history_rounds);
        while (v1 < 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::tail<Round>(&arg0.history_rounds)) {
            let v2 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow_mut<Round>(&mut arg0.history_rounds, v1);
            if (0x2::clock::timestamp_ms(arg1) / 1000 < v2.end_time + 5184000) {
                break
            };
            let v3 = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v2.vault);
            if (v3 > 0) {
                0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v0, 0x2::balance::split<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v2.vault, v3));
                let v4 = PrizeRecovered{
                    from_round : v2.number,
                    to_round   : arg0.current_round - 1,
                    amount     : v3,
                };
                0x2::event::emit<PrizeRecovered>(v4);
            };
            v1 = v1 + 1;
        };
        0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow_mut<Round>(&mut arg0.history_rounds, arg0.current_round - 1).vault, v0);
    }

    public(friend) fun collect_fee(arg0: &mut RandomVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        assert_version(arg0);
        let v0 = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg0.fees);
        if (arg1 == 0 || arg1 > v0) {
            arg1 = v0;
        };
        let v1 = PrizeCollected{
            user   : 0x2::tx_context::sender(arg2),
            amount : arg1,
        };
        0x2::event::emit<PrizeCollected>(v1);
        0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0x2::balance::split<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.fees, arg1), arg2)
    }

    public fun deposit(arg0: &mut RandomVault, arg1: &0x2::clock::Clock, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.paused, 2);
        let v0 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow_mut<Round>(&mut arg0.history_rounds, arg0.current_round - 1);
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v0.start_time <= v1 && v0.end_time > v1, 1);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        let v3 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_stake_coin(arg2, arg3, arg4, arg5, arg6);
        let v4 = 0x2::tx_context::sender(arg6);
        let v5 = UserDeposited{
            user         : v4,
            round        : v0.number,
            ts           : v1,
            sui_amount   : v2,
            hasui_amount : 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v3),
        };
        0x2::event::emit<UserDeposited>(v5);
        0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v0.vault, 0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v3));
        let v6 = (v2 as u128) * ((v0.end_time - v1) as u128);
        if (!0x2::table::contains<address, UserInfo>(&v0.users, v4)) {
            let v7 = UserInfo{
                total_amount      : v2,
                withdrawed_amount : 0,
                account           : v4,
                share             : v6,
                last_deposit_time : v1,
            };
            v0.total_share = v0.total_share + v6;
            0x2::table::add<address, UserInfo>(&mut v0.users, v4, v7);
            0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::push_back<address>(&mut v0.user_addresses, v4);
        } else {
            let v8 = 0x2::table::borrow_mut<address, UserInfo>(&mut v0.users, v4);
            v8.total_amount = v8.total_amount + v2;
            v8.last_deposit_time = v1;
            if (v8.withdrawed_amount == 0) {
                v8.share = v8.share + v6;
                v0.total_share = v0.total_share + v6;
            };
        };
        v0.total_deposit = v0.total_deposit + v2;
    }

    fun destroy_round(arg0: Round) {
        let Round {
            vault          : v0,
            users          : v1,
            user_addresses : v2,
            number         : _,
            start_time     : _,
            end_time       : _,
            prize_pot      : _,
            total_deposit  : _,
            winners        : _,
            total_share    : _,
        } = arg0;
        let v10 = v2;
        let v11 = v1;
        0x2::balance::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v0);
        while (0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::is_empty<address>(&v10)) {
            let UserInfo {
                total_amount      : _,
                withdrawed_amount : _,
                account           : _,
                share             : _,
                last_deposit_time : _,
            } = 0x2::table::remove<address, UserInfo>(&mut v11, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::pop_front<address>(&mut v10));
        };
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::destroy_empty<address>(v10);
        0x2::table::destroy_empty<address, UserInfo>(v11);
    }

    public(friend) fun draw(arg0: &mut RandomVault, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.paused, 2);
        let v0 = update_old_round(arg0, arg1, arg2, arg3);
        open_new_round(arg0, v0, arg1, arg2, arg3);
    }

    fun draw_one_user(arg0: &vector<UserDraw>, arg1: u64, arg2: u128, arg3: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<UserDraw>(arg0)) {
            let v2 = 0x1::vector::borrow<UserDraw>(arg0, v0);
            if (v1 + v2.share > (arg1 as u128) * (arg3 as u128) % arg2) {
                return v0
            };
            v1 = v1 + v2.share;
            v0 = v0 + 1;
        };
        abort 100
    }

    public(friend) fun draw_step_1(arg0: &mut RandomVault, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = update_old_round(arg0, arg1, arg2, arg3);
        let v1 = new_round(arg0, 0x2::clock::timestamp_ms(arg2) / 1000, arg3);
        0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v1.vault, v0);
        0x2::dynamic_field::add<vector<u8>, Round>(&mut arg0.id, b"latest_round_key", v1);
    }

    public(friend) fun draw_step_2(arg0: &mut RandomVault, arg1: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, Round>(&mut arg0.id, b"latest_round_key").vault, 0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1));
    }

    public(friend) fun draw_step_2_new(arg0: &mut RandomVault, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, Round>(&mut arg0.id, b"latest_round_key");
        let v1 = v0.end_time - v0.start_time;
        let v2 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow<Round>(&arg0.history_rounds, arg0.current_round - 1);
        if (0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::length<address>(&v2.user_addresses) > 0) {
            let v3 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::tail<address>(&v2.user_addresses);
            let v4 = v3;
            if (v3 > arg2 + arg3) {
                v4 = arg2 + arg3;
            };
            while (arg2 < v4) {
                let v5 = *0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow<address>(&v2.user_addresses, arg2);
                let v6 = 0x2::table::borrow<address, UserInfo>(&v2.users, v5);
                arg2 = arg2 + 1;
                let v7 = v6.total_amount - v6.withdrawed_amount;
                if (v7 == 0) {
                    continue
                };
                let v8 = UserDeposited{
                    user         : v5,
                    round        : arg0.current_round + 1,
                    ts           : v0.start_time,
                    sui_amount   : v7,
                    hasui_amount : 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_stsui_by_sui(arg1, v7),
                };
                0x2::event::emit<UserDeposited>(v8);
                let v9 = UserInfo{
                    total_amount      : v7,
                    withdrawed_amount : 0,
                    account           : v5,
                    share             : (v7 as u128) * (v1 as u128),
                    last_deposit_time : v0.start_time,
                };
                v0.total_share = v0.total_share + v9.share;
                v0.total_deposit = v0.total_deposit + v7;
                0x2::table::add<address, UserInfo>(&mut v0.users, v5, v9);
                0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::push_back<address>(&mut v0.user_addresses, v5);
            };
        };
    }

    public(friend) fun draw_step_3(arg0: &mut RandomVault, arg1: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::dynamic_field::remove<vector<u8>, Round>(&mut arg0.id, b"latest_round_key");
        let v1 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow<Round>(&arg0.history_rounds, arg0.current_round - 1);
        assert!(0x2::table::length<address, UserInfo>(&v0.users) == 0x2::table::length<address, UserInfo>(&v1.users), 14);
        assert!(0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::length<address>(&v0.user_addresses) == 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::length<address>(&v1.user_addresses), 14);
        add_round(arg0, v0);
    }

    fun format_round(arg0: &Round) : RoundClosed {
        RoundClosed{
            number        : arg0.number,
            start_time    : arg0.start_time,
            end_time      : arg0.end_time,
            prize_pot     : arg0.prize_pot,
            total_deposit : arg0.total_deposit,
            winners       : arg0.winners,
            user_count    : 0x2::table::length<address, UserInfo>(&arg0.users),
            left_prizes   : 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg0.vault),
            total_share   : arg0.total_share,
        }
    }

    public fun get_config_mut(arg0: &mut RandomVault) : &mut 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::config::Config {
        assert_version(arg0);
        &mut arg0.config
    }

    fun init(arg0: RANDOM_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RandomVault{
            id             : 0x2::object::new(arg1),
            version        : 0,
            config         : 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::config::new(),
            current_round  : 0,
            history_rounds : 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::empty<Round>(arg1),
            fees           : 0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(),
            paused         : false,
        };
        0x2::transfer::share_object<RandomVault>(v0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"round"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"rank"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"amount"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"expire_time"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"claimed"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Haedal Random Vault Winner Ticket"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://assets.haedal.xyz/logos/hrv.svg"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"round: {round}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"rank: {rank}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"amount: {amount}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"expire_time: {expire_time}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"claimed: {claimed}"));
        let v5 = 0x2::package::claim<RANDOM_VAULT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<WinnerTicket>(&v5, v1, v3, arg1);
        0x2::display::update_version<WinnerTicket>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<WinnerTicket>>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun is_round_paused(arg0: &RandomVault) : bool {
        arg0.paused
    }

    public(friend) fun migrate(arg0: &mut RandomVault) {
        assert!(arg0.version < 0, 0);
        let v0 = VersionUpdated{
            old : arg0.version,
            new : 0,
        };
        0x2::event::emit<VersionUpdated>(v0);
        arg0.version = 0;
    }

    fun new_round(arg0: &RandomVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Round {
        Round{
            vault          : 0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(),
            users          : 0x2::table::new<address, UserInfo>(arg2),
            user_addresses : 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::empty<address>(arg2),
            number         : 0,
            start_time     : arg1,
            end_time       : arg1 + 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::config::get_round_duration(&arg0.config),
            prize_pot      : 0,
            total_deposit  : 0,
            winners        : 0x1::vector::empty<Winner>(),
            total_share    : 0,
        }
    }

    fun open_new_round(arg0: &mut RandomVault, arg1: 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = new_round(arg0, v0, arg4);
        0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v1.vault, arg1);
        let v2 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow<Round>(&arg0.history_rounds, arg0.current_round - 1);
        if (0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::length<address>(&v2.user_addresses) > 0) {
            let v3 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::head<address>(&v2.user_addresses);
            while (v3 < 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::tail<address>(&v2.user_addresses)) {
                let v4 = *0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow<address>(&v2.user_addresses, v3);
                let v5 = 0x2::table::borrow<address, UserInfo>(&v2.users, v4);
                v3 = v3 + 1;
                let v6 = v5.total_amount - v5.withdrawed_amount;
                if (v6 == 0) {
                    continue
                };
                let v7 = UserDeposited{
                    user         : v4,
                    round        : arg0.current_round + 1,
                    ts           : v0,
                    sui_amount   : v6,
                    hasui_amount : 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_stsui_by_sui(arg2, v6),
                };
                0x2::event::emit<UserDeposited>(v7);
                let v8 = UserInfo{
                    total_amount      : v6,
                    withdrawed_amount : 0,
                    account           : v4,
                    share             : (v6 as u128) * ((v1.end_time - v1.start_time) as u128),
                    last_deposit_time : v0,
                };
                v1.total_share = v1.total_share + v8.share;
                v1.total_deposit = v1.total_deposit + v6;
                0x2::table::add<address, UserInfo>(&mut v1.users, v4, v8);
                0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::push_back<address>(&mut v1.user_addresses, v4);
            };
        };
        add_round(arg0, v1);
    }

    public(friend) fun pause(arg0: &mut RandomVault) {
        assert_version(arg0);
        arg0.paused = true;
        let v0 = StateChanged{paused: true};
        0x2::event::emit<StateChanged>(v0);
    }

    public fun queryHistoryRound(arg0: &RandomVault, arg1: u64, arg2: u64) : vector<RoundClosed> {
        let v0 = 0x1::vector::empty<RoundClosed>();
        let v1 = 1;
        while (v1 <= arg2) {
            if (arg1 < 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::head<Round>(&arg0.history_rounds) + v1) {
                break
            };
            0x1::vector::push_back<RoundClosed>(&mut v0, format_round(0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow<Round>(&arg0.history_rounds, arg1 - v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun queryRoundUsers(arg0: &RandomVault, arg1: u64) : vector<address> {
        let v0 = vector[];
        let v1 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow<Round>(&arg0.history_rounds, arg1 - 1);
        if (0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::length<address>(&v1.user_addresses) == 0) {
            return v0
        };
        let v2 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::head<address>(&v1.user_addresses);
        while (v2 < 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::tail<address>(&v1.user_addresses)) {
            0x1::vector::push_back<address>(&mut v0, *0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow<address>(&v1.user_addresses, v2));
            v2 = v2 + 1;
        };
        v0
    }

    public fun queryUserInfo(arg0: &RandomVault, arg1: address, arg2: u64) : UserInfo {
        let v0 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow<Round>(&arg0.history_rounds, arg2 - 1);
        if (!0x2::table::contains<address, UserInfo>(&v0.users, arg1)) {
            return UserInfo{
                total_amount      : 0,
                withdrawed_amount : 0,
                account           : arg1,
                share             : 0,
                last_deposit_time : 0,
            }
        };
        let v1 = 0x2::table::borrow<address, UserInfo>(&v0.users, arg1);
        UserInfo{
            total_amount      : v1.total_amount,
            withdrawed_amount : v1.withdrawed_amount,
            account           : v1.account,
            share             : v1.share,
            last_deposit_time : v1.last_deposit_time,
        }
    }

    public fun queryUserInfoByPos(arg0: &RandomVault, arg1: u64, arg2: u64) : UserInfo {
        let v0 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow<Round>(&arg0.history_rounds, arg1 - 1);
        let v1 = 0x2::table::borrow<address, UserInfo>(&v0.users, *0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow<address>(&v0.user_addresses, arg2));
        UserInfo{
            total_amount      : v1.total_amount,
            withdrawed_amount : v1.withdrawed_amount,
            account           : v1.account,
            share             : v1.share,
            last_deposit_time : v1.last_deposit_time,
        }
    }

    public fun queryWinRate(arg0: &RandomVault, arg1: address, arg2: u64) : u64 {
        let v0 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow<Round>(&arg0.history_rounds, arg2 - 1);
        if (!0x2::table::contains<address, UserInfo>(&v0.users, arg1)) {
            return 0
        };
        let v1 = 0x2::table::borrow<address, UserInfo>(&v0.users, arg1);
        if (v1.withdrawed_amount > 0) {
            return 0
        };
        (((v1.share as u128) * 1000000 / v0.total_share) as u64)
    }

    public fun query_current_round(arg0: &RandomVault, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : RoundClosed {
        let v0 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow<Round>(&arg0.history_rounds, arg0.current_round - 1);
        let v1 = format_round(v0);
        let v2 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_stsui_by_sui(arg1, v0.total_deposit);
        if (v1.left_prizes >= v2) {
            v1.prize_pot = v1.left_prizes - v2;
        };
        v1
    }

    public fun query_open_new_round(arg0: &mut RandomVault, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Round {
        assert_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = new_round(arg0, v0, arg3);
        let v2 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow<Round>(&arg0.history_rounds, arg0.current_round - 1);
        if (0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::length<address>(&v2.user_addresses) > 0) {
            let v3 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::head<address>(&v2.user_addresses);
            while (v3 < 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::tail<address>(&v2.user_addresses)) {
                let v4 = *0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow<address>(&v2.user_addresses, v3);
                let v5 = 0x2::table::borrow<address, UserInfo>(&v2.users, v4);
                v3 = v3 + 1;
                let v6 = v5.total_amount - v5.withdrawed_amount;
                if (v6 == 0) {
                    continue
                };
                let v7 = UserDeposited{
                    user         : v4,
                    round        : arg0.current_round + 1,
                    ts           : v0,
                    sui_amount   : v6,
                    hasui_amount : 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_stsui_by_sui(arg1, v6),
                };
                0x2::event::emit<UserDeposited>(v7);
                let v8 = UserInfo{
                    total_amount      : v6,
                    withdrawed_amount : 0,
                    account           : v4,
                    share             : (v6 as u128) * ((v1.end_time - v1.start_time) as u128),
                    last_deposit_time : v0,
                };
                v1.total_share = v1.total_share + v8.share;
                v1.total_deposit = v1.total_deposit + v6;
                0x2::table::add<address, UserInfo>(&mut v1.users, v4, v8);
                0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::push_back<address>(&mut v1.user_addresses, v4);
            };
        };
        v1
    }

    public fun query_open_new_round_step(arg0: &mut RandomVault, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Round {
        assert_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = new_round(arg0, v0, arg5);
        let v2 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow<Round>(&arg0.history_rounds, arg0.current_round - 1);
        if (0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::length<address>(&v2.user_addresses) > 0) {
            let v3 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::tail<address>(&v2.user_addresses);
            let v4 = v3;
            if (v3 > arg3 + arg4) {
                v4 = arg3 + arg4;
            };
            while (arg3 < v4) {
                let v5 = *0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow<address>(&v2.user_addresses, arg3);
                let v6 = 0x2::table::borrow<address, UserInfo>(&v2.users, v5);
                arg3 = arg3 + 1;
                let v7 = v6.total_amount - v6.withdrawed_amount;
                if (v7 == 0) {
                    continue
                };
                let v8 = UserDeposited{
                    user         : v5,
                    round        : arg0.current_round + 1,
                    ts           : v0,
                    sui_amount   : v7,
                    hasui_amount : 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_stsui_by_sui(arg1, v7),
                };
                0x2::event::emit<UserDeposited>(v8);
                let v9 = UserInfo{
                    total_amount      : v7,
                    withdrawed_amount : 0,
                    account           : v5,
                    share             : (v7 as u128) * ((v1.end_time - v1.start_time) as u128),
                    last_deposit_time : v0,
                };
                v1.total_share = v1.total_share + v9.share;
                v1.total_deposit = v1.total_deposit + v7;
                0x2::table::add<address, UserInfo>(&mut v1.users, v5, v9);
                0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::push_back<address>(&mut v1.user_addresses, v5);
            };
        };
        v1
    }

    public fun query_round(arg0: &RandomVault, arg1: u64) : RoundClosed {
        format_round(0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow<Round>(&arg0.history_rounds, arg1 - 1))
    }

    public(friend) fun resume(arg0: &mut RandomVault) {
        assert_version(arg0);
        arg0.paused = false;
        let v0 = StateChanged{paused: false};
        0x2::event::emit<StateChanged>(v0);
    }

    fun select_winner(arg0: &RandomVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : vector<address> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow<Round>(&arg0.history_rounds, arg0.current_round - 1);
        let v2 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::length<address>(&v1.user_addresses);
        if (v2 == 0) {
            return vector[]
        };
        let v3 = 0x1::vector::empty<UserDraw>();
        let v4 = v0 % v2;
        let v5 = &mut v3;
        shuffle_users(v1, v4, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::tail<address>(&v1.user_addresses), v5);
        let v6 = &mut v3;
        shuffle_users(v1, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::head<address>(&v1.user_addresses), v4, v6);
        let v7 = 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::config::get_prize_count(&arg0.config);
        let v8 = v7;
        if (0x1::vector::length<UserDraw>(&v3) < v7) {
            v8 = 0x1::vector::length<UserDraw>(&v3);
        };
        let v9 = v1.total_share;
        let v10 = vector[];
        let v11 = 0;
        while (v11 < v8) {
            let v12 = draw_one_user(&v3, v0, v9, v1.total_deposit);
            let v13 = 0x1::vector::borrow<UserDraw>(&v3, v12);
            0x1::vector::push_back<address>(&mut v10, v13.account);
            v9 = v9 - v13.share;
            0x1::vector::remove<UserDraw>(&mut v3, v12);
            v11 = v11 + 1;
        };
        v10
    }

    fun shuffle_users(arg0: &Round, arg1: u64, arg2: u64, arg3: &mut vector<UserDraw>) {
        while (arg1 < arg2) {
            let v0 = *0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow<address>(&arg0.user_addresses, arg1);
            arg1 = arg1 + 1;
            let v1 = 0x2::table::borrow<address, UserInfo>(&arg0.users, v0);
            if (v1.withdrawed_amount > 0) {
                continue
            };
            let v2 = UserDraw{
                account : v0,
                share   : v1.share,
            };
            0x1::vector::push_back<UserDraw>(arg3, v2);
        };
    }

    public(friend) fun start_first_round(arg0: &mut RandomVault, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.paused, 2);
        assert!(arg1 >= 0x2::clock::timestamp_ms(arg2) / 1000, 1);
        assert!(arg0.current_round == 0, 1);
        let v0 = new_round(arg0, arg1, arg3);
        add_round(arg0, v0);
    }

    fun update_old_round(arg0: &mut RandomVault, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        let v0 = select_winner(arg0, arg2, arg3);
        let v1 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow_mut<Round>(&mut arg0.history_rounds, arg0.current_round - 1);
        assert!(v1.end_time <= 0x2::clock::timestamp_ms(arg2) / 1000, 1);
        let v2 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_stsui_by_sui(arg1, v1.total_deposit);
        let v3 = v2;
        let v4 = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v1.vault);
        if (v2 > v4) {
            v3 = v4;
        };
        v1.prize_pot = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v1.vault);
        let v5 = 0;
        let v6 = 0;
        while (v5 < 0x1::vector::length<address>(&v0)) {
            let v7 = *0x1::vector::borrow<address>(&v0, v5);
            let v8 = v1.prize_pot * 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::config::get_prize_rate(&arg0.config, v5) / 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::config::get_rate_denominator();
            let v9 = Winner{
                account      : v7,
                hasui_amount : v8,
            };
            0x1::vector::push_back<Winner>(&mut v1.winners, v9);
            let v10 = WinnerTicket{
                id          : 0x2::object::new(arg3),
                round       : v1.number,
                rank        : v5 + 1,
                amount      : v8,
                expire_time : v1.end_time + 5184000,
                claimed     : false,
            };
            0x2::transfer::transfer<WinnerTicket>(v10, v7);
            v6 = v6 + v8;
            v5 = v5 + 1;
        };
        0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.fees, 0x2::balance::split<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v1.vault, v1.prize_pot - v6));
        0x2::event::emit<RoundClosed>(format_round(v1));
        0x2::balance::split<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v1.vault, v3)
    }

    public fun withdraw(arg0: &mut RandomVault, arg1: &0x2::clock::Clock, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        assert_version(arg0);
        assert!(!arg0.paused, 2);
        let v0 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::table_queue::borrow_mut<Round>(&mut arg0.history_rounds, arg0.current_round - 1);
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v0.start_time <= v1 && v0.end_time > v1, 1);
        let v2 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, UserInfo>(&v0.users, v2), 4);
        let v3 = 0x2::table::borrow_mut<address, UserInfo>(&mut v0.users, v2);
        assert!(v3.total_amount - v3.withdrawed_amount >= arg4, 5);
        v0.total_deposit = v0.total_deposit - arg4;
        if (v3.withdrawed_amount == 0) {
            v0.total_share = v0.total_share - v3.share;
        };
        let v4 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_stsui_by_sui(arg3, arg4);
        let v5 = 0x2::balance::split<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v0.vault, v4);
        v3.withdrawed_amount = v3.withdrawed_amount + arg4;
        let v6 = 0;
        if (v1 - v3.last_deposit_time < 86400) {
            let v7 = v4 * 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::config::get_withdraw_fee_rate(&arg0.config) / 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::config::get_rate_denominator();
            v6 = v7;
            0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.fees, 0x2::balance::split<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v5, v7));
        };
        let v8 = UserWithdrawed{
            user         : v2,
            round        : v0.number,
            ts           : v1,
            sui_amount   : arg4,
            hasui_amount : v4,
            fee_amount   : v6,
        };
        0x2::event::emit<UserWithdrawed>(v8);
        0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v5, arg5)
    }

    // decompiled from Move bytecode v6
}

