module 0xe064f20930d138caa5fb632707f61603dd356f5f9410628a09842fb13e111fae::capy_flip {
    struct FlipAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FlipConfig has key {
        id: 0x2::object::UID,
        fee_recipient: address,
        fee_bps: u64,
        allowed_tokens: vector<0x1::type_name::TypeName>,
    }

    struct FlipTable<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        table_type: u8,
        stake: u64,
        min_players: u64,
        max_players: u64,
        close_ms: u64,
        pot: 0x2::balance::Balance<T0>,
        players: vector<address>,
        picks: 0x2::vec_map::VecMap<address, u8>,
        status: u8,
    }

    struct TableCreated has copy, drop {
        table_id: 0x2::object::ID,
        creator: address,
        table_type: u8,
        stake: u64,
        min_players: u64,
        max_players: u64,
        close_ms: u64,
    }

    struct PlayerJoined has copy, drop {
        table_id: 0x2::object::ID,
        player: address,
        pick: u8,
    }

    struct TableSettled has copy, drop {
        table_id: 0x2::object::ID,
        flip: u8,
        winners: vector<address>,
        payout_each: u64,
        fee: u64,
    }

    struct TableRefunded has copy, drop {
        table_id: 0x2::object::ID,
        reason: u8,
    }

    entry fun cancel_empty<T0>(arg0: &mut FlipTable<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 12);
        assert!(arg0.status == 0, 4);
        assert!(0x1::vector::is_empty<address>(&arg0.players), 11);
        arg0.status = 2;
    }

    entry fun create_table<T0>(arg0: u8, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &FlipConfig, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg6.allowed_tokens, &v0), 14);
        assert!(arg0 == 0 || arg0 == 1, 7);
        assert!(arg1 >= 1000000 && arg1 <= 1000000000, 13);
        assert!(arg2 >= 3, 0);
        assert!(arg3 >= arg2 && arg3 <= 9, 1);
        let v1 = 0x2::object::new(arg7);
        let v2 = 0x2::clock::timestamp_ms(arg5) + arg4;
        let v3 = TableCreated{
            table_id    : 0x2::object::uid_to_inner(&v1),
            creator     : 0x2::tx_context::sender(arg7),
            table_type  : arg0,
            stake       : arg1,
            min_players : arg2,
            max_players : arg3,
            close_ms    : v2,
        };
        0x2::event::emit<TableCreated>(v3);
        let v4 = FlipTable<T0>{
            id          : v1,
            creator     : 0x2::tx_context::sender(arg7),
            table_type  : arg0,
            stake       : arg1,
            min_players : arg2,
            max_players : arg3,
            close_ms    : v2,
            pot         : 0x2::balance::zero<T0>(),
            players     : vector[],
            picks       : 0x2::vec_map::empty<address, u8>(),
            status      : 0,
        };
        0x2::transfer::share_object<FlipTable<T0>>(v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FlipAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<FlipAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FlipConfig{
            id             : 0x2::object::new(arg0),
            fee_recipient  : 0x2::tx_context::sender(arg0),
            fee_bps        : 500,
            allowed_tokens : 0x1::vector::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<FlipConfig>(v1);
    }

    public fun join_assigned<T0>(arg0: &mut FlipTable<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.table_type == 1, 7);
        join_common<T0>(arg0, arg1, arg2, arg3);
        let v0 = PlayerJoined{
            table_id : 0x2::object::id<FlipTable<T0>>(arg0),
            player   : 0x2::tx_context::sender(arg3),
            pick     : 255,
        };
        0x2::event::emit<PlayerJoined>(v0);
    }

    entry fun join_choice<T0>(arg0: &mut FlipTable<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.table_type == 0, 7);
        assert!(arg2 == 0 || arg2 == 1, 9);
        join_common<T0>(arg0, arg1, arg3, arg4);
        0x2::vec_map::insert<address, u8>(&mut arg0.picks, 0x2::tx_context::sender(arg4), arg2);
        let v0 = PlayerJoined{
            table_id : 0x2::object::id<FlipTable<T0>>(arg0),
            player   : 0x2::tx_context::sender(arg4),
            pick     : arg2,
        };
        0x2::event::emit<PlayerJoined>(v0);
    }

    entry fun join_common<T0>(arg0: &mut FlipTable<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 4);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.close_ms, 4);
        assert!(0x1::vector::length<address>(&arg0.players) < arg0.max_players, 5);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x1::vector::contains<address>(&arg0.players, &v0), 6);
        assert!(0x2::coin::value<T0>(&arg1) == arg0.stake, 8);
        0x2::balance::join<T0>(&mut arg0.pot, 0x2::coin::into_balance<T0>(arg1));
        0x1::vector::push_back<address>(&mut arg0.players, 0x2::tx_context::sender(arg3));
    }

    entry fun pay_winners<T0>(arg0: &mut FlipTable<T0>, arg1: &FlipConfig, arg2: vector<address>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.pot);
        let v1 = v0 * arg1.fee_bps / 10000;
        let v2 = v0 - v1;
        let v3 = 0x1::vector::length<address>(&arg2);
        let v4 = v2 / v3;
        let v5 = v2 - v4 * v3;
        if (v1 + v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pot, v1 + v5), arg4), arg1.fee_recipient);
        };
        let v6 = 0;
        while (v6 < v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pot, v4), arg4), *0x1::vector::borrow<address>(&arg2, v6));
            v6 = v6 + 1;
        };
        arg0.status = 1;
        let v7 = TableSettled{
            table_id    : 0x2::object::id<FlipTable<T0>>(arg0),
            flip        : arg3,
            winners     : arg2,
            payout_each : v4,
            fee         : v1 + v5,
        };
        0x2::event::emit<TableSettled>(v7);
    }

    public fun player_count<T0>(arg0: &FlipTable<T0>) : u64 {
        0x1::vector::length<address>(&arg0.players)
    }

    public fun pot_value<T0>(arg0: &FlipTable<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pot)
    }

    fun refund_all<T0>(arg0: &mut FlipTable<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.players)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pot, arg0.stake), arg1), *0x1::vector::borrow<address>(&arg0.players, v0));
            v0 = v0 + 1;
        };
        arg0.status = 2;
    }

    entry fun refund_table<T0>(arg0: &mut FlipTable<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 11);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.close_ms && 0x1::vector::length<address>(&arg0.players) < arg0.min_players, 11);
        refund_all<T0>(arg0, arg2);
        let v0 = TableRefunded{
            table_id : 0x2::object::id<FlipTable<T0>>(arg0),
            reason   : 0,
        };
        0x2::event::emit<TableRefunded>(v0);
    }

    entry fun set_allowed_token(arg0: &FlipAdminCap, arg1: &mut FlipConfig, arg2: 0x1::type_name::TypeName, arg3: bool) {
        if (arg3) {
            if (!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.allowed_tokens, &arg2)) {
                0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.allowed_tokens, arg2);
            };
        } else {
            let (v0, v1) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg1.allowed_tokens, &arg2);
            if (v0) {
                0x1::vector::remove<0x1::type_name::TypeName>(&mut arg1.allowed_tokens, v1);
            };
        };
    }

    entry fun set_fee(arg0: &FlipAdminCap, arg1: &mut FlipConfig, arg2: address, arg3: u64) {
        assert!(arg3 <= 1000, 3);
        arg1.fee_recipient = arg2;
        arg1.fee_bps = arg3;
    }

    entry fun settle<T0>(arg0: &mut FlipTable<T0>, arg1: &FlipConfig, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 4);
        let v0 = 0x1::vector::length<address>(&arg0.players);
        assert!(v0 >= arg0.min_players && (0x2::clock::timestamp_ms(arg3) >= arg0.close_ms || v0 == arg0.max_players), 10);
        let v1 = 0x2::random::new_generator(arg2, arg4);
        let v2 = if (0x2::random::generate_bool(&mut v1)) {
            0
        } else {
            1
        };
        let v3 = vector[];
        let v4 = vector[];
        if (arg0.table_type == 0) {
            let v5 = 0;
            while (v5 < v0) {
                let v6 = *0x1::vector::borrow<address>(&arg0.players, v5);
                if (*0x2::vec_map::get<address, u8>(&arg0.picks, &v6) == 0) {
                    0x1::vector::push_back<address>(&mut v3, v6);
                } else {
                    0x1::vector::push_back<address>(&mut v4, v6);
                };
                v5 = v5 + 1;
            };
        } else {
            let v7 = 0;
            while (v7 < v0) {
                if (0x2::random::generate_bool(&mut v1) && v7 % 2 == 0 || v7 % 2 == 1) {
                    0x1::vector::push_back<address>(&mut v3, *0x1::vector::borrow<address>(&arg0.players, v7));
                } else {
                    0x1::vector::push_back<address>(&mut v4, *0x1::vector::borrow<address>(&arg0.players, v7));
                };
                v7 = v7 + 1;
            };
        };
        if (0x1::vector::is_empty<address>(&v3) || 0x1::vector::is_empty<address>(&v4)) {
            refund_all<T0>(arg0, arg4);
            let v8 = TableRefunded{
                table_id : 0x2::object::id<FlipTable<T0>>(arg0),
                reason   : 1,
            };
            0x2::event::emit<TableRefunded>(v8);
        } else {
            let v9 = if (v2 == 0) {
                v3
            } else {
                v4
            };
            pay_winners<T0>(arg0, arg1, v9, v2, arg4);
        };
    }

    public fun status<T0>(arg0: &FlipTable<T0>) : u8 {
        arg0.status
    }

    // decompiled from Move bytecode v7
}

