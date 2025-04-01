module 0x5dd43dba06df5557cf175c92e933787d7dbc36cb3a53b45b80b1eb512758093a::pie {
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

    struct Round has store, key {
        id: 0x2::object::UID,
        key: u64,
        status: u8,
        current_entry_index: u64,
        value_per_entry: u64,
        deposits: vector<Deposit>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        draw_entry_index: 0x1::option::Option<u64>,
        winner: 0x1::option::Option<address>,
        drawer: 0x1::option::Option<address>,
        participant_amount: 0x2::table::Table<address, u64>,
        drawable_time: u64,
        draw_time: u64,
    }

    struct Game has store, key {
        id: 0x2::object::UID,
        rounds: 0x2::object_table::ObjectTable<u64, Round>,
        fee_in_bp: u16,
        round_duration: u64,
        current_round_key: u64,
        value_per_entry: u64,
        fee_manager: address,
        max_future_round: u64,
        max_deposits_per_round: u64,
    }

    struct Deposited has copy, drop {
        start_round_key: u64,
        amounts: vector<u64>,
        balances: vector<u64>,
        entry_indexes: vector<u64>,
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
        while (v3 < 0x1::vector::length<Deposit>(&v1.deposits)) {
            let v4 = 0x1::vector::borrow_mut<Deposit>(&mut v1.deposits, v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v1.balance, v4.amount, arg2), v4.depositor);
            v3 = v3 + 1;
        };
        start_new_round(arg0, arg2);
        if (0x1::vector::length<Deposit>(&0x2::object_table::borrow<u64, Round>(&arg0.rounds, arg0.current_round_key).deposits) > 0) {
            let v5 = arg0.current_round_key;
            update_round_drawable_time(arg0, v5, arg1);
        };
    }

    fun check_round_status(arg0: &Game, arg1: u64, arg2: u8) {
        assert!(0x2::object_table::borrow<u64, Round>(&arg0.rounds, arg1).status == arg2, 9223373703302414342);
    }

    fun create_new_round_if_not_exists(arg0: &mut Game, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::object_table::contains<u64, Round>(&arg0.rounds, arg1)) {
            return
        };
        let v0 = Round{
            id                  : 0x2::object::new(arg2),
            key                 : arg1,
            status              : 0,
            current_entry_index : 0,
            value_per_entry     : arg0.value_per_entry,
            deposits            : 0x1::vector::empty<Deposit>(),
            balance             : 0x2::balance::zero<0x2::sui::SUI>(),
            draw_entry_index    : 0x1::option::none<u64>(),
            winner              : 0x1::option::none<address>(),
            drawer              : 0x1::option::none<address>(),
            participant_amount  : 0x2::table::new<address, u64>(arg2),
            drawable_time       : 0,
            draw_time           : 0,
        };
        0x2::object_table::add<u64, Round>(&mut arg0.rounds, arg1, v0);
        let v1 = 0x2::object_table::value_id<u64, Round>(&arg0.rounds, arg1);
        let v2 = RoundCreated{
            round_key     : arg1,
            round_address : 0x2::object::id_to_address(0x1::option::borrow<0x2::object::ID>(&v1)),
        };
        0x2::event::emit<RoundCreated>(v2);
    }

    entry fun deposit(arg0: &mut Game, arg1: vector<u64>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::PlayManager, arg4: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun deposit_v2(arg0: &mut Game, arg1: u64, arg2: vector<u64>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::PlayManager, arg5: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::check_version_gte<Witness>(arg5, 2);
        assert!(0x1::vector::length<u64>(&arg2) > 0 && 0x1::vector::length<u64>(&arg2) <= arg0.max_future_round, 9223372612380983306);
        assert!(arg1 == arg0.current_round_key, 9223372625266802712);
        check_round_status(arg0, arg1, 1);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg2)) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg2, v1);
            v1 = v1 + 1;
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == v0, 9223372663920853006);
        update_drawable_time_if_needed(arg0, arg1, arg6);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        let v3 = vector[];
        let v4 = vector[];
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&arg2)) {
            create_new_round_if_not_exists(arg0, arg1, arg7);
            let v6 = 0x2::object_table::borrow_mut<u64, Round>(&mut arg0.rounds, arg1);
            assert!(0x1::vector::length<Deposit>(&v6.deposits) < arg0.max_deposits_per_round, 9223372711165624336);
            let v7 = *0x1::vector::borrow<u64>(&arg2, v5);
            assert!(v7 >= v6.value_per_entry, 9223372724050264076);
            assert!(v7 % v6.value_per_entry == 0, 9223372728345231372);
            let v8 = v6.current_entry_index + v7 / v6.value_per_entry;
            let v9 = Deposit{
                id          : 0x2::object::new(arg7),
                depositor   : 0x2::tx_context::sender(arg7),
                amount      : v7,
                entry_index : v8,
            };
            0x1::vector::push_back<Deposit>(&mut v6.deposits, v9);
            v6.current_entry_index = v8;
            0x2::balance::join<0x2::sui::SUI>(&mut v6.balance, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v7));
            if (!0x2::table::contains<address, u64>(&v6.participant_amount, 0x2::tx_context::sender(arg7))) {
                0x2::table::add<address, u64>(&mut v6.participant_amount, 0x2::tx_context::sender(arg7), 0);
            };
            let v10 = 0x2::table::borrow_mut<address, u64>(&mut v6.participant_amount, 0x2::tx_context::sender(arg7));
            *v10 = *v10 + v7;
            0x1::vector::push_back<u64>(&mut v3, v8);
            0x1::vector::push_back<u64>(&mut v4, 0x2::balance::value<0x2::sui::SUI>(&v6.balance));
            arg1 = arg1 + 1;
            v5 = v5 + 1;
        };
        let v11 = Deposited{
            start_round_key : arg1,
            amounts         : arg2,
            balances        : v4,
            entry_indexes   : v3,
            depositor       : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<Deposited>(v11);
        let v12 = Witness{dummy_field: false};
        0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::record_play<Witness>(arg4, v0, 0x2::tx_context::sender(arg7), &v12, arg6, arg7);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
    }

    entry fun draw(arg0: &mut Game, arg1: &mut 0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::PlayManager, arg2: &mut 0xef199024460c12d9880f7b6bb9712de2a56b3761fd5a480f297dadb60f956c03::referral::ReferralRegistry, arg3: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun draw_v2(arg0: &mut Game, arg1: u64, arg2: &mut 0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::PlayManager, arg3: &mut 0xef199024460c12d9880f7b6bb9712de2a56b3761fd5a480f297dadb60f956c03::referral::ReferralRegistry, arg4: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::check_version_gte<Witness>(arg4, 2);
        assert!(arg1 == arg0.current_round_key, 9223373020403793944);
        check_round_status(arg0, arg1, 1);
        let v0 = 0x2::object_table::borrow_mut<u64, Round>(&mut arg0.rounds, arg1);
        assert!(0x1::vector::length<Deposit>(&v0.deposits) > 0 && 0x2::table::length<address, u64>(&v0.participant_amount) > 0, 9223373033288302610);
        assert!(v0.drawable_time > 0 && v0.drawable_time < 0x2::clock::timestamp_ms(arg6), 9223373037582614536);
        assert!(0x2::table::contains<address, u64>(&v0.participant_amount, 0x2::tx_context::sender(arg7)), 9223373041878499350);
        if (0x2::table::length<address, u64>(&v0.participant_amount) < 2) {
            cancel_current_round(arg0, arg6, arg7);
            return
        };
        let v1 = 0x2::random::new_generator(arg5, arg7);
        let v2 = 0x2::random::generate_u64_in_range(&mut v1, 1, v0.current_entry_index);
        let v3 = vector[];
        let v4 = 0;
        while (v4 < 0x1::vector::length<Deposit>(&v0.deposits)) {
            0x1::vector::push_back<u64>(&mut v3, 0x1::vector::borrow<Deposit>(&v0.deposits, v4).entry_index);
            v4 = v4 + 1;
        };
        let v5 = 0x1::vector::borrow<Deposit>(&v0.deposits, 0xf6b668302a8d006e599bf2c9bf7377e631db1a04d30158fd5478b079e92bced8::common::find_upper_bound(v3, v2)).depositor;
        v0.winner = 0x1::option::some<address>(v5);
        v0.drawer = 0x1::option::some<address>(0x2::tx_context::sender(arg7));
        v0.draw_time = 0x2::clock::timestamp_ms(arg6);
        v0.draw_entry_index = 0x1::option::some<u64>(v2);
        let v6 = Witness{dummy_field: false};
        0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::increment_point<Witness>(arg2, *0x2::table::borrow<address, u64>(&v0.participant_amount, 0x2::tx_context::sender(arg7)), 0x2::tx_context::sender(arg7), 0x1::type_name::get<0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::point::Witness>(), b"MysteryPoint", &v6, arg6, arg7);
        let v7 = v0.value_per_entry * v0.current_entry_index;
        let v8 = v7 * (arg0.fee_in_bp as u64) / 10000;
        let v9 = v7 - v8;
        assert!(v8 + v9 == 0x2::balance::value<0x2::sui::SUI>(&v0.balance), 9223373230856929300);
        let v10 = 0x2::balance::split<0x2::sui::SUI>(&mut v0.balance, v8);
        let v11 = 0xef199024460c12d9880f7b6bb9712de2a56b3761fd5a480f297dadb60f956c03::referral::get_referral_fee(arg3, v5, v8);
        if (v11 > 0) {
            0xef199024460c12d9880f7b6bb9712de2a56b3761fd5a480f297dadb60f956c03::referral::earn_referral_balance(arg3, v5, arg4, 0x2::balance::split<0x2::sui::SUI>(&mut v10, v11));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v10, arg7), arg0.fee_manager);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0.balance, v9), arg7), v5);
        let v12 = Witness{dummy_field: false};
        0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::emit_play_history<Witness>(arg2, 0x1::u64::to_string(arg1), 0x2::address::to_string(v5), *0x2::table::borrow<address, u64>(&v0.participant_amount, v5), v7, v9, &v12);
        let v13 = Witness{dummy_field: false};
        0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::record_play_activity<Witness>(arg2, false, 0, v7, v9, v5, &v13);
        v0.status = 2;
        let v14 = RoundFinished{
            round_key     : arg1,
            round_address : get_round_address(arg0, arg1),
        };
        0x2::event::emit<RoundFinished>(v14);
        start_new_round(arg0, arg7);
        if (0x1::vector::length<Deposit>(&0x2::object_table::borrow<u64, Round>(&arg0.rounds, arg0.current_round_key).deposits) > 0) {
            let v15 = arg0.current_round_key;
            update_round_drawable_time(arg0, v15, arg6);
        };
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

    entry fun update_game(arg0: &AdminCap, arg1: &mut Game, arg2: u16, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        arg1.fee_in_bp = arg2;
        arg1.round_duration = arg3;
        arg1.value_per_entry = arg4;
        arg1.fee_manager = arg5;
        arg1.max_future_round = arg6;
        arg1.max_deposits_per_round = arg7;
    }

    fun update_round_drawable_time(arg0: &mut Game, arg1: u64, arg2: &0x2::clock::Clock) {
        0x2::object_table::borrow_mut<u64, Round>(&mut arg0.rounds, arg1).drawable_time = 0x2::clock::timestamp_ms(arg2) + arg0.round_duration;
    }

    // decompiled from Move bytecode v6
}

