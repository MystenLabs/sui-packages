module 0xecd1be65a57c9994554068e1c7997c0a567137f26a33e30350c29ca64b8d618f::launchpad {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LaunchpadManager<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        ecosystem: address,
        token_count: u64,
        total_volume: u64,
        total_graduated: u64,
        tokens: 0x2::table::Table<u64, MemeTokenInfo<T0>>,
    }

    struct MemeTokenInfo<phantom T0> has store {
        id: u64,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        image: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        created_at: u64,
        meme_sold: u64,
        agent_raised: u64,
        trades: u64,
        buys: u64,
        sells: u64,
        treasury: 0x2::balance::Balance<T0>,
        graduated: bool,
        graduated_at: u64,
    }

    struct MemeBalance has store, key {
        id: 0x2::object::UID,
        token_id: u64,
        manager_id: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        amount: u64,
        unlock_at_ms: u64,
    }

    struct TokenCreated has copy, drop {
        token_id: u64,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        image: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        creation_fee_paid: u64,
        timestamp: u64,
    }

    struct TokenPurchased has copy, drop {
        token_id: u64,
        buyer: address,
        agent_in: u64,
        agent_fee: u64,
        fee_to_creator: u64,
        fee_to_ecosystem: u64,
        meme_out: u64,
        meme_sold_after: u64,
        agent_raised_after: u64,
        price_milli: u64,
        unlock_at_ms: u64,
    }

    struct TokenSold has copy, drop {
        token_id: u64,
        seller: address,
        meme_in: u64,
        agent_out: u64,
        agent_fee: u64,
        fee_to_creator: u64,
        fee_to_ecosystem: u64,
        meme_sold_after: u64,
        agent_raised_after: u64,
    }

    struct TokenGraduated has copy, drop {
        token_id: u64,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        agent_raised: u64,
        meme_sold: u64,
        timestamp: u64,
    }

    struct BalanceSplit has copy, drop {
        split_amount: u64,
        remain_amount: u64,
        owner: address,
    }

    struct BalanceMerged has copy, drop {
        merged_amount: u64,
        total_amount: u64,
        owner: address,
    }

    struct EcosystemUpdated has copy, drop {
        old_ecosystem: address,
        new_ecosystem: address,
    }

    public entry fun admin_graduate_withdraw<T0>(arg0: &AdminCap, arg1: &mut LaunchpadManager<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, MemeTokenInfo<T0>>(&arg1.tokens, arg2), 0);
        let v0 = 0x2::table::borrow_mut<u64, MemeTokenInfo<T0>>(&mut arg1.tokens, arg2);
        assert!(v0.graduated, 1);
        let v1 = 0x2::balance::value<T0>(&v0.treasury);
        if (v1 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.treasury, v1), arg4), arg3);
    }

    public entry fun admin_withdraw_fees<T0>(arg0: &AdminCap, arg1: &mut LaunchpadManager<T0>, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, MemeTokenInfo<T0>>(&arg1.tokens, arg2), 0);
        let v0 = 0x2::table::borrow_mut<u64, MemeTokenInfo<T0>>(&mut arg1.tokens, arg2);
        let v1 = 0x2::balance::value<T0>(&v0.treasury);
        let v2 = if (arg3 > v1) {
            v1
        } else {
            arg3
        };
        if (v2 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.treasury, v2), arg5), arg4);
    }

    public entry fun buy_meme<T0>(arg0: &mut LaunchpadManager<T0>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, MemeTokenInfo<T0>>(&arg0.tokens, arg1), 0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 > 0, 3);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = v1 * 100 / 10000;
        let v4 = v1 - v3;
        let v5 = 0x2::coin::into_balance<T0>(arg2);
        let (v6, v7) = route_fee<T0>(0x2::balance::split<T0>(&mut v5, v3), 0x2::table::borrow<u64, MemeTokenInfo<T0>>(&arg0.tokens, arg1).creator, arg0.ecosystem, arg4);
        let v8 = 0x2::table::borrow_mut<u64, MemeTokenInfo<T0>>(&mut arg0.tokens, arg1);
        assert!(!v8.graduated, 1);
        let v9 = calc_meme_out(v8.meme_sold, v4);
        assert!(v9 > 0, 2);
        let v10 = if (v2 <= v8.created_at + 5000) {
            v2 + 600000
        } else {
            0
        };
        v8.meme_sold = v8.meme_sold + v9;
        v8.agent_raised = v8.agent_raised + v4;
        v8.trades = v8.trades + 1;
        v8.buys = v8.buys + 1;
        0x2::balance::join<T0>(&mut v8.treasury, v5);
        let v11 = v8.agent_raised >= 15000000000000;
        if (v11) {
            v8.graduated = true;
            v8.graduated_at = v2;
        };
        let v12 = v8.name;
        let v13 = v8.symbol;
        let v14 = v8.agent_raised;
        let v15 = v8.meme_sold;
        if (v11) {
            arg0.total_graduated = arg0.total_graduated + 1;
        };
        arg0.total_volume = arg0.total_volume + v1;
        let v16 = TokenPurchased{
            token_id           : arg1,
            buyer              : v0,
            agent_in           : v1,
            agent_fee          : v3,
            fee_to_creator     : v6,
            fee_to_ecosystem   : v7,
            meme_out           : v9,
            meme_sold_after    : v15,
            agent_raised_after : v14,
            price_milli        : current_price_milli(v8.meme_sold + v9 / 2),
            unlock_at_ms       : v10,
        };
        0x2::event::emit<TokenPurchased>(v16);
        if (v11) {
            let v17 = TokenGraduated{
                token_id     : arg1,
                name         : v12,
                symbol       : v13,
                agent_raised : v14,
                meme_sold    : v15,
                timestamp    : v2,
            };
            0x2::event::emit<TokenGraduated>(v17);
        };
        let v18 = MemeBalance{
            id           : 0x2::object::new(arg4),
            token_id     : arg1,
            manager_id   : 0x2::object::id<LaunchpadManager<T0>>(arg0),
            name         : v12,
            symbol       : v13,
            amount       : v9,
            unlock_at_ms : v10,
        };
        0x2::transfer::public_transfer<MemeBalance>(v18, v0);
    }

    fun calc_agent_out(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0 || arg0 == 0) {
            return 0
        };
        let v0 = if (arg1 > arg0) {
            arg0
        } else {
            arg1
        };
        let v1 = current_price_milli(arg0 - v0 / 2);
        if (v1 == 0) {
            return 0
        };
        v0 * v1 / 1000
    }

    fun calc_meme_out(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = current_price_milli(arg0);
        if (v0 == 0) {
            return 0
        };
        let v1 = current_price_milli(arg0 + arg1 * 1000 / v0 / 2);
        if (v1 == 0) {
            return 0
        };
        let v2 = arg1 * 1000 / v1;
        let v3 = 10000000000 - arg0;
        if (v2 > v3) {
            v3
        } else {
            v2
        }
    }

    public entry fun create_token<T0>(arg0: &mut LaunchpadManager<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg5);
        assert!(v0 >= 1000000000000, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg5, arg0.ecosystem);
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = arg0.token_count;
        arg0.token_count = v2 + 1;
        let v3 = 0x2::clock::timestamp_ms(arg7);
        let v4 = 0x2::coin::value<T0>(&arg6);
        let v5 = 0x1::string::utf8(arg1);
        let v6 = 0x1::string::utf8(arg2);
        let v7 = 0x1::string::utf8(arg3);
        let v8 = 0x1::string::utf8(arg4);
        let (v9, v10, v11, v12, v13, v14) = if (v4 > 0) {
            let v15 = v4 * 100 / 10000;
            let v16 = v4 - v15;
            let v17 = calc_meme_out(0, v16);
            assert!(v17 > 0, 2);
            let v18 = 0x2::coin::into_balance<T0>(arg6);
            let (_, _) = route_fee<T0>(0x2::balance::split<T0>(&mut v18, v15), v1, arg0.ecosystem, arg8);
            (v16, 1, v17, v17, 1, v18)
        } else {
            0x2::coin::destroy_zero<T0>(arg6);
            (0, 0, 0, 0, 0, 0x2::balance::zero<T0>())
        };
        let v21 = MemeTokenInfo<T0>{
            id           : v2,
            name         : v5,
            symbol       : v6,
            image        : v7,
            description  : v8,
            creator      : v1,
            created_at   : v3,
            meme_sold    : v12,
            agent_raised : v9,
            trades       : v13,
            buys         : v10,
            sells        : 0,
            treasury     : v14,
            graduated    : false,
            graduated_at : 0,
        };
        0x2::table::add<u64, MemeTokenInfo<T0>>(&mut arg0.tokens, v2, v21);
        arg0.total_volume = arg0.total_volume + v4;
        let v22 = TokenCreated{
            token_id          : v2,
            name              : v5,
            symbol            : v6,
            image             : v7,
            description       : v8,
            creator           : v1,
            creation_fee_paid : v0,
            timestamp         : v3,
        };
        0x2::event::emit<TokenCreated>(v22);
        if (v11 > 0) {
            let v23 = MemeBalance{
                id           : 0x2::object::new(arg8),
                token_id     : v2,
                manager_id   : 0x2::object::id<LaunchpadManager<T0>>(arg0),
                name         : v5,
                symbol       : v6,
                amount       : v11,
                unlock_at_ms : v3 + 3600000,
            };
            0x2::transfer::public_transfer<MemeBalance>(v23, v1);
        };
    }

    fun current_price_milli(arg0: u64) : u64 {
        let v0 = if (arg0 > 10000000000) {
            10000000000
        } else {
            arg0
        };
        15500 + 2969000 * v0 / 10000000000
    }

    fun do_sell<T0>(arg0: &mut LaunchpadManager<T0>, arg1: MemeBalance, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.token_id;
        assert!(0x2::table::contains<u64, MemeTokenInfo<T0>>(&arg0.tokens, v0), 0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = arg1.amount;
        assert!(v2 > 0, 3);
        assert!(arg1.unlock_at_ms == 0 || 0x2::clock::timestamp_ms(arg2) >= arg1.unlock_at_ms, 8);
        let MemeBalance {
            id           : v3,
            token_id     : _,
            manager_id   : _,
            name         : _,
            symbol       : _,
            amount       : _,
            unlock_at_ms : _,
        } = arg1;
        0x2::object::delete(v3);
        let v10 = 0x2::table::borrow_mut<u64, MemeTokenInfo<T0>>(&mut arg0.tokens, v0);
        assert!(!v10.graduated, 1);
        let v11 = if (v2 > v10.meme_sold) {
            v10.meme_sold
        } else {
            v2
        };
        let v12 = calc_agent_out(v10.meme_sold, v11);
        let v13 = v12 * 100 / 10000;
        let v14 = v12 - v13;
        let v15 = 0x2::balance::value<T0>(&v10.treasury);
        let (v16, v17) = if (v14 + v13 <= v15) {
            (v14, v13)
        } else if (v14 <= v15) {
            (v14, v15 - v14)
        } else {
            (v15, 0)
        };
        assert!(v16 > 0, 5);
        v10.meme_sold = v10.meme_sold - v11;
        if (v10.agent_raised > v16 + v17) {
            v10.agent_raised = v10.agent_raised - v16 - v17;
        } else {
            v10.agent_raised = 0;
        };
        v10.trades = v10.trades + 1;
        v10.sells = v10.sells + 1;
        let v18 = if (v17 > 0) {
            0x2::balance::split<T0>(&mut v10.treasury, v17)
        } else {
            0x2::balance::zero<T0>()
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v10.treasury, v16), arg3), v1);
        let v19 = v10.agent_raised;
        let (v20, v21) = route_fee<T0>(v18, 0x2::table::borrow<u64, MemeTokenInfo<T0>>(&arg0.tokens, v0).creator, arg0.ecosystem, arg3);
        arg0.total_volume = arg0.total_volume + v12;
        let v22 = TokenSold{
            token_id           : v0,
            seller             : v1,
            meme_in            : v2,
            agent_out          : v16,
            agent_fee          : v13,
            fee_to_creator     : v20,
            fee_to_ecosystem   : v21,
            meme_sold_after    : v10.meme_sold,
            agent_raised_after : v19,
        };
        0x2::event::emit<TokenSold>(v22);
    }

    public entry fun initialize<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = LaunchpadManager<T0>{
            id              : 0x2::object::new(arg0),
            admin           : v0,
            ecosystem       : v0,
            token_count     : 0,
            total_volume    : 0,
            total_graduated : 0,
            tokens          : 0x2::table::new<u64, MemeTokenInfo<T0>>(arg0),
        };
        0x2::transfer::share_object<LaunchpadManager<T0>>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public entry fun merge_balance(arg0: MemeBalance, arg1: MemeBalance, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.token_id == arg1.token_id, 4);
        assert!(arg0.manager_id == arg1.manager_id, 4);
        let v0 = arg1.unlock_at_ms;
        let MemeBalance {
            id           : v1,
            token_id     : _,
            manager_id   : _,
            name         : _,
            symbol       : _,
            amount       : v6,
            unlock_at_ms : _,
        } = arg1;
        0x2::object::delete(v1);
        arg0.amount = arg0.amount + v6;
        if (v0 > arg0.unlock_at_ms) {
            arg0.unlock_at_ms = v0;
        };
        let v8 = BalanceMerged{
            merged_amount : arg1.amount,
            total_amount  : arg0.amount,
            owner         : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<BalanceMerged>(v8);
        0x2::transfer::public_transfer<MemeBalance>(arg0, 0x2::tx_context::sender(arg2));
    }

    fun route_fee<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg0);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return (0, 0)
        };
        let v1 = v0 * 7000 / 10000;
        if (v1 > 0 && v1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0, v1), arg3), arg1);
        };
        let v2 = 0x2::balance::value<T0>(&arg0);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg3), arg2);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
        (v1, v2)
    }

    public entry fun sell_meme<T0>(arg0: &mut LaunchpadManager<T0>, arg1: MemeBalance, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        do_sell<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun sell_meme_partial<T0>(arg0: &mut LaunchpadManager<T0>, arg1: MemeBalance, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.amount;
        assert!(arg2 > 0 && arg2 <= v0, 6);
        if (arg2 == v0) {
            do_sell<T0>(arg0, arg1, arg3, arg4);
        } else {
            let v1 = 0x2::tx_context::sender(arg4);
            let v2 = v0 - arg2;
            let MemeBalance {
                id           : v3,
                token_id     : v4,
                manager_id   : v5,
                name         : v6,
                symbol       : v7,
                amount       : _,
                unlock_at_ms : v9,
            } = arg1;
            0x2::object::delete(v3);
            let v10 = MemeBalance{
                id           : 0x2::object::new(arg4),
                token_id     : v4,
                manager_id   : v5,
                name         : v6,
                symbol       : v7,
                amount       : v2,
                unlock_at_ms : v9,
            };
            0x2::transfer::public_transfer<MemeBalance>(v10, v1);
            let v11 = MemeBalance{
                id           : 0x2::object::new(arg4),
                token_id     : v4,
                manager_id   : v5,
                name         : v6,
                symbol       : v7,
                amount       : arg2,
                unlock_at_ms : v9,
            };
            let v12 = BalanceSplit{
                split_amount  : arg2,
                remain_amount : v2,
                owner         : v1,
            };
            0x2::event::emit<BalanceSplit>(v12);
            do_sell<T0>(arg0, v11, arg3, arg4);
        };
    }

    public entry fun set_ecosystem<T0>(arg0: &AdminCap, arg1: &mut LaunchpadManager<T0>, arg2: address) {
        arg1.ecosystem = arg2;
        let v0 = EcosystemUpdated{
            old_ecosystem : arg1.ecosystem,
            new_ecosystem : arg2,
        };
        0x2::event::emit<EcosystemUpdated>(v0);
    }

    public entry fun split_balance(arg0: MemeBalance, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0 && arg1 < arg0.amount, 6);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = arg0.amount - arg1;
        let MemeBalance {
            id           : v2,
            token_id     : v3,
            manager_id   : v4,
            name         : v5,
            symbol       : v6,
            amount       : _,
            unlock_at_ms : v8,
        } = arg0;
        0x2::object::delete(v2);
        let v9 = MemeBalance{
            id           : 0x2::object::new(arg2),
            token_id     : v3,
            manager_id   : v4,
            name         : v5,
            symbol       : v6,
            amount       : arg1,
            unlock_at_ms : v8,
        };
        0x2::transfer::public_transfer<MemeBalance>(v9, v0);
        let v10 = MemeBalance{
            id           : 0x2::object::new(arg2),
            token_id     : v3,
            manager_id   : v4,
            name         : v5,
            symbol       : v6,
            amount       : v1,
            unlock_at_ms : v8,
        };
        0x2::transfer::public_transfer<MemeBalance>(v10, v0);
        let v11 = BalanceSplit{
            split_amount  : arg1,
            remain_amount : v1,
            owner         : v0,
        };
        0x2::event::emit<BalanceSplit>(v11);
    }

    // decompiled from Move bytecode v6
}

