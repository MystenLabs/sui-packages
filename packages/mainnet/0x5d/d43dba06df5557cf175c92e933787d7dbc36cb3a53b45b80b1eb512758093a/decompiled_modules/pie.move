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
        while (v3 < 0x1::vector::length<Deposit>(&v1.deposits)) {
            let v4 = 0x1::vector::borrow_mut<Deposit>(&mut v1.deposits, v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v1.balance, v4.amount, arg3), v4.depositor);
            v3 = v3 + 1;
        };
        let v5 = Witness{dummy_field: false};
        0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::cancel_play<Witness>(arg1, *0x2::table::borrow<address, u64>(&v1.participant_amount, 0x2::tx_context::sender(arg3)), 0x2::tx_context::sender(arg3), &v5, arg2, arg3);
        start_new_round(arg0, arg3);
        if (0x1::vector::length<Deposit>(&0x2::object_table::borrow<u64, Round>(&arg0.rounds, arg0.current_round_key).deposits) > 0) {
            let v6 = arg0.current_round_key;
            update_round_drawable_time(arg0, v6, arg2);
        };
    }

    fun check_round_status(arg0: &Game, arg1: u64, arg2: u8) {
        assert!(0x2::object_table::borrow<u64, Round>(&arg0.rounds, arg1).status == arg2, 9223373565863460870);
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
        0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::check_version_gte<Witness>(arg4, 1);
        assert!(0x1::vector::length<u64>(&arg1) > 0 && 0x1::vector::length<u64>(&arg1) <= arg0.max_future_round, 9223372547956473866);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg1, v1);
            v1 = v1 + 1;
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == v0, 9223372582316474382);
        let v2 = arg0.current_round_key;
        check_round_status(arg0, v2, 1);
        update_drawable_time_if_needed(arg0, v2, arg5);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v4 = vector[];
        let v5 = vector[];
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&arg1)) {
            create_new_round_if_not_exists(arg0, v2, arg6);
            let v7 = 0x2::object_table::borrow_mut<u64, Round>(&mut arg0.rounds, v2);
            assert!(0x1::vector::length<Deposit>(&v7.deposits) < arg0.max_deposits_per_round, 9223372642446147600);
            let v8 = *0x1::vector::borrow<u64>(&arg1, v6);
            assert!(v8 >= v7.value_per_entry, 9223372655330787340);
            assert!(v8 % v7.value_per_entry == 0, 9223372659625754636);
            let v9 = v7.current_entry_index + v8 / v7.value_per_entry;
            let v10 = Deposit{
                id          : 0x2::object::new(arg6),
                depositor   : 0x2::tx_context::sender(arg6),
                amount      : v8,
                entry_index : v9,
            };
            0x1::vector::push_back<Deposit>(&mut v7.deposits, v10);
            v7.current_entry_index = v9;
            0x2::balance::join<0x2::sui::SUI>(&mut v7.balance, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v8));
            if (!0x2::table::contains<address, u64>(&v7.participant_amount, 0x2::tx_context::sender(arg6))) {
                0x2::table::add<address, u64>(&mut v7.participant_amount, 0x2::tx_context::sender(arg6), 0);
            };
            let v11 = 0x2::table::borrow_mut<address, u64>(&mut v7.participant_amount, 0x2::tx_context::sender(arg6));
            *v11 = *v11 + v8;
            0x1::vector::push_back<u64>(&mut v4, v9);
            0x1::vector::push_back<u64>(&mut v5, 0x2::balance::value<0x2::sui::SUI>(&v7.balance));
            v2 = v2 + 1;
            v6 = v6 + 1;
        };
        let v12 = Deposited{
            start_round_key : v2,
            amounts         : arg1,
            balances        : v5,
            entry_indexes   : v4,
            depositor       : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<Deposited>(v12);
        let v13 = Witness{dummy_field: false};
        0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::record_play<Witness>(arg3, v0, 0x2::tx_context::sender(arg6), &v13, arg5, arg6);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
    }

    entry fun draw(arg0: &mut Game, arg1: &mut 0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::PlayManager, arg2: &mut 0xef199024460c12d9880f7b6bb9712de2a56b3761fd5a480f297dadb60f956c03::referral::ReferralRegistry, arg3: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::check_version_gte<Witness>(arg3, 1);
        check_round_status(arg0, arg0.current_round_key, 1);
        let v0 = arg0.current_round_key;
        let v1 = 0x2::object_table::borrow_mut<u64, Round>(&mut arg0.rounds, v0);
        assert!(0x1::vector::length<Deposit>(&v1.deposits) > 0 && 0x2::table::length<address, u64>(&v1.participant_amount) > 0, 9223372908734251026);
        assert!(v1.drawable_time > 0 && v1.drawable_time < 0x2::clock::timestamp_ms(arg5), 9223372913028562952);
        assert!(0x2::table::contains<address, u64>(&v1.participant_amount, 0x2::tx_context::sender(arg6)), 9223372917324447766);
        if (0x2::table::length<address, u64>(&v1.participant_amount) < 2) {
            cancel_current_round(arg0, arg1, arg5, arg6);
            return
        };
        let v2 = 0x2::random::new_generator(arg4, arg6);
        let v3 = 0x2::random::generate_u64_in_range(&mut v2, 1, v1.current_entry_index);
        let v4 = vector[];
        let v5 = 0;
        while (v5 < 0x1::vector::length<Deposit>(&v1.deposits)) {
            0x1::vector::push_back<u64>(&mut v4, 0x1::vector::borrow<Deposit>(&v1.deposits, v5).entry_index);
            v5 = v5 + 1;
        };
        let v6 = 0x1::vector::borrow<Deposit>(&v1.deposits, 0xf6b668302a8d006e599bf2c9bf7377e631db1a04d30158fd5478b079e92bced8::common::find_upper_bound(v4, v3)).depositor;
        v1.winner = 0x1::option::some<address>(v6);
        v1.drawer = 0x1::option::some<address>(0x2::tx_context::sender(arg6));
        v1.draw_time = 0x2::clock::timestamp_ms(arg5);
        v1.draw_entry_index = 0x1::option::some<u64>(v3);
        let v7 = Witness{dummy_field: false};
        0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::increment_point<Witness>(arg1, *0x2::table::borrow<address, u64>(&v1.participant_amount, 0x2::tx_context::sender(arg6)), 0x2::tx_context::sender(arg6), 0x1::type_name::get<0xf8ee6671c195bb61ee5effbccb2c4fdf6492c7395d16f498c142468d38ad9e54::point::Witness>(), &v7, arg5, arg6);
        let v8 = v1.value_per_entry * v1.current_entry_index;
        let v9 = v8 * (arg0.fee_in_bp as u64) / 10000;
        let v10 = v8 - v9;
        assert!(v9 + v10 == 0x2::balance::value<0x2::sui::SUI>(&v1.balance), 9223373102007910420);
        let v11 = 0x2::balance::split<0x2::sui::SUI>(&mut v1.balance, v9);
        let v12 = 0xef199024460c12d9880f7b6bb9712de2a56b3761fd5a480f297dadb60f956c03::referral::get_referral_fee(arg2, v6, v9);
        if (v12 > 0) {
            0xef199024460c12d9880f7b6bb9712de2a56b3761fd5a480f297dadb60f956c03::referral::earn_referral_balance(arg2, v6, arg3, 0x2::balance::split<0x2::sui::SUI>(&mut v11, v12));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v11, arg6), arg0.fee_manager);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1.balance, v10), arg6), v6);
        let v13 = Witness{dummy_field: false};
        0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::emit_win_play_history<Witness>(arg1, v6, *0x2::table::borrow<address, u64>(&v1.participant_amount, v6), v8, &v13);
        v1.status = 2;
        let v14 = RoundFinished{
            round_key     : v0,
            round_address : get_round_address(arg0, v0),
        };
        0x2::event::emit<RoundFinished>(v14);
        start_new_round(arg0, arg6);
        if (0x1::vector::length<Deposit>(&0x2::object_table::borrow<u64, Round>(&arg0.rounds, arg0.current_round_key).deposits) > 0) {
            let v15 = arg0.current_round_key;
            update_round_drawable_time(arg0, v15, arg5);
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

