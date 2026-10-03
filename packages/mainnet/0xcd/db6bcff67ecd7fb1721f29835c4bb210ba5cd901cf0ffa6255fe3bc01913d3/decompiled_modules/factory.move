module 0x7efba387fc9d67f9fffed572d3353c0918dab2b936413bcd89067bb9eac6b8fe::factory {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Factory has key {
        id: 0x2::object::UID,
        admin: address,
        aero_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        launch_count: u64,
    }

    struct Curve<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        mode: u8,
        uri: vector<u8>,
        virt_quote: u64,
        sold: u64,
        tokens: 0x2::balance::Balance<T0>,
        quote_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        creator_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        burn_accrued: 0x2::balance::Balance<0x2::sui::SUI>,
        volume: u64,
        graduated: bool,
        pool: 0x1::option::Option<0x2::object::ID>,
        target: u64,
        deposited: u64,
        deadline_ms: u64,
        deposits: 0x2::table::Table<address, u64>,
    }

    struct CurveCreated has copy, drop {
        curve: 0x2::object::ID,
        creator: address,
        coin_type: 0x1::ascii::String,
        mode: u8,
        virt_quote: u64,
        target: u64,
        deadline_ms: u64,
    }

    struct Bought has copy, drop {
        curve: 0x2::object::ID,
        buyer: address,
        sui_in: u64,
        tokens_out: u64,
        sold: u64,
        reserve: u64,
    }

    struct Sold has copy, drop {
        curve: 0x2::object::ID,
        seller: address,
        tokens_in: u64,
        sui_out: u64,
        sold: u64,
        reserve: u64,
    }

    struct Deposited has copy, drop {
        curve: 0x2::object::ID,
        who: address,
        sui_in: u64,
        deposited: u64,
    }

    struct Withdrawn has copy, drop {
        curve: 0x2::object::ID,
        who: address,
        sui_out: u64,
        deposited: u64,
    }

    struct Claimed has copy, drop {
        curve: 0x2::object::ID,
        who: address,
        tokens: u64,
    }

    struct Graduated has copy, drop {
        curve: 0x2::object::ID,
        sui_to_lp: u64,
        tokens_to_lp: u64,
    }

    struct PoolSet has copy, drop {
        curve: 0x2::object::ID,
        pool: 0x2::object::ID,
    }

    public fun buy<T0>(arg0: &mut Curve<T0>, arg1: &mut Factory, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mode == 0, 3);
        assert!(!arg0.graduated, 2);
        assert!(arg0.sold < 793100000000000, 5);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = v0;
        assert!(v0 > 0, 8);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg0.quote_reserve);
        let v4 = quote_buy(arg0.virt_quote, arg0.sold, v3, v0 - v0 * 100 / 10000);
        let v5 = v4;
        let v6 = 793100000000000 - arg0.sold;
        let v7 = 0x2::tx_context::sender(arg4);
        if (v4 > v6) {
            v5 = v6;
            let v8 = cost_for(arg0.virt_quote, arg0.sold, v3, v6) * 10000 / (10000 - 100) + 1;
            v1 = v8;
            if (v8 > 0x2::balance::value<0x2::sui::SUI>(&v2)) {
                v1 = 0x2::balance::value<0x2::sui::SUI>(&v2);
            };
            let v9 = 0x2::balance::value<0x2::sui::SUI>(&v2) - v1;
            if (v9 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v2, v9), arg4), v7);
            };
        };
        assert!(v5 > 0 && v5 >= arg3, 4);
        split_fees<T0>(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v1 * 100 / 10000), v1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.quote_reserve, v2);
        arg0.sold = arg0.sold + v5;
        arg0.volume = arg0.volume + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.tokens, v5), arg4), v7);
        let v10 = Bought{
            curve      : 0x2::object::id<Curve<T0>>(arg0),
            buyer      : v7,
            sui_in     : v1,
            tokens_out : v5,
            sold       : arg0.sold,
            reserve    : 0x2::balance::value<0x2::sui::SUI>(&arg0.quote_reserve),
        };
        0x2::event::emit<Bought>(v10);
    }

    public fun claim<T0>(arg0: &mut Curve<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mode == 1 && offering_filled<T0>(arg0), 6);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, u64>(&arg0.deposits, v0), 12);
        let v1 = (((0x2::table::remove<address, u64>(&mut arg0.deposits, v0) as u128) * (793100000000000 as u128) / (arg0.target as u128)) as u64);
        let v2 = 0x2::balance::value<T0>(&arg0.tokens);
        let v3 = if (v1 > v2) {
            v2
        } else {
            v1
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.tokens, v3), arg1), v0);
        let v4 = Claimed{
            curve  : 0x2::object::id<Curve<T0>>(arg0),
            who    : v0,
            tokens : v3,
        };
        0x2::event::emit<Claimed>(v4);
    }

    public fun claim_creator_fees<T0>(arg0: &mut Curve<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.creator_fees), arg1), arg0.creator);
    }

    public fun collect_aero_fees(arg0: &mut Factory, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.aero_fees), arg1), arg0.admin);
    }

    fun cost_for(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg0 as u128);
        let v1 = v0 * 1073000000000000 / (1073000000000000 - (arg1 as u128) - (arg3 as u128)) + 1;
        let v2 = v0 + (arg2 as u128);
        if (v1 <= v2) {
            0
        } else {
            ((v1 - v2) as u64)
        }
    }

    public fun deposit<T0>(arg0: &mut Curve<T0>, arg1: &mut Factory, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mode == 1, 3);
        if (arg0.deadline_ms < 1000000000000) {
            arg0.deadline_ms = 0x2::clock::timestamp_ms(arg3) + arg0.deadline_ms;
        };
        assert!(!offering_filled<T0>(arg0) && 0x2::clock::timestamp_ms(arg3) < arg0.deadline_ms, 7);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1);
        let v3 = v2;
        assert!(v2 > 0, 8);
        let v4 = arg0.target - arg0.deposited;
        let v5 = v2 - v2 * 100 / 10000;
        let v6 = v5;
        if (v5 > v4) {
            let v7 = v4 * 10000 / (10000 - 100) + 1;
            v3 = v7;
            if (v7 > 0x2::balance::value<0x2::sui::SUI>(&v1)) {
                v3 = 0x2::balance::value<0x2::sui::SUI>(&v1);
            };
            let v8 = 0x2::balance::value<0x2::sui::SUI>(&v1) - v3;
            if (v8 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, v8), arg4), v0);
            };
            let v9 = v3 - v3 * 100 / 10000;
            v6 = v9;
            if (v9 > v4) {
                v6 = v4;
            };
        };
        split_fees<T0>(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v3 - v6), v3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.quote_reserve, v1);
        arg0.deposited = arg0.deposited + v6;
        arg0.volume = arg0.volume + v3;
        if (0x2::table::contains<address, u64>(&arg0.deposits, v0)) {
            let v10 = 0x2::table::borrow_mut<address, u64>(&mut arg0.deposits, v0);
            *v10 = *v10 + v6;
        } else {
            0x2::table::add<address, u64>(&mut arg0.deposits, v0, v6);
        };
        let v11 = Deposited{
            curve     : 0x2::object::id<Curve<T0>>(arg0),
            who       : v0,
            sui_in    : v3,
            deposited : arg0.deposited,
        };
        0x2::event::emit<Deposited>(v11);
    }

    public fun deposit_of<T0>(arg0: &Curve<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.deposits, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.deposits, arg1)
        } else {
            0
        }
    }

    public fun graduate<T0>(arg0: &mut Curve<T0>, arg1: &AdminCap, arg2: &Factory, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(!arg0.graduated, 2);
        assert!(arg0.mode == 0 && arg0.sold >= 793100000000000 || arg0.mode == 1 && offering_filled<T0>(arg0), 6);
        arg0.graduated = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.burn_accrued), arg3), arg2.admin);
        let v0 = Graduated{
            curve        : 0x2::object::id<Curve<T0>>(arg0),
            sui_to_lp    : 0x2::balance::value<0x2::sui::SUI>(&arg0.quote_reserve),
            tokens_to_lp : 206900000000000,
        };
        0x2::event::emit<Graduated>(v0);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.tokens, 206900000000000), arg3), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.quote_reserve), arg3))
    }

    public fun graduated<T0>(arg0: &Curve<T0>) : bool {
        arg0.graduated
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id           : 0x2::object::new(arg0),
            admin        : 0x2::tx_context::sender(arg0),
            aero_fees    : 0x2::balance::zero<0x2::sui::SUI>(),
            launch_count : 0,
        };
        0x2::transfer::share_object<Factory>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun launch<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::CoinMetadata<T0>, arg2: vector<u8>, arg3: u64, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg1);
        launch_inner<T0>(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    public fun launch_inner<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: vector<u8>, arg2: u64, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg2 >= 1000000000 && arg2 <= 1000000000000000, 10);
        assert!(arg3 <= 2, 3);
        assert!(0x2::coin::total_supply<T0>(&arg0) == 0, 11);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg0);
        let (v0, v1) = if (arg3 == 1) {
            assert!(arg4 >= 3600000 && arg4 <= 2592000000, 13);
            (cost_for(arg2, 0, 0, 793100000000000), arg4)
        } else {
            (0, 0)
        };
        let v2 = Curve<T0>{
            id            : 0x2::object::new(arg5),
            creator       : 0x2::tx_context::sender(arg5),
            mode          : arg3,
            uri           : arg1,
            virt_quote    : arg2,
            sold          : 0,
            tokens        : 0x2::coin::mint_balance<T0>(&mut arg0, 1000000000000000),
            quote_reserve : 0x2::balance::zero<0x2::sui::SUI>(),
            creator_fees  : 0x2::balance::zero<0x2::sui::SUI>(),
            burn_accrued  : 0x2::balance::zero<0x2::sui::SUI>(),
            volume        : 0,
            graduated     : false,
            pool          : 0x1::option::none<0x2::object::ID>(),
            target        : v0,
            deposited     : 0,
            deadline_ms   : v1,
            deposits      : 0x2::table::new<address, u64>(arg5),
        };
        let v3 = 0x2::object::id<Curve<T0>>(&v2);
        let v4 = CurveCreated{
            curve       : v3,
            creator     : v2.creator,
            coin_type   : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            mode        : arg3,
            virt_quote  : arg2,
            target      : v0,
            deadline_ms : v1,
        };
        0x2::event::emit<CurveCreated>(v4);
        0x2::transfer::share_object<Curve<T0>>(v2);
        v3
    }

    public fun lock_position<T0, T1: store + key>(arg0: &mut Curve<T0>, arg1: &AdminCap, arg2: T1) {
        0x2::dynamic_object_field::add<vector<u8>, T1>(&mut arg0.id, b"lp", arg2);
    }

    fun offering_filled<T0>(arg0: &Curve<T0>) : bool {
        arg0.deposited >= arg0.target
    }

    public fun quote_buy(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg0 as u128);
        let v1 = 1073000000000000 - (arg1 as u128);
        let v2 = v0 * 1073000000000000 / (v0 + (arg2 as u128) + (arg3 as u128));
        if (v2 >= v1) {
            0
        } else {
            ((v1 - v2) as u64)
        }
    }

    public fun quote_sell(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg0 as u128);
        let v1 = v0 + (arg2 as u128);
        let v2 = v0 * 1073000000000000 / (1073000000000000 - (arg1 as u128) + (arg3 as u128));
        let v3 = if (v2 >= v1) {
            0
        } else {
            v1 - v2
        };
        let v4 = (v3 as u64);
        if (v4 > arg2) {
            arg2
        } else {
            v4
        }
    }

    public fun release_direct<T0>(arg0: &mut Curve<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.mode == 2 && !arg0.graduated, 3);
        arg0.graduated = true;
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.tokens);
        let v1 = Graduated{
            curve        : 0x2::object::id<Curve<T0>>(arg0),
            sui_to_lp    : 0,
            tokens_to_lp : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<Graduated>(v1);
        0x2::coin::from_balance<T0>(v0, arg2)
    }

    public fun reserve<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.quote_reserve)
    }

    public fun sell<T0>(arg0: &mut Curve<T0>, arg1: &mut Factory, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mode == 0, 3);
        assert!(!arg0.graduated, 2);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0 && v0 <= arg0.sold, 8);
        let v1 = quote_sell(arg0.virt_quote, arg0.sold, 0x2::balance::value<0x2::sui::SUI>(&arg0.quote_reserve), v0);
        assert!(v1 > 0, 8);
        let v2 = v1 * 100 / 10000;
        let v3 = v1 - v2;
        assert!(v3 >= arg3, 4);
        0x2::balance::join<T0>(&mut arg0.tokens, 0x2::coin::into_balance<T0>(arg2));
        let v4 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.quote_reserve, v1);
        split_fees<T0>(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v2), v1);
        arg0.sold = arg0.sold - v0;
        arg0.volume = arg0.volume + v1;
        let v5 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg4), v5);
        let v6 = Sold{
            curve     : 0x2::object::id<Curve<T0>>(arg0),
            seller    : v5,
            tokens_in : v0,
            sui_out   : v3,
            sold      : arg0.sold,
            reserve   : 0x2::balance::value<0x2::sui::SUI>(&arg0.quote_reserve),
        };
        0x2::event::emit<Sold>(v6);
    }

    public fun set_pool<T0>(arg0: &mut Curve<T0>, arg1: &AdminCap, arg2: 0x2::object::ID) {
        arg0.pool = 0x1::option::some<0x2::object::ID>(arg2);
        let v0 = PoolSet{
            curve : 0x2::object::id<Curve<T0>>(arg0),
            pool  : arg2,
        };
        0x2::event::emit<PoolSet>(v0);
    }

    public fun sold<T0>(arg0: &Curve<T0>) : u64 {
        arg0.sold
    }

    fun split_fees<T0>(arg0: &mut Curve<T0>, arg1: &mut Factory, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: u64) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg2, arg3 * 70 / 10000));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.burn_accrued, 0x2::balance::split<0x2::sui::SUI>(&mut arg2, arg3 * 10 / 10000));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.aero_fees, arg2);
    }

    public fun withdraw<T0>(arg0: &mut Curve<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mode == 1, 3);
        assert!(!offering_filled<T0>(arg0), 7);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, u64>(&arg0.deposits, v0), 12);
        let v1 = 0x2::table::remove<address, u64>(&mut arg0.deposits, v0);
        arg0.deposited = arg0.deposited - v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.quote_reserve, v1), arg1), v0);
        let v2 = Withdrawn{
            curve     : 0x2::object::id<Curve<T0>>(arg0),
            who       : v0,
            sui_out   : v1,
            deposited : arg0.deposited,
        };
        0x2::event::emit<Withdrawn>(v2);
    }

    // decompiled from Move bytecode v7
}

