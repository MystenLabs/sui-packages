module 0x7bfb1dc5eb26e41ef5c7566d35b1dbc4dab370c62004aca0e1cfa2dc1c8647ee::curve {
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

    public fun buy_order<T0: store + key>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (CurveBuyOrder<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(!arg0.completed, 0);
        assert!(arg0.minted < 1000, 0);
        assert!(arg2 > 0, 0);
        assert!(arg2 <= 1000 - arg0.minted, 0);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::empty<u64>();
        while (v0 < arg2) {
            arg0.minted = arg0.minted + 1;
            let v3 = price(arg0.minted);
            v1 = v1 + v3;
            0x1::vector::push_back<u64>(&mut v2, v3);
            if (arg0.minted == 1000) {
                arg0.completed = true;
                let v4 = TradingCompleted{curve: 0x2::object::id<Curve<T0>>(arg0)};
                0x2::event::emit<TradingCompleted>(v4);
            };
            v0 = v0 + 1;
        };
        let v5 = v1 + v1 * 25 / 1000;
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v6 >= v5, 0);
        let v7 = 0x2::coin::zero<0x2::sui::SUI>(arg3);
        let v8 = v6 - v5;
        if (v8 > 0) {
            0x2::coin::join<0x2::sui::SUI>(&mut v7, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v8, arg3));
        };
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0x8f88f57664158421f50752ab12455b27c042cac2b4861f56c2e3935470981b75);
        let v9 = CurveBuyOrder<T0>{
            curve_id : 0x2::object::id<Curve<T0>>(arg0),
            prices   : v2,
            size     : arg2,
        };
        (v9, v7)
    }

    public fun buy_order_curve<T0>(arg0: &CurveBuyOrder<T0>) : 0x2::object::ID {
        arg0.curve_id
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
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v10, v7 * 25 / 1000, arg3), @0x8f88f57664158421f50752ab12455b27c042cac2b4861f56c2e3935470981b75);
        0x1::vector::destroy_empty<0x2::object::UID>(arg2);
        v10
    }

    public entry fun create_curve<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Curve<T0>{
            id        : 0x2::object::new(arg0),
            publisher : 0x2::tx_context::sender(arg0),
            balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            minted    : 0,
            completed : false,
        };
        let v1 = 0x2::object::id<Curve<T0>>(&v0);
        0x2::transfer::share_object<Curve<T0>>(v0);
        let v2 = TradingStarted{curve: v1};
        0x2::event::emit<TradingStarted>(v2);
        v1
    }

    fun init(arg0: CURVE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<CURVE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun minted<T0: store + key>(arg0: &Curve<T0>) : u64 {
        arg0.minted
    }

    public fun price(arg0: u64) : u64 {
        assert!(arg0 > 0, 0);
        assert!(arg0 <= 1000, 0);
        let v0 = 1000000000 + 21 * arg0 * 1000000;
        assert!(v0 > 0, 1);
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
            let v5 = price(arg0.minted - v1);
            0x1::vector::push_back<u64>(&mut v3, v5);
            v2 = v2 + v5;
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

    public fun withdraw<T0: store + key>(arg0: &mut Curve<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.completed, 0);
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg1);
        let v1 = 10000000000000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&v0) >= v1, 9223373157841240063);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v1, arg1), arg0.publisher);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, @0x8f88f57664158421f50752ab12455b27c042cac2b4861f56c2e3935470981b75);
    }

    // decompiled from Move bytecode v6
}

