module 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::bridge {
    struct Ticket<phantom T0> has store, key {
        id: 0x2::object::UID,
        bridge_id: 0x2::object::ID,
        owner: address,
        inscription: 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::inscription::Inscription,
        amount: u64,
        status: u8,
        cross_i2c_id: 0x2::object::ID,
        created_ts: u64,
        accepted_ts: u64,
        rejected_ts: u64,
    }

    struct OwnerIndexer has store, key {
        id: 0x2::object::UID,
        tickets: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>,
    }

    struct Bridge<phantom T0> has store, key {
        id: 0x2::object::UID,
        key: 0x2::object::ID,
        p: 0x1::string::String,
        tick: 0x1::string::String,
        status: u8,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        ticket_ids: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>,
        in_bridge_count: u64,
        in_bridge_amount: u64,
        total_bridged_amount: u64,
        creator: address,
        created_ts: u64,
    }

    struct BridgeSimpleInfo has copy, drop, store {
        bridge_id: 0x2::object::ID,
        p: 0x1::string::String,
        tick: 0x1::string::String,
        coin: 0x1::type_name::TypeName,
        status: u8,
        creator: address,
        created_ts: u64,
    }

    struct Bridges has store, key {
        id: 0x2::object::UID,
        coins_table: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
        inscriptions_table: 0x2::table::Table<0x2::object::ID, bool>,
        list: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, BridgeSimpleInfo>,
    }

    struct BRIDGE has drop {
        dummy_field: bool,
    }

    struct InitEvent has copy, drop, store {
        bridges_id: 0x2::object::ID,
        owner_indexer_id: 0x2::object::ID,
    }

    struct BridgeCreatedEvent has copy, drop, store {
        bridge_id: 0x2::object::ID,
        p: 0x1::string::String,
        tick: 0x1::string::String,
        coin: 0x1::string::String,
    }

    struct CrossCoinToInscription has copy, drop, store {
        bridge_id: 0x2::object::ID,
        inscription: 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::inscription::Inscription,
        cross_c2i_id: 0x2::object::ID,
        coin: 0x1::string::String,
    }

    struct TicketCreatedEvent has copy, drop, store {
        ticket_id: 0x2::object::ID,
        bridge_id: 0x2::object::ID,
        inscription: 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::inscription::Inscription,
        cross_i2c_id: 0x2::object::ID,
        coin: 0x1::string::String,
    }

    struct TicketRejectedEvent has copy, drop, store {
        ticket_id: 0x2::object::ID,
        bridge_id: 0x2::object::ID,
        owner: address,
        inscription: 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::inscription::Inscription,
        created_ts: u64,
        coin: 0x1::string::String,
    }

    struct TicketAcceptedEvent has copy, drop, store {
        ticket_id: 0x2::object::ID,
        bridge_id: 0x2::object::ID,
        owner: address,
        inscription: 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::inscription::Inscription,
        protocol_fee: u64,
        created_ts: u64,
        coin: 0x1::string::String,
    }

    struct TicketDeletedEvent has copy, drop, store {
        ticket_id: 0x2::object::ID,
        owner: address,
        inscription: 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::inscription::Inscription,
        created_ts: u64,
        accepted_ts: u64,
        rejected_ts: u64,
        coin: 0x1::string::String,
    }

    struct FetchOwnerTicketIDsEvent has copy, drop, store {
        tickets: vector<0x2::object::ID>,
    }

    struct UpdateBridgeStatusEvent has copy, drop, store {
        bridge_id: 0x2::object::ID,
        status: u8,
    }

    public entry fun accept_ticket<T0>(arg0: &0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::GlobalConfig, arg1: &mut Bridge<T0>, arg2: &mut Ticket<T0>, arg3: vector<0x1::string::String>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::check_package_version(arg0);
        assert!(0x2::object::id<Bridge<T0>>(arg1) == arg2.bridge_id, 4);
        assert!(arg2.status == 0, 6);
        let v0 = 0x2::object::id_bytes<Ticket<T0>>(arg2);
        0x1::vector::append<u8>(&mut v0, x"01");
        assert!(0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::validator::verify(arg0, v0, arg3), 8);
        0x2::coin::mint_and_transfer<T0>(&mut arg1.treasury_cap, arg2.amount, arg2.owner, arg5);
        arg2.accepted_ts = 0x2::clock::timestamp_ms(arg4);
        arg2.status = 1;
        remove_ticket_from_bridge<T0>(arg1, arg2);
        arg1.total_bridged_amount = arg1.total_bridged_amount + arg2.amount;
        let v1 = TicketAcceptedEvent{
            ticket_id    : 0x2::object::id<Ticket<T0>>(arg2),
            bridge_id    : 0x2::object::id<Bridge<T0>>(arg1),
            owner        : arg2.owner,
            inscription  : arg2.inscription,
            protocol_fee : 0,
            created_ts   : arg2.created_ts,
            coin         : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        };
        0x2::event::emit<TicketAcceptedEvent>(v1);
    }

    fun add_ticket_in_bridge<T0>(arg0: &mut Bridge<T0>, arg1: &Ticket<T0>) {
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, bool>(&arg0.ticket_ids, 0x2::object::id<Ticket<T0>>(arg1))) {
            return
        };
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, bool>(&mut arg0.ticket_ids, 0x2::object::id<Ticket<T0>>(arg1), true);
        arg0.in_bridge_count = arg0.in_bridge_count + 1;
        arg0.in_bridge_amount = arg0.in_bridge_amount + arg1.amount;
    }

    fun add_ticket_in_owner_indexer<T0>(arg0: &mut OwnerIndexer, arg1: &Ticket<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.owner;
        let v1 = 0x2::object::id<Ticket<T0>>(arg1);
        if (!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&arg0.tickets, v0)) {
            let v2 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, bool>(arg2);
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, bool>(&mut v2, v1, true);
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&mut arg0.tickets, v0, v2);
        } else {
            let v3 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&mut arg0.tickets, v0);
            if (!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, bool>(v3, v1)) {
                0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, bool>(v3, v1, true);
            };
        };
    }

    public fun bridge_key<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String) : 0x2::object::ID {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, arg1);
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x2::object::id_from_bytes(0x2::hash::blake2b256(0x1::string::bytes(&v0)))
    }

    public entry fun create_bridge<T0>(arg0: &0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::BridgeCap, arg1: &0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::GlobalConfig, arg2: &0xcb5bd7a29f458a1b1e0221516fbfaeb182be027033eb8dcb4f33dd540d20bb87::config::GlobalConfig, arg3: &mut Bridges, arg4: 0x2::coin::TreasuryCap<T0>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::check_package_version(arg1);
        assert!(0x2::coin::total_supply<T0>(&arg4) == 0, 0);
        let v0 = 0xcb5bd7a29f458a1b1e0221516fbfaeb182be027033eb8dcb4f33dd540d20bb87::config::tick_key(arg5, arg6);
        assert!(0xcb5bd7a29f458a1b1e0221516fbfaeb182be027033eb8dcb4f33dd540d20bb87::config::contains_tick(arg2, v0), 1);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg3.inscriptions_table, v0), 2);
        let v1 = 0x1::type_name::get<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg3.coins_table, v1), 3);
        let v2 = bridge_key<T0>(arg5, arg6);
        let v3 = 0x2::tx_context::sender(arg8);
        let v4 = create_bridge_internal<T0>(v2, arg5, arg6, arg4, v3, 0x2::clock::timestamp_ms(arg7), arg8);
        let v5 = 0x2::object::id<Bridge<T0>>(&v4);
        let v6 = BridgeSimpleInfo{
            bridge_id  : v5,
            p          : arg5,
            tick       : arg6,
            coin       : v1,
            status     : v4.status,
            creator    : 0x2::tx_context::sender(arg8),
            created_ts : 0x2::clock::timestamp_ms(arg7),
        };
        if (!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, BridgeSimpleInfo>(&arg3.list, v2)) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, BridgeSimpleInfo>(&mut arg3.list, v2, v6);
        };
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg3.coins_table, v1, v0);
        0x2::table::add<0x2::object::ID, bool>(&mut arg3.inscriptions_table, v0, true);
        0x2::transfer::share_object<Bridge<T0>>(v4);
        let v7 = BridgeCreatedEvent{
            bridge_id : v5,
            p         : arg5,
            tick      : arg6,
            coin      : 0x1::string::from_ascii(0x1::type_name::into_string(v1)),
        };
        0x2::event::emit<BridgeCreatedEvent>(v7);
    }

    fun create_bridge_internal<T0>(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x2::coin::TreasuryCap<T0>, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Bridge<T0> {
        Bridge<T0>{
            id                   : 0x2::object::new(arg6),
            key                  : arg0,
            p                    : arg1,
            tick                 : arg2,
            status               : 1,
            treasury_cap         : arg3,
            ticket_ids           : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, bool>(arg6),
            in_bridge_count      : 0,
            in_bridge_amount     : 0,
            total_bridged_amount : 0,
            creator              : arg4,
            created_ts           : arg5,
        }
    }

    fun create_ticket_internal<T0>(arg0: &Bridge<T0>, arg1: 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::inscription::Inscription, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Ticket<T0> {
        Ticket<T0>{
            id           : 0x2::object::new(arg4),
            bridge_id    : 0x2::object::id<Bridge<T0>>(arg0),
            owner        : 0x2::tx_context::sender(arg4),
            inscription  : arg1,
            amount       : 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::inscription::get_amt(&arg1),
            status       : 0,
            cross_i2c_id : arg2,
            created_ts   : arg3,
            accepted_ts  : 0,
            rejected_ts  : 0,
        }
    }

    public entry fun cross_coin_to_inscription<T0>(arg0: &mut 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::GlobalConfig, arg1: &mut Bridge<T0>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::check_package_version(arg0);
        assert!(0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::open_c2i(arg0), 10);
        assert!(arg1.status & 2 > 0, 13);
        assert!(0x2::coin::value<T0>(&arg2) >= arg4, 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::get_protocol_fee_amount(arg0), 9);
        if (0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::get_protocol_fee_amount(arg0) > 0) {
            0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::receive_protocol_fee(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::get_protocol_fee_amount(arg0), arg5)));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg5));
        0x2::coin::burn<T0>(&mut arg1.treasury_cap, 0x2::coin::split<T0>(&mut arg2, arg4, arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg5));
        let v0 = 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::inscription::new(arg1.p, arg1.tick, arg4);
        let v1 = CrossCoinToInscription{
            bridge_id    : 0x2::object::id<Bridge<T0>>(arg1),
            inscription  : v0,
            cross_c2i_id : 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::transfer_from_vault(arg0, &v0, 0x2::tx_context::sender(arg5), arg5),
            coin         : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        };
        0x2::event::emit<CrossCoinToInscription>(v1);
    }

    public entry fun cross_inscription_to_coin<T0>(arg0: &mut 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::GlobalConfig, arg1: &mut Bridge<T0>, arg2: &mut OwnerIndexer, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::check_package_version(arg0);
        assert!(arg1.p == arg3 && arg1.tick == arg4, 4);
        assert!(arg1.status & 1 > 0, 12);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::get_protocol_fee_amount(arg0), 9);
        if (0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::get_protocol_fee_amount(arg0) > 0) {
            0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::receive_protocol_fee(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg6, 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::get_protocol_fee_amount(arg0), arg8)));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, 0x2::tx_context::sender(arg8));
        cross_inscription_to_coin_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8);
    }

    fun cross_inscription_to_coin_internal<T0>(arg0: &0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::GlobalConfig, arg1: &mut Bridge<T0>, arg2: &mut OwnerIndexer, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::inscription::new(arg3, arg4, arg5);
        let v1 = 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::transfer_to_vault(arg0, &v0, arg7);
        let v2 = create_ticket_internal<T0>(arg1, v0, v1, 0x2::clock::timestamp_ms(arg6), arg7);
        add_ticket_in_bridge<T0>(arg1, &v2);
        add_ticket_in_owner_indexer<T0>(arg2, &v2, arg7);
        let v3 = TicketCreatedEvent{
            ticket_id    : 0x2::object::id<Ticket<T0>>(&v2),
            bridge_id    : 0x2::object::id<Bridge<T0>>(arg1),
            inscription  : v0,
            cross_i2c_id : v1,
            coin         : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        };
        0x2::event::emit<TicketCreatedEvent>(v3);
        0x2::transfer::public_share_object<Ticket<T0>>(v2);
    }

    public entry fun delete_ticket<T0>(arg0: &0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::GlobalConfig, arg1: &mut OwnerIndexer, arg2: Ticket<T0>, arg3: vector<0x1::string::String>, arg4: &0x2::clock::Clock) {
        0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::check_package_version(arg0);
        assert!(arg2.status != 0, 7);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg2.accepted_ts + arg2.rejected_ts + 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::get_delete_grace(arg0), 11);
        let v0 = 0x2::object::id_bytes<Ticket<T0>>(&arg2);
        0x1::vector::append<u8>(&mut v0, x"01");
        assert!(0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::validator::verify(arg0, v0, arg3), 8);
        remove_ticket_from_owner_indexer<T0>(arg1, &arg2);
        let v1 = TicketDeletedEvent{
            ticket_id   : 0x2::object::id<Ticket<T0>>(&arg2),
            owner       : arg2.owner,
            inscription : arg2.inscription,
            created_ts  : arg2.created_ts,
            accepted_ts : arg2.accepted_ts,
            rejected_ts : arg2.rejected_ts,
            coin        : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        };
        0x2::event::emit<TicketDeletedEvent>(v1);
        let Ticket {
            id           : v2,
            bridge_id    : _,
            owner        : _,
            inscription  : _,
            amount       : _,
            status       : _,
            cross_i2c_id : _,
            created_ts   : _,
            accepted_ts  : _,
            rejected_ts  : _,
        } = arg2;
        0x2::object::delete(v2);
    }

    public fun fetch_owner_tickets(arg0: &OwnerIndexer, arg1: address, arg2: vector<0x2::object::ID>, arg3: u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        if (!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&arg0.tickets, arg1)) {
            return
        };
        let v1 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&arg0.tickets, arg1);
        let v2 = if (0x1::vector::is_empty<0x2::object::ID>(&arg2)) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::head<0x2::object::ID, bool>(v1)
        } else {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::next<0x2::object::ID, bool>(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_node<0x2::object::ID, bool>(v1, *0x1::vector::borrow<0x2::object::ID>(&arg2, 0)))
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v3) && v4 < arg3) {
            let v5 = *0x1::option::borrow<0x2::object::ID>(&v3);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, v5);
            v3 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::next<0x2::object::ID, bool>(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_node<0x2::object::ID, bool>(v1, v5));
            v4 = v4 + 1;
        };
        let v6 = FetchOwnerTicketIDsEvent{tickets: v0};
        0x2::event::emit<FetchOwnerTicketIDsEvent>(v6);
    }

    fun init(arg0: BRIDGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<BRIDGE>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = Bridges{
            id                 : 0x2::object::new(arg1),
            coins_table        : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg1),
            inscriptions_table : 0x2::table::new<0x2::object::ID, bool>(arg1),
            list               : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, BridgeSimpleInfo>(arg1),
        };
        let v1 = OwnerIndexer{
            id      : 0x2::object::new(arg1),
            tickets : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(arg1),
        };
        0x2::transfer::public_share_object<Bridges>(v0);
        0x2::transfer::public_share_object<OwnerIndexer>(v1);
        let v2 = InitEvent{
            bridges_id       : 0x2::object::id<Bridges>(&v0),
            owner_indexer_id : 0x2::object::id<OwnerIndexer>(&v1),
        };
        0x2::event::emit<InitEvent>(v2);
    }

    public entry fun reject_ticket<T0>(arg0: &0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::GlobalConfig, arg1: &mut Bridge<T0>, arg2: &mut Ticket<T0>, arg3: vector<0x1::string::String>, arg4: &0x2::clock::Clock) {
        0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::check_package_version(arg0);
        assert!(0x2::object::id<Bridge<T0>>(arg1) == arg2.bridge_id, 4);
        assert!(arg2.status == 0, 6);
        let v0 = 0x2::object::id_bytes<Ticket<T0>>(arg2);
        0x1::vector::append<u8>(&mut v0, x"00");
        assert!(0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::validator::verify(arg0, v0, arg3), 8);
        arg2.rejected_ts = 0x2::clock::timestamp_ms(arg4);
        arg2.status = 2;
        remove_ticket_from_bridge<T0>(arg1, arg2);
        let v1 = TicketRejectedEvent{
            ticket_id   : 0x2::object::id<Ticket<T0>>(arg2),
            bridge_id   : 0x2::object::id<Bridge<T0>>(arg1),
            owner       : arg2.owner,
            inscription : arg2.inscription,
            created_ts  : arg2.created_ts,
            coin        : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        };
        0x2::event::emit<TicketRejectedEvent>(v1);
    }

    fun remove_ticket_from_bridge<T0>(arg0: &mut Bridge<T0>, arg1: &Ticket<T0>) {
        if (!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, bool>(&arg0.ticket_ids, 0x2::object::id<Ticket<T0>>(arg1))) {
            return
        };
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::remove<0x2::object::ID, bool>(&mut arg0.ticket_ids, 0x2::object::id<Ticket<T0>>(arg1));
        arg0.in_bridge_count = arg0.in_bridge_count - 1;
        arg0.in_bridge_amount = arg0.in_bridge_amount - arg1.amount;
    }

    fun remove_ticket_from_owner_indexer<T0>(arg0: &mut OwnerIndexer, arg1: &Ticket<T0>) {
        let v0 = arg1.owner;
        let v1 = 0x2::object::id<Ticket<T0>>(arg1);
        if (!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&arg0.tickets, v0)) {
            return
        };
        let v2 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&mut arg0.tickets, v0);
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, bool>(v2, v1)) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::remove<0x2::object::ID, bool>(v2, v1);
        };
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::length<0x2::object::ID, bool>(v2) == 0) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::destroy_empty<0x2::object::ID, bool>(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::remove<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&mut arg0.tickets, v0));
        };
    }

    public fun transfer_coin_to_sender<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public entry fun update_bridge_status<T0>(arg0: &0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::AdminCap, arg1: &0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::GlobalConfig, arg2: &mut Bridges, arg3: &mut Bridge<T0>, arg4: u8) {
        0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config::check_package_version(arg1);
        arg3.status = arg4;
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<0x2::object::ID, BridgeSimpleInfo>(&mut arg2.list, arg3.key).status = arg4;
        let v0 = UpdateBridgeStatusEvent{
            bridge_id : 0x2::object::id<Bridge<T0>>(arg3),
            status    : arg4,
        };
        0x2::event::emit<UpdateBridgeStatusEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

