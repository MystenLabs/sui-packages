module 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::raffle {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct Raffle<phantom T0> has store, key {
        id: 0x2::object::UID,
        admin: address,
        admin_cap_id: 0x2::object::ID,
        active: bool,
        drawn: bool,
        duration: u64,
        deadline: u64,
        winners_count: u64,
        sold: u64,
        supply: u64,
        max_per_address: u64,
        price: u64,
        prize_ref: 0x1::option::Option<0x2::object::ID>,
        counter: 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::pseudorandom::Counter,
    }

    struct RaffleAdminCap has store, key {
        id: 0x2::object::UID,
        raffle_id: 0x2::object::ID,
    }

    struct WarehouseKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RaffleCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        admin: address,
    }

    struct RaffleActivatedEvent has copy, drop {
        id: 0x2::object::ID,
        admin: address,
        deadline: u64,
        winners_count: u64,
        supply: u64,
        max_per_address: u64,
        price_type: 0x1::ascii::String,
        price: u64,
    }

    struct RaffleDrawnEvent has copy, drop {
        id: 0x2::object::ID,
        admin: address,
    }

    public(friend) fun activate_raffle<T0>(arg0: &mut Raffle<T0>, arg1: &0x2::clock::Clock, arg2: &RaffleAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        activate_raffle_<T0>(arg0, arg1, arg2, arg3);
    }

    fun activate_raffle_<T0>(arg0: &mut Raffle<T0>, arg1: &0x2::clock::Clock, arg2: &RaffleAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert_raffle_admin<T0>(arg0, arg2);
        assert_inactive<T0>(arg0);
        assert_has_prize<T0>(arg0);
        arg0.deadline = 0x2::clock::timestamp_ms(arg1) + arg0.duration;
        arg0.active = true;
        let v0 = 0x1::type_name::get<T0>();
        let v1 = RaffleActivatedEvent{
            id              : 0x2::object::uid_to_inner(&arg0.id),
            admin           : 0x2::tx_context::sender(arg3),
            deadline        : arg0.deadline,
            winners_count   : arg0.winners_count,
            supply          : arg0.supply,
            max_per_address : arg0.max_per_address,
            price_type      : *0x1::type_name::borrow_string(&v0),
            price           : arg0.price,
        };
        0x2::event::emit<RaffleActivatedEvent>(v1);
    }

    public fun active<T0>(arg0: &Raffle<T0>) : bool {
        arg0.active
    }

    fun add_proceeds_<T0>(arg0: &mut Raffle<T0>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::marker<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::Marker<T0>, 0x2::coin::Coin<T0>>(&arg0.id, v0)) {
            0x2::dynamic_field::add<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::Marker<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v0, arg1);
        } else {
            0x2::coin::join<T0>(0x2::dynamic_field::borrow_mut<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::Marker<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v0), arg1);
        };
    }

    public fun admin<T0>(arg0: &Raffle<T0>) : address {
        arg0.admin
    }

    public fun admin_cap_id<T0>(arg0: &Raffle<T0>) : 0x2::object::ID {
        arg0.admin_cap_id
    }

    public fun assert_active<T0>(arg0: &Raffle<T0>) {
        assert!(arg0.active == true, 7);
    }

    public fun assert_before_deadline<T0>(arg0: &Raffle<T0>, arg1: u64) {
        assert!(arg1 <= arg0.deadline, 4);
    }

    public fun assert_drawn<T0>(arg0: &Raffle<T0>) {
        assert!(arg0.drawn == true, 11);
    }

    public fun assert_has_prize<T0>(arg0: &Raffle<T0>) {
        assert!(arg0.winners_count != 0, 9);
    }

    public fun assert_inactive<T0>(arg0: &Raffle<T0>) {
        assert!(arg0.active == false, 8);
    }

    public fun assert_not_admin<T0>(arg0: &Raffle<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) != arg0.admin, 15);
    }

    public fun assert_not_claimed(arg0: bool) {
        assert!(arg0 == false, 12);
    }

    public fun assert_not_drawn<T0>(arg0: &Raffle<T0>) {
        assert!(arg0.drawn == false, 10);
    }

    public fun assert_past_deadline<T0>(arg0: &Raffle<T0>, arg1: u64) {
        assert!(arg1 > arg0.deadline, 5);
    }

    public fun assert_raffle_admin<T0>(arg0: &Raffle<T0>, arg1: &RaffleAdminCap) {
        assert!(arg0.admin_cap_id == 0x2::object::id<RaffleAdminCap>(arg1), 6);
    }

    public fun balance<T0>(arg0: &Raffle<T0>) : &0x2::coin::Coin<T0> {
        0x2::dynamic_field::borrow<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::Marker<T0>, 0x2::coin::Coin<T0>>(&arg0.id, 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::marker<T0>())
    }

    public entry fun buy_ticket<T0>(arg0: &mut Raffle<T0>, arg1: &mut 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::ticket_bag::TicketBag, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        buy_ticket_<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun buy_ticket_<T0>(arg0: &mut Raffle<T0>, arg1: &mut 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::ticket_bag::TicketBag, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_not_admin<T0>(arg0, arg5);
        assert_before_deadline<T0>(arg0, 0x2::clock::timestamp_ms(arg4));
        assert_active<T0>(arg0);
        assert!(arg2 <= arg0.max_per_address, 3);
        if (arg0.supply != 0) {
            assert!(arg0.sold + arg2 <= arg0.supply, 2);
        };
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = buyers<T0>(arg0);
        if (!!0x2::table::contains<address, u64>(v1, v0)) {
            assert!(*0x2::table::borrow<address, u64>(v1, v0) + arg2 <= arg0.max_per_address, 3);
        };
        assert!(0x2::coin::value<T0>(&arg3) == arg0.price * arg2, 1);
        add_proceeds_<T0>(arg0, arg3);
        let v2 = 0;
        while (v2 < arg2) {
            0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::ticket_bag::add_ticket(arg1, 0x2::object::id<Raffle<T0>>(arg0), 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::ticket::new(0x2::object::id<Raffle<T0>>(arg0), arg0.sold + 1, arg5), arg5);
            arg0.sold = arg0.sold + 1;
            v2 = v2 + 1;
        };
        let v3 = buyers_mut<T0>(arg0);
        if (!0x2::table::contains<address, u64>(v3, v0)) {
            0x2::table::add<address, u64>(v3, v0, 0);
        };
        let v4 = 0x2::table::borrow_mut<address, u64>(v3, v0);
        *v4 = *v4 + arg2;
    }

    public fun buyers<T0>(arg0: &Raffle<T0>) : &0x2::table::Table<address, u64> {
        0x2::dynamic_object_field::borrow<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::Marker<0x2::table::Table<address, u64>>, 0x2::table::Table<address, u64>>(&arg0.id, 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::marker<0x2::table::Table<address, u64>>())
    }

    fun buyers_mut<T0>(arg0: &mut Raffle<T0>) : &mut 0x2::table::Table<address, u64> {
        0x2::dynamic_object_field::borrow_mut<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::Marker<0x2::table::Table<address, u64>>, 0x2::table::Table<address, u64>>(&mut arg0.id, 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::marker<0x2::table::Table<address, u64>>())
    }

    public entry fun claim_prizes<T0, T1: store + key>(arg0: &mut Raffle<T0>, arg1: &0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::ticket_bag::TicketBag, arg2: &mut 0x2::tx_context::TxContext) {
        claim_prizes_<T0, T1>(arg0, arg1, arg2);
    }

    fun claim_prizes_<T0, T1: store + key>(arg0: &mut Raffle<T0>, arg1: &0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::ticket_bag::TicketBag, arg2: &mut 0x2::tx_context::TxContext) {
        assert_drawn<T0>(arg0);
        let v0 = 0x2::table_vec::empty<u64>(arg2);
        let v1 = winners<T0>(arg0);
        let v2 = 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::ticket_bag::tickets(0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::ticket_bag::envelope(arg1, 0x2::object::id<Raffle<T0>>(arg0)));
        let v3 = 0;
        while (v3 < 0x2::table_vec::length<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::ticket::Ticket>(v2)) {
            let v4 = 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::ticket::ticket_number(0x2::table_vec::borrow<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::ticket::Ticket>(v2, v3));
            if (0x2::table::contains<u64, bool>(v1, v4) && !*0x2::table::borrow<u64, bool>(v1, v4)) {
                0x2::table_vec::push_back<u64>(&mut v0, v4);
            };
            v3 = v3 + 1;
        };
        assert!(!0x2::table_vec::is_empty<u64>(&v0), 14);
        let v5 = winners_mut<T0>(arg0);
        let v6 = 0;
        while (v6 < 0x2::table_vec::length<u64>(&v0)) {
            *0x2::table::borrow_mut<u64, bool>(v5, *0x2::table_vec::borrow<u64>(&v0, v6)) = true;
            v6 = v6 + 1;
        };
        let v7 = warehouse_mut<T0, T1>(arg0);
        let v8 = 0;
        while (v8 < 0x2::table_vec::length<u64>(&v0)) {
            0x2::table_vec::pop_back<u64>(&mut v0);
            0x2::transfer::public_transfer<T1>(0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::warehouse::redeem_prize<T1>(v7), 0x2::tx_context::sender(arg2));
            v8 = v8 + 1;
        };
        0x2::table_vec::destroy_empty<u64>(v0);
    }

    public(friend) fun create_raffle<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (Raffle<T0>, RaffleAdminCap) {
        let v0 = 0x2::object::new(arg5);
        let v1 = 0x2::object::new(arg5);
        0x2::dynamic_object_field::add<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::Marker<0x2::table::Table<address, u64>>, 0x2::table::Table<address, u64>>(&mut v0, 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::marker<0x2::table::Table<address, u64>>(), 0x2::table::new<address, u64>(arg5));
        0x2::dynamic_object_field::add<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::Marker<0x2::table::Table<u64, bool>>, 0x2::table::Table<u64, bool>>(&mut v0, 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::marker<0x2::table::Table<u64, bool>>(), 0x2::table::new<u64, bool>(arg5));
        let v2 = Raffle<T0>{
            id              : v0,
            admin           : 0x2::tx_context::sender(arg5),
            admin_cap_id    : 0x2::object::uid_to_inner(&v1),
            active          : false,
            drawn           : false,
            duration        : arg0,
            deadline        : 0,
            winners_count   : 0,
            sold            : 0,
            supply          : arg1,
            max_per_address : arg3,
            price           : arg2,
            prize_ref       : 0x1::option::none<0x2::object::ID>(),
            counter         : 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::pseudorandom::create_counter(arg4, arg5),
        };
        let v3 = RaffleCreatedEvent{
            id    : 0x2::object::uid_to_inner(&v2.id),
            admin : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<RaffleCreatedEvent>(v3);
        let v4 = RaffleAdminCap{
            id        : v1,
            raffle_id : *0x2::object::borrow_id<Raffle<T0>>(&v2),
        };
        (v2, v4)
    }

    public fun deadline<T0>(arg0: &Raffle<T0>) : u64 {
        arg0.deadline
    }

    public entry fun deposit_prizes<T0, T1: store + key>(arg0: &mut Raffle<T0>, arg1: vector<T1>, arg2: &RaffleAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        deposit_prizes_<T0, T1>(arg0, arg1, arg2, arg3);
        set_prize_ref_<T0, T1>(arg0);
    }

    fun deposit_prizes_<T0, T1: store + key>(arg0: &mut Raffle<T0>, arg1: vector<T1>, arg2: &RaffleAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert_raffle_admin<T0>(arg0, arg2);
        assert_inactive<T0>(arg0);
        if (!has_warehouse<T0, T1>(arg0)) {
            let v0 = WarehouseKey{dummy_field: false};
            0x2::dynamic_field::add<WarehouseKey, 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::warehouse::Warehouse<T1>>(&mut arg0.id, v0, 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::warehouse::new<T1>(0, arg3));
        };
        while (!0x1::vector::is_empty<T1>(&arg1)) {
            let v1 = warehouse_mut<T0, T1>(arg0);
            0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::warehouse::deposit_prize<T1>(v1, 0x1::vector::pop_back<T1>(&mut arg1));
        };
        arg0.winners_count = 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::warehouse::supply<T1>(warehouse<T0, T1>(arg0));
        0x1::vector::destroy_empty<T1>(arg1);
    }

    public entry fun draw_raffle<T0>(arg0: &mut Raffle<T0>, arg1: &0x2::clock::Clock, arg2: &RaffleAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert_raffle_admin<T0>(arg0, arg2);
        draw_raffle_<T0>(arg0, arg1, arg3);
    }

    fun draw_raffle_<T0>(arg0: &mut Raffle<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_not_drawn<T0>(arg0);
        if (arg0.sold > 0) {
            if (arg0.sold < arg0.supply) {
                assert_past_deadline<T0>(arg0, 0x2::clock::timestamp_ms(arg1));
            };
            let v0 = 0x2::table::new<u64, bool>(arg2);
            let v1 = arg0.winners_count;
            let v2 = arg0.sold;
            let v3 = 0;
            if (v1 < v2) {
                while (v3 < v1) {
                    let v4 = &mut arg0.counter;
                    let v5 = 0x2::tx_context::sender(arg2);
                    let v6 = 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::pseudorandom::rand_u64_range(v4, &v5, 1, v2 + 1, arg1);
                    0x1::debug::print<u64>(&v6);
                    0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::pseudorandom::increment(v4);
                    if (!0x2::table::contains<u64, bool>(&v0, v6)) {
                        let v7 = winners_mut<T0>(arg0);
                        0x2::table::add<u64, bool>(&mut v0, v6, false);
                        0x2::table::add<u64, bool>(v7, v6, false);
                        v3 = v3 + 1;
                    };
                };
            } else {
                while (v3 < v2) {
                    let v8 = winners_mut<T0>(arg0);
                    0x2::table::add<u64, bool>(v8, v3 + 1, false);
                    v3 = v3 + 1;
                };
            };
            0x2::table::drop<u64, bool>(v0);
        } else {
            assert_past_deadline<T0>(arg0, 0x2::clock::timestamp_ms(arg1));
        };
        arg0.drawn = true;
        let v9 = RaffleDrawnEvent{
            id    : 0x2::object::uid_to_inner(&arg0.id),
            admin : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RaffleDrawnEvent>(v9);
    }

    public(friend) fun draw_raffle_friend<T0>(arg0: &mut Raffle<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        draw_raffle_<T0>(arg0, arg1, arg2);
    }

    public fun drawn<T0>(arg0: &Raffle<T0>) : bool {
        arg0.drawn
    }

    public fun duration<T0>(arg0: &Raffle<T0>) : u64 {
        arg0.duration
    }

    public fun has_warehouse<T0, T1: store + key>(arg0: &Raffle<T0>) : bool {
        let v0 = WarehouseKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<WarehouseKey, 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::warehouse::Warehouse<T1>>(&arg0.id, v0)
    }

    public fun max_per_address<T0>(arg0: &Raffle<T0>) : u64 {
        arg0.max_per_address
    }

    public fun price<T0>(arg0: &Raffle<T0>) : u64 {
        arg0.price
    }

    public fun raffle_admin_cap_raffle_id(arg0: &RaffleAdminCap) : 0x2::object::ID {
        arg0.raffle_id
    }

    public entry fun set_deadline<T0>(arg0: &mut Raffle<T0>, arg1: u64, arg2: &RaffleAdminCap) {
        set_deadline_<T0>(arg0, arg1, arg2);
    }

    fun set_deadline_<T0>(arg0: &mut Raffle<T0>, arg1: u64, arg2: &RaffleAdminCap) {
        assert_raffle_admin<T0>(arg0, arg2);
        assert_inactive<T0>(arg0);
        arg0.deadline = arg1;
    }

    public entry fun set_max_per_address<T0>(arg0: &mut Raffle<T0>, arg1: u64, arg2: &RaffleAdminCap) {
        set_max_per_address_<T0>(arg0, arg1, arg2);
    }

    fun set_max_per_address_<T0>(arg0: &mut Raffle<T0>, arg1: u64, arg2: &RaffleAdminCap) {
        assert_raffle_admin<T0>(arg0, arg2);
        assert_inactive<T0>(arg0);
        arg0.max_per_address = arg1;
    }

    public entry fun set_price<T0>(arg0: &mut Raffle<T0>, arg1: u64, arg2: &RaffleAdminCap) {
        set_price_<T0>(arg0, arg1, arg2);
    }

    fun set_price_<T0>(arg0: &mut Raffle<T0>, arg1: u64, arg2: &RaffleAdminCap) {
        assert_raffle_admin<T0>(arg0, arg2);
        assert_inactive<T0>(arg0);
        arg0.price = arg1;
    }

    fun set_prize_ref_<T0, T1: store + key>(arg0: &mut Raffle<T0>) {
        let v0 = warehouse<T0, T1>(arg0);
        if (0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::warehouse::is_empty<T1>(v0)) {
            0x1::option::extract<0x2::object::ID>(&mut arg0.prize_ref);
        } else {
            0x1::option::swap_or_fill<0x2::object::ID>(&mut arg0.prize_ref, *0x1::vector::borrow<0x2::object::ID>(0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::warehouse::prizes<T1>(v0), 0));
        };
    }

    public entry fun set_supply<T0>(arg0: &mut Raffle<T0>, arg1: u64, arg2: &RaffleAdminCap) {
        set_supply_<T0>(arg0, arg1, arg2);
    }

    fun set_supply_<T0>(arg0: &mut Raffle<T0>, arg1: u64, arg2: &RaffleAdminCap) {
        assert_raffle_admin<T0>(arg0, arg2);
        assert_inactive<T0>(arg0);
        arg0.supply = arg1;
    }

    public fun sold<T0>(arg0: &Raffle<T0>) : u64 {
        arg0.sold
    }

    public fun supply<T0>(arg0: &Raffle<T0>) : u64 {
        arg0.supply
    }

    public fun warehouse<T0, T1: store + key>(arg0: &Raffle<T0>) : &0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::warehouse::Warehouse<T1> {
        let v0 = WarehouseKey{dummy_field: false};
        0x2::dynamic_field::borrow<WarehouseKey, 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::warehouse::Warehouse<T1>>(&arg0.id, v0)
    }

    fun warehouse_key() : WarehouseKey {
        WarehouseKey{dummy_field: false}
    }

    public fun warehouse_mut<T0, T1: store + key>(arg0: &mut Raffle<T0>) : &mut 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::warehouse::Warehouse<T1> {
        let v0 = WarehouseKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<WarehouseKey, 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::warehouse::Warehouse<T1>>(&mut arg0.id, v0)
    }

    public fun winners<T0>(arg0: &Raffle<T0>) : &0x2::table::Table<u64, bool> {
        0x2::dynamic_object_field::borrow<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::Marker<0x2::table::Table<u64, bool>>, 0x2::table::Table<u64, bool>>(&arg0.id, 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::marker<0x2::table::Table<u64, bool>>())
    }

    public fun winners_count<T0>(arg0: &Raffle<T0>) : u64 {
        arg0.winners_count
    }

    fun winners_mut<T0>(arg0: &mut Raffle<T0>) : &mut 0x2::table::Table<u64, bool> {
        0x2::dynamic_object_field::borrow_mut<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::Marker<0x2::table::Table<u64, bool>>, 0x2::table::Table<u64, bool>>(&mut arg0.id, 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::marker<0x2::table::Table<u64, bool>>())
    }

    public entry fun withdraw_prizes<T0, T1: store + key>(arg0: &mut Raffle<T0>, arg1: vector<0x2::object::ID>, arg2: &RaffleAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert_inactive<T0>(arg0);
        withdraw_prizes_<T0, T1>(arg0, arg1, arg2, arg3);
        set_prize_ref_<T0, T1>(arg0);
    }

    fun withdraw_prizes_<T0, T1: store + key>(arg0: &mut Raffle<T0>, arg1: vector<0x2::object::ID>, arg2: &RaffleAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert_raffle_admin<T0>(arg0, arg2);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg1)) {
            let v0 = warehouse_mut<T0, T1>(arg0);
            0x2::transfer::public_transfer<T1>(0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::warehouse::withdraw_prize_by_id<T1>(v0, 0x1::vector::pop_back<0x2::object::ID>(&mut arg1)), 0x2::tx_context::sender(arg3));
        };
        arg0.winners_count = 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::warehouse::supply<T1>(warehouse<T0, T1>(arg0));
        0x1::vector::destroy_empty<0x2::object::ID>(arg1);
    }

    public entry fun withdraw_proceeds<T0>(arg0: &mut Raffle<T0>, arg1: &RaffleAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        withdraw_proceeds_<T0>(arg0, arg1, arg2);
    }

    fun withdraw_proceeds_<T0>(arg0: &mut Raffle<T0>, arg1: &RaffleAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_raffle_admin<T0>(arg0, arg1);
        assert_drawn<T0>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::dynamic_field::remove<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::Marker<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::marker<T0>()), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_unclaimed_prizes<T0, T1: store + key>(arg0: &mut Raffle<T0>, arg1: &RaffleAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        withdraw_unclaimed_prizes_<T0, T1>(arg0, arg1, arg2);
    }

    fun withdraw_unclaimed_prizes_<T0, T1: store + key>(arg0: &mut Raffle<T0>, arg1: &RaffleAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_raffle_admin<T0>(arg0, arg1);
        assert_drawn<T0>(arg0);
        assert!(arg0.sold < arg0.winners_count, 16);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::warehouse::prizes<T1>(warehouse<T0, T1>(arg0));
        let v2 = 0;
        while (v2 < arg0.winners_count - arg0.sold) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, *0x1::vector::borrow<0x2::object::ID>(v1, 0x1::vector::length<0x2::object::ID>(v1) - 1 - v2));
            v2 = v2 + 1;
        };
        withdraw_prizes_<T0, T1>(arg0, v0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

