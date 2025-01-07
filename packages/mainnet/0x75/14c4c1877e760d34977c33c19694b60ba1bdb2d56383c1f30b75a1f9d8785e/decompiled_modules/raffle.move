module 0x9bef3053e086a602587e698a38f8a57ded5e531f43df8ca53e450cab0ea3b1fc::raffle {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct MarketplaceRaffle<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        fee: u16,
        fee_balance: 0x2::balance::Balance<T0>,
    }

    struct RaffleFund<phantom T0> has store {
        funds: 0x2::balance::Balance<T0>,
    }

    struct Raffle<T0: store + key, phantom T1> has store, key {
        id: 0x2::object::UID,
        owner: address,
        item: 0x1::option::Option<T0>,
        max_ticket: u64,
        ticket_price: u64,
        limit_buy: u64,
        expires: u64,
        balance: 0x1::option::Option<RaffleFund<T1>>,
        ticket_sold: u64,
        winning_ticket: u64,
        list_player: vector<Player>,
        winner: address,
    }

    struct Player has drop, store {
        addr: address,
        tickets: vector<u64>,
    }

    struct RaffleCreateEvent has copy, drop {
        raffle_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        type_name: 0x1::type_name::TypeName,
        expires: u64,
        owner: address,
        max_ticket: u64,
        limit_buy: u64,
        ticket_price: u64,
    }

    struct RaffleJoinEvent has copy, drop {
        raffle_id: 0x2::object::ID,
        player: address,
        ticket_bought: u64,
        paid: u64,
    }

    struct RaffleCancelEvent has copy, drop {
        raffle_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        type_name: 0x1::type_name::TypeName,
        owner: address,
    }

    struct RaffleDeclareWinnerEvent has copy, drop {
        raffle_id: 0x2::object::ID,
        owner: address,
        winner: address,
        winning_ticket: u64,
    }

    struct RaffleClaimEvent has copy, drop {
        raffle_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        type_name: 0x1::type_name::TypeName,
        winner: address,
    }

    struct RaffleKiosk<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        owner_kiosk: 0x2::object::ID,
        item: 0x2::object::ID,
        max_ticket: u64,
        ticket_price: u64,
        limit_buy: u64,
        expires: u64,
        balance: 0x1::option::Option<RaffleFund<T0>>,
        ticket_sold: u64,
        winning_ticket: u64,
        list_player: vector<Player>,
        winner: address,
    }

    struct RaffleCreateEventKiosk has copy, drop {
        raffle_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        type_name: 0x1::type_name::TypeName,
        expires: u64,
        owner: address,
        owner_kiosk: 0x2::object::ID,
        max_ticket: u64,
        limit_buy: u64,
        ticket_price: u64,
    }

    fun bytes_to_u64(arg0: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 | (*0x1::vector::borrow<u8>(&arg0, v1) as u64) << ((8 * (7 - v1)) as u8);
            v1 = v1 + 1;
        };
        v0
    }

    public fun cancel_raffle<T0: store + key, T1>(arg0: &mut MarketplaceRaffle<T1>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let Raffle {
            id             : v0,
            owner          : v1,
            item           : v2,
            max_ticket     : _,
            ticket_price   : _,
            limit_buy      : _,
            expires        : _,
            balance        : v7,
            ticket_sold    : v8,
            winning_ticket : _,
            list_player    : _,
            winner         : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Raffle<T0, T1>>(&mut arg0.id, arg1);
        let v12 = v2;
        assert!(0x2::tx_context::sender(arg2) == v1, 1);
        assert!(v8 == 0, 12);
        0x1::option::destroy_none<RaffleFund<T1>>(v7);
        0x2::object::delete(v0);
        let v13 = 0x1::option::extract<T0>(&mut v12);
        0x2::transfer::public_transfer<T0>(v13, v1);
        0x1::option::destroy_none<T0>(v12);
        let v14 = RaffleCancelEvent{
            raffle_id : arg1,
            item_id   : 0x2::object::id<T0>(&v13),
            type_name : 0x1::type_name::get<T0>(),
            owner     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RaffleCancelEvent>(v14);
    }

    public fun cancel_raffle_kiosk<T0: store + key, T1>(arg0: &mut MarketplaceRaffle<T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let RaffleKiosk {
            id             : v0,
            owner          : v1,
            owner_kiosk    : v2,
            item           : v3,
            max_ticket     : _,
            ticket_price   : _,
            limit_buy      : _,
            expires        : _,
            balance        : v8,
            ticket_sold    : v9,
            winning_ticket : _,
            list_player    : _,
            winner         : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, RaffleKiosk<T1>>(&mut arg0.id, arg2);
        let v13 = v0;
        assert!(0x2::tx_context::sender(arg3) == v1, 1);
        assert!(v9 == 0, 12);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v2, 15);
        0x1::option::destroy_none<RaffleFund<T1>>(v8);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::remove_auth_transfer(arg1, v3, &v13);
        0x2::object::delete(v13);
        let v14 = RaffleCancelEvent{
            raffle_id : arg2,
            item_id   : v3,
            type_name : 0x1::type_name::get<T0>(),
            owner     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RaffleCancelEvent>(v14);
    }

    public entry fun create_marketplace<T0>(arg0: address, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 2000, 6);
        let v0 = MarketplaceRaffle<T0>{
            id          : 0x2::object::new(arg2),
            owner       : arg0,
            fee         : arg1,
            fee_balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<MarketplaceRaffle<T0>>(v0);
    }

    public fun create_raffle<T0: store + key, T1>(arg0: &mut MarketplaceRaffle<T1>, arg1: T0, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg5 >= 0x2::clock::timestamp_ms(arg6) + 180000, 4);
        assert!(arg4 <= arg2, 9);
        let v0 = create_raffle_private<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg7);
        let v1 = 0x2::object::id<Raffle<T0, T1>>(&v0);
        0x2::dynamic_object_field::add<0x2::object::ID, Raffle<T0, T1>>(&mut arg0.id, v1, v0);
        let v2 = RaffleCreateEvent{
            raffle_id    : v1,
            item_id      : 0x2::object::id<T0>(&arg1),
            type_name    : 0x1::type_name::get<T0>(),
            expires      : arg5,
            owner        : 0x2::tx_context::sender(arg7),
            max_ticket   : arg2,
            limit_buy    : arg4,
            ticket_price : arg3,
        };
        0x2::event::emit<RaffleCreateEvent>(v2);
        v1
    }

    public fun create_raffle_kiosk<T0: store + key, T1>(arg0: &mut MarketplaceRaffle<T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg6 >= 0x2::clock::timestamp_ms(arg7) + 180000, 4);
        assert!(arg5 <= arg3, 9);
        let v0 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v1 = create_raffle_kiosk_<T1>(arg2, v0, arg3, arg4, arg5, arg6, arg8);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::auth_exclusive_transfer(arg1, arg2, &v1.id, arg8);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::assert_nft_type<T0>(arg1, arg2);
        let v2 = 0x2::object::id<RaffleKiosk<T1>>(&v1);
        0x2::dynamic_object_field::add<0x2::object::ID, RaffleKiosk<T1>>(&mut arg0.id, v2, v1);
        let v3 = RaffleCreateEventKiosk{
            raffle_id    : v2,
            item_id      : arg2,
            type_name    : 0x1::type_name::get<T0>(),
            expires      : arg6,
            owner        : 0x2::tx_context::sender(arg8),
            owner_kiosk  : v0,
            max_ticket   : arg3,
            limit_buy    : arg5,
            ticket_price : arg4,
        };
        0x2::event::emit<RaffleCreateEventKiosk>(v3);
        v2
    }

    fun create_raffle_kiosk_<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : RaffleKiosk<T0> {
        RaffleKiosk<T0>{
            id             : 0x2::object::new(arg6),
            owner          : 0x2::tx_context::sender(arg6),
            owner_kiosk    : arg1,
            item           : arg0,
            max_ticket     : arg2,
            ticket_price   : arg3,
            limit_buy      : arg4,
            expires        : arg5,
            balance        : 0x1::option::none<RaffleFund<T0>>(),
            ticket_sold    : 0,
            winning_ticket : 0,
            list_player    : 0x1::vector::empty<Player>(),
            winner         : 0x2::tx_context::sender(arg6),
        }
    }

    fun create_raffle_private<T0: store + key, T1>(arg0: T0, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Raffle<T0, T1> {
        Raffle<T0, T1>{
            id             : 0x2::object::new(arg5),
            owner          : 0x2::tx_context::sender(arg5),
            item           : 0x1::option::some<T0>(arg0),
            max_ticket     : arg1,
            ticket_price   : arg2,
            limit_buy      : arg3,
            expires        : arg4,
            balance        : 0x1::option::none<RaffleFund<T1>>(),
            ticket_sold    : 0,
            winning_ticket : 0,
            list_player    : 0x1::vector::empty<Player>(),
            winner         : 0x2::tx_context::sender(arg5),
        }
    }

    public fun declare_winner<T0: store + key, T1>(arg0: &mut MarketplaceRaffle<T1>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Raffle<T0, T1>>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.owner, 1);
        assert!(v0.expires <= 0x2::clock::timestamp_ms(arg2), 5);
        assert!(v0.winner == v0.owner, 13);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0;
        if (v0.ticket_sold == 0) {
            0x2::transfer::public_transfer<T0>(0x1::option::extract<T0>(&mut v0.item), v0.owner);
        } else if (v0.ticket_sold == 1) {
            let v3 = 0x1::vector::borrow<Player>(&mut v0.list_player, 0);
            v1 = v3.addr;
            v0.winner = v3.addr;
            v0.winning_ticket = v2;
        } else {
            v2 = rand_u64_range(1, v0.ticket_sold, arg3);
            let v4 = 0;
            while (v4 < 0x1::vector::length<Player>(&v0.list_player)) {
                let v5 = 0x1::vector::borrow<Player>(&mut v0.list_player, v4);
                if (0x1::vector::contains<u64>(&v5.tickets, &v2)) {
                    v1 = v5.addr;
                    v0.winner = v5.addr;
                    v0.winning_ticket = v2;
                    break
                };
                v4 = v4 + 1;
            };
        };
        let v6 = RaffleDeclareWinnerEvent{
            raffle_id      : arg1,
            owner          : 0x2::tx_context::sender(arg3),
            winner         : v1,
            winning_ticket : v2,
        };
        0x2::event::emit<RaffleDeclareWinnerEvent>(v6);
    }

    public fun declare_winner_kiosk<T0>(arg0: &mut MarketplaceRaffle<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, RaffleKiosk<T0>>(&mut arg0.id, arg2);
        assert!(0x2::tx_context::sender(arg4) == v0.owner, 1);
        assert!(v0.expires <= 0x2::clock::timestamp_ms(arg3), 5);
        assert!(v0.winner == v0.owner, 13);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v0.owner_kiosk, 15);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0;
        if (v0.ticket_sold == 0) {
            0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::remove_auth_transfer(arg1, v0.item, &v0.id);
        } else if (v0.ticket_sold == 1) {
            let v3 = 0x1::vector::borrow<Player>(&mut v0.list_player, 0);
            v1 = v3.addr;
            v0.winner = v3.addr;
            v0.winning_ticket = v2;
        } else {
            v2 = rand_u64_range(1, v0.ticket_sold, arg4);
            let v4 = 0;
            while (v4 < 0x1::vector::length<Player>(&v0.list_player)) {
                let v5 = 0x1::vector::borrow<Player>(&mut v0.list_player, v4);
                if (0x1::vector::contains<u64>(&v5.tickets, &v2)) {
                    v1 = v5.addr;
                    v0.winner = v5.addr;
                    v0.winning_ticket = v2;
                    break
                };
                v4 = v4 + 1;
            };
        };
        let v6 = RaffleDeclareWinnerEvent{
            raffle_id      : arg2,
            owner          : 0x2::tx_context::sender(arg4),
            winner         : v1,
            winning_ticket : v2,
        };
        0x2::event::emit<RaffleDeclareWinnerEvent>(v6);
    }

    public fun join_raffle<T0: store + key, T1>(arg0: &mut MarketplaceRaffle<T1>, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Raffle<T0, T1>>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg5) != v0.owner, 2);
        assert!(v0.expires >= 0x2::clock::timestamp_ms(arg4), 3);
        assert!(arg2 > 0, 17);
        assert!(v0.max_ticket - v0.ticket_sold >= arg2, 7);
        assert!(arg2 <= v0.limit_buy || v0.limit_buy == 0, 10);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x2::coin::into_balance<T1>(arg3);
        let v3 = 0x2::balance::value<T1>(&v2);
        assert!(v3 == v0.ticket_price * arg2, 6);
        let v4 = Player{
            addr    : v1,
            tickets : 0x1::vector::empty<u64>(),
        };
        let v5 = 0;
        while (v5 < arg2) {
            v0.ticket_sold = v0.ticket_sold + 1;
            let v6 = RaffleJoinEvent{
                raffle_id     : arg1,
                player        : 0x2::tx_context::sender(arg5),
                ticket_bought : v0.ticket_sold,
                paid          : v3,
            };
            0x2::event::emit<RaffleJoinEvent>(v6);
            0x1::vector::push_back<u64>(&mut v4.tickets, v0.ticket_sold);
            v5 = v5 + 1;
        };
        v5 = 0;
        let v7 = 0;
        while (v5 < 0x1::vector::length<Player>(&v0.list_player)) {
            let v8 = 0x1::vector::borrow_mut<Player>(&mut v0.list_player, v5);
            if (v8.addr == v1) {
                v7 = 1;
                assert!(0x1::vector::length<u64>(&v8.tickets) + 0x1::vector::length<u64>(&v4.tickets) <= v0.limit_buy, 11);
                0x1::vector::append<u64>(&mut v8.tickets, v4.tickets);
                break
            };
            v5 = v5 + 1;
        };
        if (0x1::option::is_none<RaffleFund<T1>>(&v0.balance)) {
            let v9 = RaffleFund<T1>{funds: v2};
            0x1::option::fill<RaffleFund<T1>>(&mut v0.balance, v9);
        } else {
            0x2::coin::put<T1>(&mut 0x1::option::borrow_mut<RaffleFund<T1>>(&mut v0.balance).funds, 0x2::coin::from_balance<T1>(v2, arg5));
        };
        if (v7 == 0) {
            0x1::vector::push_back<Player>(&mut v0.list_player, v4);
        };
    }

    public fun join_raffle_kiosk<T0: store + key, T1>(arg0: &mut MarketplaceRaffle<T1>, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, RaffleKiosk<T1>>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg5) != v0.owner, 2);
        assert!(v0.expires >= 0x2::clock::timestamp_ms(arg4), 3);
        assert!(arg2 > 0, 17);
        assert!(v0.max_ticket - v0.ticket_sold >= arg2, 7);
        assert!(arg2 <= v0.limit_buy || v0.limit_buy == 0, 10);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x2::coin::into_balance<T1>(arg3);
        let v3 = 0x2::balance::value<T1>(&v2);
        assert!(v3 == v0.ticket_price * arg2, 6);
        let v4 = Player{
            addr    : v1,
            tickets : 0x1::vector::empty<u64>(),
        };
        let v5 = 0;
        while (v5 < arg2) {
            v0.ticket_sold = v0.ticket_sold + 1;
            let v6 = RaffleJoinEvent{
                raffle_id     : arg1,
                player        : 0x2::tx_context::sender(arg5),
                ticket_bought : v0.ticket_sold,
                paid          : v3,
            };
            0x2::event::emit<RaffleJoinEvent>(v6);
            0x1::vector::push_back<u64>(&mut v4.tickets, v0.ticket_sold);
            v5 = v5 + 1;
        };
        v5 = 0;
        let v7 = 0;
        while (v5 < 0x1::vector::length<Player>(&v0.list_player)) {
            let v8 = 0x1::vector::borrow_mut<Player>(&mut v0.list_player, v5);
            if (v8.addr == v1) {
                v7 = 1;
                assert!(0x1::vector::length<u64>(&v8.tickets) + 0x1::vector::length<u64>(&v4.tickets) <= v0.limit_buy, 11);
                0x1::vector::append<u64>(&mut v8.tickets, v4.tickets);
                break
            };
            v5 = v5 + 1;
        };
        if (0x1::option::is_none<RaffleFund<T1>>(&v0.balance)) {
            let v9 = RaffleFund<T1>{funds: v2};
            0x1::option::fill<RaffleFund<T1>>(&mut v0.balance, v9);
        } else {
            0x2::coin::put<T1>(&mut 0x1::option::borrow_mut<RaffleFund<T1>>(&mut v0.balance).funds, 0x2::coin::from_balance<T1>(v2, arg5));
        };
        if (v7 == 0) {
            0x1::vector::push_back<Player>(&mut v0.list_player, v4);
        };
    }

    fun rand_u64(arg0: &mut 0x2::tx_context::TxContext) : u64 {
        rand_u64_with_seed(seed(arg0))
    }

    fun rand_u64_range(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        rand_u64_range_with_seed(seed(arg2), arg0, arg1)
    }

    fun rand_u64_range_with_seed(arg0: vector<u8>, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > arg1, 17);
        rand_u64_with_seed(arg0) % (arg2 - arg1) + arg1
    }

    fun rand_u64_with_seed(arg0: vector<u8>) : u64 {
        bytes_to_u64(arg0)
    }

    fun seed(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::object::new(arg0);
        0x2::object::delete(v0);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<0x2::tx_context::TxContext>(arg0));
        0x1::vector::append<u8>(&mut v1, 0x2::object::uid_to_bytes(&v0));
        0x1::hash::sha3_256(v1)
    }

    public fun terminate_raffle<T0: store + key, T1>(arg0: &mut MarketplaceRaffle<T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let RaffleKiosk {
            id             : v0,
            owner          : _,
            owner_kiosk    : _,
            item           : v3,
            max_ticket     : _,
            ticket_price   : _,
            limit_buy      : _,
            expires        : _,
            balance        : v8,
            ticket_sold    : _,
            winning_ticket : _,
            list_player    : _,
            winner         : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, RaffleKiosk<T1>>(&mut arg0.id, arg2);
        let v13 = v0;
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        0x1::option::destroy_none<RaffleFund<T1>>(v8);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::remove_auth_transfer(arg1, v3, &v13);
        0x2::object::delete(v13);
        let v14 = RaffleCancelEvent{
            raffle_id : arg2,
            item_id   : v3,
            type_name : 0x1::type_name::get<T0>(),
            owner     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RaffleCancelEvent>(v14);
    }

    public entry fun updateMarket<T0>(arg0: &mut MarketplaceRaffle<T0>, arg1: address, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        assert!(arg2 <= 2000, 6);
        arg0.owner = arg1;
        arg0.fee = arg2;
    }

    public entry fun withdraw_admin<T0>(arg0: &mut MarketplaceRaffle<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        let v0 = 0x2::balance::value<T0>(&arg0.fee_balance);
        let v1 = v0;
        if (arg2 > v0) {
            v1 = arg2;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.fee_balance, v1, arg3), arg1);
    }

    public fun withdraw_and_transfer<T0: store + key, T1>(arg0: &mut MarketplaceRaffle<T1>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Raffle<T0, T1>>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.owner, 1);
        assert!(v0.expires <= 0x2::clock::timestamp_ms(arg2), 5);
        assert!(v0.owner != v0.winner, 14);
        let RaffleFund { funds: v1 } = 0x1::option::extract<RaffleFund<T1>>(&mut v0.balance);
        let v2 = 0x2::coin::from_balance<T1>(v1, arg3);
        0x2::coin::put<T1>(&mut arg0.fee_balance, 0x2::coin::split<T1>(&mut v2, 0x2::balance::value<T1>(&v1) * (arg0.fee as u64) / 10000, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, v0.owner);
        0x2::transfer::public_transfer<T0>(0x1::option::extract<T0>(&mut v0.item), v0.winner);
    }

    public fun withdraw_and_transfer_kiosk<T0: store + key, T1>(arg0: &mut MarketplaceRaffle<T1>, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist, arg6: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::BpsRoyaltyStrategy<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, RaffleKiosk<T1>>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg8) == v0.owner, 1);
        assert!(v0.expires <= 0x2::clock::timestamp_ms(arg7), 5);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v0.owner_kiosk, 15);
        assert!(0x2::kiosk::owner(arg3) == v0.winner, 16);
        assert!(v0.owner != v0.winner, 14);
        let RaffleFund { funds: v1 } = 0x1::option::extract<RaffleFund<T1>>(&mut v0.balance);
        let v2 = 0x2::coin::from_balance<T1>(v1, arg8);
        0x2::coin::put<T1>(&mut arg0.fee_balance, 0x2::coin::split<T1>(&mut v2, 0x2::balance::value<T1>(&v1) * (arg0.fee as u64) / 10000, arg8));
        let v3 = 0x2::coin::into_balance<T1>(v2);
        let v4 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::transfer_delegated<T0>(arg2, arg3, v0.item, &v0.id, 0x2::balance::value<T1>(&v3), arg8);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::set_paid<T0, T1>(&mut v4, v3, v0.owner);
        let v5 = Witness{dummy_field: false};
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::set_transfer_request_auth<T0, Witness>(&mut v4, &v5);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::confirm_transfer<T0>(arg5, &mut v4);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::confirm_transfer<T0, T1>(arg6, &mut v4);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::confirm<T0, T1>(v4, arg4, arg8);
    }

    // decompiled from Move bytecode v6
}

