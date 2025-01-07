module 0xa4e703a5234ed455a28d763d3f208357fa3158072283d4696216fdc4f8aa6584::sui20 {
    struct SUI20 has drop {
        dummy_field: bool,
    }

    struct Global has store, key {
        id: 0x2::object::UID,
        sui20tokens: 0x2::bag::Bag,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
        upgrade_bag: 0x2::bag::Bag,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
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

    struct QueryDataEvent has copy, drop {
        tick: 0x1::string::String,
        start_at: u64,
        total_cap: u64,
        limit_per_mint: u64,
        decimals: u8,
        mint_fee: u64,
        total_minted: u64,
        remain_supply: u64,
        txs: u64,
        user_minted_amount: u64,
        user_hold_amount: u64,
        user_last_mint_at: u64,
    }

    struct QueryUsersEvent has copy, drop {
        users: vector<address>,
        minted_amounts: vector<u64>,
    }

    public fun transfer(arg0: &mut Global, arg1: 0x1::string::String, arg2: vector<Sui20>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg1), 1002);
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

    fun check_tick(arg0: vector<u8>, arg1: &mut Global) : 0x1::string::String {
        let v0 = 0x1::string::utf8(arg0);
        assert!(0x1::vector::length<u8>(&arg0) == 4, 1009);
        while (!0x1::vector::is_empty<u8>(&arg0)) {
            let v1 = 0x1::vector::pop_back<u8>(&mut arg0);
            assert!(v1 >= 97 && v1 <= 122 || v1 >= 48 && v1 <= 57, 1010);
        };
        assert!(!0x2::bag::contains<0x1::string::String>(&arg1.sui20tokens, v0), 1011);
        v0
    }

    public fun deploy(arg0: &mut Global, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = check_tick(arg2, arg0);
        assert!(!0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, v1), 1001);
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
            meta           : v3,
            enable_to_coin : false,
            total_minted   : 0,
            txs            : 0,
            user_infos     : 0x2::table::new<address, UserInfo>(arg8),
            users          : 0x1::vector::empty<address>(),
            upgrade_bag    : 0x2::bag::new(arg8),
        };
        0x2::bag::add<0x1::string::String, Sui20Data>(&mut arg0.sui20tokens, v1, v4);
    }

    public fun get_mint_data(arg0: &mut Global, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg1), 1002);
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
            total_minted       : v1.total_minted,
            remain_supply      : v1.meta.max - v1.total_minted,
            txs                : v1.txs,
            user_minted_amount : v2,
            user_hold_amount   : v3,
            user_last_mint_at  : v4,
        };
        0x2::event::emit<QueryDataEvent>(v6);
    }

    public fun get_users_data(arg0: &mut Global, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg1), 1002);
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

    fun init(arg0: SUI20, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id          : 0x2::object::new(arg1),
            sui20tokens : 0x2::bag::new(arg1),
            fee         : 0x2::balance::zero<0x2::sui::SUI>(),
            upgrade_bag : 0x2::bag::new(arg1),
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

    public fun mint(arg0: &mut Global, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg2), 1002);
        let v2 = 0x2::bag::borrow_mut<0x1::string::String, Sui20Data>(&mut arg0.sui20tokens, arg2);
        assert!(v1 >= v2.meta.start_at, 1013);
        assert!(arg3 <= v2.meta.limit, 1003);
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
        v4.minted_amount = v4.minted_amount + arg3;
        v4.last_mint_at = v1;
        v4.hold_amount = v4.hold_amount + arg3;
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

    public fun update_enable_to_coin(arg0: &mut Global, arg1: &AdminCap, arg2: 0x1::string::String, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg2), 1002);
        0x2::bag::borrow_mut<0x1::string::String, Sui20Data>(&mut arg0.sui20tokens, arg2).enable_to_coin = arg3;
    }

    // decompiled from Move bytecode v6
}

