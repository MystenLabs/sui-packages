module 0x520413c9ca49d6e6db244583778e2514056aaf109ee5e38fdc20420f7c9bbc0a::competition {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        treasury: address,
        supported_coins: 0x2::vec_map::VecMap<vector<u8>, bool>,
    }

    struct CompetitionBucket has key {
        id: 0x2::object::UID,
        competitions: 0x2::table::Table<vector<u8>, Competition>,
        winning_ticket_id: 0x1::option::Option<address>,
        start_ts: u64,
        end_ts: u64,
        answer: vector<u8>,
        revealed_answer: 0x1::string::String,
        img_digest: vector<u8>,
    }

    struct Competition has store {
        ticket_price: u64,
    }

    struct Ticket has key {
        id: 0x2::object::UID,
        serial_number: u64,
        competition_bucket_id: address,
        competition_id: vector<u8>,
        redeemed: bool,
        answer: vector<u64>,
    }

    public entry fun new(arg0: &AdminCap, arg1: vector<vector<u8>>, arg2: vector<u64>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = CompetitionBucket{
            id                : 0x2::object::new(arg7),
            competitions      : 0x2::table::new<vector<u8>, Competition>(arg7),
            winning_ticket_id : 0x1::option::none<address>(),
            start_ts          : arg3,
            end_ts            : arg4,
            answer            : arg5,
            revealed_answer   : 0x1::string::utf8(b""),
            img_digest        : arg6,
        };
        let v1 = &mut v0;
        add_competitions(arg0, v1, arg1, arg2);
        0x2::transfer::share_object<CompetitionBucket>(v0);
    }

    public entry fun add_competitions(arg0: &AdminCap, arg1: &mut CompetitionBucket, arg2: vector<vector<u8>>, arg3: vector<u64>) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 0x1::vector::length<vector<u8>>(&arg2), 6);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v1 = Competition{ticket_price: *0x1::vector::borrow<u64>(&arg3, v0)};
            0x2::table::add<vector<u8>, Competition>(&mut arg1.competitions, *0x1::vector::borrow<vector<u8>>(&arg2, v0), v1);
            v0 = v0 + 1;
        };
    }

    public entry fun add_operator_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<OperatorCap>(v0, arg1);
    }

    public entry fun buy_ticket<T0>(arg0: &Config, arg1: &CompetitionBucket, arg2: vector<u8>, arg3: &mut 0x520413c9ca49d6e6db244583778e2514056aaf109ee5e38fdc20420f7c9bbc0a::sequence_number::Registry, arg4: &mut 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = buy_ticket_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = 0;
        while (v1 < arg5) {
            0x2::transfer::transfer<Ticket>(0x1::vector::pop_back<Ticket>(&mut v0), 0x2::tx_context::sender(arg7));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<Ticket>(v0);
    }

    public entry fun buy_ticket_and_submit_answer<T0>(arg0: &Config, arg1: &CompetitionBucket, arg2: vector<u8>, arg3: &mut 0x520413c9ca49d6e6db244583778e2514056aaf109ee5e38fdc20420f7c9bbc0a::sequence_number::Registry, arg4: &mut 0x2::coin::Coin<T0>, arg5: vector<vector<u64>>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = buy_ticket_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8);
        let v1 = 0;
        while (v1 < arg6) {
            let v2 = 0x1::vector::pop_back<Ticket>(&mut v0);
            let v3 = &mut v2;
            submit_answer(v3, 0x1::vector::pop_back<vector<u64>>(&mut arg5));
            0x2::transfer::transfer<Ticket>(v2, 0x2::tx_context::sender(arg8));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<Ticket>(v0);
    }

    fun buy_ticket_internal<T0>(arg0: &Config, arg1: &CompetitionBucket, arg2: vector<u8>, arg3: &mut 0x520413c9ca49d6e6db244583778e2514056aaf109ee5e38fdc20420f7c9bbc0a::sequence_number::Registry, arg4: &mut 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<Ticket> {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 >= arg1.start_ts && v0 < arg1.end_ts, 0);
        let v1 = 0x2::table::borrow<vector<u8>, Competition>(&arg1.competitions, arg2).ticket_price * arg5;
        assert!(0x2::coin::value<T0>(arg4) >= v1, 1);
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(is_coin_supported(arg0, &v2), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg4, v1, arg7), arg0.treasury);
        let v3 = 0;
        let v4 = 0x1::vector::empty<Ticket>();
        while (v3 < arg5) {
            0x1::vector::push_back<Ticket>(&mut v4, new_ticket(arg3, 0x2::object::uid_to_address(&arg1.id), arg2, arg7));
            v3 = v3 + 1;
        };
        v4
    }

    public entry fun delete_operator_cap(arg0: OperatorCap) {
        let OperatorCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_answer(arg0: &Ticket) : &vector<u64> {
        &arg0.answer
    }

    public fun get_competition_bucket_data(arg0: &CompetitionBucket) : (0x1::option::Option<address>, u64, u64, vector<u8>, 0x1::string::String, vector<u8>) {
        (arg0.winning_ticket_id, arg0.start_ts, arg0.end_ts, arg0.answer, arg0.revealed_answer, arg0.img_digest)
    }

    public fun get_competition_data(arg0: &CompetitionBucket, arg1: vector<u8>) : u64 {
        0x2::table::borrow<vector<u8>, Competition>(&arg0.competitions, arg1).ticket_price
    }

    public fun get_ticket_data(arg0: &Ticket) : (u64, address, vector<u8>, bool) {
        (arg0.serial_number, arg0.competition_bucket_id, arg0.competition_id, arg0.redeemed)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Config{
            id              : 0x2::object::new(arg0),
            treasury        : 0x2::tx_context::sender(arg0),
            supported_coins : 0x2::vec_map::empty<vector<u8>, bool>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Config>(v1);
    }

    public fun is_coin_supported(arg0: &Config, arg1: &vector<u8>) : bool {
        0x2::vec_map::contains<vector<u8>, bool>(&arg0.supported_coins, arg1)
    }

    fun new_ticket(arg0: &mut 0x520413c9ca49d6e6db244583778e2514056aaf109ee5e38fdc20420f7c9bbc0a::sequence_number::Registry, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : Ticket {
        Ticket{
            id                    : 0x2::object::new(arg3),
            serial_number         : 0x520413c9ca49d6e6db244583778e2514056aaf109ee5e38fdc20420f7c9bbc0a::sequence_number::new(arg0),
            competition_bucket_id : arg1,
            competition_id        : arg2,
            redeemed              : false,
            answer                : vector[],
        }
    }

    public entry fun reveal_winner(arg0: &OperatorCap, arg1: &mut CompetitionBucket, arg2: 0x1::string::String, arg3: address) {
        let v0 = 0x1::hash::sha3_256(*0x1::string::bytes(&arg2));
        let v1 = 0x1::bcs::to_bytes<vector<u8>>(&v0);
        let v2 = 0x1::bcs::to_bytes<vector<u8>>(&arg1.answer);
        assert!(0x520413c9ca49d6e6db244583778e2514056aaf109ee5e38fdc20420f7c9bbc0a::compare::cmp_bcs_bytes(&v1, &v2) == 0, 5);
        arg1.winning_ticket_id = 0x1::option::some<address>(arg3);
        arg1.revealed_answer = arg2;
    }

    public entry fun submit_answer(arg0: &mut Ticket, arg1: vector<u64>) {
        assert!(0x1::vector::length<u64>(&arg1) == 2, 2);
        assert!(!arg0.redeemed, 3);
        arg0.redeemed = true;
        arg0.answer = arg1;
    }

    public entry fun update_config(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: vector<0x1::ascii::String>) {
        arg1.supported_coins = 0x2::vec_map::empty<vector<u8>, bool>();
        arg1.treasury = arg2;
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::ascii::String>(&arg3)) {
            0x2::vec_map::insert<vector<u8>, bool>(&mut arg1.supported_coins, 0x1::ascii::into_bytes(*0x1::vector::borrow<0x1::ascii::String>(&arg3, v0)), true);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

