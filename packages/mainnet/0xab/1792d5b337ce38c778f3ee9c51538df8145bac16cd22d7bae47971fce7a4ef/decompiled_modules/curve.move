module 0x50a3ac2280430c3b668535d82b56c7fe860cac42132b687ca1e1cd11dfe8c918::curve {
    struct CURVE has drop {
        dummy_field: bool,
    }

    struct AssetsTraded has copy, drop {
        address: address,
        curve: 0x2::object::ID,
        assets: vector<0x2::object::ID>,
        prices: vector<u64>,
        minted: u64,
        trade_type: u8,
    }

    struct TradingStarted has copy, drop {
        curve: 0x2::object::ID,
    }

    struct TradingCompleted has copy, drop {
        curve: 0x2::object::ID,
    }

    struct Curve<phantom T0: store + key> has key {
        id: 0x2::object::UID,
        publisher: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        minted: u64,
        completed: bool,
        base_price: u64,
        scaling_factor: u64,
        max_supply: u64,
        fee_bps: u64,
        reward_bps: u64,
    }

    struct CurveBuyOrder<phantom T0> {
        curve_id: 0x2::object::ID,
        prices: vector<u64>,
        size: u64,
    }

    struct CurveSellOrder<phantom T0> {
        curve_id: 0x2::object::ID,
        asset_ids: vector<0x2::object::ID>,
        prices: vector<u64>,
    }

    public fun admin_remove_curve_df<T0: store + key, T1: copy + drop + store, T2: drop + store>(arg0: &mut Curve<T0>, arg1: T1, arg2: &0x2::package::Publisher) {
        assert!(0x2::package::from_module<Curve<T0>>(arg2), 0);
        if (0x2::dynamic_field::exists_with_type<T1, T2>(&arg0.id, arg1)) {
            0x2::dynamic_field::remove<T1, T2>(&mut arg0.id, arg1);
        };
    }

    public fun admin_update_curve_df<T0: store + key, T1: copy + drop + store, T2: drop + store>(arg0: &mut Curve<T0>, arg1: T1, arg2: T2, arg3: &0x2::package::Publisher) {
        assert!(0x2::package::from_module<Curve<T0>>(arg3), 0);
        if (0x2::dynamic_field::exists_with_type<T1, T2>(&arg0.id, arg1)) {
            0x2::dynamic_field::remove<T1, T2>(&mut arg0.id, arg1);
        };
        0x2::dynamic_field::add<T1, T2>(&mut arg0.id, arg1, arg2);
    }

    public fun admin_update_reward_bps<T0: store + key>(arg0: &mut Curve<T0>, arg1: u64, arg2: &0x2::package::Publisher) {
        assert!(0x2::package::from_module<Curve<T0>>(arg2), 0);
        assert!(arg1 >= 0, 0);
        assert!(arg1 <= 10000, 0);
        arg0.reward_bps = arg1;
    }

    public fun buy_order<T0: store + key>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (CurveBuyOrder<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(!arg0.completed, 1);
        assert!(arg0.minted < arg0.max_supply, 2);
        assert!(arg2 > 0, 3);
        assert!(arg2 <= arg0.max_supply - arg0.minted, 4);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::empty<u64>();
        while (v0 < arg2) {
            arg0.minted = arg0.minted + 1;
            let v3 = arg0.minted;
            let v4 = price<T0>(v3, arg0);
            v1 = v1 + v4;
            0x1::vector::push_back<u64>(&mut v2, v4);
            if (arg0.minted == arg0.max_supply) {
                arg0.completed = true;
                let v5 = TradingCompleted{curve: 0x2::object::id<Curve<T0>>(arg0)};
                0x2::event::emit<TradingCompleted>(v5);
            };
            v0 = v0 + 1;
        };
        let v6 = v1 * arg0.fee_bps / 10000;
        let v7 = v1 + v6;
        let v8 = v7;
        let v9 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v9 >= v7, 0);
        let v10 = 0x1::string::utf8(b"collection_fee_bps");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v10)) {
            let v11 = v7 + v1 * *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, v10) / 10000;
            v8 = v11;
            assert!(v9 >= v11, 0);
        };
        let v12 = 0x2::coin::zero<0x2::sui::SUI>(arg3);
        let v13 = v9 - v8;
        if (v13 > 0) {
            0x2::coin::join<0x2::sui::SUI>(&mut v12, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v13, arg3));
        };
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v6, arg3), @0x8f88f57664158421f50752ab12455b27c042cac2b4861f56c2e3935470981b75);
        if (0x2::balance::value<0x2::sui::SUI>(0x2::coin::balance<0x2::sui::SUI>(&arg1)) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.publisher);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        let v14 = CurveBuyOrder<T0>{
            curve_id : 0x2::object::id<Curve<T0>>(arg0),
            prices   : v2,
            size     : arg2,
        };
        (v14, v12)
    }

    public fun buy_order_curve<T0>(arg0: &CurveBuyOrder<T0>) : 0x2::object::ID {
        arg0.curve_id
    }

    public fun buy_order_post_sale<T0: store + key>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (CurveBuyOrder<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg0.publisher == 0x2::tx_context::sender(arg3), 0);
        assert!(!arg0.completed, 1);
        let v0 = arg0.max_supply - arg0.minted;
        assert!(v0 > 0, 2);
        assert!(0x2::clock::timestamp_ms(arg2) > *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, 0x1::string::utf8(b"created_at")) + *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, 0x1::string::utf8(b"cooldown")), 4);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::empty<u64>();
        while (v1 < v0) {
            arg0.minted = arg0.minted + 1;
            let v4 = arg0.minted;
            let v5 = price<T0>(v4, arg0);
            v2 = v2 + v5;
            0x1::vector::push_back<u64>(&mut v3, v5);
            if (arg0.minted == arg0.max_supply) {
                arg0.completed = true;
                let v6 = TradingCompleted{curve: 0x2::object::id<Curve<T0>>(arg0)};
                0x2::event::emit<TradingCompleted>(v6);
            };
            v1 = v1 + 1;
        };
        let v7 = v2 * arg0.fee_bps / 10000;
        let v8 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v8 >= v7, 4);
        let v9 = 0x2::coin::zero<0x2::sui::SUI>(arg3);
        let v10 = v8 - v7;
        if (v10 > 0) {
            0x2::coin::join<0x2::sui::SUI>(&mut v9, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v10, arg3));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0x8f88f57664158421f50752ab12455b27c042cac2b4861f56c2e3935470981b75);
        let v11 = CurveBuyOrder<T0>{
            curve_id : 0x2::object::id<Curve<T0>>(arg0),
            prices   : v3,
            size     : v0,
        };
        (v11, v9)
    }

    public fun buy_order_pre_sale<T0: store + key>(arg0: Curve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (CurveBuyOrder<T0>, 0x2::coin::Coin<0x2::sui::SUI>, Curve<T0>) {
        assert!(arg0.publisher == 0x2::tx_context::sender(arg3), 0);
        let v0 = &mut arg0;
        let (v1, v2) = buy_order<T0>(v0, arg1, arg2, arg3);
        (v1, v2, arg0)
    }

    public fun buy_order_size<T0>(arg0: &CurveBuyOrder<T0>) : u64 {
        arg0.size
    }

    public fun confirm_buy_order<T0: store + key>(arg0: CurveBuyOrder<T0>, arg1: &Curve<T0>, arg2: vector<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let CurveBuyOrder {
            curve_id : v0,
            prices   : v1,
            size     : v2,
        } = arg0;
        assert!(0x2::object::id<Curve<T0>>(arg1) == v0, 0);
        let v3 = 0;
        let v4 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::reverse<T0>(&mut arg2);
        while (v3 < v2) {
            let v5 = 0x1::vector::pop_back<T0>(&mut arg2);
            0x1::vector::push_back<0x2::object::ID>(&mut v4, 0x2::object::id<T0>(&v5));
            0x2::transfer::public_transfer<T0>(v5, 0x2::tx_context::sender(arg3));
            v3 = v3 + 1;
        };
        let v6 = AssetsTraded{
            address    : 0x2::tx_context::sender(arg3),
            curve      : 0x2::object::id<Curve<T0>>(arg1),
            assets     : v4,
            prices     : v1,
            minted     : arg1.minted,
            trade_type : 0,
        };
        0x2::event::emit<AssetsTraded>(v6);
        0x1::vector::destroy_empty<T0>(arg2);
    }

    public fun confirm_buy_order_pre_sale<T0: store + key>(arg0: CurveBuyOrder<T0>, arg1: Curve<T0>, arg2: vector<T0>, arg3: &mut 0x2::tx_context::TxContext) : Curve<T0> {
        assert!(arg1.publisher == 0x2::tx_context::sender(arg3), 0);
        confirm_buy_order<T0>(arg0, &arg1, arg2, arg3);
        arg1
    }

    public fun confirm_sell_order<T0: store + key>(arg0: CurveSellOrder<T0>, arg1: &mut Curve<T0>, arg2: vector<0x2::object::UID>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let CurveSellOrder {
            curve_id  : v0,
            asset_ids : v1,
            prices    : v2,
        } = arg0;
        let v3 = v2;
        let v4 = v1;
        assert!(0x2::object::id<Curve<T0>>(arg1) == v0, 0);
        let v5 = 0x1::vector::length<0x2::object::ID>(&v4);
        assert!(v5 == 0x1::vector::length<0x2::object::UID>(&arg2), 0);
        0x1::vector::reverse<0x2::object::UID>(&mut arg2);
        let v6 = 0;
        let v7 = 0;
        while (v6 < v5) {
            let v8 = 0x1::vector::pop_back<0x2::object::UID>(&mut arg2);
            assert!(0x2::object::uid_to_inner(&v8) == *0x1::vector::borrow<0x2::object::ID>(&v4, v6), 0);
            0x2::object::delete(v8);
            v7 = v7 + *0x1::vector::borrow<u64>(&v3, v6);
            v6 = v6 + 1;
        };
        let v9 = AssetsTraded{
            address    : 0x2::tx_context::sender(arg3),
            curve      : 0x2::object::id<Curve<T0>>(arg1),
            assets     : v4,
            prices     : v3,
            minted     : arg1.minted,
            trade_type : 1,
        };
        0x2::event::emit<AssetsTraded>(v9);
        let v10 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v7), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v10, v7 * arg1.fee_bps / 10000, arg3), @0x8f88f57664158421f50752ab12455b27c042cac2b4861f56c2e3935470981b75);
        let v11 = 0x1::string::utf8(b"collection_fee_bps");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, v11)) {
            let v12 = v7 * *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg1.id, v11) / 10000;
            if (v12 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v10, v12, arg3), arg1.publisher);
            };
        };
        0x1::vector::destroy_empty<0x2::object::UID>(arg2);
        v10
    }

    public fun create_curve<T0: store + key>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0 > 0, 0);
        assert!(arg0 < 100000000000, 0);
        assert!(arg1 > 0, 0);
        assert!(arg1 < 100000000000, 0);
        assert!(arg2 >= 100, 0);
        assert!(arg2 <= 10000, 0);
        assert!(arg3 >= 0, 0);
        assert!(arg3 <= 1000, 0);
        assert!(arg4 >= 0, 0);
        assert!(arg4 <= 10000, 0);
        let v0 = Curve<T0>{
            id             : 0x2::object::new(arg5),
            publisher      : 0x2::tx_context::sender(arg5),
            balance        : 0x2::balance::zero<0x2::sui::SUI>(),
            minted         : 0,
            completed      : false,
            base_price     : arg0,
            scaling_factor : arg1,
            max_supply     : arg2,
            fee_bps        : arg3,
            reward_bps     : arg4,
        };
        let v1 = 0x2::object::id<Curve<T0>>(&v0);
        0x2::transfer::share_object<Curve<T0>>(v0);
        let v2 = TradingStarted{curve: v1};
        0x2::event::emit<TradingStarted>(v2);
        v1
    }

    public fun curve_id<T0: store + key>(arg0: Curve<T0>) : (0x2::object::ID, Curve<T0>) {
        (0x2::object::id<Curve<T0>>(&arg0), arg0)
    }

    fun init(arg0: CURVE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<CURVE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun minted<T0: store + key>(arg0: &Curve<T0>) : u64 {
        arg0.minted
    }

    public fun new_curve<T0: store + key>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Curve<T0> {
        assert!(arg0 > 0, 0);
        assert!(arg0 < 100000000000, 0);
        assert!(arg1 > 0, 0);
        assert!(arg1 < 100000000000, 0);
        assert!(arg2 >= 100, 0);
        assert!(arg2 <= 10000, 0);
        assert!(arg3 >= 0, 0);
        assert!(arg3 <= 1000, 0);
        assert!(arg4 >= 0, 0);
        assert!(arg4 <= 10000, 0);
        Curve<T0>{
            id             : 0x2::object::new(arg5),
            publisher      : 0x2::tx_context::sender(arg5),
            balance        : 0x2::balance::zero<0x2::sui::SUI>(),
            minted         : 0,
            completed      : false,
            base_price     : arg0,
            scaling_factor : arg1,
            max_supply     : arg2,
            fee_bps        : arg3,
            reward_bps     : arg4,
        }
    }

    public fun price<T0: store + key>(arg0: u64, arg1: &mut Curve<T0>) : u64 {
        assert!(!arg1.completed, 0);
        assert!(arg0 > 0, 1);
        let v0 = arg1.base_price + arg1.scaling_factor / arg1.max_supply * arg0;
        assert!(v0 > 0, 2);
        v0
    }

    public fun sell_asset_ids<T0>(arg0: &CurveSellOrder<T0>) : vector<0x2::object::ID> {
        arg0.asset_ids
    }

    public fun sell_order<T0: store + key>(arg0: &mut Curve<T0>, arg1: &vector<T0>, arg2: u64) : CurveSellOrder<T0> {
        assert!(!arg0.completed, 0);
        let v0 = 0x1::vector::length<T0>(arg1);
        assert!(v0 > 0, 0);
        assert!(arg0.minted >= v0, 0);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<0x2::object::ID>();
        while (v1 < v0) {
            let v5 = arg0.minted - v1;
            let v6 = price<T0>(v5, arg0);
            0x1::vector::push_back<u64>(&mut v3, v6);
            v2 = v2 + v6;
            0x1::vector::push_back<0x2::object::ID>(&mut v4, 0x2::object::id<T0>(0x1::vector::borrow<T0>(arg1, v1)));
            v1 = v1 + 1;
        };
        assert!(arg2 <= v2, 0);
        arg0.minted = arg0.minted - v0;
        CurveSellOrder<T0>{
            curve_id  : 0x2::object::id<Curve<T0>>(arg0),
            asset_ids : v4,
            prices    : v3,
        }
    }

    public fun sell_order_curve<T0>(arg0: &CurveSellOrder<T0>) : 0x2::object::ID {
        arg0.curve_id
    }

    public fun set_collection_fee_bps<T0: store + key>(arg0: Curve<T0>, arg1: u64) : Curve<T0> {
        assert!(arg1 >= 0, 0);
        assert!(arg1 <= 500, 1);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"collection_fee_bps"), arg1);
        arg0
    }

    public fun share_curve<T0: store + key>(arg0: Curve<T0>, arg1: &0x2::clock::Clock, arg2: u64) {
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"created_at"), 0x2::clock::timestamp_ms(arg1));
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"cooldown"), arg2);
        0x2::transfer::share_object<Curve<T0>>(arg0);
        let v0 = TradingStarted{curve: 0x2::object::id<Curve<T0>>(&arg0)};
        0x2::event::emit<TradingStarted>(v0);
    }

    public fun withdraw<T0: store + key>(arg0: &mut Curve<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.completed, 0);
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0) * arg0.reward_bps / 10000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&v0) >= v1, 9223373819266203647);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v1, arg1), arg0.publisher);
        };
        if (0x2::balance::value<0x2::sui::SUI>(0x2::coin::balance<0x2::sui::SUI>(&v0)) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, @0x8f88f57664158421f50752ab12455b27c042cac2b4861f56c2e3935470981b75);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

