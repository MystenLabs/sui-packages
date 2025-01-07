module 0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::main {
    struct Raffle<T0: store + key, phantom T1> has store, key {
        id: 0x2::object::UID,
        creator: address,
        limit: u64,
        tickets: u64,
        tickets_sold: u64,
        end_timestamp: u64,
        round: u64,
        fee_collector: address,
        ticket_price: u64,
        prize: 0x1::option::Option<T0>,
        participants: 0x2::table::Table<address, 0x2::object::ID>,
        winner: 0x1::option::Option<u64>,
        collection: u64,
        collections: 0x2::object::ID,
        proceeds: 0x2::balance::Balance<T1>,
    }

    struct Participation has store, key {
        id: 0x2::object::UID,
        raffle_id: 0x2::object::ID,
        tickets: vector<u64>,
    }

    public entry fun new<T0: store + key, T1>(arg0: T0, arg1: &mut 0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::project_config::ProjectConfig, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::project_config::contains_item(arg1, arg2, 0x2::object::id_address<T0>(&arg0)), 1);
        assert!(0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::project_config::is_enabled(arg1, arg2), 2);
        assert!(arg5 > 0x2::clock::timestamp_ms(arg7), 4);
        let (v0, v1) = 0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::project_config::deep_immutable(arg1);
        let v2 = Raffle<T0, T1>{
            id            : 0x2::object::new(arg8),
            creator       : 0x2::tx_context::sender(arg8),
            limit         : arg3,
            tickets       : arg4,
            tickets_sold  : 0,
            end_timestamp : arg5,
            round         : (arg5 - 0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::drand_lib::get_genesis()) / 30,
            fee_collector : 0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::admin::get_owner(v0),
            ticket_price  : arg6,
            prize         : 0x1::option::some<T0>(arg0),
            participants  : 0x2::table::new<address, 0x2::object::ID>(arg8),
            winner        : 0x1::option::none<u64>(),
            collection    : arg2,
            collections   : 0x2::object::id<0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::project_config::WhitelistedCollections>(v1),
            proceeds      : 0x2::balance::zero<T1>(),
        };
        let v3 = 0x2::object::id<Raffle<T0, T1>>(&v2);
        0x2::transfer::public_share_object<Raffle<T0, T1>>(v2);
        0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::project_config::add_raffle(arg1, v3);
        v3
    }

    public entry fun buy<T0: store + key, T1>(arg0: &mut Raffle<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut Participation, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.end_timestamp > 0x2::clock::timestamp_ms(arg4), 4);
        assert!(arg0.tickets_sold + arg3 <= arg0.tickets, 3);
        assert!(arg0.limit == 0 || 0x1::vector::length<u64>(&arg2.tickets) + arg3 <= arg0.limit, 3);
        assert!(0x2::balance::value<T1>(0x2::coin::balance<T1>(&arg1)) == arg3 * arg0.ticket_price, 1);
        let v0 = 0;
        while (v0 < arg3) {
            0x1::vector::push_back<u64>(&mut arg2.tickets, arg0.tickets_sold + v0);
            v0 = v0 + 1;
        };
        arg0.tickets_sold = arg0.tickets_sold + arg3;
        0x2::coin::put<T1>(&mut arg0.proceeds, arg1);
        if (arg0.tickets_sold == arg0.tickets) {
            arg0.end_timestamp = 0x2::clock::timestamp_ms(arg4);
            arg0.round = (arg0.end_timestamp - 0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::drand_lib::get_genesis() + 30) / 30;
        };
    }

    public entry fun claim<T0: store + key, T1>(arg0: &mut Raffle<T0, T1>, arg1: &mut Participation, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.raffle_id == 0x2::object::id<Raffle<T0, T1>>(arg0), 1);
        assert!(!0x1::option::is_none<u64>(&arg0.winner), 1);
        assert!(!0x1::option::is_none<T0>(&arg0.prize), 1);
        let (v0, _) = 0x1::vector::index_of<u64>(&arg1.tickets, 0x1::option::borrow<u64>(&arg0.winner));
        assert!(v0, 1);
        0x2::transfer::public_transfer<T0>(0x1::option::extract<T0>(&mut arg0.prize), 0x2::tx_context::sender(arg2));
    }

    public entry fun draw<T0: store + key, T1>(arg0: &mut Raffle<T0, T1>, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.end_timestamp <= 0x2::clock::timestamp_ms(arg1), 5);
        assert!(arg0.winner == 0x1::option::none<u64>(), 1);
        assert!(arg0.tickets_sold > 0, 1);
        0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::drand_lib::verify_drand_signature(arg2, arg3, arg0.round);
        let v0 = 0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::drand_lib::derive_randomness(arg2);
        arg0.winner = 0x1::option::some<u64>(0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::drand_lib::safe_selection(arg0.tickets_sold, &v0));
        let v1 = 0x2::balance::value<T1>(&arg0.proceeds);
        let v2 = v1 * 5 / 100;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.proceeds, v2, arg4), 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.proceeds, v1 - v2, arg4), 0x2::tx_context::sender(arg4));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        initialize(arg0);
    }

    public entry fun init_participation<T0: store + key, T1>(arg0: &mut Raffle<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.end_timestamp > 0x2::clock::timestamp_ms(arg1), 4);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.participants, 0x2::tx_context::sender(arg2)), 6);
        let v0 = Participation{
            id        : 0x2::object::new(arg2),
            raffle_id : 0x2::object::id<Raffle<T0, T1>>(arg0),
            tickets   : 0x1::vector::empty<u64>(),
        };
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.participants, 0x2::tx_context::sender(arg2), 0x2::object::id<Participation>(&v0));
        0x2::transfer::public_transfer<Participation>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun initialize(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x5c1f0a800cecdf3c6ff620257688332ed8e9b771528b8fa56c33268676046f01::project_config::initialize(arg0)
    }

    // decompiled from Move bytecode v6
}

