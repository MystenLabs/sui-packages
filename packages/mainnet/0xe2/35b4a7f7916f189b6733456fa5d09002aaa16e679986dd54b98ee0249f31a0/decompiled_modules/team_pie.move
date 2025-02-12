module 0xe235b4a7f7916f189b6733456fa5d09002aaa16e679986dd54b98ee0249f31a0::team_pie {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Deposit has store, key {
        id: 0x2::object::UID,
        depositor: address,
        amount: u64,
        entry_index: u64,
    }

    struct Team has store, key {
        id: 0x2::object::UID,
        key: u8,
        deposits: vector<Deposit>,
        total_deposit_amount: u64,
    }

    struct Round has store, key {
        id: 0x2::object::UID,
        key: u64,
        status: u8,
        team_count: u8,
        current_entry_index: u64,
        value_per_entry: u64,
        teams: 0x2::table::Table<u8, Team>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        draw_entry_index: 0x1::option::Option<u64>,
        winner_team_key: 0x1::option::Option<u8>,
        drawer: 0x1::option::Option<address>,
        participant_team_key: 0x2::table::Table<address, u8>,
        participant_amount: 0x2::table::Table<address, u64>,
        drawable_time: u64,
        draw_time: u64,
    }

    struct Game has store, key {
        id: 0x2::object::UID,
        rounds: 0x2::object_table::ObjectTable<u64, Round>,
        team_count: u8,
        fee_in_bp: u16,
        round_duration: u64,
        current_round_key: u64,
        value_per_entry: u64,
        fee_manager: address,
        max_future_round: u64,
        max_deposits_per_round: u64,
    }

    struct Entry has copy, drop {
        amount: u64,
        round_key: u64,
    }

    struct Deposited has copy, drop {
        start_round_key: u64,
        amounts: vector<u64>,
        balances: vector<u64>,
        entry_indexes: vector<u64>,
        team_key: u8,
        depositor: address,
    }

    struct RoundCreated has copy, drop {
        round_key: u64,
        round_address: address,
    }

    struct RoundOpened has copy, drop {
        round_key: u64,
        round_address: address,
    }

    struct RoundFinished has copy, drop {
        round_key: u64,
        round_address: address,
    }

    fun cancel_current_round(arg0: &mut Game, arg1: &mut 0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::PlayManager, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.current_round_key;
        let v1 = 0x2::object_table::borrow_mut<u64, Round>(&mut arg0.rounds, v0);
        v1.status = 3;
        let v2 = RoundFinished{
            round_key     : v0,
            round_address : get_round_address(arg0, v0),
        };
        0x2::event::emit<RoundFinished>(v2);
        let v3 = 0;
        let v4 = vector[];
        while (v3 < v1.team_count) {
            let v5 = 0x2::table::borrow_mut<u8, Team>(&mut v1.teams, v3);
            let v6 = 0;
            while (v6 < 0x1::vector::length<Deposit>(&v5.deposits)) {
                let v7 = 0x1::vector::borrow_mut<Deposit>(&mut v5.deposits, v6);
                let v8 = v7.depositor;
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v1.balance, v7.amount, arg3), v8);
                v6 = v6 + 1;
                if (!0x1::vector::contains<address>(&v4, &v8)) {
                    0x1::vector::push_back<address>(&mut v4, v8);
                };
            };
            v3 = v3 + 1;
        };
        let v9 = 0;
        while (v9 < 0x1::vector::length<address>(&v4)) {
            let v10 = *0x1::vector::borrow<address>(&v4, v9);
            let v11 = Witness{dummy_field: false};
            0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::cancel_play<Witness>(arg1, *0x2::table::borrow<address, u64>(&v1.participant_amount, v10), v10, &v11, arg2, arg3);
            v9 = v9 + 1;
        };
        start_new_round(arg0, arg3);
        if (0x2::table::length<address, u8>(&0x2::object_table::borrow<u64, Round>(&arg0.rounds, arg0.current_round_key).participant_team_key) > 0) {
            let v12 = arg0.current_round_key;
            update_round_drawable_time(arg0, v12, arg2);
        };
    }

    fun check_round_status(arg0: &Game, arg1: u64, arg2: u8) {
        assert!(0x2::object_table::borrow<u64, Round>(&arg0.rounds, arg1).status == arg2, 9223374317482737670);
    }

    fun create_new_round_if_not_exists(arg0: &mut Game, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::object_table::contains<u64, Round>(&arg0.rounds, arg1)) {
            return
        };
        let v0 = 0x2::table::new<u8, Team>(arg2);
        let v1 = 0;
        while (v1 < arg0.team_count) {
            let v2 = Team{
                id                   : 0x2::object::new(arg2),
                key                  : v1,
                deposits             : 0x1::vector::empty<Deposit>(),
                total_deposit_amount : 0,
            };
            0x2::table::add<u8, Team>(&mut v0, v1, v2);
            v1 = v1 + 1;
        };
        let v3 = Round{
            id                   : 0x2::object::new(arg2),
            key                  : arg1,
            status               : 0,
            team_count           : arg0.team_count,
            current_entry_index  : 0,
            value_per_entry      : arg0.value_per_entry,
            teams                : v0,
            balance              : 0x2::balance::zero<0x2::sui::SUI>(),
            draw_entry_index     : 0x1::option::none<u64>(),
            winner_team_key      : 0x1::option::none<u8>(),
            drawer               : 0x1::option::none<address>(),
            participant_team_key : 0x2::table::new<address, u8>(arg2),
            participant_amount   : 0x2::table::new<address, u64>(arg2),
            drawable_time        : 0,
            draw_time            : 0,
        };
        0x2::object_table::add<u64, Round>(&mut arg0.rounds, arg1, v3);
        let v4 = 0x2::object_table::value_id<u64, Round>(&arg0.rounds, arg1);
        let v5 = RoundCreated{
            round_key     : arg1,
            round_address : 0x2::object::id_to_address(0x1::option::borrow<0x2::object::ID>(&v4)),
        };
        0x2::event::emit<RoundCreated>(v5);
    }

    entry fun deposit(arg0: &mut Game, arg1: u8, arg2: vector<u64>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::PlayManager, arg5: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::check_version_gte<Witness>(arg5, 1);
        assert!(0x1::vector::length<u64>(&arg2) > 0 && 0x1::vector::length<u64>(&arg2) <= arg0.max_future_round, 9223372668215558154);
        let v0 = 0;
        let v1 = 0;
        while (0x1::vector::length<u64>(&arg2) > v1) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg2, v1);
            v1 = v1 + 1;
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == v0, 9223372702575558670);
        let v2 = arg0.current_round_key;
        check_round_status(arg0, v2, 1);
        update_drawable_time_if_needed(arg0, v2, arg6);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        let v4 = vector[];
        let v5 = vector[];
        let v6 = 0;
        while (0x1::vector::length<u64>(&arg2) > v6) {
            create_new_round_if_not_exists(arg0, v2, arg7);
            let v7 = 0x2::object_table::borrow_mut<u64, Round>(&mut arg0.rounds, v2);
            assert!(v7.team_count > arg1, 9223372762706018332);
            let v8 = *0x1::vector::borrow<u64>(&arg2, v6);
            assert!(v8 >= v7.value_per_entry, 9223372775589871628);
            assert!(v8 % v7.value_per_entry == 0, 9223372779884838924);
            if (0x2::table::contains<address, u8>(&v7.participant_team_key, 0x2::tx_context::sender(arg7))) {
                assert!(0x2::table::borrow<address, u8>(&v7.participant_team_key, 0x2::tx_context::sender(arg7)) == &arg1, 9223372801360330774);
            };
            let v9 = v7.current_entry_index + v8 / v7.value_per_entry;
            let v10 = Deposit{
                id          : 0x2::object::new(arg7),
                depositor   : 0x2::tx_context::sender(arg7),
                amount      : v8,
                entry_index : v9,
            };
            let v11 = 0x2::table::borrow_mut<u8, Team>(&mut v7.teams, arg1);
            assert!(0x1::vector::length<Deposit>(&v11.deposits) < arg0.max_deposits_per_round, 9223372848604577808);
            0x1::vector::push_back<Deposit>(&mut v11.deposits, v10);
            v11.total_deposit_amount = v11.total_deposit_amount + v8;
            v7.current_entry_index = v9;
            0x2::balance::join<0x2::sui::SUI>(&mut v7.balance, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v8));
            if (!0x2::table::contains<address, u8>(&v7.participant_team_key, 0x2::tx_context::sender(arg7))) {
                0x2::table::add<address, u8>(&mut v7.participant_team_key, 0x2::tx_context::sender(arg7), arg1);
            };
            if (!0x2::table::contains<address, u64>(&v7.participant_amount, 0x2::tx_context::sender(arg7))) {
                0x2::table::add<address, u64>(&mut v7.participant_amount, 0x2::tx_context::sender(arg7), 0);
            };
            let v12 = 0x2::table::borrow_mut<address, u64>(&mut v7.participant_amount, 0x2::tx_context::sender(arg7));
            *v12 = *v12 + v8;
            0x1::vector::push_back<u64>(&mut v4, v9);
            0x1::vector::push_back<u64>(&mut v5, 0x2::balance::value<0x2::sui::SUI>(&v7.balance));
            v2 = v2 + 1;
            v6 = v6 + 1;
        };
        let v13 = Deposited{
            start_round_key : v2,
            amounts         : arg2,
            balances        : v5,
            entry_indexes   : v4,
            team_key        : arg1,
            depositor       : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<Deposited>(v13);
        let v14 = Witness{dummy_field: false};
        0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::record_play<Witness>(arg4, v0, 0x2::tx_context::sender(arg7), &v14, arg6, arg7);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
    }

    entry fun draw(arg0: &mut Game, arg1: &mut 0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::PlayManager, arg2: &mut 0xef199024460c12d9880f7b6bb9712de2a56b3761fd5a480f297dadb60f956c03::referral::ReferralRegistry, arg3: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::check_version_gte<Witness>(arg3, 1);
        check_round_status(arg0, arg0.current_round_key, 1);
        let v0 = arg0.current_round_key;
        let v1 = 0x2::object_table::borrow_mut<u64, Round>(&mut arg0.rounds, v0);
        assert!(0x2::table::length<address, u8>(&v1.participant_team_key) > 0, 9223373089122877458);
        assert!(v1.drawable_time > 0 && v1.drawable_time < 0x2::clock::timestamp_ms(arg5), 9223373093417189384);
        assert!(0x2::table::contains<address, u8>(&v1.participant_team_key, 0x2::tx_context::sender(arg6)), 9223373097713336346);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v1.team_count > v4) {
            let v5 = 0x2::table::borrow<u8, Team>(&v1.teams, v4);
            if (0x1::vector::length<Deposit>(&v5.deposits) > 0) {
                v3 = v3 + 1;
            };
            v2 = v2 + 0x1::vector::length<Deposit>(&v5.deposits);
            v4 = v4 + 1;
        };
        if (v3 < 2) {
            cancel_current_round(arg0, arg1, arg5, arg6);
            return
        };
        let v6 = vector[];
        let v7 = b"";
        let v8 = vector[];
        loop {
            let v9 = 18446744073709551615;
            let v10 = v9;
            let v11 = 255;
            let v12 = 0;
            while (v12 < v1.team_count) {
                if (v12 >= (0x1::vector::length<u64>(&v8) as u8)) {
                    0x1::vector::push_back<u64>(&mut v8, 0);
                };
                let v13 = 0x2::table::borrow<u8, Team>(&v1.teams, v12);
                let v14 = *0x1::vector::borrow<u64>(&v8, (v12 as u64));
                if (v14 == 0x1::vector::length<Deposit>(&v13.deposits)) {
                    v12 = v12 + 1;
                    continue
                };
                let v15 = 0x1::vector::borrow<Deposit>(&v13.deposits, v14).entry_index;
                if (v9 > v15) {
                    v10 = v15;
                };
                v12 = v12 + 1;
            };
            if (v10 == 18446744073709551615) {
                break
            };
            0x1::vector::push_back<u64>(&mut v6, v10);
            0x1::vector::push_back<u8>(&mut v7, v11);
            let v16 = 0x1::vector::borrow_mut<u64>(&mut v8, (v11 as u64));
            *v16 = *v16 + 1;
        };
        assert!(0x1::vector::length<u64>(&v6) == v2, 9223373372591505438);
        let v17 = 0x2::random::new_generator(arg4, arg6);
        let v18 = 0x2::random::generate_u64_in_range(&mut v17, 1, v1.current_entry_index);
        let v19 = *0x1::vector::borrow<u8>(&v7, 0xf6b668302a8d006e599bf2c9bf7377e631db1a04d30158fd5478b079e92bced8::common::find_upper_bound(v6, v18));
        v1.winner_team_key = 0x1::option::some<u8>(v19);
        v1.drawer = 0x1::option::some<address>(0x2::tx_context::sender(arg6));
        v1.draw_entry_index = 0x1::option::some<u64>(v18);
        v1.draw_time = 0x2::clock::timestamp_ms(arg5);
        let v20 = Witness{dummy_field: false};
        0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::increment_point<Witness>(arg1, *0x2::table::borrow<address, u64>(&v1.participant_amount, 0x2::tx_context::sender(arg6)), 0x2::tx_context::sender(arg6), 0x1::type_name::get<0xf8ee6671c195bb61ee5effbccb2c4fdf6492c7395d16f498c142468d38ad9e54::point::Witness>(), &v20, arg5, arg6);
        let v21 = v1.value_per_entry * v1.current_entry_index;
        assert!(v21 == 0x2::balance::value<0x2::sui::SUI>(&v1.balance), 9223373488554967060);
        let v22 = v21 * (arg0.fee_in_bp as u64) / 10000;
        assert!(v22 + v21 - v22 == 0x2::balance::value<0x2::sui::SUI>(&v1.balance), 9223373505734836244);
        let v23 = 0x2::table::borrow_mut<u8, Team>(&mut v1.teams, v19);
        let v24 = 0x2::linked_table::new<address, u64>(arg6);
        let v25 = 0x2::table::new<address, u64>(arg6);
        let v26 = 0;
        let v27 = 0;
        let v28 = 0;
        while (0x1::vector::length<Deposit>(&v23.deposits) > v28) {
            let v29 = 0x1::vector::borrow_mut<Deposit>(&mut v23.deposits, v28);
            let v30 = 0x1::u256::try_as_u64((v21 as u256) * (v29.amount as u256) / (v23.total_deposit_amount as u256));
            let v31 = 0x1::option::extract<u64>(&mut v30);
            let v32 = v31 * (arg0.fee_in_bp as u64) / 10000;
            let v33 = v31 - v32;
            assert!(v32 + v33 == v31, 9223373565864378388);
            let v34 = v29.depositor;
            if (0x2::linked_table::contains<address, u64>(&v24, v34)) {
                let v35 = 0x2::linked_table::borrow_mut<address, u64>(&mut v24, v34);
                *v35 = *v35 + v33;
            } else {
                0x2::linked_table::push_back<address, u64>(&mut v24, v34, v33);
            };
            v27 = v27 + v33;
            if (0x2::table::contains<address, u64>(&v25, v34)) {
                let v36 = 0x2::table::borrow_mut<address, u64>(&mut v25, v34);
                *v36 = *v36 + v32;
            } else {
                0x2::table::add<address, u64>(&mut v25, v34, v32);
            };
            v26 = v26 + v32;
            v28 = v28 + 1;
        };
        assert!(0x2::balance::value<0x2::sui::SUI>(&v1.balance) >= v27 + v26, 9223373664647380991);
        let v37 = 0x2::linked_table::front<address, u64>(&v24);
        while (0x1::option::is_some<address>(v37)) {
            let v38 = *0x1::option::borrow<address>(v37);
            let v39 = 0xef199024460c12d9880f7b6bb9712de2a56b3761fd5a480f297dadb60f956c03::referral::get_referral_fee(arg2, v38, 0x2::table::remove<address, u64>(&mut v25, v38));
            if (v39 > 0) {
                0xef199024460c12d9880f7b6bb9712de2a56b3761fd5a480f297dadb60f956c03::referral::earn_referral_balance(arg2, v38, arg3, 0x2::balance::split<0x2::sui::SUI>(&mut v1.balance, v39));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1.balance, *0x2::linked_table::borrow<address, u64>(&v24, v38)), arg6), v38);
            0x2::linked_table::remove<address, u64>(&mut v24, v38);
            v37 = 0x2::linked_table::front<address, u64>(&v24);
        };
        0x2::linked_table::destroy_empty<address, u64>(v24);
        0x2::table::destroy_empty<address, u64>(v25);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1.balance, 0x2::balance::value<0x2::sui::SUI>(&v1.balance)), arg6), arg0.fee_manager);
        v1.status = 2;
        let v40 = RoundFinished{
            round_key     : v0,
            round_address : get_round_address(arg0, v0),
        };
        0x2::event::emit<RoundFinished>(v40);
        start_new_round(arg0, arg6);
        if (0x2::table::length<address, u8>(&0x2::object_table::borrow<u64, Round>(&arg0.rounds, arg0.current_round_key).participant_team_key) > 0) {
            let v41 = arg0.current_round_key;
            update_round_drawable_time(arg0, v41, arg5);
        };
    }

    entry fun get_entries(arg0: &Game, arg1: &0x2::tx_context::TxContext) : vector<Entry> {
        let v0 = 0x1::vector::empty<Entry>();
        let v1 = arg0.current_round_key;
        while (0x2::object_table::contains<u64, Round>(&arg0.rounds, v1)) {
            let v2 = 0x2::object_table::borrow<u64, Round>(&arg0.rounds, v1);
            if (!0x2::table::contains<address, u64>(&v2.participant_amount, 0x2::tx_context::sender(arg1))) {
                break
            };
            let v3 = Entry{
                amount    : *0x2::table::borrow<address, u64>(&v2.participant_amount, 0x2::tx_context::sender(arg1)),
                round_key : v1,
            };
            0x1::vector::push_back<Entry>(&mut v0, v3);
            v1 = v1 + 1;
        };
        v0
    }

    fun get_round_address(arg0: &Game, arg1: u64) : address {
        let v0 = 0x2::object_table::value_id<u64, Round>(&arg0.rounds, arg1);
        0x2::object::id_to_address(0x1::option::borrow<0x2::object::ID>(&v0))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Game{
            id                     : 0x2::object::new(arg0),
            rounds                 : 0x2::object_table::new<u64, Round>(arg0),
            team_count             : 2,
            fee_in_bp              : 100,
            round_duration         : 60000,
            current_round_key      : 0,
            value_per_entry        : 1000000000,
            fee_manager            : 0x2::tx_context::sender(arg0),
            max_future_round       : 30,
            max_deposits_per_round : 1000,
        };
        let v2 = &mut v1;
        start_new_round(v2, arg0);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Game>(v1);
    }

    fun start_new_round(arg0: &mut Game, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.current_round_key = arg0.current_round_key + 1;
        let v0 = arg0.current_round_key;
        create_new_round_if_not_exists(arg0, v0, arg1);
        0x2::object_table::borrow_mut<u64, Round>(&mut arg0.rounds, v0).status = 1;
        let v1 = RoundOpened{
            round_key     : v0,
            round_address : get_round_address(arg0, v0),
        };
        0x2::event::emit<RoundOpened>(v1);
    }

    fun update_drawable_time_if_needed(arg0: &mut Game, arg1: u64, arg2: &0x2::clock::Clock) {
        if (0x2::object_table::borrow<u64, Round>(&arg0.rounds, arg1).drawable_time == 0) {
            update_round_drawable_time(arg0, arg1, arg2);
        };
    }

    entry fun update_game(arg0: &AdminCap, arg1: &mut Game, arg2: u16, arg3: u8, arg4: u64, arg5: u64, arg6: address, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 1 && arg3 <= 5, 9223374012541239320);
        arg1.fee_in_bp = arg2;
        arg1.team_count = arg3;
        arg1.round_duration = arg4;
        arg1.value_per_entry = arg5;
        arg1.fee_manager = arg6;
        arg1.max_future_round = arg7;
        arg1.max_deposits_per_round = arg8;
    }

    fun update_round_drawable_time(arg0: &mut Game, arg1: u64, arg2: &0x2::clock::Clock) {
        0x2::object_table::borrow_mut<u64, Round>(&mut arg0.rounds, arg1).drawable_time = 0x2::clock::timestamp_ms(arg2) + arg0.round_duration;
    }

    // decompiled from Move bytecode v6
}

