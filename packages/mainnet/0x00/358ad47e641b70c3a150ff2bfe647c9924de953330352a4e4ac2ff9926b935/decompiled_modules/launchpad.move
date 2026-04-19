module 0x358ad47e641b70c3a150ff2bfe647c9924de953330352a4e4ac2ff9926b935::launchpad {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LaunchpadManager<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
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
        meme_out: u64,
        meme_sold_after: u64,
        agent_raised_after: u64,
        price_milli: u64,
    }

    struct TokenSold has copy, drop {
        token_id: u64,
        seller: address,
        meme_in: u64,
        agent_out: u64,
        agent_fee: u64,
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

    public entry fun buy_meme<T0>(arg0: &mut LaunchpadManager<T0>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, MemeTokenInfo<T0>>(&arg0.tokens, arg1), 0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 > 0, 3);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = v1 * 100 / 10000;
        let v4 = v1 - v3;
        let v5 = 0x2::table::borrow_mut<u64, MemeTokenInfo<T0>>(&mut arg0.tokens, arg1);
        assert!(!v5.graduated, 1);
        let v6 = calc_meme_out(v5.meme_sold, v4);
        assert!(v6 > 0, 2);
        v5.meme_sold = v5.meme_sold + v6;
        v5.agent_raised = v5.agent_raised + v4;
        v5.trades = v5.trades + 1;
        v5.buys = v5.buys + 1;
        let v7 = 0x2::coin::into_balance<T0>(arg2);
        let v8 = if (arg3 != @0x0) {
            if (arg3 != v0) {
                v3 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v8) {
            let v9 = v3 * 2500 / 10000;
            if (v9 > 0 && v9 < 0x2::balance::value<T0>(&v7)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, v9), arg5), arg3);
            };
        };
        0x2::balance::join<T0>(&mut v5.treasury, v7);
        let v10 = v5.agent_raised >= 15000000000000;
        if (v10) {
            v5.graduated = true;
            v5.graduated_at = v2;
        };
        let v11 = v5.name;
        let v12 = v5.symbol;
        let v13 = v5.agent_raised;
        let v14 = v5.meme_sold;
        if (v10) {
            arg0.total_graduated = arg0.total_graduated + 1;
        };
        arg0.total_volume = arg0.total_volume + v1;
        let v15 = TokenPurchased{
            token_id           : arg1,
            buyer              : v0,
            agent_in           : v1,
            agent_fee          : v3,
            meme_out           : v6,
            meme_sold_after    : v14,
            agent_raised_after : v13,
            price_milli        : current_price_milli(v5.meme_sold + v6 / 2),
        };
        0x2::event::emit<TokenPurchased>(v15);
        if (v10) {
            let v16 = TokenGraduated{
                token_id     : arg1,
                name         : v11,
                symbol       : v12,
                agent_raised : v13,
                meme_sold    : v14,
                timestamp    : v2,
            };
            0x2::event::emit<TokenGraduated>(v16);
        };
        let v17 = MemeBalance{
            id         : 0x2::object::new(arg5),
            token_id   : arg1,
            manager_id : 0x2::object::id<LaunchpadManager<T0>>(arg0),
            name       : v11,
            symbol     : v12,
            amount     : v6,
        };
        0x2::transfer::public_transfer<MemeBalance>(v17, v0);
    }

    fun calc_agent_out(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0 || arg0 == 0) {
            return 0
        };
        let v0 = arg1 / 2;
        let v1 = if (arg0 > v0) {
            arg0 - v0
        } else {
            0
        };
        arg1 * current_price_milli(v1) / 1000
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
        let v3 = 1000000000 - arg0;
        if (v2 > v3) {
            v3
        } else {
            v2
        }
    }

    public entry fun create_token<T0>(arg0: &mut LaunchpadManager<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg5);
        assert!(v0 >= 1000000000000, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg5, arg0.admin);
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
            let v15 = v4 - v4 * 100 / 10000;
            let v16 = calc_meme_out(0, v15);
            assert!(v16 > 0, 2);
            (v15, 1, v16, v16, 1, 0x2::coin::into_balance<T0>(arg6))
        } else {
            0x2::coin::destroy_zero<T0>(arg6);
            (0, 0, 0, 0, 0, 0x2::balance::zero<T0>())
        };
        let v17 = MemeTokenInfo<T0>{
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
        0x2::table::add<u64, MemeTokenInfo<T0>>(&mut arg0.tokens, v2, v17);
        arg0.total_volume = arg0.total_volume + v4;
        let v18 = TokenCreated{
            token_id          : v2,
            name              : v5,
            symbol            : v6,
            image             : v7,
            description       : v8,
            creator           : v1,
            creation_fee_paid : v0,
            timestamp         : v3,
        };
        0x2::event::emit<TokenCreated>(v18);
        if (v11 > 0) {
            let v19 = MemeBalance{
                id         : 0x2::object::new(arg8),
                token_id   : v2,
                manager_id : 0x2::object::id<LaunchpadManager<T0>>(arg0),
                name       : v5,
                symbol     : v6,
                amount     : v11,
            };
            0x2::transfer::public_transfer<MemeBalance>(v19, v1);
        };
    }

    public fun creation_fee() : u64 {
        1000000000000
    }

    fun current_price_milli(arg0: u64) : u64 {
        let v0 = if (arg0 > 1000000000) {
            1000000000
        } else {
            arg0
        };
        15500 + 30902040 * v0 / 1000000000
    }

    public fun fee_bps() : u64 {
        100
    }

    public fun get_buy_quote<T0>(arg0: &LaunchpadManager<T0>, arg1: u64, arg2: u64) : u64 {
        if (!0x2::table::contains<u64, MemeTokenInfo<T0>>(&arg0.tokens, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<u64, MemeTokenInfo<T0>>(&arg0.tokens, arg1);
        if (v0.graduated) {
            return 0
        };
        calc_meme_out(v0.meme_sold, arg2 - arg2 * 100 / 10000)
    }

    public fun get_sell_quote<T0>(arg0: &LaunchpadManager<T0>, arg1: u64, arg2: u64) : u64 {
        if (!0x2::table::contains<u64, MemeTokenInfo<T0>>(&arg0.tokens, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<u64, MemeTokenInfo<T0>>(&arg0.tokens, arg1);
        if (v0.graduated) {
            return 0
        };
        let v1 = if (arg2 > v0.meme_sold) {
            v0.meme_sold
        } else {
            arg2
        };
        let v2 = calc_agent_out(v0.meme_sold, v1);
        v2 - v2 * 100 / 10000
    }

    public fun grad_raw() : u64 {
        15000000000000
    }

    public entry fun initialize<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = LaunchpadManager<T0>{
            id              : 0x2::object::new(arg0),
            admin           : v0,
            token_count     : 0,
            total_volume    : 0,
            total_graduated : 0,
            tokens          : 0x2::table::new<u64, MemeTokenInfo<T0>>(arg0),
        };
        0x2::transfer::share_object<LaunchpadManager<T0>>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public fun meme_balance_amount(arg0: &MemeBalance) : u64 {
        arg0.amount
    }

    public fun meme_balance_symbol(arg0: &MemeBalance) : 0x1::string::String {
        arg0.symbol
    }

    public fun meme_balance_token_id(arg0: &MemeBalance) : u64 {
        arg0.token_id
    }

    public entry fun merge_balance(arg0: MemeBalance, arg1: MemeBalance, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.token_id == arg1.token_id, 4);
        assert!(arg0.manager_id == arg1.manager_id, 4);
        let MemeBalance {
            id         : v0,
            token_id   : _,
            manager_id : _,
            name       : _,
            symbol     : _,
            amount     : v5,
        } = arg1;
        0x2::object::delete(v0);
        arg0.amount = arg0.amount + v5;
        let v6 = BalanceMerged{
            merged_amount : arg1.amount,
            total_amount  : arg0.amount,
            owner         : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<BalanceMerged>(v6);
        0x2::transfer::public_transfer<MemeBalance>(arg0, 0x2::tx_context::sender(arg2));
    }

    public entry fun sell_meme<T0>(arg0: &mut LaunchpadManager<T0>, arg1: MemeBalance, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.token_id;
        assert!(0x2::table::contains<u64, MemeTokenInfo<T0>>(&arg0.tokens, v0), 0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = arg1.amount;
        assert!(v2 > 0, 3);
        let MemeBalance {
            id         : v3,
            token_id   : _,
            manager_id : _,
            name       : _,
            symbol     : _,
            amount     : _,
        } = arg1;
        0x2::object::delete(v3);
        let v9 = 0x2::table::borrow_mut<u64, MemeTokenInfo<T0>>(&mut arg0.tokens, v0);
        assert!(!v9.graduated, 1);
        let v10 = if (v2 > v9.meme_sold) {
            v9.meme_sold
        } else {
            v2
        };
        let v11 = calc_agent_out(v9.meme_sold, v10);
        let v12 = v11 * 100 / 10000;
        let v13 = v11 - v12;
        let v14 = 0x2::balance::value<T0>(&v9.treasury);
        let v15 = if (v13 > v14) {
            v14
        } else {
            v13
        };
        assert!(v15 > 0, 5);
        let v16 = if (arg2 != @0x0) {
            if (arg2 != v1) {
                v12 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v17 = if (v16) {
            let v18 = v12 * 2500 / 10000;
            let v19 = 0x2::balance::value<T0>(&v9.treasury) - v15;
            if (v18 > v19) {
                v19
            } else {
                v18
            }
        } else {
            0
        };
        v9.meme_sold = v9.meme_sold - v10;
        if (v9.agent_raised > v15) {
            v9.agent_raised = v9.agent_raised - v15;
        } else {
            v9.agent_raised = 0;
        };
        v9.trades = v9.trades + 1;
        v9.sells = v9.sells + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v9.treasury, v15), arg3), v1);
        if (v17 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v9.treasury, v17), arg3), arg2);
        };
        arg0.total_volume = arg0.total_volume + v11;
        let v20 = TokenSold{
            token_id           : v0,
            seller             : v1,
            meme_in            : v2,
            agent_out          : v15,
            agent_fee          : v12,
            meme_sold_after    : v9.meme_sold,
            agent_raised_after : v9.agent_raised,
        };
        0x2::event::emit<TokenSold>(v20);
    }

    public entry fun split_balance(arg0: MemeBalance, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0 && arg1 < arg0.amount, 6);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = arg0.amount - arg1;
        let MemeBalance {
            id         : v2,
            token_id   : v3,
            manager_id : v4,
            name       : v5,
            symbol     : v6,
            amount     : _,
        } = arg0;
        0x2::object::delete(v2);
        let v8 = MemeBalance{
            id         : 0x2::object::new(arg2),
            token_id   : v3,
            manager_id : v4,
            name       : v5,
            symbol     : v6,
            amount     : arg1,
        };
        0x2::transfer::public_transfer<MemeBalance>(v8, v0);
        let v9 = MemeBalance{
            id         : 0x2::object::new(arg2),
            token_id   : v3,
            manager_id : v4,
            name       : v5,
            symbol     : v6,
            amount     : v1,
        };
        0x2::transfer::public_transfer<MemeBalance>(v9, v0);
        let v10 = BalanceSplit{
            split_amount  : arg1,
            remain_amount : v1,
            owner         : v0,
        };
        0x2::event::emit<BalanceSplit>(v10);
    }

    public fun token_count<T0>(arg0: &LaunchpadManager<T0>) : u64 {
        arg0.token_count
    }

    public fun total_for_sale() : u64 {
        1000000000
    }

    // decompiled from Move bytecode v6
}

