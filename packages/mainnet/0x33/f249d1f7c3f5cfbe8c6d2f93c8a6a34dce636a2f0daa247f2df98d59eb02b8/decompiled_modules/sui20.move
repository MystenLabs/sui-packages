module 0x33f249d1f7c3f5cfbe8c6d2f93c8a6a34dce636a2f0daa247f2df98d59eb02b8::sui20 {
    struct SUI20 has drop {
        dummy_field: bool,
    }

    struct Global has store, key {
        id: 0x2::object::UID,
        sui20tokens: 0x2::bag::Bag,
        tick_names: 0x2::table::Table<0x1::string::String, 0x1::type_name::TypeName>,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
        enable_to_coin: bool,
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

    struct Sui20Data<phantom T0> has store {
        meta: Sui20Meta,
        total_minted: u64,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        txs: u64,
        user_infos: 0x2::table::Table<address, UserInfo>,
        users: vector<address>,
        upgrade_bag: 0x2::bag::Bag,
    }

    struct Sui20 has store, key {
        id: 0x2::object::UID,
        tick: 0x1::string::String,
        type_name: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct QueryDataEvent<phantom T0> has copy, drop {
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

    struct QueryUsersEvent<phantom T0> has copy, drop {
        users: vector<address>,
        minted_amounts: vector<u64>,
    }

    public fun transfer<T0>(arg0: &mut Global, arg1: vector<Sui20>, arg2: address, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            assert!(arg0.enable_to_coin, 1008);
        };
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.sui20tokens, v0), 1002);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, Sui20Data<T0>>(&mut arg0.sui20tokens, v0);
        assert!(arg3 > 0, 1007);
        let v2 = 0;
        while (!0x1::vector::is_empty<Sui20>(&arg1)) {
            let Sui20 {
                id        : v3,
                tick      : _,
                type_name : v5,
                amount    : v6,
            } = 0x1::vector::pop_back<Sui20>(&mut arg1);
            assert!(v5 == v0, 1012);
            0x2::object::delete(v3);
            v2 = v2 + v6;
        };
        assert!(v2 >= arg3, 1006);
        0x1::vector::destroy_empty<Sui20>(arg1);
        if (arg4) {
            0x2::coin::mint_and_transfer<T0>(&mut v1.treasury_cap, arg3, arg2, arg5);
        } else {
            let v7 = Sui20{
                id        : 0x2::object::new(arg5),
                tick      : v1.meta.tick,
                type_name : v0,
                amount    : arg3,
            };
            0x2::transfer::public_transfer<Sui20>(v7, arg2);
        };
        let v8 = v2 - arg3;
        if (v8 > 0) {
            let v9 = Sui20{
                id        : 0x2::object::new(arg5),
                tick      : v1.meta.tick,
                type_name : v0,
                amount    : v8,
            };
            0x2::transfer::public_transfer<Sui20>(v9, 0x2::tx_context::sender(arg5));
        };
    }

    fun check_tick<T0>(arg0: vector<u8>, arg1: &mut Global) {
        assert!(0x1::vector::length<u8>(&arg0) == 4, 1009);
        while (!0x1::vector::is_empty<u8>(&arg0)) {
            let v0 = 0x1::vector::pop_back<u8>(&mut arg0);
            assert!(v0 >= 97 && v0 <= 122 || v0 >= 48 && v0 <= 57, 1010);
        };
        let v1 = 0x1::string::utf8(arg0);
        assert!(!0x2::table::contains<0x1::string::String, 0x1::type_name::TypeName>(&arg1.tick_names, v1), 1011);
        0x2::table::add<0x1::string::String, 0x1::type_name::TypeName>(&mut arg1.tick_names, v1, 0x1::type_name::get<T0>());
    }

    public fun deploy<T0>(arg0: &mut Global, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: 0x2::coin::TreasuryCap<T0>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        check_tick<T0>(arg2, arg0);
        let v1 = 0x1::type_name::get<T0>();
        assert!(!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.sui20tokens, v1), 1001);
        let v2 = v0;
        if (arg7 > v0) {
            v2 = arg7;
        };
        let v3 = Sui20Meta{
            tick     : 0x1::string::utf8(arg2),
            max      : arg3,
            limit    : arg4,
            decimals : arg5,
            fee      : arg6,
            start_at : v2,
        };
        let v4 = Sui20Data<T0>{
            meta         : v3,
            total_minted : 0,
            treasury_cap : arg8,
            txs          : 0,
            user_infos   : 0x2::table::new<address, UserInfo>(arg9),
            users        : 0x1::vector::empty<address>(),
            upgrade_bag  : 0x2::bag::new(arg9),
        };
        0x2::bag::add<0x1::type_name::TypeName, Sui20Data<T0>>(&mut arg0.sui20tokens, v1, v4);
    }

    public fun get_mint_data<T0>(arg0: &mut Global, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.sui20tokens, v1), 1002);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, Sui20Data<T0>>(&mut arg0.sui20tokens, v1);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        if (0x2::table::contains<address, UserInfo>(&v2.user_infos, v0)) {
            let v6 = 0x2::table::borrow<address, UserInfo>(&v2.user_infos, v0);
            v3 = v6.minted_amount;
            v4 = v6.hold_amount;
            v5 = v6.last_mint_at;
        };
        let v7 = QueryDataEvent<T0>{
            tick               : v2.meta.tick,
            start_at           : v2.meta.start_at,
            total_cap          : v2.meta.max,
            limit_per_mint     : v2.meta.limit,
            decimals           : v2.meta.decimals,
            mint_fee           : v2.meta.fee,
            total_minted       : v2.total_minted,
            remain_supply      : v2.meta.max - v2.total_minted,
            txs                : v2.txs,
            user_minted_amount : v3,
            user_hold_amount   : v4,
            user_last_mint_at  : v5,
        };
        0x2::event::emit<QueryDataEvent<T0>>(v7);
    }

    public fun get_users_data<T0>(arg0: &mut Global, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.sui20tokens, v0), 1002);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, Sui20Data<T0>>(&mut arg0.sui20tokens, v0);
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&v1.users)) {
            let v4 = *0x1::vector::borrow<address>(&v1.users, v3);
            let v5 = if (0x2::table::contains<address, UserInfo>(&v1.user_infos, v4)) {
                0x2::table::borrow<address, UserInfo>(&v1.user_infos, v4).minted_amount
            } else {
                0
            };
            0x1::vector::push_back<u64>(&mut v2, v5);
            v3 = v3 + 1;
        };
        let v6 = QueryUsersEvent<T0>{
            users          : v1.users,
            minted_amounts : v2,
        };
        0x2::event::emit<QueryUsersEvent<T0>>(v6);
    }

    fun init(arg0: SUI20, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id             : 0x2::object::new(arg1),
            sui20tokens    : 0x2::bag::new(arg1),
            tick_names     : 0x2::table::new<0x1::string::String, 0x1::type_name::TypeName>(arg1),
            fee            : 0x2::balance::zero<0x2::sui::SUI>(),
            enable_to_coin : false,
            upgrade_bag    : 0x2::bag::new(arg1),
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
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"website"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{tick}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://issp.io/assets/{tick}.svg"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{\"p\":\"sui-20\",\"tick\":\"{tick}\",\"amt\":\"{amount}\"}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"issp.io"));
        let v7 = 0x2::display::new_with_fields<Sui20>(&v2, v3, v5, arg1);
        0x2::display::update_version<Sui20>(&mut v7);
        0x2::transfer::public_transfer<0x2::display::Display<Sui20>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint<T0>(arg0: &mut Global, arg1: &0x2::clock::Clock, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v2 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.sui20tokens, v2), 1001);
        let v3 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, Sui20Data<T0>>(&mut arg0.sui20tokens, v2);
        assert!(v1 >= v3.meta.start_at, 1013);
        assert!(arg2 <= v3.meta.limit, 1003);
        assert!(v3.total_minted + arg2 <= v3.meta.max, 1004);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v3.meta.fee, 1005);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        v3.total_minted = v3.total_minted + arg2;
        v3.txs = v3.txs + 1;
        if (!0x2::table::contains<address, UserInfo>(&v3.user_infos, v0)) {
            let v4 = UserInfo{
                minted_amount : 0,
                last_mint_at  : 0,
                hold_amount   : 0,
            };
            0x2::table::add<address, UserInfo>(&mut v3.user_infos, v0, v4);
            0x1::vector::push_back<address>(&mut v3.users, v0);
        };
        let v5 = 0x2::table::borrow_mut<address, UserInfo>(&mut v3.user_infos, v0);
        v5.minted_amount = v5.minted_amount + arg2;
        v5.last_mint_at = v1;
        v5.hold_amount = v5.hold_amount + arg2;
        let v6 = Sui20{
            id        : 0x2::object::new(arg4),
            tick      : v3.meta.tick,
            type_name : v2,
            amount    : arg2,
        };
        0x2::transfer::public_transfer<Sui20>(v6, v0);
    }

    public fun test_upgrade() {
    }

    public fun unwrap<T0>(arg0: &mut Global, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.sui20tokens, v0), 1002);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, Sui20Data<T0>>(&mut arg0.sui20tokens, v0);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 > 0, 1007);
        0x2::coin::burn<T0>(&mut v1.treasury_cap, arg1);
        let v3 = Sui20{
            id        : 0x2::object::new(arg2),
            tick      : v1.meta.tick,
            type_name : v0,
            amount    : v2,
        };
        0x2::transfer::public_transfer<Sui20>(v3, 0x2::tx_context::sender(arg2));
    }

    public fun update_enable_to_coin(arg0: &mut Global, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.enable_to_coin = arg2;
    }

    // decompiled from Move bytecode v6
}

