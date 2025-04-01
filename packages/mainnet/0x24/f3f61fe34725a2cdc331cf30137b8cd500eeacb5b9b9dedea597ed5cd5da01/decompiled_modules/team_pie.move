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

    fun cancel_current_round(arg0: &mut Game, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
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
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v1.balance, v7.amount, arg2), v8);
                v6 = v6 + 1;
                if (!0x1::vector::contains<address>(&v4, &v8)) {
                    0x1::vector::push_back<address>(&mut v4, v8);
                };
            };
            v3 = v3 + 1;
        };
        start_new_round(arg0, arg2);
        if (0x2::table::length<address, u8>(&0x2::object_table::borrow<u64, Round>(&arg0.rounds, arg0.current_round_key).participant_team_key) > 0) {
            let v9 = arg0.current_round_key;
            update_round_drawable_time(arg0, v9, arg1);
        };
    }

    fun check_round_status(arg0: &Game, arg1: u64, arg2: u8) {
        assert!(0x2::object_table::borrow<u64, Round>(&arg0.rounds, arg1).status == arg2, 9223374540821037062);
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
        abort 0
    }

    entry fun deposit_v2(arg0: &mut Game, arg1: u64, arg2: u8, arg3: vector<u64>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::PlayManager, arg6: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::check_version_gte<Witness>(arg6, 2);
        assert!(0x1::vector::length<u64>(&arg3) > 0 && 0x1::vector::length<u64>(&arg3) <= arg0.max_future_round, 9223372741230002186);
        let v0 = 0;
        let v1 = 0;
        while (0x1::vector::length<u64>(&arg3) > v1) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg3, v1);
            v1 = v1 + 1;
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == v0, 9223372775590002702);
        assert!(arg1 == arg0.current_round_key, 9223372788476084256);
        check_round_status(arg0, arg1, 1);
        update_drawable_time_if_needed(arg0, arg1, arg7);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        let v3 = vector[];
        let v4 = vector[];
        let v5 = 0;
        while (0x1::vector::length<u64>(&arg3) > v5) {
            create_new_round_if_not_exists(arg0, arg1, arg8);
            let v6 = 0x2::object_table::borrow_mut<u64, Round>(&mut arg0.rounds, arg1);
            assert!(v6.team_count > arg2, 9223372840015429660);
            let v7 = *0x1::vector::borrow<u64>(&arg3, v5);
            assert!(v7 >= v6.value_per_entry, 9223372852899282956);
            assert!(v7 % v6.value_per_entry == 0, 9223372857194250252);
            if (0x2::table::contains<address, u8>(&v6.participant_team_key, 0x2::tx_context::sender(arg8))) {
                assert!(0x2::table::borrow<address, u8>(&v6.participant_team_key, 0x2::tx_context::sender(arg8)) == &arg2, 9223372878669742102);
            };
            let v8 = v6.current_entry_index + v7 / v6.value_per_entry;
            let v9 = Deposit{
                id          : 0x2::object::new(arg8),
                depositor   : 0x2::tx_context::sender(arg8),
                amount      : v7,
                entry_index : v8,
            };
            let v10 = 0x2::table::borrow_mut<u8, Team>(&mut v6.teams, arg2);
            assert!(0x1::vector::length<Deposit>(&v10.deposits) < arg0.max_deposits_per_round, 9223372925913989136);
            0x1::vector::push_back<Deposit>(&mut v10.deposits, v9);
            v10.total_deposit_amount = v10.total_deposit_amount + v7;
            v6.current_entry_index = v8;
            0x2::balance::join<0x2::sui::SUI>(&mut v6.balance, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v7));
            if (!0x2::table::contains<address, u8>(&v6.participant_team_key, 0x2::tx_context::sender(arg8))) {
                0x2::table::add<address, u8>(&mut v6.participant_team_key, 0x2::tx_context::sender(arg8), arg2);
            };
            if (!0x2::table::contains<address, u64>(&v6.participant_amount, 0x2::tx_context::sender(arg8))) {
                0x2::table::add<address, u64>(&mut v6.participant_amount, 0x2::tx_context::sender(arg8), 0);
            };
            let v11 = 0x2::table::borrow_mut<address, u64>(&mut v6.participant_amount, 0x2::tx_context::sender(arg8));
            *v11 = *v11 + v7;
            0x1::vector::push_back<u64>(&mut v3, v8);
            0x1::vector::push_back<u64>(&mut v4, 0x2::balance::value<0x2::sui::SUI>(&v6.balance));
            arg1 = arg1 + 1;
            v5 = v5 + 1;
        };
        let v12 = Deposited{
            start_round_key : arg1,
            amounts         : arg3,
            balances        : v4,
            entry_indexes   : v3,
            team_key        : arg2,
            depositor       : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<Deposited>(v12);
        let v13 = Witness{dummy_field: false};
        0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::record_play<Witness>(arg5, v0, 0x2::tx_context::sender(arg8), &v13, arg7, arg8);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
    }

    entry fun draw(arg0: &mut Game, arg1: &mut 0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::PlayManager, arg2: &mut 0xef199024460c12d9880f7b6bb9712de2a56b3761fd5a480f297dadb60f956c03::referral::ReferralRegistry, arg3: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun draw_v2(arg0: &mut Game, arg1: u64, arg2: &mut 0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::PlayManager, arg3: &mut 0xef199024460c12d9880f7b6bb9712de2a56b3761fd5a480f297dadb60f956c03::referral::ReferralRegistry, arg4: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::check_version_gte<Witness>(arg4, 2);
        assert!(arg1 == arg0.current_round_key, 9223373209382879264);
        check_round_status(arg0, arg1, 1);
        let v0 = 0x2::object_table::borrow_mut<u64, Round>(&mut arg0.rounds, arg1);
        assert!(0x2::table::length<address, u8>(&v0.participant_team_key) > 0, 9223373222266863634);
        assert!(v0.drawable_time > 0 && v0.drawable_time < 0x2::clock::timestamp_ms(arg6), 9223373226561175560);
        assert!(0x2::table::contains<address, u8>(&v0.participant_team_key, 0x2::tx_context::sender(arg7)), 9223373230857322522);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v0.team_count > v3) {
            let v4 = 0x2::table::borrow<u8, Team>(&v0.teams, v3);
            if (0x1::vector::length<Deposit>(&v4.deposits) > 0) {
                v2 = v2 + 1;
            };
            v1 = v1 + 0x1::vector::length<Deposit>(&v4.deposits);
            v3 = v3 + 1;
        };
        if (v2 < 2) {
            cancel_current_round(arg0, arg6, arg7);
            return
        };
        let v5 = vector[];
        let v6 = b"";
        let v7 = vector[];
        loop {
            let v8 = 18446744073709551615;
            let v9 = v8;
            let v10 = 255;
            let v11 = 0;
            while (v11 < v0.team_count) {
                if (v11 >= (0x1::vector::length<u64>(&v7) as u8)) {
                    0x1::vector::push_back<u64>(&mut v7, 0);
                };
                let v12 = 0x2::table::borrow<u8, Team>(&v0.teams, v11);
                let v13 = *0x1::vector::borrow<u64>(&v7, (v11 as u64));
                if (v13 == 0x1::vector::length<Deposit>(&v12.deposits)) {
                    v11 = v11 + 1;
                    continue
                };
                let v14 = 0x1::vector::borrow<Deposit>(&v12.deposits, v13).entry_index;
                if (v8 > v14) {
                    v9 = v14;
                };
                v11 = v11 + 1;
            };
            if (v9 == 18446744073709551615) {
                break
            };
            0x1::vector::push_back<u64>(&mut v5, v9);
            0x1::vector::push_back<u8>(&mut v6, v10);
            let v15 = 0x1::vector::borrow_mut<u64>(&mut v7, (v10 as u64));
            *v15 = *v15 + 1;
        };
        assert!(0x1::vector::length<u64>(&v5) == v1, 9223373505735491614);
        let v16 = 0x2::random::new_generator(arg5, arg7);
        let v17 = 0x2::random::generate_u64_in_range(&mut v16, 1, v0.current_entry_index);
        let v18 = *0x1::vector::borrow<u8>(&v6, 0xf6b668302a8d006e599bf2c9bf7377e631db1a04d30158fd5478b079e92bced8::common::find_upper_bound(v5, v17));
        v0.winner_team_key = 0x1::option::some<u8>(v18);
        v0.drawer = 0x1::option::some<address>(0x2::tx_context::sender(arg7));
        v0.draw_entry_index = 0x1::option::some<u64>(v17);
        v0.draw_time = 0x2::clock::timestamp_ms(arg6);
        let v19 = Witness{dummy_field: false};
        0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::increment_point<Witness>(arg2, *0x2::table::borrow<address, u64>(&v0.participant_amount, 0x2::tx_context::sender(arg7)), 0x2::tx_context::sender(arg7), 0x1::type_name::get<0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::point::Witness>(), b"MysteryPoint", &v19, arg6, arg7);
        let v20 = v0.value_per_entry * v0.current_entry_index;
        assert!(v20 == 0x2::balance::value<0x2::sui::SUI>(&v0.balance), 9223373625993920532);
        let v21 = v20 * (arg0.fee_in_bp as u64) / 10000;
        let v22 = v20 - v21;
        assert!(v21 + v22 == 0x2::balance::value<0x2::sui::SUI>(&v0.balance), 9223373643173789716);
        let v23 = 0x2::table::borrow_mut<u8, Team>(&mut v0.teams, v18);
        let v24 = 0x2::linked_table::new<address, u64>(arg7);
        let v25 = 0x2::table::new<address, u64>(arg7);
        let v26 = 0x2::table::new<address, u64>(arg7);
        let v27 = 0;
        let v28 = 0;
        let v29 = 0;
        let v30 = 0;
        while (0x1::vector::length<Deposit>(&v23.deposits) > v30) {
            let v31 = 0x1::vector::borrow_mut<Deposit>(&mut v23.deposits, v30);
            let v32 = 0x1::u256::try_as_u64((v20 as u256) * (v31.amount as u256) / (v23.total_deposit_amount as u256));
            let v33 = 0x1::option::extract<u64>(&mut v32);
            let v34 = v33 * (arg0.fee_in_bp as u64) / 10000;
            let v35 = v33 - v34;
            assert!(v34 + v35 == v33, 9223373711893266452);
            let v36 = v31.depositor;
            if (0x2::linked_table::contains<address, u64>(&v24, v36)) {
                let v37 = 0x2::linked_table::borrow_mut<address, u64>(&mut v24, v36);
                *v37 = *v37 + v35;
            } else {
                0x2::linked_table::push_back<address, u64>(&mut v24, v36, v35);
            };
            v27 = v27 + v35;
            if (0x2::table::contains<address, u64>(&v25, v36)) {
                let v38 = 0x2::table::borrow_mut<address, u64>(&mut v25, v36);
                *v38 = *v38 + v33;
            } else {
                0x2::table::add<address, u64>(&mut v25, v36, v33);
            };
            v28 = v28 + v33;
            if (0x2::table::contains<address, u64>(&v26, v36)) {
                let v39 = 0x2::table::borrow_mut<address, u64>(&mut v26, v36);
                *v39 = *v39 + v34;
            } else {
                0x2::table::add<address, u64>(&mut v26, v36, v34);
            };
            v29 = v29 + v34;
            v30 = v30 + 1;
        };
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0.balance) >= v27 + v29, 9223373849330974719);
        let v40 = 0x2::linked_table::front<address, u64>(&v24);
        while (0x1::option::is_some<address>(v40)) {
            let v41 = *0x1::option::borrow<address>(v40);
            let v42 = *0x2::linked_table::borrow<address, u64>(&v24, v41);
            let v43 = 0xef199024460c12d9880f7b6bb9712de2a56b3761fd5a480f297dadb60f956c03::referral::get_referral_fee(arg3, v41, 0x2::table::remove<address, u64>(&mut v26, v41));
            if (v43 > 0) {
                0xef199024460c12d9880f7b6bb9712de2a56b3761fd5a480f297dadb60f956c03::referral::earn_referral_balance(arg3, v41, arg4, 0x2::balance::split<0x2::sui::SUI>(&mut v0.balance, v43));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0.balance, v42), arg7), v41);
            0x2::linked_table::remove<address, u64>(&mut v24, v41);
            let v44 = Witness{dummy_field: false};
            0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::record_play_activity<Witness>(arg2, false, 0, 0x2::table::remove<address, u64>(&mut v25, v41), v42, v41, &v44);
            v40 = 0x2::linked_table::front<address, u64>(&v24);
        };
        0x2::linked_table::destroy_empty<address, u64>(v24);
        0x2::table::destroy_empty<address, u64>(v26);
        0x2::table::destroy_empty<address, u64>(v25);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0.balance, 0x2::balance::value<0x2::sui::SUI>(&v0.balance)), arg7), arg0.fee_manager);
        let v45 = Witness{dummy_field: false};
        0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::emit_play_history<Witness>(arg2, 0x1::u64::to_string(arg1), 0x1::u8::to_string(v18), v23.total_deposit_amount, v20, v22, &v45);
        v0.status = 2;
        let v46 = RoundFinished{
            round_key     : arg1,
            round_address : get_round_address(arg0, arg1),
        };
        0x2::event::emit<RoundFinished>(v46);
        start_new_round(arg0, arg7);
        if (0x2::table::length<address, u8>(&0x2::object_table::borrow<u64, Round>(&arg0.rounds, arg0.current_round_key).participant_team_key) > 0) {
            let v47 = arg0.current_round_key;
            update_round_drawable_time(arg0, v47, arg6);
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
        assert!(arg3 > 1 && arg3 <= 5, 9223374300304048152);
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

