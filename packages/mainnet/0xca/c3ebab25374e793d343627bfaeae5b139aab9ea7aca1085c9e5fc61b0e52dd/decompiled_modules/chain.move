module 0xcac3ebab25374e793d343627bfaeae5b139aab9ea7aca1085c9e5fc61b0e52dd::chain {
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
        r0: u64,
        r1: u64,
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

    struct NativeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct VaultKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Native has copy, drop, store {
        coin: 0x1::type_name::TypeName,
        reserve: u64,
        funded: u64,
    }

    struct TaxesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DivsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Tax has copy, drop, store {
        token: u64,
        buy_bps: u64,
        sell_bps: u64,
        holders_bps: u64,
        dev_bps: u64,
        burn_bps: u64,
        dev: address,
        acc: u256,
        held: u64,
        buyback: u64,
        to_holders: u64,
        to_dev: u64,
        bought_back: u64,
        burned: u64,
    }

    struct Div has copy, drop, store {
        debt: u256,
        owed: u256,
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

    struct NativeEvent has copy, drop {
        info: Native,
    }

    struct TaxEvent has copy, drop {
        tax: Tax,
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
        let (v7, v8, v9) = if (arg3 == 1 && is_taxed(arg0, v6)) {
            let v7 = bps_of(arg4, 0x2::table::borrow<u64, Tax>(taxes(arg0), v6).buy_bps);
            (v7, 0, v6)
        } else if (v6 == 1 && is_taxed(arg0, arg3)) {
            (0, 0x2::table::borrow<u64, Tax>(taxes(arg0), arg3).sell_bps, arg3)
        } else {
            (0, 0, 0)
        };
        let v10 = arg4 - v7;
        assert!(v10 > 0, 2);
        let v11 = (((v10 as u128) * (v2.fee_bps as u128) / 10000) as u64);
        let v12 = (((v11 as u128) * (arg0.params.protocol_share_bps as u128) / 10000) as u64);
        let v13 = ((v10 - v11) as u128);
        let v14 = ((v13 * (v5 as u128) / ((v4 as u128) + v13)) as u64);
        let v15 = bps_of(v14, v8);
        let v16 = v14 - v15;
        let v17 = if (v16 >= arg5) {
            if (v16 > 0) {
                v14 < v5
            } else {
                false
            }
        } else {
            false
        };
        assert!(v17, 7);
        debit(arg0, v0, arg3, v10 + v7);
        if (v7 + v15 > 0) {
            pay_tax(arg0, v9, v7 + v15, v1);
        };
        let v18 = 0x2::table::borrow_mut<u64, Pool>(&mut arg0.pools, arg2);
        if (v3) {
            v18.ra = v18.ra + v10 - v12;
            v18.rb = v18.rb - v14;
            v18.volume_a = v18.volume_a + (v10 as u128);
        } else {
            v18.rb = v18.rb + v10 - v12;
            v18.ra = v18.ra - v14;
            v18.volume_b = v18.volume_b + (v10 as u128);
        };
        v18.swaps = v18.swaps + 1;
        let v19 = PoolEvent{pool: *v18};
        0x2::event::emit<PoolEvent>(v19);
        if (v12 > 0) {
            let v20 = arg0.params.treasury;
            credit(arg0, v20, arg3, v12, v1);
        };
        credit(arg0, v0, v6, v16, v1);
        let (v21, v22) = pool_r(arg0, arg2);
        record_r(arg0, arg1, arg6, 7, v0, @0x0, arg3, v10 + v7, v6, v16, arg2, v11 + v7, v21, v22);
        if (v7 + v15 > 0) {
            buyback_now(arg0, arg1, v9, arg6);
        };
        v16
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
        let (v9, v10) = pool_r(arg0, arg2);
        record_r(arg0, arg1, arg6, 5, v6, @0x0, arg3, arg4, v3, v4, v0.lp, v5, v9, v10);
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

    fun assert_native<T0>(arg0: &Chain) {
        assert!(native_info(arg0).coin == 0x1::type_name::with_defining_ids<T0>(), 15);
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
        let v0 = NativeKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<NativeKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = arg1 / arg0.params.halving;
        if (v1 >= 64) {
            return 0
        };
        let v2 = if (arg0.open_txs > 200) {
            200
        } else {
            arg0.open_txs
        };
        let v3 = ((arg0.params.reward >> (v1 as u8)) as u128) * (v2 as u128);
        let v4 = if (v3 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v3 as u64)
        };
        let v5 = NativeKey{dummy_field: false};
        let v6 = 0x2::dynamic_field::borrow<NativeKey, Native>(&arg0.id, v5).reserve;
        if (v4 > v6) {
            v6
        } else {
            v4
        }
    }

    fun bps_of(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
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

    public fun bridge_native_in<T0>(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        check(arg0);
        assert_native<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 2);
        let v1 = VaultKey{dummy_field: false};
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<VaultKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v1), 0x2::coin::into_balance<T0>(arg2));
        let v2 = 0x2::tx_context::sender(arg3);
        mint(arg0, v2, 0, v0, 0x2::clock::timestamp_ms(arg1));
        record(arg0, arg1, arg3, 2, @0x0, v2, 0, v0, 0, 0, 0, 0);
    }

    public fun bridge_native_out<T0>(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        check(arg0);
        assert_native<T0>(arg0);
        assert!(arg2 > 0, 2);
        let v0 = 0x2::tx_context::sender(arg4);
        burn_from(arg0, v0, 0, arg2);
        let v1 = VaultKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<VaultKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v1), arg2), arg4), arg3);
        record(arg0, arg1, arg4, 3, v0, arg3, 0, arg2, 0, 0, 0, 0);
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
        assert!(arg2 != 1 && arg2 != 0, 3);
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

    fun burn_supply(arg0: &mut Chain, arg1: u64, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<u64, Token>(&mut arg0.tokens, arg1);
        v0.supply = v0.supply - arg2;
        let v1 = TokenEvent{token: *v0};
        0x2::event::emit<TokenEvent>(v1);
    }

    fun buy_and_burn(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) : (u64, u64) {
        if (arg3 == 0) {
            return (0, 0)
        };
        if (0x2::table::contains<u64, Curve>(&arg0.curves, arg2) && !0x2::table::borrow<u64, Curve>(&arg0.curves, arg2).done) {
            let v0 = *0x2::table::borrow<u64, Curve>(&arg0.curves, arg2);
            let v1 = (v0.vq as u128) * (v0.vt as u128);
            let v2 = arg3;
            let v3 = v0.vt - (div_up(v1, (v0.vq as u128) + (arg3 as u128)) as u64);
            let v4 = v3;
            if (v3 >= v0.rt) {
                let v5 = v0.rt;
                v4 = v5;
                let v6 = (div_up(v1, ((v0.vt - v5) as u128)) as u64) - v0.vq;
                v2 = v6;
                if (v6 > arg3) {
                    return (0, 0)
                };
            };
            if (v4 == 0) {
                return (0, 0)
            };
            let v7 = 0x2::table::borrow_mut<u64, Curve>(&mut arg0.curves, arg2);
            v7.vq = v7.vq + v2;
            v7.vt = v7.vt - v4;
            v7.rq = v7.rq + v2;
            v7.rt = v7.rt - v4;
            let v8 = CurveEvent{curve: *v7};
            0x2::event::emit<CurveEvent>(v8);
            burn_supply(arg0, arg2, v4);
            if (v7.rt == 0) {
                graduate(arg0, arg1, arg2, arg4);
            };
            return (v2, v4)
        };
        let v9 = pair(arg2, 1);
        if (!0x2::table::contains<PairKey, u64>(&arg0.pairs, v9)) {
            return (0, 0)
        };
        let v10 = *0x2::table::borrow<PairKey, u64>(&arg0.pairs, v9);
        let v11 = *0x2::table::borrow<u64, Pool>(&arg0.pools, v10);
        let (v12, v13) = if (v11.a == 1) {
            (v11.ra, v11.rb)
        } else {
            (v11.rb, v11.ra)
        };
        let v14 = (((arg3 as u128) * (v13 as u128) / ((v12 as u128) + (arg3 as u128))) as u64);
        if (v14 == 0 || v14 >= v13) {
            return (0, 0)
        };
        let v15 = 0x2::table::borrow_mut<u64, Pool>(&mut arg0.pools, v10);
        if (v15.a == 1) {
            v15.ra = v15.ra + arg3;
            v15.rb = v15.rb - v14;
            v15.volume_a = v15.volume_a + (arg3 as u128);
        } else {
            v15.rb = v15.rb + arg3;
            v15.ra = v15.ra - v14;
            v15.volume_b = v15.volume_b + (arg3 as u128);
        };
        v15.swaps = v15.swaps + 1;
        let v16 = PoolEvent{pool: *v15};
        0x2::event::emit<PoolEvent>(v16);
        burn_supply(arg0, arg2, v14);
        (arg3, v14)
    }

    public fun buy_tokens(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) : u64 {
        check(arg0);
        assert!(0x2::table::contains<u64, Curve>(&arg0.curves, arg2), 11);
        assert!(arg3 > 0, 2);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = *0x2::table::borrow<u64, Curve>(&arg0.curves, arg2);
        assert!(!v2.done, 12);
        let v3 = if (is_taxed(arg0, arg2)) {
            0x2::table::borrow<u64, Tax>(taxes(arg0), arg2).buy_bps
        } else {
            0
        };
        let v4 = bps_of(arg3, v3);
        let v5 = v4;
        let v6 = arg3 - v4;
        let v7 = (((v6 as u128) * (v2.fee_bps as u128) / 10000) as u64);
        let v8 = v7;
        let v9 = v6 - v7;
        let v10 = v9;
        let v11 = (v2.vq as u128) * (v2.vt as u128);
        let v12 = v2.vt - (div_up(v11, (v2.vq as u128) + (v9 as u128)) as u64);
        let v13 = v12;
        if (v12 >= v2.rt) {
            let v14 = v2.rt;
            v13 = v14;
            let v15 = (div_up(v11, ((v2.vt - v14) as u128)) as u64) - v2.vq;
            v10 = v15;
            let v16 = (((v15 as u128) * (v2.fee_bps as u128) / (10000 - (v2.fee_bps as u128))) as u64);
            v8 = v16;
            let v17 = ((((v15 + v16) as u128) * (v3 as u128) / (10000 - (v3 as u128))) as u64);
            v5 = v17;
            if (v15 + v16 + v17 > arg3) {
                v5 = arg3 - v15 - v16;
            };
        };
        assert!(v13 >= arg4 && v13 > 0, 7);
        debit(arg0, v0, 1, v10 + v8 + v5);
        if (v8 > 0) {
            let v18 = arg0.params.treasury;
            credit(arg0, v18, 1, v8, v1);
        };
        if (v5 > 0) {
            pay_tax(arg0, arg2, v5, v1);
        };
        let v19 = 0x2::table::borrow_mut<u64, Curve>(&mut arg0.curves, arg2);
        v19.vq = v19.vq + v10;
        v19.vt = v19.vt - v13;
        v19.rq = v19.rq + v10;
        v19.rt = v19.rt - v13;
        v19.trades = v19.trades + 1;
        let v20 = v19.rt == 0;
        let v21 = CurveEvent{curve: *v19};
        0x2::event::emit<CurveEvent>(v21);
        credit(arg0, v0, arg2, v13, v1);
        let (v22, v23) = curve_r(arg0, arg2);
        record_r(arg0, arg1, arg5, 9, v0, @0x0, 1, v10 + v8 + v5, arg2, v13, 0, v8 + v5, v22, v23);
        if (v20) {
            graduate(arg0, arg1, arg2, arg5);
        };
        if (v5 > 0) {
            buyback_now(arg0, arg1, arg2, arg5);
        };
        v13
    }

    fun buyback_now(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow<u64, Tax>(taxes(arg0), arg2).buyback;
        if (v0 == 0) {
            return
        };
        let v1 = if (0x2::table::contains<u64, Curve>(&arg0.curves, arg2)) {
            !0x2::table::borrow<u64, Curve>(&arg0.curves, arg2).done
        } else {
            false
        };
        let (v2, v3) = buy_and_burn(arg0, arg1, arg2, v0, arg3);
        let v4 = taxes_mut(arg0);
        let v5 = 0x2::table::borrow_mut<u64, Tax>(v4, arg2);
        v5.buyback = v0 - v2;
        v5.bought_back = v5.bought_back + v2;
        v5.burned = v5.burned + v3;
        let v6 = TaxEvent{tax: *v5};
        0x2::event::emit<TaxEvent>(v6);
        if (v3 > 0) {
            if (v1) {
                let (v7, v8) = curve_r(arg0, arg2);
                record_r(arg0, arg1, arg3, 14, @0x0, @0x0, 1, v2, arg2, v3, 0, 0, v7, v8);
            } else {
                let v9 = *0x2::table::borrow<PairKey, u64>(&arg0.pairs, pair(arg2, 1));
                let (v10, v11) = pool_r(arg0, v9);
                record_r(arg0, arg1, arg3, 14, @0x0, @0x0, 1, v2, arg2, v3, v9, 1, v10, v11);
            };
        };
    }

    public fun can_seal(arg0: &Chain, arg1: &0x2::clock::Clock) : bool {
        arg0.open_txs > 0 && 0x2::clock::timestamp_ms(arg1) >= arg0.last_block_ms + arg0.params.block_ms
    }

    fun check(arg0: &Chain) {
        assert!(arg0.version == 2, 0);
    }

    public fun claim_dividends(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: u64, arg3: &0x2::tx_context::TxContext) : u64 {
        check(arg0);
        assert!(is_taxed(arg0, arg2), 19);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = balance_of(arg0, v0, arg2);
        div_move(arg0, v0, arg2, v1, v1);
        let v2 = BalKey{
            owner : v0,
            token : arg2,
        };
        let v3 = divs_mut(arg0);
        let v4 = 0x2::table::borrow_mut<BalKey, Div>(v3, v2);
        let v5 = v4.owed / 1000000000000000000;
        assert!(v5 > 0, 2);
        v4.owed = v4.owed - v5 * 1000000000000000000;
        let v6 = (v5 as u64);
        credit(arg0, v0, 1, v6, 0x2::clock::timestamp_ms(arg1));
        record(arg0, arg1, arg3, 15, @0x0, v0, 1, v6, arg2, 0, 0, 0);
        v6
    }

    public fun create_pool(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) : u64 {
        check(arg0);
        assert!(arg2 != arg3, 4);
        assert!(0x2::table::contains<u64, Token>(&arg0.tokens, arg2) && 0x2::table::contains<u64, Token>(&arg0.tokens, arg3), 3);
        assert!(0x2::table::borrow<u64, Token>(&arg0.tokens, arg2).kind != 4 && 0x2::table::borrow<u64, Token>(&arg0.tokens, arg3).kind != 4, 3);
        assert!(not_on_curve(arg0, arg2) && not_on_curve(arg0, arg3), 11);
        assert!(!is_taxed(arg0, arg2) || arg3 == 1, 21);
        assert!(!is_taxed(arg0, arg3) || arg2 == 1, 21);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        debit(arg0, v0, arg2, arg4);
        debit(arg0, v0, arg3, arg5);
        let (v2, v3, v4) = open_pool(arg0, arg2, arg3, arg4, arg5, v0, v1);
        mint(arg0, v0, v3, v4, v1);
        let (v5, v6) = pool_r(arg0, v2);
        record_r(arg0, arg1, arg6, 5, v0, @0x0, arg2, arg4, arg3, arg5, v3, v4, v5, v6);
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
        if (arg1 != @0x0 && is_taxed(arg0, arg2)) {
            let v0 = balance_of(arg0, arg1, arg2);
            div_move(arg0, arg1, arg2, v0, v0 + arg3);
        };
        let v1 = BalKey{
            owner : arg1,
            token : arg2,
        };
        let v2 = if (0x2::table::contains<BalKey, u64>(&arg0.balances, v1)) {
            let v3 = 0x2::table::borrow_mut<BalKey, u64>(&mut arg0.balances, v1);
            if (*v3 == 0) {
                let v4 = 0x2::table::borrow_mut<u64, Token>(&mut arg0.tokens, arg2);
                v4.holders = v4.holders + 1;
            };
            *v3 = *v3 + arg3;
            *v3
        } else {
            0x2::table::add<BalKey, u64>(&mut arg0.balances, v1, arg3);
            let v5 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, arg1);
            let v6 = v5.tokens;
            v5.tokens = v6 + 1;
            let v7 = HistKey{
                owner : arg1,
                n     : v6,
            };
            0x2::table::add<HistKey, u64>(&mut arg0.owned, v7, arg2);
            let v8 = 0x2::table::borrow_mut<u64, Token>(&mut arg0.tokens, arg2);
            v8.holders = v8.holders + 1;
            arg3
        };
        let v9 = BalEvent{
            owner   : arg1,
            token   : arg2,
            balance : v2,
        };
        0x2::event::emit<BalEvent>(v9);
    }

    fun curve_r(arg0: &Chain, arg1: u64) : (u64, u64) {
        let v0 = *0x2::table::borrow<u64, Curve>(&arg0.curves, arg1);
        (v0.rt, v0.rq)
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
        let v1 = *0x2::table::borrow<BalKey, u64>(&arg0.balances, v0);
        assert!(v1 >= arg3, 1);
        if (arg1 != @0x0 && is_taxed(arg0, arg2)) {
            div_move(arg0, arg1, arg2, v1, v1 - arg3);
        };
        let v2 = 0x2::table::borrow_mut<BalKey, u64>(&mut arg0.balances, v0);
        *v2 = *v2 - arg3;
        let v3 = *v2;
        if (v3 == 0) {
            let v4 = 0x2::table::borrow_mut<u64, Token>(&mut arg0.tokens, arg2);
            v4.holders = v4.holders - 1;
        };
        let v5 = BalEvent{
            owner   : arg1,
            token   : arg2,
            balance : v3,
        };
        0x2::event::emit<BalEvent>(v5);
    }

    fun div_move(arg0: &mut Chain, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = taxes_mut(arg0);
        let v1 = 0x2::table::borrow_mut<u64, Tax>(v0, arg2);
        v1.held = v1.held - arg3 + arg4;
        let v2 = v1.acc;
        let v3 = BalKey{
            owner : arg1,
            token : arg2,
        };
        let v4 = divs_mut(arg0);
        if (!0x2::table::contains<BalKey, Div>(v4, v3)) {
            let v5 = Div{
                debt : 0,
                owed : 0,
            };
            0x2::table::add<BalKey, Div>(v4, v3, v5);
        };
        let v6 = 0x2::table::borrow_mut<BalKey, Div>(v4, v3);
        v6.owed = v6.owed + (arg3 as u256) * v2 - v6.debt;
        v6.debt = (arg4 as u256) * v2;
    }

    fun div_up(arg0: u128, arg1: u128) : u128 {
        (arg0 + arg1 - 1) / arg1
    }

    public fun dividends_of(arg0: &Chain, arg1: address, arg2: u64) : u64 {
        if (!is_taxed(arg0, arg2)) {
            return 0
        };
        let v0 = *0x2::table::borrow<u64, Tax>(taxes(arg0), arg2);
        let v1 = BalKey{
            owner : arg1,
            token : arg2,
        };
        let (v2, v3) = if (0x2::table::contains<BalKey, Div>(divs(arg0), v1)) {
            let v4 = *0x2::table::borrow<BalKey, Div>(divs(arg0), v1);
            (v4.debt, v4.owed)
        } else {
            (0, 0)
        };
        (((v3 + (balance_of(arg0, arg1, arg2) as u256) * v0.acc - v2) / 1000000000000000000) as u64)
    }

    fun divs(arg0: &Chain) : &0x2::table::Table<BalKey, Div> {
        let v0 = DivsKey{dummy_field: false};
        0x2::dynamic_field::borrow<DivsKey, 0x2::table::Table<BalKey, Div>>(&arg0.id, v0)
    }

    fun divs_mut(arg0: &mut Chain) : &mut 0x2::table::Table<BalKey, Div> {
        let v0 = DivsKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<DivsKey, 0x2::table::Table<BalKey, Div>>(&mut arg0.id, v0)
    }

    public fun fund_rewards<T0>(arg0: &mut Chain, arg1: 0x2::coin::Coin<T0>) {
        check(arg0);
        assert_native<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = VaultKey{dummy_field: false};
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<VaultKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v1), 0x2::coin::into_balance<T0>(arg1));
        let v2 = NativeKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<NativeKey, Native>(&mut arg0.id, v2);
        v3.reserve = v3.reserve + v0;
        let v4 = if (v3.funded > 18446744073709551615 - v0) {
            18446744073709551615
        } else {
            v3.funded + v0
        };
        v3.funded = v4;
        let v5 = NativeEvent{info: *v3};
        0x2::event::emit<NativeEvent>(v5);
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
        let (v18, v19) = pool_r(arg0, v5);
        record_r(arg0, arg1, arg3, 11, @0x0, @0x0, arg2, v4, 1, v2, v6, v7, v18, v19);
    }

    public fun has_native(arg0: &Chain) : bool {
        let v0 = NativeKey{dummy_field: false};
        0x2::dynamic_field::exists<NativeKey>(&arg0.id, v0)
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
            reward             : 0,
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
            version       : 2,
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
        add_token(v8, 0, b"BloxChain coin", b"COIN", 9, @0x0, b"", b"", v1);
        let v9 = &mut v5;
        add_token(v9, 1, b"Sui", b"SUI", 9, @0x0, b"", b"", v1);
        let v10 = TaxesKey{dummy_field: false};
        0x2::dynamic_field::add<TaxesKey, 0x2::table::Table<u64, Tax>>(&mut v5.id, v10, 0x2::table::new<u64, Tax>(arg0));
        let v11 = DivsKey{dummy_field: false};
        0x2::dynamic_field::add<DivsKey, 0x2::table::Table<BalKey, Div>>(&mut v5.id, v11, 0x2::table::new<BalKey, Div>(arg0));
        0x2::transfer::share_object<Chain>(v5);
        let v12 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v12, v0);
    }

    public fun is_node(arg0: &Chain, arg1: address) : bool {
        0x2::table::contains<address, Node>(&arg0.nodes, arg1)
    }

    fun is_taxed(arg0: &Chain, arg1: u64) : bool {
        let v0 = TaxesKey{dummy_field: false};
        0x2::dynamic_field::exists<TaxesKey>(&arg0.id, v0) && 0x2::table::contains<u64, Tax>(taxes(arg0), arg1)
    }

    public fun launch(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &0x2::tx_context::TxContext) : u64 {
        let v0 = new_launch(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        if (arg6 > 0) {
            buy_tokens(arg0, arg1, v0, arg6, 0, arg7);
        };
        v0
    }

    public fun launch_taxed(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::tx_context::TxContext) : u64 {
        let v0 = if (arg7 <= 1000) {
            if (arg8 <= 1000) {
                arg7 + arg8 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 19);
        assert!(arg9 + arg10 + arg11 == (10000 as u64), 19);
        let v1 = new_launch(arg0, arg1, arg2, arg3, arg4, arg5, arg12);
        let v2 = Tax{
            token       : v1,
            buy_bps     : arg7,
            sell_bps    : arg8,
            holders_bps : arg9,
            dev_bps     : arg10,
            burn_bps    : arg11,
            dev         : 0x2::tx_context::sender(arg12),
            acc         : 0,
            held        : 0,
            buyback     : 0,
            to_holders  : 0,
            to_dev      : 0,
            bought_back : 0,
            burned      : 0,
        };
        let v3 = taxes_mut(arg0);
        0x2::table::add<u64, Tax>(v3, v1, v2);
        let v4 = TaxEvent{tax: v2};
        0x2::event::emit<TaxEvent>(v4);
        if (arg6 > 0) {
            buy_tokens(arg0, arg1, v1, arg6, 0, arg12);
        };
        v1
    }

    public fun lower_tax(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        check(arg0);
        assert!(is_taxed(arg0, arg2), 19);
        assert!(0x2::table::borrow<u64, Token>(&arg0.tokens, arg2).creator == 0x2::tx_context::sender(arg5), 20);
        let v0 = taxes_mut(arg0);
        let v1 = 0x2::table::borrow_mut<u64, Tax>(v0, arg2);
        assert!(arg3 <= v1.buy_bps && arg4 <= v1.sell_bps, 19);
        v1.buy_bps = arg3;
        v1.sell_bps = arg4;
        let v2 = TaxEvent{tax: *v1};
        0x2::event::emit<TaxEvent>(v2);
        record(arg0, arg1, arg5, 16, 0x2::tx_context::sender(arg5), @0x0, arg2, arg3, arg2, arg4, 0, 0);
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Chain, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version < 2, 0);
        let v0 = TaxesKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<TaxesKey>(&arg1.id, v0)) {
            let v1 = TaxesKey{dummy_field: false};
            0x2::dynamic_field::add<TaxesKey, 0x2::table::Table<u64, Tax>>(&mut arg1.id, v1, 0x2::table::new<u64, Tax>(arg2));
        };
        let v2 = DivsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<DivsKey>(&arg1.id, v2)) {
            let v3 = DivsKey{dummy_field: false};
            0x2::dynamic_field::add<DivsKey, 0x2::table::Table<BalKey, Div>>(&mut arg1.id, v3, 0x2::table::new<BalKey, Div>(arg2));
        };
        arg1.version = 2;
    }

    fun mint(arg0: &mut Chain, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = 0x2::table::borrow_mut<u64, Token>(&mut arg0.tokens, arg2);
        v0.supply = v0.supply + arg3;
        let v1 = TokenEvent{token: *v0};
        0x2::event::emit<TokenEvent>(v1);
        credit(arg0, arg1, arg2, arg3, arg4);
    }

    public fun native_coin(arg0: &Chain) : 0x1::type_name::TypeName {
        native_info(arg0).coin
    }

    fun native_info(arg0: &Chain) : &Native {
        let v0 = NativeKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<NativeKey>(&arg0.id, v0), 18);
        let v1 = NativeKey{dummy_field: false};
        0x2::dynamic_field::borrow<NativeKey, Native>(&arg0.id, v1)
    }

    public fun native_vault_value<T0>(arg0: &Chain) : u64 {
        assert_native<T0>(arg0);
        let v0 = VaultKey{dummy_field: false};
        0x2::balance::value<T0>(0x2::dynamic_field::borrow<VaultKey, 0x2::balance::Balance<T0>>(&arg0.id, v0))
    }

    fun new_launch(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::tx_context::TxContext) : u64 {
        check(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
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
        record(arg0, arg1, arg6, 8, v0, @0x0, v3, 1000000000000000, 0, 0, 0, 0);
        v3
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

    fun pay_tax(arg0: &mut Chain, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = taxes_mut(arg0);
        let v1 = 0x2::table::borrow_mut<u64, Tax>(v0, arg1);
        let v2 = bps_of(arg2, v1.holders_bps);
        let v3 = bps_of(arg2, v1.burn_bps);
        if (v1.held < 1000000) {
            v2 = 0;
        };
        let v4 = arg2 - v2 - v3;
        if (v2 > 0) {
            v1.acc = v1.acc + (v2 as u256) * 1000000000000000000 / (v1.held as u256);
            v1.to_holders = v1.to_holders + v2;
        };
        v1.to_dev = v1.to_dev + v4;
        v1.buyback = v1.buyback + v3;
        let v5 = TaxEvent{tax: *v1};
        0x2::event::emit<TaxEvent>(v5);
        credit(arg0, v1.dev, 1, v4, arg3);
    }

    public fun pool_count(arg0: &Chain) : u64 {
        arg0.pool_count
    }

    public fun pool_of(arg0: &Chain, arg1: u64, arg2: u64) : u64 {
        let v0 = pair(arg1, arg2);
        assert!(0x2::table::contains<PairKey, u64>(&arg0.pairs, v0), 5);
        *0x2::table::borrow<PairKey, u64>(&arg0.pairs, v0)
    }

    fun pool_r(arg0: &Chain, arg1: u64) : (u64, u64) {
        let v0 = *0x2::table::borrow<u64, Pool>(&arg0.pools, arg1);
        (v0.ra, v0.rb)
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
        record_r(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0, 0);
    }

    fun record_r(arg0: &mut Chain, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext, arg3: u8, arg4: address, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64) {
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
            r0         : arg12,
            r1         : arg13,
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
        let (v9, v10) = pool_r(arg0, arg2);
        record_r(arg0, arg1, arg6, 6, v5, @0x0, v0.a, v2, v0.b, v3, v0.lp, arg3, v9, v10);
        (v2, v3)
    }

    public fun reward_reserve(arg0: &Chain) : u64 {
        native_info(arg0).reserve
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
                let v6 = NativeKey{dummy_field: false};
                let v7 = 0x2::dynamic_field::borrow_mut<NativeKey, Native>(&mut arg0.id, v6);
                v7.reserve = v7.reserve - v3;
                let v8 = NativeEvent{info: *v7};
                0x2::event::emit<NativeEvent>(v8);
                mint(arg0, arg2, 0, v3, arg1);
            };
            let v9 = 0x2::table::borrow_mut<address, Node>(&mut arg0.nodes, arg2);
            v9.blocks = v9.blocks + 1;
            v9.rewards = v9.rewards + v3;
            v9.last_ms = arg1;
            let v10 = NodeEvent{
                addr : arg2,
                node : *v9,
            };
            0x2::event::emit<NodeEvent>(v10);
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
        let v6 = if (is_taxed(arg0, arg2)) {
            bps_of(v4, 0x2::table::borrow<u64, Tax>(taxes(arg0), arg2).sell_bps)
        } else {
            0
        };
        let v7 = v4 - v5 - v6;
        assert!(v7 >= arg4 && v7 > 0, 7);
        debit(arg0, v0, arg2, arg3);
        let v8 = 0x2::table::borrow_mut<u64, Curve>(&mut arg0.curves, arg2);
        v8.vq = v8.vq - v4;
        v8.vt = v8.vt + arg3;
        v8.rq = v8.rq - v4;
        v8.rt = v8.rt + arg3;
        v8.trades = v8.trades + 1;
        let v9 = CurveEvent{curve: *v8};
        0x2::event::emit<CurveEvent>(v9);
        if (v5 > 0) {
            let v10 = arg0.params.treasury;
            credit(arg0, v10, 1, v5, v1);
        };
        if (v6 > 0) {
            pay_tax(arg0, arg2, v6, v1);
        };
        credit(arg0, v0, 1, v7, v1);
        let (v11, v12) = curve_r(arg0, arg2);
        record_r(arg0, arg1, arg5, 10, v0, @0x0, arg2, arg3, 1, v7, 0, v5 + v6, v11, v12);
        if (v6 > 0) {
            buyback_now(arg0, arg1, arg2, arg5);
        };
        v7
    }

    public fun set_native_coin<T0>(arg0: &AdminCap, arg1: &mut Chain, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: u64, arg7: u64) {
        check(arg1);
        let v0 = NativeKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<NativeKey>(&arg1.id, v0), 14);
        assert!(0x2::table::borrow<u64, Token>(&arg1.tokens, 0).supply == 0, 14);
        assert!(0x1::type_name::with_defining_ids<T0>() != 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), 15);
        assert!(arg7 > 0 && arg4 <= 18, 17);
        let v1 = 0x2::table::borrow_mut<u64, Token>(&mut arg1.tokens, 0);
        v1.kind = 1;
        v1.name = text(arg2, 1, 40);
        v1.symbol = text(arg3, 1, 16);
        v1.decimals = arg4;
        v1.icon = text(arg5, 0, 24000);
        let v2 = TokenEvent{token: *v1};
        0x2::event::emit<TokenEvent>(v2);
        arg1.params.reward = arg6;
        arg1.params.halving = arg7;
        arg1.genesis_done = true;
        let v3 = Native{
            coin    : 0x1::type_name::with_defining_ids<T0>(),
            reserve : 0,
            funded  : 0,
        };
        let v4 = NativeKey{dummy_field: false};
        0x2::dynamic_field::add<NativeKey, Native>(&mut arg1.id, v4, v3);
        let v5 = VaultKey{dummy_field: false};
        0x2::dynamic_field::add<VaultKey, 0x2::balance::Balance<T0>>(&mut arg1.id, v5, 0x2::balance::zero<T0>());
        let v6 = NativeEvent{info: v3};
        0x2::event::emit<NativeEvent>(v6);
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

    public fun set_reward(arg0: &AdminCap, arg1: &mut Chain, arg2: u64, arg3: u64) {
        check(arg1);
        assert!(arg3 > 0, 17);
        arg1.params.reward = arg2;
        arg1.params.halving = arg3;
    }

    public fun set_tax_wallet(arg0: &mut Chain, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) {
        check(arg0);
        assert!(is_taxed(arg0, arg1), 19);
        let v0 = 0x2::table::borrow_mut<u64, Tax>(taxes_mut(arg0), arg1);
        assert!(v0.dev == 0x2::tx_context::sender(arg3), 20);
        v0.dev = arg2;
        let v1 = TaxEvent{tax: *v0};
        0x2::event::emit<TaxEvent>(v1);
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

    public fun tax_burned(arg0: &Tax) : u64 {
        arg0.burned
    }

    public fun tax_buy_bps(arg0: &Tax) : u64 {
        arg0.buy_bps
    }

    public fun tax_buyback(arg0: &Tax) : u64 {
        arg0.buyback
    }

    public fun tax_of(arg0: &Chain, arg1: u64) : Tax {
        *0x2::table::borrow<u64, Tax>(taxes(arg0), arg1)
    }

    public fun tax_sell_bps(arg0: &Tax) : u64 {
        arg0.sell_bps
    }

    fun taxes(arg0: &Chain) : &0x2::table::Table<u64, Tax> {
        let v0 = TaxesKey{dummy_field: false};
        0x2::dynamic_field::borrow<TaxesKey, 0x2::table::Table<u64, Tax>>(&arg0.id, v0)
    }

    fun taxes_mut(arg0: &mut Chain) : &mut 0x2::table::Table<u64, Tax> {
        let v0 = TaxesKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<TaxesKey, 0x2::table::Table<u64, Tax>>(&mut arg0.id, v0)
    }

    fun text(arg0: vector<u8>, arg1: u64, arg2: u64) : 0x1::string::String {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 >= arg1 && v0 <= arg2, 13);
        let v1 = 0x1::string::try_utf8(arg0);
        assert!(0x1::option::is_some<0x1::string::String>(&v1), 13);
        0x1::option::destroy_some<0x1::string::String>(v1)
    }

    public fun token_address(arg0: &Chain, arg1: u64) : address {
        let v0 = b"bloxchain:token";
        let v1 = 0x2::object::uid_to_address(&arg0.id);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
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

    public fun withdraw_rewards<T0>(arg0: &AdminCap, arg1: &mut Chain, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        check(arg1);
        assert_native<T0>(arg1);
        let v0 = NativeKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<NativeKey, Native>(&mut arg1.id, v0);
        assert!(arg2 > 0 && arg2 <= v1.reserve, 2);
        v1.reserve = v1.reserve - arg2;
        let v2 = NativeEvent{info: *v1};
        0x2::event::emit<NativeEvent>(v2);
        let v3 = VaultKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<VaultKey, 0x2::balance::Balance<T0>>(&mut arg1.id, v3), arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v7
}

