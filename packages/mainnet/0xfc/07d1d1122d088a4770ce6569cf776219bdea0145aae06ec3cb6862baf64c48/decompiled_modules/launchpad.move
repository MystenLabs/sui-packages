module 0x27df51ef6874ac97cb461443b19b59d856e925d138ad8aaa426a152aee11f45b::launchpad {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Launchpad<phantom T0> has store, key {
        id: 0x2::object::UID,
        stakers: 0x2::table::Table<address, 0x2::balance::Balance<T0>>,
        diamond_list: vector<address>,
        tracked_addresses: 0x2::table::Table<address, TicketRecord<T0>>,
    }

    struct TicketRecord<phantom T0> has store {
        records: 0x2::table::Table<0x2::object::ID, Record<T0>>,
    }

    struct Record<phantom T0> has store {
        launchpad_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        sender: address,
        balance: 0x2::balance::Balance<T0>,
        created_at: u64,
        unlock_at: u64,
    }

    struct LaunchpadCreatedEvent<phantom T0> has copy, drop {
        id: 0x2::object::ID,
        sender: address,
    }

    struct DiamondListChangedEvent<phantom T0> has copy, drop {
        launchpad_id: 0x2::object::ID,
        sender: address,
        diamond_list: vector<address>,
    }

    struct StakedEvent<phantom T0> has copy, drop {
        launchpad_id: 0x2::object::ID,
        sender: address,
        amount: u64,
    }

    struct UnstakedEvent<phantom T0> has copy, drop {
        launchpad_id: 0x2::object::ID,
        sender: address,
        amount: u64,
        unlock_at: u64,
    }

    struct RedeemedEvent<phantom T0> has copy, drop {
        launchpad_id: 0x2::object::ID,
        sender: address,
        amount: u64,
    }

    public entry fun create_launchpad<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Launchpad<T0>{
            id                : 0x2::object::new(arg1),
            stakers           : 0x2::table::new<address, 0x2::balance::Balance<T0>>(arg1),
            diamond_list      : 0x1::vector::empty<address>(),
            tracked_addresses : 0x2::table::new<address, TicketRecord<T0>>(arg1),
        };
        let v1 = LaunchpadCreatedEvent<T0>{
            id     : 0x2::object::id<Launchpad<T0>>(&v0),
            sender : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<LaunchpadCreatedEvent<T0>>(v1);
        0x2::transfer::share_object<Launchpad<T0>>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun is_exist_staker<T0>(arg0: &Launchpad<T0>, arg1: address) : bool {
        0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.stakers, arg1)
    }

    public entry fun redeem<T0>(arg0: &mut Launchpad<T0>, arg1: 0x27df51ef6874ac97cb461443b19b59d856e925d138ad8aaa426a152aee11f45b::ticket::Ticket, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= 0x27df51ef6874ac97cb461443b19b59d856e925d138ad8aaa426a152aee11f45b::ticket::get_unlock_time(&arg1), 1002);
        assert!(0x2::object::id<Launchpad<T0>>(arg0) == 0x27df51ef6874ac97cb461443b19b59d856e925d138ad8aaa426a152aee11f45b::ticket::get_launchpad_id(&arg1), 1005);
        let v0 = 0x2::balance::withdraw_all<T0>(&mut 0x2::table::borrow_mut<0x2::object::ID, Record<T0>>(&mut 0x2::table::borrow_mut<address, TicketRecord<T0>>(&mut arg0.tracked_addresses, 0x2::tx_context::sender(arg3)).records, 0x2::object::id<0x27df51ef6874ac97cb461443b19b59d856e925d138ad8aaa426a152aee11f45b::ticket::Ticket>(&arg1)).balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg3), 0x2::tx_context::sender(arg3));
        0x27df51ef6874ac97cb461443b19b59d856e925d138ad8aaa426a152aee11f45b::ticket::burn_ticket_and_emit(arg1, arg3);
        let v1 = RedeemedEvent<T0>{
            launchpad_id : 0x2::object::id<Launchpad<T0>>(arg0),
            sender       : 0x2::tx_context::sender(arg3),
            amount       : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<RedeemedEvent<T0>>(v1);
    }

    public entry fun redeem_with_lock_duration<T0>(arg0: &mut Launchpad<T0>, arg1: 0x27df51ef6874ac97cb461443b19b59d856e925d138ad8aaa426a152aee11f45b::ticket::Ticket, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Launchpad<T0>>(arg0) == 0x27df51ef6874ac97cb461443b19b59d856e925d138ad8aaa426a152aee11f45b::ticket::get_launchpad_id(&arg1), 1005);
        verify_signature(0x2::tx_context::sender(arg6), 0x2::object::id<0x27df51ef6874ac97cb461443b19b59d856e925d138ad8aaa426a152aee11f45b::ticket::Ticket>(&arg1), arg2, arg3, arg4);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Record<T0>>(&mut 0x2::table::borrow_mut<address, TicketRecord<T0>>(&mut arg0.tracked_addresses, 0x2::tx_context::sender(arg6)).records, 0x2::object::id<0x27df51ef6874ac97cb461443b19b59d856e925d138ad8aaa426a152aee11f45b::ticket::Ticket>(&arg1));
        assert!(0x2::clock::timestamp_ms(arg5) >= v0.created_at + arg2, 1002);
        let v1 = 0x2::balance::withdraw_all<T0>(&mut v0.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg6), 0x2::tx_context::sender(arg6));
        0x27df51ef6874ac97cb461443b19b59d856e925d138ad8aaa426a152aee11f45b::ticket::burn_ticket_and_emit(arg1, arg6);
        let v2 = RedeemedEvent<T0>{
            launchpad_id : 0x2::object::id<Launchpad<T0>>(arg0),
            sender       : 0x2::tx_context::sender(arg6),
            amount       : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<RedeemedEvent<T0>>(v2);
    }

    public fun set_diamond_list<T0>(arg0: &AdminCap, arg1: &mut Launchpad<T0>, arg2: &0x27df51ef6874ac97cb461443b19b59d856e925d138ad8aaa426a152aee11f45b::metadata::Metadata, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _, v4, _, _, _, _, _) = 0x27df51ef6874ac97cb461443b19b59d856e925d138ad8aaa426a152aee11f45b::metadata::get_metadata_props(arg2);
        let v10 = 0;
        while (v10 < 0x1::vector::length<address>(&arg3)) {
            assert!(0x2::balance::value<T0>(0x2::table::borrow<address, 0x2::balance::Balance<T0>>(&arg1.stakers, *0x1::vector::borrow<address>(&arg3, v10))) >= v4, 1004);
            v10 = v10 + 1;
        };
        arg1.diamond_list = arg3;
        let v11 = DiamondListChangedEvent<T0>{
            launchpad_id : 0x2::object::id<Launchpad<T0>>(arg1),
            sender       : 0x2::tx_context::sender(arg4),
            diamond_list : arg3,
        };
        0x2::event::emit<DiamondListChangedEvent<T0>>(v11);
    }

    public entry fun stake<T0>(arg0: &mut Launchpad<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::into_balance<T0>(arg1);
        if (!is_exist_staker<T0>(arg0, v0)) {
            0x2::table::add<address, 0x2::balance::Balance<T0>>(&mut arg0.stakers, v0, v1);
        } else {
            0x2::balance::join<T0>(0x2::table::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.stakers, v0), v1);
        };
        let v2 = StakedEvent<T0>{
            launchpad_id : 0x2::object::id<Launchpad<T0>>(arg0),
            sender       : v0,
            amount       : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<StakedEvent<T0>>(v2);
    }

    public entry fun unstake<T0>(arg0: &mut Launchpad<T0>, arg1: &0x27df51ef6874ac97cb461443b19b59d856e925d138ad8aaa426a152aee11f45b::metadata::Metadata, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(is_exist_staker<T0>(arg0, v0), 1000);
        let v1 = 0x2::table::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.stakers, v0);
        let v2 = 0x2::balance::value<T0>(v1);
        assert!(v2 > 0, 1001);
        assert!(v2 >= arg2, 1003);
        let v3 = 0x2::balance::split<T0>(v1, arg2);
        let (_, _, v6, v7, v8, v9, v10, v11, v12, v13) = 0x27df51ef6874ac97cb461443b19b59d856e925d138ad8aaa426a152aee11f45b::metadata::get_metadata_props(arg1);
        let v14 = if (0x1::vector::contains<address>(&arg0.diamond_list, &v0)) {
            0x2::clock::timestamp_ms(arg3) + v13
        } else if (v2 >= v8) {
            0x2::clock::timestamp_ms(arg3) + v12
        } else if (v7 <= v2 && v2 < v8) {
            0x2::clock::timestamp_ms(arg3) + v11
        } else if (v6 <= v2 && v2 < v7) {
            0x2::clock::timestamp_ms(arg3) + v10
        } else {
            0x2::clock::timestamp_ms(arg3) + v9
        };
        let v15 = 0x2::object::id<Launchpad<T0>>(arg0);
        let v16 = 0x27df51ef6874ac97cb461443b19b59d856e925d138ad8aaa426a152aee11f45b::ticket::mint_ticket_and_emit(v15, arg1, arg2, v14, arg4);
        let v17 = Record<T0>{
            launchpad_id : v15,
            ticket_id    : 0x2::object::id<0x27df51ef6874ac97cb461443b19b59d856e925d138ad8aaa426a152aee11f45b::ticket::Ticket>(&v16),
            sender       : v0,
            balance      : v3,
            created_at   : 0x2::clock::timestamp_ms(arg3),
            unlock_at    : v14,
        };
        if (!0x2::table::contains<address, TicketRecord<T0>>(&arg0.tracked_addresses, v0)) {
            let v18 = 0x2::table::new<0x2::object::ID, Record<T0>>(arg4);
            0x2::table::add<0x2::object::ID, Record<T0>>(&mut v18, 0x2::object::id<0x27df51ef6874ac97cb461443b19b59d856e925d138ad8aaa426a152aee11f45b::ticket::Ticket>(&v16), v17);
            let v19 = TicketRecord<T0>{records: v18};
            0x2::table::add<address, TicketRecord<T0>>(&mut arg0.tracked_addresses, v0, v19);
        } else {
            0x2::table::add<0x2::object::ID, Record<T0>>(&mut 0x2::table::borrow_mut<address, TicketRecord<T0>>(&mut arg0.tracked_addresses, 0x2::tx_context::sender(arg4)).records, 0x2::object::id<0x27df51ef6874ac97cb461443b19b59d856e925d138ad8aaa426a152aee11f45b::ticket::Ticket>(&v16), v17);
        };
        0x27df51ef6874ac97cb461443b19b59d856e925d138ad8aaa426a152aee11f45b::ticket::transfer(v16, v0);
        let v20 = UnstakedEvent<T0>{
            launchpad_id : v15,
            sender       : v0,
            amount       : arg2,
            unlock_at    : v14,
        };
        0x2::event::emit<UnstakedEvent<T0>>(v20);
    }

    fun verify_signature(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: vector<u8>) {
        let v0 = b"SUIDAOS_LAUNCHPAD";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        let v1 = x"297d36f7868aea706e11598a3605411ad494261718e8484f21c6ff37ecf033d0";
        assert!(0x2::ed25519::ed25519_verify(&arg4, &v1, &v0), 1007);
    }

    // decompiled from Move bytecode v6
}

