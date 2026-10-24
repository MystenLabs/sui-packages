module 0x3e4fe2f75162196d7e138967dd177b470e955d7b59d994f1b667bc1861ffc8b0::chain {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BalKey has copy, drop, store {
        owner: address,
        token: u64,
    }

    struct HistKey has copy, drop, store {
        owner: address,
        n: u64,
    }

    struct PairKey has copy, drop, store {
        a: u64,
        b: u64,
    }

    struct Token has copy, drop, store {
        id: u64,
        kind: u8,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        supply: u64,
        creator: address,
        icon: 0x1::string::String,
        links: 0x1::string::String,
        created_ms: u64,
        holders: u64,
        pool: u64,
    }

    struct Account has copy, drop, store {
        since_ms: u64,
        txs: u64,
        tokens: u64,
    }

    struct Tx has copy, drop, store {
        hash: vector<u8>,
        block: u64,
        kind: u8,
        from: address,
        to: address,
        token: u64,
        amount: u64,
        token2: u64,
        amount2: u64,
        token3: u64,
        amount3: u64,
        time_ms: u64,
        sui_digest: vector<u8>,
    }

    struct Block has copy, drop, store {
        height: u64,
        hash: vector<u8>,
        parent: vector<u8>,
        tx_root: vector<u8>,
        first_tx: u64,
        tx_count: u64,
        time_ms: u64,
        producer: address,
        reward: u64,
    }

    struct Pool has copy, drop, store {
        id: u64,
        a: u64,
        b: u64,
        ra: u64,
        rb: u64,
        lp: u64,
        fee_bps: u64,
        created_ms: u64,
        creator: address,
        volume_a: u128,
        volume_b: u128,
        swaps: u64,
    }

    struct Curve has copy, drop, store {
        token: u64,
        vq: u64,
        vt: u64,
        rq: u64,
        rt: u64,
        fee_bps: u64,
        done: bool,
        trades: u64,
        creator: address,
        created_ms: u64,
    }

    struct Node has copy, drop, store {
        name: 0x1::string::String,
        joined_ms: u64,
        blocks: u64,
        rewards: u64,
        last_ms: u64,
    }

    struct Params has copy, drop, store {
        block_ms: u64,
        max_open_ms: u64,
        reward: u64,
        halving: u64,
        swap_fee_bps: u64,
        protocol_share_bps: u64,
        launch_fee_bps: u64,
        launch_vq: u64,
        create_fee: u64,
        launch_cost: u64,
        treasury: address,
    }

    struct Chain has key {
        id: 0x2::object::UID,
        version: u64,
        params: Params,
        height: u64,
        last_hash: vector<u8>,
        last_block_ms: u64,
        open_txs: u64,
        open_first: u64,
        open_since: u64,
        open_root: vector<u8>,
        tx_count: u64,
        token_count: u64,
        pool_count: u64,
        account_count: u64,
        node_count: u64,
        launch_count: u64,
        genesis_done: bool,
        blocks: 0x2::table::Table<u64, Block>,
        txs: 0x2::table::Table<u64, Tx>,
        tokens: 0x2::table::Table<u64, Token>,
        balances: 0x2::table::Table<BalKey, u64>,
        accounts: 0x2::table::Table<address, Account>,
        history: 0x2::table::Table<HistKey, u64>,
        owned: 0x2::table::Table<HistKey, u64>,
        pools: 0x2::table::Table<u64, Pool>,
        pairs: 0x2::table::Table<PairKey, u64>,
        curves: 0x2::table::Table<u64, Curve>,
        nodes: 0x2::table::Table<address, Node>,
        hashes: 0x2::table::Table<vector<u8>, u64>,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct TxEvent has copy, drop {
        index: u64,
        tx: Tx,
    }

    struct BlockEvent has copy, drop {
        block: Block,
    }

    struct BalEvent has copy, drop {
        owner: address,
        token: u64,
        balance: u64,
    }

    struct TokenEvent has copy, drop {
        token: Token,
    }

    struct PoolEvent has copy, drop {
        pool: Pool,
    }

    struct CurveEvent has copy, drop {
        curve: Curve,
    }

    struct NodeEvent has copy, drop {
        addr: address,
        node: Node,
    }

    public fun swap(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) : u64 {
        check(arg0);
        assert!(0x2::table::contains<u64, Pool>(&arg0.pools, arg2), 5);
        assert!(arg4 > 0, 2);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = *0x2::table::borrow<u64, Pool>(&arg0.pools, arg2);
        assert!(arg3 == v2.a || arg3 == v2.b, 16);
        let v3 = arg3 == v2.a;
        let (v4, v5, v6) = if (v3) {
            (v2.ra, v2.rb, v2.b)
        } else {
            (v2.rb, v2.ra, v2.a)
        };
        let v7 = (((arg4 as u128) * (v2.fee_bps as u128) / 10000) as u64);
        let v8 = (((v7 as u128) * (arg0.params.protocol_share_bps as u128) / 10000) as u64);
        let v9 = ((arg4 - v7) as u128);
        let v10 = ((v9 * (v5 as u128) / ((v4 as u128) + v9)) as u64);
        let v11 = if (v10 >= arg5) {
            if (v10 > 0) {
                v10 < v5
            } else {
                false
            }
        } else {
            false
        };
        assert!(v11, 7);
        debit(arg0, v0, arg3, arg4);
        let v12 = 0x2::table::borrow_mut<u64, Pool>(&mut arg0.pools, arg2);
        if (v3) {
            v12.ra = v12.ra + arg4 - v8;
            v12.rb = v12.rb - v10;
            v12.volume_a = v12.volume_a + (arg4 as u128);
        } else {
            v12.rb = v12.rb + arg4 - v8;
            v12.ra = v12.ra - v10;
            v12.volume_b = v12.volume_b + (arg4 as u128);
        };
        v12.swaps = v12.swaps + 1;
        let v13 = PoolEvent{pool: *v12};
        0x2::event::emit<PoolEvent>(v13);
        if (v8 > 0) {
            let v14 = arg0.params.treasury;
            credit(arg0, v14, arg3, v8, v1);
        };
        credit(arg0, v0, v6, v10, v1);
        record(arg0, arg1, arg6, 7, v0, @0x0, arg3, arg4, v6, v10, arg2, v7);
        v10
    }

    public fun transfer(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: u64, arg3: address, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        check(arg0);
        assert!(arg4 > 0, 2);
        assert!(0x2::table::contains<u64, Token>(&arg0.tokens, arg2), 3);
        let v0 = 0x2::tx_context::sender(arg5);
        debit(arg0, v0, arg2, arg4);
        credit(arg0, arg3, arg2, arg4, 0x2::clock::timestamp_ms(arg1));
        record(arg0, arg1, arg5, 1, v0, arg3, arg2, arg4, 0, 0, 0, 0);
    }

    public fun add_liquidity(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) : u64 {
        check(arg0);
        assert!(0x2::table::contains<u64, Pool>(&arg0.pools, arg2), 5);
        assert!(arg4 > 0, 2);
        let v0 = *0x2::table::borrow<u64, Pool>(&arg0.pools, arg2);
        assert!(arg3 == v0.a || arg3 == v0.b, 16);
        let (v1, v2, v3) = if (arg3 == v0.a) {
            (v0.ra, v0.rb, v0.b)
        } else {
            (v0.rb, v0.ra, v0.a)
        };
        let v4 = ((((arg4 as u128) * (v2 as u128) + (v1 as u128) - 1) / (v1 as u128)) as u64);
        assert!(v4 <= arg5 && v4 > 0, 7);
        let v5 = (((arg4 as u128) * (0x2::table::borrow<u64, Token>(&arg0.tokens, v0.lp).supply as u128) / (v1 as u128)) as u64);
        assert!(v5 > 0, 2);
        let v6 = 0x2::tx_context::sender(arg6);
        debit(arg0, v6, arg3, arg4);
        debit(arg0, v6, v3, v4);
        let v7 = 0x2::table::borrow_mut<u64, Pool>(&mut arg0.pools, arg2);
        if (arg3 == v7.a) {
            v7.ra = v7.ra + arg4;
            v7.rb = v7.rb + v4;
        } else {
            v7.rb = v7.rb + arg4;
            v7.ra = v7.ra + v4;
        };
        let v8 = PoolEvent{pool: *v7};
        0x2::event::emit<PoolEvent>(v8);
        mint(arg0, v6, v0.lp, v5, 0x2::clock::timestamp_ms(arg1));
        record(arg0, arg1, arg6, 5, v6, @0x0, arg3, arg4, v3, v4, v0.lp, v5);
        v5
    }

    fun add_token(arg0: &mut Chain, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: address, arg6: vector<u8>, arg7: vector<u8>, arg8: u64) : u64 {
        let v0 = arg0.token_count;
        let v1 = Token{
            id         : v0,
            kind       : arg1,
            name       : text(arg2, 1, 40),
            symbol     : text(arg3, 1, 16),
            decimals   : arg4,
            supply     : 0,
            creator    : arg5,
            icon       : text(arg6, 0, 24000),
            links      : text(arg7, 0, 600),
            created_ms : arg8,
            holders    : 0,
            pool       : 0,
        };
        0x2::table::add<u64, Token>(&mut arg0.tokens, v0, v1);
        arg0.token_count = v0 + 1;
        let v2 = TokenEvent{token: v1};
        0x2::event::emit<TokenEvent>(v2);
        v0
    }

    public fun balance_of(arg0: &Chain, arg1: address, arg2: u64) : u64 {
        let v0 = BalKey{
            owner : arg1,
            token : arg2,
        };
        if (0x2::table::contains<BalKey, u64>(&arg0.balances, v0)) {
            *0x2::table::borrow<BalKey, u64>(&arg0.balances, v0)
        } else {
            0
        }
    }

    fun block_reward(arg0: &Chain, arg1: u64) : u64 {
        let v0 = arg1 / arg0.params.halving;
        if (v0 >= 64) {
            return 0
        };
        let v1 = arg0.params.reward >> (v0 as u8);
        let v2 = 1000000000000000000 - 0x2::table::borrow<u64, Token>(&arg0.tokens, 0).supply;
        if (v1 > v2) {
            v2
        } else {
            v1
        }
    }

    public fun bridge_in(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::tx_context::TxContext) {
        check(arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v1 = 0x2::tx_context::sender(arg3);
        mint(arg0, v1, 1, v0, 0x2::clock::timestamp_ms(arg1));
        record(arg0, arg1, arg3, 2, @0x0, v1, 1, v0, 0, 0, 0, 0);
    }

    public fun bridge_out(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        check(arg0);
        assert!(arg2 > 0, 2);
        let v0 = 0x2::tx_context::sender(arg4);
        burn_from(arg0, v0, 1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, arg2), arg4), arg3);
        record(arg0, arg1, arg4, 3, v0, arg3, 1, arg2, 0, 0, 0, 0);
    }

    public fun burn(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        check(arg0);
        assert!(arg3 > 0, 2);
        assert!(0x2::table::contains<u64, Token>(&arg0.tokens, arg2), 3);
        let v0 = 0x2::tx_context::sender(arg4);
        burn_from(arg0, v0, arg2, arg3);
        record(arg0, arg1, arg4, 13, v0, @0x0, arg2, arg3, 0, 0, 0, 0);
    }

    fun burn_from(arg0: &mut Chain, arg1: address, arg2: u64, arg3: u64) {
        debit(arg0, arg1, arg2, arg3);
        let v0 = 0x2::table::borrow_mut<u64, Token>(&mut arg0.tokens, arg2);
        v0.supply = v0.supply - arg3;
        let v1 = TokenEvent{token: *v0};
        0x2::event::emit<TokenEvent>(v1);
    }

    public fun buy_tokens(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) : u64 {
        check(arg0);
        assert!(0x2::table::contains<u64, Curve>(&arg0.curves, arg2), 11);
        assert!(arg3 > 0, 2);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = *0x2::table::borrow<u64, Curve>(&arg0.curves, arg2);
        assert!(!v2.done, 12);
        let v3 = (((arg3 as u128) * (v2.fee_bps as u128) / 10000) as u64);
        let v4 = v3;
        let v5 = arg3 - v3;
        let v6 = v5;
        let v7 = (v2.vq as u128) * (v2.vt as u128);
        let v8 = v2.vt - (div_up(v7, (v2.vq as u128) + (v5 as u128)) as u64);
        let v9 = v8;
        if (v8 >= v2.rt) {
            let v10 = v2.rt;
            v9 = v10;
            let v11 = (div_up(v7, ((v2.vt - v10) as u128)) as u64) - v2.vq;
            v6 = v11;
            v4 = (((v11 as u128) * (v2.fee_bps as u128) / (10000 - (v2.fee_bps as u128))) as u64);
        };
        assert!(v9 >= arg4 && v9 > 0, 7);
        debit(arg0, v0, 1, v6 + v4);
        if (v4 > 0) {
            let v12 = arg0.params.treasury;
            credit(arg0, v12, 1, v4, v1);
        };
        let v13 = 0x2::table::borrow_mut<u64, Curve>(&mut arg0.curves, arg2);
        v13.vq = v13.vq + v6;
        v13.vt = v13.vt - v9;
        v13.rq = v13.rq + v6;
        v13.rt = v13.rt - v9;
        v13.trades = v13.trades + 1;
        let v14 = CurveEvent{curve: *v13};
        0x2::event::emit<CurveEvent>(v14);
        credit(arg0, v0, arg2, v9, v1);
        record(arg0, arg1, arg5, 9, v0, @0x0, 1, v6 + v4, arg2, v9, 0, v4);
        if (v13.rt == 0) {
            graduate(arg0, arg1, arg2, arg5);
        };
        v9
    }

    public fun can_seal(arg0: &Chain, arg1: &0x2::clock::Clock) : bool {
        arg0.open_txs > 0 && 0x2::clock::timestamp_ms(arg1) >= arg0.last_block_ms + arg0.params.block_ms
    }

    fun check(arg0: &Chain) {
        assert!(arg0.version == 1, 0);
    }

    public fun create_pool(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) : u64 {
        check(arg0);
        assert!(arg2 != arg3, 4);
        assert!(0x2::table::contains<u64, Token>(&arg0.tokens, arg2) && 0x2::table::contains<u64, Token>(&arg0.tokens, arg3), 3);
        assert!(0x2::table::borrow<u64, Token>(&arg0.tokens, arg2).kind != 4 && 0x2::table::borrow<u64, Token>(&arg0.tokens, arg3).kind != 4, 3);
        assert!(not_on_curve(arg0, arg2) && not_on_curve(arg0, arg3), 11);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        debit(arg0, v0, arg2, arg4);
        debit(arg0, v0, arg3, arg5);
        let (v2, v3, v4) = open_pool(arg0, arg2, arg3, arg4, arg5, v0, v1);
        mint(arg0, v0, v3, v4, v1);
        record(arg0, arg1, arg6, 5, v0, @0x0, arg2, arg4, arg3, arg5, v3, v4);
        v2
    }

    public fun create_token(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::tx_context::TxContext) : u64 {
        check(arg0);
        assert!(arg5 > 0 && arg4 <= 18, 2);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = arg0.params.create_fee;
        pay_fee(arg0, v0, v2, v1);
        let v3 = add_token(arg0, 2, arg2, arg3, arg4, v0, arg6, arg7, v1);
        mint(arg0, v0, v3, arg5, v1);
        record(arg0, arg1, arg8, 4, @0x0, v0, v3, arg5, 0, 0, 0, 0);
        v3
    }

    fun credit(arg0: &mut Chain, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        if (arg3 == 0) {
            return
        };
        touch(arg0, arg1, arg4);
        let v0 = BalKey{
            owner : arg1,
            token : arg2,
        };
        let v1 = if (0x2::table::contains<BalKey, u64>(&arg0.balances, v0)) {
            let v2 = 0x2::table::borrow_mut<BalKey, u64>(&mut arg0.balances, v0);
            if (*v2 == 0) {
                let v3 = 0x2::table::borrow_mut<u64, Token>(&mut arg0.tokens, arg2);
                v3.holders = v3.holders + 1;
            };
            *v2 = *v2 + arg3;
            *v2
        } else {
            0x2::table::add<BalKey, u64>(&mut arg0.balances, v0, arg3);
            let v4 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, arg1);
            let v5 = v4.tokens;
            v4.tokens = v5 + 1;
            let v6 = HistKey{
                owner : arg1,
                n     : v5,
            };
            0x2::table::add<HistKey, u64>(&mut arg0.owned, v6, arg2);
            let v7 = 0x2::table::borrow_mut<u64, Token>(&mut arg0.tokens, arg2);
            v7.holders = v7.holders + 1;
            arg3
        };
        let v8 = BalEvent{
            owner   : arg1,
            token   : arg2,
            balance : v1,
        };
        0x2::event::emit<BalEvent>(v8);
    }

    public fun curve_state(arg0: &Chain, arg1: u64) : (u64, u64, u64, u64, bool) {
        let v0 = *0x2::table::borrow<u64, Curve>(&arg0.curves, arg1);
        (v0.vq, v0.vt, v0.rq, v0.rt, v0.done)
    }

    fun debit(arg0: &mut Chain, arg1: address, arg2: u64, arg3: u64) {
        if (arg3 == 0) {
            return
        };
        let v0 = BalKey{
            owner : arg1,
            token : arg2,
        };
        assert!(0x2::table::contains<BalKey, u64>(&arg0.balances, v0), 1);
        let v1 = 0x2::table::borrow_mut<BalKey, u64>(&mut arg0.balances, v0);
        assert!(*v1 >= arg3, 1);
        *v1 = *v1 - arg3;
        let v2 = *v1;
        if (v2 == 0) {
            let v3 = 0x2::table::borrow_mut<u64, Token>(&mut arg0.tokens, arg2);
            v3.holders = v3.holders - 1;
        };
        let v4 = BalEvent{
            owner   : arg1,
            token   : arg2,
            balance : v2,
        };
        0x2::event::emit<BalEvent>(v4);
    }

    fun div_up(arg0: u128, arg1: u128) : u128 {
        (arg0 + arg1 - 1) / arg1
    }

    public fun genesis_mint(arg0: &AdminCap, arg1: &mut Chain, arg2: &0x2::clock::Clock, arg3: address, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        check(arg1);
        assert!(!arg1.genesis_done, 14);
        assert!(arg4 > 0 && arg4 <= 200000000000000000, 15);
        arg1.genesis_done = true;
        mint(arg1, arg3, 0, arg4, 0x2::clock::timestamp_ms(arg2));
        record(arg1, arg2, arg5, 0, @0x0, arg3, 0, arg4, 0, 0, 0, 0);
    }

    fun graduate(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::table::borrow_mut<u64, Curve>(&mut arg0.curves, arg2);
        v1.done = true;
        let v2 = v1.rq;
        let v3 = CurveEvent{curve: *v1};
        0x2::event::emit<CurveEvent>(v3);
        let v4 = 1000000000000000 - 793100000000000;
        let (v5, v6, v7) = if (0x2::table::contains<PairKey, u64>(&arg0.pairs, pair(arg2, 1))) {
            let v8 = *0x2::table::borrow<PairKey, u64>(&arg0.pairs, pair(arg2, 1));
            let v9 = *0x2::table::borrow<u64, Pool>(&arg0.pools, v8);
            let v10 = if (v9.a == arg2) {
                v9.ra
            } else {
                v9.rb
            };
            let v11 = (((v4 as u128) * (0x2::table::borrow<u64, Token>(&arg0.tokens, v9.lp).supply as u128) / (v10 as u128)) as u64);
            let v12 = 0x2::table::borrow_mut<u64, Pool>(&mut arg0.pools, v8);
            if (v12.a == arg2) {
                v12.ra = v12.ra + v4;
                v12.rb = v12.rb + v2;
            } else {
                v12.rb = v12.rb + v4;
                v12.ra = v12.ra + v2;
            };
            let v13 = PoolEvent{pool: *v12};
            0x2::event::emit<PoolEvent>(v13);
            mint(arg0, @0x0, v9.lp, v11, v0);
            (v8, v9.lp, v11)
        } else {
            let (v14, v15, v16) = open_pool(arg0, arg2, 1, v4, v2, @0x0, v0);
            mint(arg0, @0x0, v15, v16, v0);
            (v14, v15, v16)
        };
        0x2::table::borrow_mut<u64, Token>(&mut arg0.tokens, arg2).pool = v5;
        let v17 = TokenEvent{token: *0x2::table::borrow<u64, Token>(&arg0.tokens, arg2)};
        0x2::event::emit<TokenEvent>(v17);
        record(arg0, arg1, arg3, 11, @0x0, @0x0, arg2, v4, 1, v2, v6, v7);
    }

    public fun height(arg0: &Chain) : u64 {
        arg0.height
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg0);
        let v2 = b"BloxChain genesis";
        let v3 = 0x2::hash::blake2b256(&v2);
        let v4 = Params{
            block_ms           : 3000,
            max_open_ms        : 20000,
            reward             : 50000000000,
            halving            : 8000000,
            swap_fee_bps       : 30,
            protocol_share_bps : 1666,
            launch_fee_bps     : 100,
            launch_vq          : 300000000000,
            create_fee         : 0,
            launch_cost        : 0,
            treasury           : v0,
        };
        let v5 = Chain{
            id            : 0x2::object::new(arg0),
            version       : 1,
            params        : v4,
            height        : 0,
            last_hash     : v3,
            last_block_ms : v1,
            open_txs      : 0,
            open_first    : 0,
            open_since    : 0,
            open_root     : b"",
            tx_count      : 0,
            token_count   : 0,
            pool_count    : 0,
            account_count : 0,
            node_count    : 0,
            launch_count  : 0,
            genesis_done  : false,
            blocks        : 0x2::table::new<u64, Block>(arg0),
            txs           : 0x2::table::new<u64, Tx>(arg0),
            tokens        : 0x2::table::new<u64, Token>(arg0),
            balances      : 0x2::table::new<BalKey, u64>(arg0),
            accounts      : 0x2::table::new<address, Account>(arg0),
            history       : 0x2::table::new<HistKey, u64>(arg0),
            owned         : 0x2::table::new<HistKey, u64>(arg0),
            pools         : 0x2::table::new<u64, Pool>(arg0),
            pairs         : 0x2::table::new<PairKey, u64>(arg0),
            curves        : 0x2::table::new<u64, Curve>(arg0),
            nodes         : 0x2::table::new<address, Node>(arg0),
            hashes        : 0x2::table::new<vector<u8>, u64>(arg0),
            vault         : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v6 = Block{
            height   : 0,
            hash     : v3,
            parent   : b"",
            tx_root  : b"",
            first_tx : 0,
            tx_count : 0,
            time_ms  : v1,
            producer : @0x0,
            reward   : 0,
        };
        0x2::table::add<u64, Block>(&mut v5.blocks, 0, v6);
        0x2::table::add<vector<u8>, u64>(&mut v5.hashes, v3, 9223372036854775808);
        let v7 = BlockEvent{block: v6};
        0x2::event::emit<BlockEvent>(v7);
        let v8 = &mut v5;
        add_token(v8, 0, b"BloxChain", b"BLOX", 9, @0x0, b"", b"", v1);
        let v9 = &mut v5;
        add_token(v9, 1, b"Sui", b"SUI", 9, @0x0, b"", b"", v1);
        0x2::transfer::share_object<Chain>(v5);
        let v10 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v10, v0);
    }

    public fun is_node(arg0: &Chain, arg1: address) : bool {
        0x2::table::contains<address, Node>(&arg0.nodes, arg1)
    }

    public fun launch(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &0x2::tx_context::TxContext) : u64 {
        check(arg0);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = arg0.params.launch_cost;
        pay_fee(arg0, v0, v2, v1);
        let v3 = add_token(arg0, 3, arg2, arg3, 6, v0, arg4, arg5, v1);
        let v4 = 0x2::table::borrow_mut<u64, Token>(&mut arg0.tokens, v3);
        v4.supply = 1000000000000000;
        let v5 = TokenEvent{token: *v4};
        0x2::event::emit<TokenEvent>(v5);
        let v6 = Curve{
            token      : v3,
            vq         : arg0.params.launch_vq,
            vt         : 1073000000000000,
            rq         : 0,
            rt         : 793100000000000,
            fee_bps    : arg0.params.launch_fee_bps,
            done       : false,
            trades     : 0,
            creator    : v0,
            created_ms : v1,
        };
        0x2::table::add<u64, Curve>(&mut arg0.curves, v3, v6);
        arg0.launch_count = arg0.launch_count + 1;
        let v7 = CurveEvent{curve: v6};
        0x2::event::emit<CurveEvent>(v7);
        record(arg0, arg1, arg7, 8, v0, @0x0, v3, 1000000000000000, 0, 0, 0, 0);
        if (arg6 > 0) {
            buy_tokens(arg0, arg1, v3, arg6, 0, arg7);
        };
        v3
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Chain) {
        assert!(arg1.version < 1, 0);
        arg1.version = 1;
    }

    fun mint(arg0: &mut Chain, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = 0x2::table::borrow_mut<u64, Token>(&mut arg0.tokens, arg2);
        v0.supply = v0.supply + arg3;
        let v1 = TokenEvent{token: *v0};
        0x2::event::emit<TokenEvent>(v1);
        credit(arg0, arg1, arg2, arg3, arg4);
    }

    fun not_on_curve(arg0: &Chain, arg1: u64) : bool {
        !0x2::table::contains<u64, Curve>(&arg0.curves, arg1) || 0x2::table::borrow<u64, Curve>(&arg0.curves, arg1).done
    }

    fun open_pool(arg0: &mut Chain, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: u64) : (u64, u64, u64) {
        let v0 = pair(arg1, arg2);
        assert!(!0x2::table::contains<PairKey, u64>(&arg0.pairs, v0), 6);
        assert!(arg3 > 0 && arg4 > 0, 2);
        let (v1, v2, v3, v4) = if (arg1 < arg2) {
            (arg1, arg2, arg3, arg4)
        } else {
            (arg2, arg1, arg4, arg3)
        };
        let v5 = 0x1::string::into_bytes(0x2::table::borrow<u64, Token>(&arg0.tokens, v1).symbol);
        0x1::vector::append<u8>(&mut v5, b"/");
        0x1::vector::append<u8>(&mut v5, 0x1::string::into_bytes(0x2::table::borrow<u64, Token>(&arg0.tokens, v2).symbol));
        if (0x1::vector::length<u8>(&v5) > 33) {
            v5 = b"BloxChain";
        };
        0x1::vector::append<u8>(&mut v5, b" LP");
        let v6 = arg0.pool_count;
        let v7 = add_token(arg0, 4, v5, b"BLP", 9, arg5, b"", b"", arg6);
        0x2::table::borrow_mut<u64, Token>(&mut arg0.tokens, v7).pool = v6;
        let v8 = sqrt((v3 as u128) * (v4 as u128));
        assert!(v8 > (1000 as u128), 2);
        mint(arg0, @0x0, v7, 1000, arg6);
        let v9 = Pool{
            id         : v6,
            a          : v1,
            b          : v2,
            ra         : v3,
            rb         : v4,
            lp         : v7,
            fee_bps    : arg0.params.swap_fee_bps,
            created_ms : arg6,
            creator    : arg5,
            volume_a   : 0,
            volume_b   : 0,
            swaps      : 0,
        };
        0x2::table::add<u64, Pool>(&mut arg0.pools, v6, v9);
        0x2::table::add<PairKey, u64>(&mut arg0.pairs, v0, v6);
        arg0.pool_count = v6 + 1;
        let v10 = PoolEvent{pool: v9};
        0x2::event::emit<PoolEvent>(v10);
        (v6, v7, (v8 as u64) - 1000)
    }

    public fun open_txs(arg0: &Chain) : u64 {
        arg0.open_txs
    }

    fun pair(arg0: u64, arg1: u64) : PairKey {
        if (arg0 < arg1) {
            PairKey{a: arg0, b: arg1}
        } else {
            PairKey{a: arg1, b: arg0}
        }
    }

    fun pay_fee(arg0: &mut Chain, arg1: address, arg2: u64, arg3: u64) {
        if (arg2 == 0) {
            return
        };
        debit(arg0, arg1, 1, arg2);
        let v0 = arg0.params.treasury;
        credit(arg0, v0, 1, arg2, arg3);
    }

    public fun pool_count(arg0: &Chain) : u64 {
        arg0.pool_count
    }

    public fun pool_of(arg0: &Chain, arg1: u64, arg2: u64) : u64 {
        let v0 = pair(arg1, arg2);
        assert!(0x2::table::contains<PairKey, u64>(&arg0.pairs, v0), 5);
        *0x2::table::borrow<PairKey, u64>(&arg0.pairs, v0)
    }

    public fun pool_reserves(arg0: &Chain, arg1: u64) : (u64, u64, u64, u64) {
        let v0 = *0x2::table::borrow<u64, Pool>(&arg0.pools, arg1);
        (v0.a, v0.b, v0.ra, v0.rb)
    }

    fun push_history(arg0: &mut Chain, arg1: address, arg2: u64, arg3: u64) {
        touch(arg0, arg1, arg3);
        let v0 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, arg1);
        let v1 = v0.txs;
        v0.txs = v1 + 1;
        let v2 = HistKey{
            owner : arg1,
            n     : v1,
        };
        0x2::table::add<HistKey, u64>(&mut arg0.history, v2, arg2);
    }

    fun record(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext, arg3: u8, arg4: address, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (arg0.open_txs > 0 && v0 >= arg0.open_since + arg0.params.max_open_ms) {
            seal(arg0, v0, @0x0, false);
        };
        let v1 = arg0.tx_count;
        arg0.tx_count = v1 + 1;
        if (arg0.open_txs == 0) {
            arg0.open_first = v1;
            arg0.open_since = v0;
        };
        let v2 = *0x2::tx_context::digest(arg2);
        let v3 = 0x2::bcs::to_bytes<u64>(&v1);
        0x1::vector::push_back<u8>(&mut v3, arg3);
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<address>(&arg4));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<address>(&arg5));
        let v4 = 0x1::vector::empty<u64>();
        let v5 = &mut v4;
        0x1::vector::push_back<u64>(v5, arg6);
        0x1::vector::push_back<u64>(v5, arg7);
        0x1::vector::push_back<u64>(v5, arg8);
        0x1::vector::push_back<u64>(v5, arg9);
        0x1::vector::push_back<u64>(v5, arg10);
        0x1::vector::push_back<u64>(v5, arg11);
        0x1::vector::push_back<u64>(v5, v0);
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<vector<u64>>(&v4));
        0x1::vector::append<u8>(&mut v3, v2);
        let v6 = 0x2::hash::blake2b256(&v3);
        let v7 = arg0.open_root;
        0x1::vector::append<u8>(&mut v7, v6);
        arg0.open_root = 0x2::hash::blake2b256(&v7);
        arg0.open_txs = arg0.open_txs + 1;
        let v8 = Tx{
            hash       : v6,
            block      : arg0.height + 1,
            kind       : arg3,
            from       : arg4,
            to         : arg5,
            token      : arg6,
            amount     : arg7,
            token2     : arg8,
            amount2    : arg9,
            token3     : arg10,
            amount3    : arg11,
            time_ms    : v0,
            sui_digest : v2,
        };
        0x2::table::add<u64, Tx>(&mut arg0.txs, v1, v8);
        0x2::table::add<vector<u8>, u64>(&mut arg0.hashes, v6, v1);
        if (arg4 != @0x0) {
            push_history(arg0, arg4, v1, v0);
        };
        if (arg5 != @0x0 && arg5 != arg4) {
            push_history(arg0, arg5, v1, v0);
        };
        let v9 = TxEvent{
            index : v1,
            tx    : v8,
        };
        0x2::event::emit<TxEvent>(v9);
    }

    public fun register_node(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        check(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        if (0x2::table::contains<address, Node>(&arg0.nodes, v0)) {
            let v2 = 0x2::table::borrow_mut<address, Node>(&mut arg0.nodes, v0);
            v2.name = text(arg2, 1, 24);
            let v3 = NodeEvent{
                addr : v0,
                node : *v2,
            };
            0x2::event::emit<NodeEvent>(v3);
        } else {
            let v4 = Node{
                name      : text(arg2, 1, 24),
                joined_ms : v1,
                blocks    : 0,
                rewards   : 0,
                last_ms   : v1,
            };
            0x2::table::add<address, Node>(&mut arg0.nodes, v0, v4);
            arg0.node_count = arg0.node_count + 1;
            let v5 = NodeEvent{
                addr : v0,
                node : v4,
            };
            0x2::event::emit<NodeEvent>(v5);
            touch(arg0, v0, v1);
            record(arg0, arg1, arg3, 12, v0, v0, 0, 0, 0, 0, 0, 0);
        };
    }

    public fun remove_liquidity(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) : (u64, u64) {
        check(arg0);
        assert!(0x2::table::contains<u64, Pool>(&arg0.pools, arg2), 5);
        assert!(arg3 > 0, 2);
        let v0 = *0x2::table::borrow<u64, Pool>(&arg0.pools, arg2);
        let v1 = (0x2::table::borrow<u64, Token>(&arg0.tokens, v0.lp).supply as u128);
        let v2 = (((arg3 as u128) * (v0.ra as u128) / v1) as u64);
        let v3 = (((arg3 as u128) * (v0.rb as u128) / v1) as u64);
        let v4 = if (v2 >= arg4) {
            if (v3 >= arg5) {
                if (v2 > 0) {
                    v3 > 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 7);
        let v5 = 0x2::tx_context::sender(arg6);
        let v6 = 0x2::clock::timestamp_ms(arg1);
        burn_from(arg0, v5, v0.lp, arg3);
        let v7 = 0x2::table::borrow_mut<u64, Pool>(&mut arg0.pools, arg2);
        v7.ra = v7.ra - v2;
        v7.rb = v7.rb - v3;
        let v8 = PoolEvent{pool: *v7};
        0x2::event::emit<PoolEvent>(v8);
        credit(arg0, v5, v0.a, v2, v6);
        credit(arg0, v5, v0.b, v3, v6);
        record(arg0, arg1, arg6, 6, v5, @0x0, v0.a, v2, v0.b, v3, v0.lp, arg3);
        (v2, v3)
    }

    fun seal(arg0: &mut Chain, arg1: u64, arg2: address, arg3: bool) {
        let v0 = arg0.height + 1;
        let v1 = 0x2::bcs::to_bytes<u64>(&v0);
        0x1::vector::append<u8>(&mut v1, arg0.last_hash);
        0x1::vector::append<u8>(&mut v1, arg0.open_root);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg0.open_txs));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg2));
        let v2 = 0x2::hash::blake2b256(&v1);
        let v3 = if (arg3) {
            block_reward(arg0, v0)
        } else {
            0
        };
        let v4 = Block{
            height   : v0,
            hash     : v2,
            parent   : arg0.last_hash,
            tx_root  : arg0.open_root,
            first_tx : arg0.open_first,
            tx_count : arg0.open_txs,
            time_ms  : arg1,
            producer : arg2,
            reward   : v3,
        };
        0x2::table::add<u64, Block>(&mut arg0.blocks, v0, v4);
        0x2::table::add<vector<u8>, u64>(&mut arg0.hashes, v2, 9223372036854775808 | v0);
        arg0.height = v0;
        arg0.last_hash = v2;
        arg0.last_block_ms = arg1;
        arg0.open_txs = 0;
        arg0.open_root = b"";
        let v5 = BlockEvent{block: v4};
        0x2::event::emit<BlockEvent>(v5);
        if (arg3) {
            if (v3 > 0) {
                mint(arg0, arg2, 0, v3, arg1);
            };
            let v6 = 0x2::table::borrow_mut<address, Node>(&mut arg0.nodes, arg2);
            v6.blocks = v6.blocks + 1;
            v6.rewards = v6.rewards + v3;
            v6.last_ms = arg1;
            let v7 = NodeEvent{
                addr : arg2,
                node : *v6,
            };
            0x2::event::emit<NodeEvent>(v7);
        };
    }

    public fun seal_block(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        check(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, Node>(&arg0.nodes, v0), 8);
        assert!(arg0.open_txs > 0, 9);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(v1 >= arg0.last_block_ms + arg0.params.block_ms, 10);
        seal(arg0, v1, v0, true);
    }

    public fun sell_tokens(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) : u64 {
        check(arg0);
        assert!(0x2::table::contains<u64, Curve>(&arg0.curves, arg2), 11);
        assert!(arg3 > 0, 2);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = *0x2::table::borrow<u64, Curve>(&arg0.curves, arg2);
        assert!(!v2.done, 12);
        let v3 = v2.vq - (div_up((v2.vq as u128) * (v2.vt as u128), (v2.vt as u128) + (arg3 as u128)) as u64);
        let v4 = if (v3 > v2.rq) {
            v2.rq
        } else {
            v3
        };
        let v5 = (((v4 as u128) * (v2.fee_bps as u128) / 10000) as u64);
        let v6 = v4 - v5;
        assert!(v6 >= arg4 && v6 > 0, 7);
        debit(arg0, v0, arg2, arg3);
        let v7 = 0x2::table::borrow_mut<u64, Curve>(&mut arg0.curves, arg2);
        v7.vq = v7.vq - v4;
        v7.vt = v7.vt + arg3;
        v7.rq = v7.rq - v4;
        v7.rt = v7.rt + arg3;
        v7.trades = v7.trades + 1;
        let v8 = CurveEvent{curve: *v7};
        0x2::event::emit<CurveEvent>(v8);
        if (v5 > 0) {
            let v9 = arg0.params.treasury;
            credit(arg0, v9, 1, v5, v1);
        };
        credit(arg0, v0, 1, v6, v1);
        record(arg0, arg1, arg5, 10, v0, @0x0, arg2, arg3, 1, v6, 0, v5);
        v6
    }

    public fun set_params(arg0: &AdminCap, arg1: &mut Chain, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: address) {
        check(arg1);
        assert!(arg2 >= 500 && arg3 >= arg2, 17);
        let v0 = if (arg4 <= 100) {
            if (arg5 <= 5000) {
                arg6 <= 200
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 17);
        assert!(arg7 >= 1000000000, 17);
        let v1 = &mut arg1.params;
        v1.block_ms = arg2;
        v1.max_open_ms = arg3;
        v1.swap_fee_bps = arg4;
        v1.protocol_share_bps = arg5;
        v1.launch_fee_bps = arg6;
        v1.launch_vq = arg7;
        v1.create_fee = arg8;
        v1.launch_cost = arg9;
        v1.treasury = arg10;
    }

    fun sqrt(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 / 2;
        };
        arg0
    }

    fun text(arg0: vector<u8>, arg1: u64, arg2: u64) : 0x1::string::String {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 >= arg1 && v0 <= arg2, 13);
        let v1 = 0x1::string::try_utf8(arg0);
        assert!(0x1::option::is_some<0x1::string::String>(&v1), 13);
        0x1::option::destroy_some<0x1::string::String>(v1)
    }

    public fun token_count(arg0: &Chain) : u64 {
        arg0.token_count
    }

    public fun token_supply(arg0: &Chain, arg1: u64) : u64 {
        0x2::table::borrow<u64, Token>(&arg0.tokens, arg1).supply
    }

    fun touch(arg0: &mut Chain, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, Account>(&arg0.accounts, arg1)) {
            let v0 = Account{
                since_ms : arg2,
                txs      : 0,
                tokens   : 0,
            };
            0x2::table::add<address, Account>(&mut arg0.accounts, arg1, v0);
            arg0.account_count = arg0.account_count + 1;
        };
    }

    public fun tx_count(arg0: &Chain) : u64 {
        arg0.tx_count
    }

    public fun vault_value(arg0: &Chain) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.vault)
    }

    // decompiled from Move bytecode v7
}

