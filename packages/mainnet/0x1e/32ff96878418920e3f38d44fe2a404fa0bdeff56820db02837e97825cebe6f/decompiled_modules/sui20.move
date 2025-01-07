module 0xd0ea9bc91c3855e9b58a51cd55e8455b37bd5c75f70b4d6e97e54b55c4ba4ae8::sui20 {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SUI20 has drop {
        dummy_field: bool,
    }

    struct Global has store, key {
        id: 0x2::object::UID,
        is_paused: bool,
        sui20tokens: 0x2::bag::Bag,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
        current_version: u64,
        upgrade_bag: 0x2::bag::Bag,
    }

    struct GlobalV2 has store {
        mint_to_issp_staking_rate: u64,
        destroy_issp_fee_amount: u64,
    }

    struct UserInfo has copy, drop, store {
        minted_amount: u64,
        last_mint_at: u64,
        hold_amount: u64,
    }

    struct Sui20Meta has store {
        tick: 0x1::string::String,
        max: u64,
        limit: u64,
        decimals: u8,
        fee: u64,
        start_at: u64,
    }

    struct Sui20Data has store {
        meta: Sui20Meta,
        enable_to_coin: bool,
        total_minted: u64,
        txs: u64,
        user_infos: 0x2::table::Table<address, UserInfo>,
        users: vector<address>,
        mint_cd: u64,
        max_mint_per_user: u64,
        upgrade_bag: 0x2::bag::Bag,
    }

    struct Sui20 has store, key {
        id: 0x2::object::UID,
        tick: 0x1::string::String,
        amount: u64,
    }

    struct Sui20WrapCoin<phantom T0> has store {
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
    }

    struct Sui20WrapCoinV2<phantom T0> has store {
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        coin_unit: u64,
        total_wrapped: u64,
    }

    struct QueryDataEvent has copy, drop {
        tick: 0x1::string::String,
        start_at: u64,
        total_cap: u64,
        limit_per_mint: u64,
        decimals: u8,
        mint_fee: u64,
        mint_cd: u64,
        max_mint_per_user: u64,
        total_minted: u64,
        remain_supply: u64,
        txs: u64,
        user_minted_amount: u64,
        user_hold_amount: u64,
        user_last_mint_at: u64,
    }

    struct QueryDataEventV2 has copy, drop {
        mint_to_issp_staking_rate: u64,
        destroy_issp_fee_amount: u64,
        coin_unit: u64,
        total_wrapped: u64,
    }

    struct QueryUsersEvent has copy, drop {
        users: vector<address>,
        minted_amounts: vector<u64>,
    }

    public fun transfer(arg0: &mut Global, arg1: 0x1::string::String, arg2: vector<Sui20>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg1), 1003);
        let v0 = 0x2::bag::borrow_mut<0x1::string::String, Sui20Data>(&mut arg0.sui20tokens, arg1);
        assert!(arg4 > 0, 1007);
        let v1 = 0;
        while (!0x1::vector::is_empty<Sui20>(&arg2)) {
            let Sui20 {
                id     : v2,
                tick   : v3,
                amount : v4,
            } = 0x1::vector::pop_back<Sui20>(&mut arg2);
            assert!(v3 == arg1, 1012);
            0x2::object::delete(v2);
            v1 = v1 + v4;
        };
        assert!(v1 >= arg4, 1006);
        0x1::vector::destroy_empty<Sui20>(arg2);
        let v5 = Sui20{
            id     : 0x2::object::new(arg5),
            tick   : v0.meta.tick,
            amount : arg4,
        };
        0x2::transfer::public_transfer<Sui20>(v5, arg3);
        let v6 = v1 - arg4;
        if (v6 > 0) {
            let v7 = Sui20{
                id     : 0x2::object::new(arg5),
                tick   : v0.meta.tick,
                amount : v6,
            };
            0x2::transfer::public_transfer<Sui20>(v7, 0x2::tx_context::sender(arg5));
        };
    }

    public fun batch_transfer(arg0: &mut Global, arg1: Sui20, arg2: vector<address>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        let Sui20 {
            id     : v0,
            tick   : v1,
            amount : v2,
        } = arg1;
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, v1), 1003);
        assert!(arg3 > 0, 1007);
        assert!(v2 == arg3 * 0x1::vector::length<address>(&arg2), 1007);
        0x2::object::delete(v0);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v3 = Sui20{
                id     : 0x2::object::new(arg4),
                tick   : v1,
                amount : arg3,
            };
            0x2::transfer::public_transfer<Sui20>(v3, 0x1::vector::pop_back<address>(&mut arg2));
        };
    }

    fun check_tick(arg0: vector<u8>, arg1: &Global) : 0x1::string::String {
        let v0 = 0x1::string::utf8(arg0);
        assert!(0x1::vector::length<u8>(&arg0) == 4, 1009);
        while (!0x1::vector::is_empty<u8>(&arg0)) {
            let v1 = 0x1::vector::pop_back<u8>(&mut arg0);
            assert!(v1 >= 97 && v1 <= 122 || v1 >= 48 && v1 <= 57, 1010);
        };
        assert!(!0x2::bag::contains<0x1::string::String>(&arg1.sui20tokens, v0), 1011);
        v0
    }

    public fun deploy(arg0: &mut Global, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = check_tick(arg2, arg0);
        assert!(!0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, v1), 1002);
        let v2 = v0;
        if (arg7 > v0) {
            v2 = arg7;
        };
        let v3 = Sui20Meta{
            tick     : v1,
            max      : arg3,
            limit    : arg4,
            decimals : arg5,
            fee      : arg6,
            start_at : v2,
        };
        let v4 = Sui20Data{
            meta              : v3,
            enable_to_coin    : false,
            total_minted      : 0,
            txs               : 0,
            user_infos        : 0x2::table::new<address, UserInfo>(arg9),
            users             : 0x1::vector::empty<address>(),
            mint_cd           : 0,
            max_mint_per_user : arg8,
            upgrade_bag       : 0x2::bag::new(arg9),
        };
        0x2::bag::add<0x1::string::String, Sui20Data>(&mut arg0.sui20tokens, v1, v4);
    }

    public fun deploy_v2(arg0: &mut Global, arg1: &0x2::clock::Clock, arg2: Sui20, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = check_tick(arg3, arg0);
        assert!(!0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, v1), 1002);
        let Sui20 {
            id     : v2,
            tick   : v3,
            amount : v4,
        } = arg2;
        assert!(v3 == 0x1::string::utf8(b"issp"), 1017);
        assert!(v4 == 0x2::bag::borrow<u64, GlobalV2>(&arg0.upgrade_bag, 2).destroy_issp_fee_amount, 1018);
        0x2::object::delete(v2);
        let v5 = v0;
        if (arg8 > v0) {
            v5 = arg8;
        };
        let v6 = Sui20Meta{
            tick     : v1,
            max      : arg4,
            limit    : arg5,
            decimals : arg6,
            fee      : arg7,
            start_at : v5,
        };
        let v7 = Sui20Data{
            meta              : v6,
            enable_to_coin    : false,
            total_minted      : 0,
            txs               : 0,
            user_infos        : 0x2::table::new<address, UserInfo>(arg10),
            users             : 0x1::vector::empty<address>(),
            mint_cd           : 0,
            max_mint_per_user : arg9,
            upgrade_bag       : 0x2::bag::new(arg10),
        };
        0x2::bag::add<0x1::string::String, Sui20Data>(&mut arg0.sui20tokens, v1, v7);
    }

    public fun destroy_zero(arg0: Sui20) {
        let Sui20 {
            id     : v0,
            tick   : _,
            amount : v2,
        } = arg0;
        assert!(v2 == 0, 1007);
        0x2::object::delete(v0);
    }

    public fun get_mint_data(arg0: &mut Global, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg1), 1003);
        let v1 = 0x2::bag::borrow_mut<0x1::string::String, Sui20Data>(&mut arg0.sui20tokens, arg1);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        if (0x2::table::contains<address, UserInfo>(&v1.user_infos, v0)) {
            let v5 = 0x2::table::borrow<address, UserInfo>(&v1.user_infos, v0);
            v2 = v5.minted_amount;
            v3 = v5.hold_amount;
            v4 = v5.last_mint_at;
        };
        let v6 = QueryDataEvent{
            tick               : v1.meta.tick,
            start_at           : v1.meta.start_at,
            total_cap          : v1.meta.max,
            limit_per_mint     : v1.meta.limit,
            decimals           : v1.meta.decimals,
            mint_fee           : v1.meta.fee,
            mint_cd            : v1.mint_cd,
            max_mint_per_user  : v1.max_mint_per_user,
            total_minted       : v1.total_minted,
            remain_supply      : v1.meta.max - v1.total_minted,
            txs                : v1.txs,
            user_minted_amount : v2,
            user_hold_amount   : v3,
            user_last_mint_at  : v4,
        };
        0x2::event::emit<QueryDataEvent>(v6);
        let v7 = 0;
        let v8 = 0;
        let v9 = 2;
        if (0x2::bag::contains<u64>(&arg0.upgrade_bag, v9)) {
            let v10 = 0x2::bag::borrow<u64, GlobalV2>(&arg0.upgrade_bag, v9);
            v7 = v10.mint_to_issp_staking_rate;
            v8 = v10.destroy_issp_fee_amount;
        };
        let v11 = 1000000;
        let v12 = 0;
        if (0x2::bag::contains<0x1::string::String>(&arg0.upgrade_bag, arg1)) {
            let v13 = 0x2::bag::borrow<0x1::string::String, Sui20WrapCoinV2<0xd0ea9bc91c3855e9b58a51cd55e8455b37bd5c75f70b4d6e97e54b55c4ba4ae8::issp::ISSP>>(&arg0.upgrade_bag, arg1);
            v11 = v13.coin_unit;
            v12 = v13.total_wrapped;
        };
        let v14 = QueryDataEventV2{
            mint_to_issp_staking_rate : v7,
            destroy_issp_fee_amount   : v8,
            coin_unit                 : v11,
            total_wrapped             : v12,
        };
        0x2::event::emit<QueryDataEventV2>(v14);
    }

    public fun get_mint_data_list(arg0: &mut Global, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            get_mint_data(arg0, *0x1::vector::borrow<0x1::string::String>(&mut arg1, v0), arg2);
        };
    }

    public(friend) fun get_sui20_data(arg0: &Sui20) : (0x1::string::String, u64) {
        (arg0.tick, arg0.amount)
    }

    public fun get_users_data(arg0: &mut Global, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg1), 1003);
        let v0 = 0x2::bag::borrow_mut<0x1::string::String, Sui20Data>(&mut arg0.sui20tokens, arg1);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v0.users)) {
            let v3 = *0x1::vector::borrow<address>(&v0.users, v2);
            let v4 = if (0x2::table::contains<address, UserInfo>(&v0.user_infos, v3)) {
                0x2::table::borrow<address, UserInfo>(&v0.user_infos, v3).minted_amount
            } else {
                0
            };
            0x1::vector::push_back<u64>(&mut v1, v4);
            v2 = v2 + 1;
        };
        let v5 = QueryUsersEvent{
            users          : v0.users,
            minted_amounts : v1,
        };
        0x2::event::emit<QueryUsersEvent>(v5);
    }

    public fun get_users_data_v2(arg0: &mut Global, arg1: 0x1::string::String, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg1), 1003);
        let v0 = 0x2::bag::borrow_mut<0x1::string::String, Sui20Data>(&mut arg0.sui20tokens, arg1);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg2)) {
            let v3 = *0x1::vector::borrow<address>(&arg2, v2);
            let v4 = if (0x2::table::contains<address, UserInfo>(&v0.user_infos, v3)) {
                0x2::table::borrow<address, UserInfo>(&v0.user_infos, v3).minted_amount
            } else {
                0
            };
            0x1::vector::push_back<u64>(&mut v1, v4);
            v2 = v2 + 1;
        };
        let v5 = QueryUsersEvent{
            users          : v0.users,
            minted_amounts : v1,
        };
        0x2::event::emit<QueryUsersEvent>(v5);
    }

    fun init(arg0: SUI20, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id              : 0x2::object::new(arg1),
            is_paused       : false,
            sui20tokens     : 0x2::bag::new(arg1),
            fee             : 0x2::balance::zero<0x2::sui::SUI>(),
            current_version : 0,
            upgrade_bag     : 0x2::bag::new(arg1),
        };
        0x2::transfer::public_share_object<Global>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
        let v2 = 0x2::package::claim<SUI20>(arg0, arg1);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{tick}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://issp.io/assets/{tick}.svg"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{\"p\":\"sui-20\",\"tick\":\"{tick}\",\"amt\":\"{amount}\"}"));
        let v7 = 0x2::display::new_with_fields<Sui20>(&v2, v3, v5, arg1);
        0x2::display::update_version<Sui20>(&mut v7);
        0x2::transfer::public_transfer<0x2::display::Display<Sui20>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun merge(arg0: &mut Global, arg1: 0x1::string::String, arg2: vector<Sui20>, arg3: &mut 0x2::tx_context::TxContext) : (Sui20, u64) {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg1), 1003);
        let v0 = 0;
        while (!0x1::vector::is_empty<Sui20>(&arg2)) {
            let Sui20 {
                id     : v1,
                tick   : v2,
                amount : v3,
            } = 0x1::vector::pop_back<Sui20>(&mut arg2);
            assert!(v2 == arg1, 1012);
            0x2::object::delete(v1);
            v0 = v0 + v3;
        };
        assert!(v0 > 0, 1006);
        0x1::vector::destroy_empty<Sui20>(arg2);
        let v4 = Sui20{
            id     : 0x2::object::new(arg3),
            tick   : arg1,
            amount : v0,
        };
        (v4, v0)
    }

    public fun merge_v2(arg0: &mut Global, arg1: 0x1::string::String, arg2: vector<Sui20>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (Sui20, Sui20, u64, u64) {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        assert!(arg3 >= 0, 1007);
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg1), 1003);
        let v0 = 0;
        while (!0x1::vector::is_empty<Sui20>(&arg2)) {
            let Sui20 {
                id     : v1,
                tick   : v2,
                amount : v3,
            } = 0x1::vector::pop_back<Sui20>(&mut arg2);
            assert!(v2 == arg1, 1012);
            0x2::object::delete(v1);
            v0 = v0 + v3;
        };
        assert!(v0 >= arg3, 1006);
        0x1::vector::destroy_empty<Sui20>(arg2);
        let v4 = Sui20{
            id     : 0x2::object::new(arg4),
            tick   : arg1,
            amount : arg3,
        };
        let v5 = Sui20{
            id     : 0x2::object::new(arg4),
            tick   : arg1,
            amount : v0 - arg3,
        };
        (v4, v5, v0, v0 - arg3)
    }

    public fun mint(arg0: &mut Global, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg2), 1003);
        let v2 = 0x2::bag::borrow_mut<0x1::string::String, Sui20Data>(&mut arg0.sui20tokens, arg2);
        assert!(v1 >= v2.meta.start_at, 1013);
        assert!(arg3 <= v2.meta.limit, 1014);
        assert!(v2.total_minted + arg3 <= v2.meta.max, 1004);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v2.meta.fee, 1005);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v2.meta.fee, arg5)));
        v2.total_minted = v2.total_minted + arg3;
        v2.txs = v2.txs + 1;
        if (!0x2::table::contains<address, UserInfo>(&v2.user_infos, v0)) {
            let v3 = UserInfo{
                minted_amount : 0,
                last_mint_at  : 0,
                hold_amount   : 0,
            };
            0x2::table::add<address, UserInfo>(&mut v2.user_infos, v0, v3);
        };
        let v4 = 0x2::table::borrow_mut<address, UserInfo>(&mut v2.user_infos, v0);
        assert!(v1 >= v4.last_mint_at + v2.mint_cd, 1015);
        v4.minted_amount = v4.minted_amount + arg3;
        v4.last_mint_at = v1;
        v4.hold_amount = v4.hold_amount + arg3;
        assert!(v4.minted_amount <= v2.max_mint_per_user, 1016);
        let v5 = v4.minted_amount;
        let v6 = 0x1::vector::length<address>(&v2.users);
        if (!0x1::vector::contains<address>(&v2.users, &v0)) {
            let v7 = 0;
            while (v7 < v6) {
                if (v5 > 0x2::table::borrow<address, UserInfo>(&v2.user_infos, *0x1::vector::borrow<address>(&v2.users, v7)).minted_amount) {
                    0x1::vector::insert<address>(&mut v2.users, v0, v7);
                    break
                };
                v7 = v7 + 1;
            };
            let v8 = 0x1::vector::length<address>(&v2.users);
            if (v8 == v6 && v6 < 20) {
                0x1::vector::push_back<address>(&mut v2.users, v0);
            } else if (v8 > 20) {
                0x1::vector::pop_back<address>(&mut v2.users);
            };
        };
        let v9 = Sui20{
            id     : 0x2::object::new(arg5),
            tick   : v2.meta.tick,
            amount : arg3,
        };
        0x2::transfer::public_transfer<Sui20>(v9, v0);
        arg4
    }

    fun only_allowed_version(arg0: &Global) {
        assert!(arg0.current_version <= 5, 1000);
    }

    fun only_not_paused(arg0: &Global) {
        assert!(!arg0.is_paused, 1001);
    }

    public fun set_paused(arg0: &mut Global, arg1: &mut AdminCap, arg2: bool) {
        arg0.is_paused = arg2;
    }

    public fun set_version(arg0: &mut Global, arg1: &mut AdminCap, arg2: u64) {
        arg0.current_version = arg2;
    }

    public fun set_wrapped_coin<T0>(arg0: &mut Global, arg1: &mut AdminCap, arg2: 0x1::string::String, arg3: 0x2::coin::TreasuryCap<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg2), 1003);
        assert!(!0x2::bag::contains<0x1::string::String>(&arg0.upgrade_bag, arg2), 1019);
        let v0 = Sui20WrapCoinV2<T0>{
            treasury_cap  : arg3,
            coin_unit     : arg4,
            total_wrapped : 0,
        };
        0x2::bag::add<0x1::string::String, Sui20WrapCoinV2<T0>>(&mut arg0.upgrade_bag, arg2, v0);
    }

    public fun update_blacklist(arg0: &mut Global, arg1: 0x1::string::String, arg2: &mut AdminCap, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
    }

    public fun update_enable_to_coin(arg0: &mut Global, arg1: &mut AdminCap, arg2: 0x1::string::String, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg2), 1003);
        0x2::bag::borrow_mut<0x1::string::String, Sui20Data>(&mut arg0.sui20tokens, arg2).enable_to_coin = arg3;
    }

    public fun update_global_v2(arg0: &mut Global, arg1: &mut AdminCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 2;
        if (!0x2::bag::contains<u64>(&arg0.upgrade_bag, v0)) {
            let v1 = GlobalV2{
                mint_to_issp_staking_rate : 5,
                destroy_issp_fee_amount   : 2000000,
            };
            0x2::bag::add<u64, GlobalV2>(&mut arg0.upgrade_bag, v0, v1);
        };
        let v2 = 0x2::bag::borrow_mut<u64, GlobalV2>(&mut arg0.upgrade_bag, v0);
        v2.mint_to_issp_staking_rate = arg2;
        v2.destroy_issp_fee_amount = arg3;
    }

    public fun update_mint_cd(arg0: &mut Global, arg1: &mut AdminCap, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg2), 1003);
        0x2::bag::borrow_mut<0x1::string::String, Sui20Data>(&mut arg0.sui20tokens, arg2).mint_cd = arg3;
    }

    public fun wrap<T0>(arg0: &mut Global, arg1: 0x1::string::String, arg2: Sui20, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg1), 1003);
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.upgrade_bag, arg1), 1020);
        assert!(0x2::bag::borrow<0x1::string::String, Sui20Data>(&arg0.sui20tokens, arg1).enable_to_coin, 1008);
        let Sui20 {
            id     : v0,
            tick   : v1,
            amount : v2,
        } = arg2;
        assert!(v1 == arg1, 1021);
        assert!(v2 >= 100000, 1022);
        0x2::object::delete(v0);
        let v3 = 0x2::bag::borrow_mut<0x1::string::String, Sui20WrapCoinV2<T0>>(&mut arg0.upgrade_bag, v1);
        v3.total_wrapped = v3.total_wrapped + v2;
        0x2::coin::mint_and_transfer<T0>(&mut v3.treasury_cap, v2 * v3.coin_unit * 95 / 100, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

