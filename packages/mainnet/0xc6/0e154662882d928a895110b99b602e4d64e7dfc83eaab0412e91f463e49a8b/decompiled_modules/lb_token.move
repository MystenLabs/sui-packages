module 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::lb_token {
    struct TransferBatch has copy, drop {
        operator: address,
        from: address,
        to: address,
        ids: vector<u256>,
        values: vector<u256>,
    }

    struct LBTokenManager has store {
        name: vector<u8>,
        symbol: vector<u8>,
        balances: 0x2::table::Table<BalanceKey, u256>,
        total_supplies: 0x2::table::Table<u256, u256>,
        token_infos: 0x2::table::Table<0x2::object::ID, LBTokenInfo>,
        pool_id: 0x2::object::ID,
    }

    struct LBToken has store, key {
        id: 0x2::object::UID,
        bin_id: u256,
        amount: u256,
        pool_id: 0x2::object::ID,
        description: 0x1::string::String,
    }

    struct LBTokenBucket has store, key {
        id: 0x2::object::UID,
        tokens: vector<LBToken>,
        pool_id: 0x2::object::ID,
    }

    struct LBTokenInfo has copy, drop, store {
        token_id: 0x2::object::ID,
        bin_id: u256,
        amount: u256,
    }

    struct BalanceKey has copy, drop, store {
        account: address,
        id: u256,
    }

    struct LB_TOKEN has drop {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : LBTokenManager {
        LBTokenManager{
            name           : b"Liquidity Book Token",
            symbol         : b"LBT",
            balances       : 0x2::table::new<BalanceKey, u256>(arg1),
            total_supplies : 0x2::table::new<u256, u256>(arg1),
            token_infos    : 0x2::table::new<0x2::object::ID, LBTokenInfo>(arg1),
            pool_id        : arg0,
        }
    }

    public fun balance_of(arg0: &LBTokenManager, arg1: address, arg2: u256) : u256 {
        let v0 = BalanceKey{
            account : arg1,
            id      : arg2,
        };
        if (0x2::table::contains<BalanceKey, u256>(&arg0.balances, v0)) {
            *0x2::table::borrow<BalanceKey, u256>(&arg0.balances, v0)
        } else {
            0
        }
    }

    public fun balance_of_batch(arg0: &LBTokenManager, arg1: vector<address>, arg2: vector<u256>) : vector<u256> {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u256>(&arg2), 1001);
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            0x1::vector::push_back<u256>(&mut v0, balance_of(arg0, *0x1::vector::borrow<address>(&arg1, v1), *0x1::vector::borrow<u256>(&arg2, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun bucket_pool_id(arg0: &LBTokenBucket) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun bucket_tokens_count(arg0: &LBTokenBucket) : u64 {
        0x1::vector::length<LBToken>(&arg0.tokens)
    }

    public(friend) fun burn(arg0: &mut LBTokenManager, arg1: &mut LBTokenBucket, arg2: address) {
        assert!(arg1.pool_id == arg0.pool_id, 1008);
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0x1::vector::empty<u256>();
        while (!0x1::vector::is_empty<LBToken>(&arg1.tokens)) {
            let v2 = 0x1::vector::pop_back<LBToken>(&mut arg1.tokens);
            assert!(v2.pool_id == arg0.pool_id, 1007);
            let LBToken {
                id          : v3,
                bin_id      : v4,
                amount      : v5,
                pool_id     : _,
                description : _,
            } = v2;
            let v8 = v3;
            let v9 = 0x2::object::uid_to_inner(&v8);
            assert!(0x2::table::contains<0x2::object::ID, LBTokenInfo>(&arg0.token_infos, v9), 1007);
            0x2::table::remove<0x2::object::ID, LBTokenInfo>(&mut arg0.token_infos, v9);
            internal_burn(arg0, arg2, v4, v5);
            0x1::vector::push_back<u256>(&mut v0, v4);
            0x1::vector::push_back<u256>(&mut v1, v5);
            0x2::object::delete(v8);
        };
        let v10 = TransferBatch{
            operator : arg2,
            from     : arg2,
            to       : @0x0,
            ids      : v0,
            values   : v1,
        };
        0x2::event::emit<TransferBatch>(v10);
    }

    public(friend) fun collect_bucket_tokens_for_burn(arg0: &LBTokenBucket, arg1: &LBTokenManager) : (vector<u64>, vector<u256>) {
        assert!(arg0.pool_id == arg1.pool_id, 1008);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u256>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<LBToken>(&arg0.tokens)) {
            let v3 = 0x1::vector::borrow<LBToken>(&arg0.tokens, v2);
            assert!(v3.pool_id == arg1.pool_id, 1007);
            0x1::vector::push_back<u64>(&mut v0, (v3.bin_id as u64));
            0x1::vector::push_back<u256>(&mut v1, v3.amount);
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun create_empty_bucket(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : LBTokenBucket {
        LBTokenBucket{
            id      : 0x2::object::new(arg1),
            tokens  : 0x1::vector::empty<LBToken>(),
            pool_id : arg0,
        }
    }

    public fun get_account_balances(arg0: &LBTokenManager, arg1: address, arg2: vector<u256>) : vector<u256> {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u256>(&arg2)) {
            0x1::vector::push_back<u256>(&mut v0, balance_of(arg0, arg1, *0x1::vector::borrow<u256>(&arg2, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_bucket_token_info(arg0: &LBTokenBucket) : (0x2::object::ID, vector<u256>, vector<u256>) {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0x1::vector::empty<u256>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<LBToken>(&arg0.tokens)) {
            let v3 = 0x1::vector::borrow<LBToken>(&arg0.tokens, v2);
            0x1::vector::push_back<u256>(&mut v0, v3.bin_id);
            0x1::vector::push_back<u256>(&mut v1, v3.amount);
            v2 = v2 + 1;
        };
        (arg0.pool_id, v0, v1)
    }

    public fun get_token_info(arg0: &LBTokenManager, arg1: u256) : (u256, u256) {
        (total_supply(arg0, arg1), 0)
    }

    fun init(arg0: LB_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"bin_id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"amount"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"pool_id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{bin_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{amount}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{pool_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.dlmm.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"DLMM Protocol"));
        let v4 = 0x2::package::claim<LB_TOKEN>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<LBToken>(&v4, v0, v2, arg1);
        0x2::display::update_version<LBToken>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<LBToken>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn(arg0: &mut LBTokenManager, arg1: address, arg2: u256, arg3: u256) {
        let v0 = BalanceKey{
            account : arg1,
            id      : arg2,
        };
        assert!(0x2::table::contains<BalanceKey, u256>(&arg0.balances, v0), 1005);
        let v1 = 0x2::table::borrow_mut<BalanceKey, u256>(&mut arg0.balances, v0);
        assert!(*v1 >= arg3, 1005);
        *v1 = *v1 - arg3;
        let v2 = 0x2::table::borrow_mut<u256, u256>(&mut arg0.total_supplies, arg2);
        *v2 = *v2 - arg3;
    }

    fun internal_mint(arg0: &mut LBTokenManager, arg1: address, arg2: u256, arg3: u256) {
        if (0x2::table::contains<u256, u256>(&arg0.total_supplies, arg2)) {
            let v0 = 0x2::table::borrow_mut<u256, u256>(&mut arg0.total_supplies, arg2);
            *v0 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::safe_math::safe_add_u256(*v0, arg3);
        } else {
            0x2::table::add<u256, u256>(&mut arg0.total_supplies, arg2, arg3);
        };
        let v1 = BalanceKey{
            account : arg1,
            id      : arg2,
        };
        if (0x2::table::contains<BalanceKey, u256>(&arg0.balances, v1)) {
            let v2 = 0x2::table::borrow_mut<BalanceKey, u256>(&mut arg0.balances, v1);
            *v2 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::safe_math::safe_add_u256(*v2, arg3);
        } else {
            0x2::table::add<BalanceKey, u256>(&mut arg0.balances, v1, arg3);
        };
    }

    public(friend) fun mint(arg0: &mut LBTokenManager, arg1: &mut LBTokenBucket, arg2: address, arg3: u256, arg4: u256, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg1.pool_id == arg0.pool_id, 1008);
        internal_mint(arg0, arg2, arg3, arg4);
        let v0 = LBToken{
            id          : 0x2::object::new(arg5),
            bin_id      : arg3,
            amount      : arg4,
            pool_id     : arg0.pool_id,
            description : 0x1::string::utf8(b"DLMM Liquidity Position"),
        };
        let v1 = 0x2::object::id<LBToken>(&v0);
        let v2 = LBTokenInfo{
            token_id : v1,
            bin_id   : arg3,
            amount   : arg4,
        };
        0x2::table::add<0x2::object::ID, LBTokenInfo>(&mut arg0.token_infos, v1, v2);
        0x1::vector::push_back<LBToken>(&mut arg1.tokens, v0);
        let v3 = 0x1::vector::empty<u256>();
        let v4 = 0x1::vector::empty<u256>();
        0x1::vector::push_back<u256>(&mut v3, arg3);
        0x1::vector::push_back<u256>(&mut v4, arg4);
        let v5 = TransferBatch{
            operator : 0x2::tx_context::sender(arg5),
            from     : @0x0,
            to       : arg2,
            ids      : v3,
            values   : v4,
        };
        0x2::event::emit<TransferBatch>(v5);
        v1
    }

    public(friend) fun mint_batch(arg0: &mut LBTokenManager, arg1: &mut LBTokenBucket, arg2: address, arg3: vector<u256>, arg4: vector<u256>, arg5: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        assert!(0x1::vector::length<u256>(&arg3) == 0x1::vector::length<u256>(&arg4), 1001);
        assert!(arg2 != @0x0, 1000);
        assert!(arg1.pool_id == arg0.pool_id, 1008);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u256>(&arg3)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, mint(arg0, arg1, arg2, *0x1::vector::borrow<u256>(&arg3, v1), *0x1::vector::borrow<u256>(&arg4, v1), arg5));
            v1 = v1 + 1;
        };
        v0
    }

    public fun name(arg0: &LBTokenManager) : vector<u8> {
        arg0.name
    }

    public fun symbol(arg0: &LBTokenManager) : vector<u8> {
        arg0.symbol
    }

    public fun token_amount(arg0: &LBToken) : u256 {
        arg0.amount
    }

    public fun token_bin_id(arg0: &LBToken) : u256 {
        arg0.bin_id
    }

    public fun token_info(arg0: &LBToken) : (u256, u256, 0x2::object::ID) {
        (arg0.bin_id, arg0.amount, arg0.pool_id)
    }

    public fun token_pool_id(arg0: &LBToken) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun total_supply(arg0: &LBTokenManager, arg1: u256) : u256 {
        if (0x2::table::contains<u256, u256>(&arg0.total_supplies, arg1)) {
            *0x2::table::borrow<u256, u256>(&arg0.total_supplies, arg1)
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

