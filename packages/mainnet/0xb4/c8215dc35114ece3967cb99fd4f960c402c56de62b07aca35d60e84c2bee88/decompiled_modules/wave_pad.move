module 0xb4c8215dc35114ece3967cb99fd4f960c402c56de62b07aca35d60e84c2bee88::wave_pad {
    struct Event<phantom T0> has store, key {
        id: 0x2::object::UID,
        operator_pk: vector<u8>,
        version: u8,
        is_paused: bool,
        balance: 0x2::balance::Balance<T0>,
        rounds: vector<Round>,
    }

    struct Round has store {
        price: u64,
        start_time: u64,
        end_time: u64,
        max_buy_per_user: u64,
        total_sell: u64,
        sold: u64,
    }

    struct EventCreated has copy, drop {
        event_id: 0x2::object::ID,
        payment_type: 0x1::string::String,
        is_paused: bool,
    }

    struct EventUpdated has copy, drop {
        event_id: 0x2::object::ID,
        is_paused: bool,
    }

    struct RoundUpdated has copy, drop {
        event_id: 0x2::object::ID,
        round_id: u64,
        start_time: u64,
        end_time: u64,
        price: u64,
        max_buy_per_user: u64,
        total_sell: u64,
    }

    struct TicketBought has copy, drop, store {
        event_id: 0x2::object::ID,
        round_id: u64,
        receiver: address,
        price: u64,
        amount: u64,
        payment_type: 0x1::string::String,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    entry fun admin_withdraw<T0>(arg0: &OwnerCap, arg1: &mut Event<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    entry fun buy_ticket<T0>(arg0: &mut Event<T0>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 7);
        assert!(arg0.is_paused == false, 10);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::object::id<Event<T0>>(arg0);
        validate_signature(arg0.operator_pk, v1, arg1, v0, arg3, arg4, arg5, arg6);
        assert!(arg1 < 0x1::vector::length<Round>(&arg0.rounds), 1);
        let v2 = 0x1::vector::borrow_mut<Round>(&mut arg0.rounds, arg1);
        let v3 = 0x2::clock::timestamp_ms(arg6);
        assert!(v2.start_time == 0 || v3 >= v2.start_time, 8);
        assert!(v2.end_time == 0 || v3 <= v2.end_time, 9);
        assert!(v2.total_sell == 0 || v2.sold + arg3 <= v2.total_sell, 11);
        let v4 = 0x2::bcs::to_bytes<address>(&v0);
        let v5 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<0x1::string::String>(&v5));
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&arg1));
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v4)) {
            assert!(v2.max_buy_per_user == 0 || arg3 <= v2.max_buy_per_user, 3);
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, v4, arg3);
        } else {
            let v6 = 0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg0.id, v4);
            assert!(v2.max_buy_per_user == 0 || *v6 + arg3 <= v2.max_buy_per_user, 3);
            *v6 = *v6 + arg3;
        };
        v2.sold = v2.sold + arg3;
        let v7 = v2.price * arg3;
        assert!(0x2::coin::value<T0>(&arg2) >= v7, 2);
        0x2::pay::keep<T0>(arg2, arg7);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v7, arg7)));
        let v8 = TicketBought{
            event_id     : v1,
            round_id     : arg1,
            receiver     : v0,
            price        : v2.price,
            amount       : arg3,
            payment_type : type_to_string<T0>(),
        };
        0x2::event::emit<TicketBought>(v8);
    }

    public entry fun create_event<T0>(arg0: &OwnerCap, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = @0xfdefe17a05a90060ef50ef578992df05f55ee11d31877d0c3010cbe36781f1b0;
        let v2 = Event<T0>{
            id          : v0,
            operator_pk : 0x2::bcs::to_bytes<address>(&v1),
            version     : 1,
            is_paused   : arg1,
            balance     : 0x2::balance::zero<T0>(),
            rounds      : 0x1::vector::empty<Round>(),
        };
        0x2::transfer::share_object<Event<T0>>(v2);
        let v3 = EventCreated{
            event_id     : 0x2::object::uid_to_inner(&v0),
            payment_type : type_to_string<T0>(),
            is_paused    : arg1,
        };
        0x2::event::emit<EventCreated>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun migrate<T0>(arg0: &OwnerCap, arg1: &mut Event<T0>) {
        assert!(arg1.version < 1, 6);
        arg1.version = 1;
    }

    entry fun pause_event<T0>(arg0: &OwnerCap, arg1: &mut Event<T0>, arg2: bool) {
        arg1.is_paused = arg2;
        let v0 = EventUpdated{
            event_id  : 0x2::object::id<Event<T0>>(arg1),
            is_paused : arg2,
        };
        0x2::event::emit<EventUpdated>(v0);
    }

    fun type_to_string<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    entry fun update_operator<T0>(arg0: &OwnerCap, arg1: &mut Event<T0>, arg2: vector<u8>) {
        arg1.operator_pk = arg2;
    }

    public entry fun upsert_round<T0>(arg0: &OwnerCap, arg1: &mut Event<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = 0x1::vector::length<Round>(&arg1.rounds);
        let v1 = arg2;
        if (arg2 < v0) {
            let v2 = 0x1::vector::borrow_mut<Round>(&mut arg1.rounds, arg2);
            v2.start_time = arg3;
            v2.end_time = arg4;
            v2.price = arg5;
            v2.max_buy_per_user = arg6;
            v2.total_sell = arg7;
        } else {
            v1 = v0;
            let v3 = Round{
                price            : arg5,
                start_time       : arg3,
                end_time         : arg4,
                max_buy_per_user : arg6,
                total_sell       : arg7,
                sold             : 0,
            };
            0x1::vector::push_back<Round>(&mut arg1.rounds, v3);
        };
        let v4 = RoundUpdated{
            event_id         : 0x2::object::id<Event<T0>>(arg1),
            round_id         : v1,
            start_time       : arg3,
            end_time         : arg4,
            price            : arg5,
            max_buy_per_user : arg6,
            total_sell       : arg7,
        };
        0x2::event::emit<RoundUpdated>(v4);
    }

    fun validate_signature(arg0: vector<u8>, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock) {
        let v0 = 0x1::string::utf8(b"WAVE_PAD_BUY_TICKET:");
        let v1 = 0x2::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x2::object::ID>(&arg1));
        let v2 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg2));
        let v3 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v3));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg3));
        let v4 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v4));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg4));
        let v5 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v5));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg5));
        assert!(0x2::ed25519::ed25519_verify(&arg6, &arg0, &v1) == true, 4);
        assert!(0x2::clock::timestamp_ms(arg7) < arg5, 5);
    }

    // decompiled from Move bytecode v6
}

