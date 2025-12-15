module 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_lp_token {
    struct EventTransfer has copy, drop, store {
        id: u32,
        from: address,
        to: address,
        amount: u64,
    }

    struct EventMint has copy, drop, store {
        pair_id: 0x2::object::ID,
        transfer_events: vector<EventTransfer>,
    }

    struct MintCap has store {
        pair_id: 0x2::object::ID,
        pair_uniq: 0x2::object::ID,
        lp_token: 0x2::object::ID,
    }

    struct AlmmLpToken has store, key {
        id: 0x2::object::UID,
        pair_id: 0x2::object::ID,
        balances: 0x2::table::Table<u32, 0x2::table::Table<address, u64>>,
        approves: 0x2::table::Table<u32, 0x2::table::Table<address, 0x2::table::Table<address, u64>>>,
        total_supply: 0x2::table::Table<u32, u64>,
    }

    public fun balance_of(arg0: &AlmmLpToken, arg1: u32, arg2: address) : u64 {
        if (!0x2::table::contains<u32, 0x2::table::Table<address, u64>>(&arg0.balances, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<u32, 0x2::table::Table<address, u64>>(&arg0.balances, arg1);
        if (!0x2::table::contains<address, u64>(v0, arg2)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(v0, arg2)
    }

    public fun burn(arg0: &mut AlmmLpToken, arg1: &MintCap, arg2: u32, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg1.lp_token == 0x2::object::id<AlmmLpToken>(arg0) && arg1.pair_id == arg0.pair_id, 13906834629609914367);
        if (!0x2::table::contains<u32, 0x2::table::Table<address, u64>>(&arg0.balances, arg2)) {
            return 0
        };
        assert!(balance_of(arg0, arg2, arg3) >= arg4, 1);
        assert!(total_supply(arg0, arg2) >= arg4, 1);
        let v0 = 0x2::table::borrow_mut<u32, 0x2::table::Table<address, u64>>(&mut arg0.balances, arg2);
        let v1 = 0x2::table::remove<address, u64>(v0, arg3);
        let v2 = if (v1 > arg4) {
            let v3 = v1 - arg4;
            0x2::table::add<address, u64>(v0, arg3, v3);
            v3
        } else {
            0
        };
        0x2::table::add<u32, u64>(&mut arg0.total_supply, arg2, 0x2::table::remove<u32, u64>(&mut arg0.total_supply, arg2) - arg4);
        let v4 = EventTransfer{
            id     : arg2,
            from   : arg3,
            to     : @0x0,
            amount : arg4,
        };
        0x2::event::emit<EventTransfer>(v4);
        v2
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : (AlmmLpToken, MintCap) {
        let v0 = AlmmLpToken{
            id           : 0x2::object::new(arg2),
            pair_id      : arg0,
            balances     : 0x2::table::new<u32, 0x2::table::Table<address, u64>>(arg2),
            approves     : 0x2::table::new<u32, 0x2::table::Table<address, 0x2::table::Table<address, u64>>>(arg2),
            total_supply : 0x2::table::new<u32, u64>(arg2),
        };
        let v1 = MintCap{
            pair_id   : arg0,
            pair_uniq : arg1,
            lp_token  : 0x2::object::id<AlmmLpToken>(&v0),
        };
        (v0, v1)
    }

    public fun emit_mint_events_bundle(arg0: &AlmmLpToken, arg1: 0x2::object::ID, arg2: vector<EventTransfer>) {
        let v0 = EventMint{
            pair_id         : arg1,
            transfer_events : arg2,
        };
        0x2::event::emit<EventMint>(v0);
    }

    public fun mint(arg0: &mut AlmmLpToken, arg1: &MintCap, arg2: u32, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, EventTransfer) {
        assert!(arg1.lp_token == 0x2::object::id<AlmmLpToken>(arg0) && arg1.pair_id == arg0.pair_id, 13906834517940764671);
        if (!0x2::table::contains<u32, 0x2::table::Table<address, u64>>(&arg0.balances, arg2)) {
            0x2::table::add<u32, 0x2::table::Table<address, u64>>(&mut arg0.balances, arg2, 0x2::table::new<address, u64>(arg5));
            0x2::table::add<u32, u64>(&mut arg0.total_supply, arg2, 0);
        };
        let v0 = 0x2::table::borrow_mut<u32, 0x2::table::Table<address, u64>>(&mut arg0.balances, arg2);
        let v1 = if (0x2::table::contains<address, u64>(v0, arg3)) {
            0x2::table::remove<address, u64>(v0, arg3)
        } else {
            0
        };
        let v2 = v1 + arg4;
        0x2::table::add<address, u64>(v0, arg3, v2);
        0x2::table::add<u32, u64>(&mut arg0.total_supply, arg2, 0x2::table::remove<u32, u64>(&mut arg0.total_supply, arg2) + arg4);
        let v3 = EventTransfer{
            id     : arg2,
            from   : @0x0,
            to     : arg3,
            amount : arg4,
        };
        (v2, v3)
    }

    public fun total_supply(arg0: &AlmmLpToken, arg1: u32) : u64 {
        if (!0x2::table::contains<u32, u64>(&arg0.total_supply, arg1)) {
            0
        } else {
            *0x2::table::borrow<u32, u64>(&arg0.total_supply, arg1)
        }
    }

    // decompiled from Move bytecode v6
}

