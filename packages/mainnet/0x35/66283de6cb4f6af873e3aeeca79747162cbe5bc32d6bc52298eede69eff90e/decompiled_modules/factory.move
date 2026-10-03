module 0x3566283de6cb4f6af873e3aeeca79747162cbe5bc32d6bc52298eede69eff90e::factory {
    struct Factory has key {
        id: 0x2::object::UID,
        admin: address,
        aero_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        launch_count: u64,
    }

    struct Curve has key {
        id: 0x2::object::UID,
        creator: address,
        name: vector<u8>,
        symbol: vector<u8>,
        uri: vector<u8>,
        virt_quote: u64,
        sold: u64,
        quote_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        balances: 0x2::table::Table<address, u64>,
        creator_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        burn_accrued: 0x2::balance::Balance<0x2::sui::SUI>,
        volume: u64,
        graduated: bool,
    }

    struct CurveCreated has copy, drop {
        curve: 0x2::object::ID,
        creator: address,
        symbol: vector<u8>,
        virt_quote: u64,
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

    struct Graduated has copy, drop {
        curve: 0x2::object::ID,
        sui_to_lp: u64,
    }

    public fun balance_of(arg0: &Curve, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.balances, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.balances, arg1)
        } else {
            0
        }
    }

    public fun buy(arg0: &mut Curve, arg1: &mut Factory, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
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
        split_fees(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v1 * 100 / 10000), v1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.quote_reserve, v2);
        arg0.sold = arg0.sold + v5;
        arg0.volume = arg0.volume + v1;
        if (0x2::table::contains<address, u64>(&arg0.balances, v7)) {
            let v10 = 0x2::table::borrow_mut<address, u64>(&mut arg0.balances, v7);
            *v10 = *v10 + v5;
        } else {
            0x2::table::add<address, u64>(&mut arg0.balances, v7, v5);
        };
        let v11 = Bought{
            curve      : 0x2::object::id<Curve>(arg0),
            buyer      : v7,
            sui_in     : v1,
            tokens_out : v5,
            sold       : arg0.sold,
            reserve    : 0x2::balance::value<0x2::sui::SUI>(&arg0.quote_reserve),
        };
        0x2::event::emit<Bought>(v11);
    }

    public fun claim_creator_fees(arg0: &mut Curve, arg1: &mut 0x2::tx_context::TxContext) {
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

    public fun create_curve(arg0: &mut Factory, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg4 >= 1000000000 && arg4 <= 1000000000000000, 10);
        arg0.launch_count = arg0.launch_count + 1;
        let v0 = Curve{
            id            : 0x2::object::new(arg5),
            creator       : 0x2::tx_context::sender(arg5),
            name          : arg1,
            symbol        : arg2,
            uri           : arg3,
            virt_quote    : arg4,
            sold          : 0,
            quote_reserve : 0x2::balance::zero<0x2::sui::SUI>(),
            balances      : 0x2::table::new<address, u64>(arg5),
            creator_fees  : 0x2::balance::zero<0x2::sui::SUI>(),
            burn_accrued  : 0x2::balance::zero<0x2::sui::SUI>(),
            volume        : 0,
            graduated     : false,
        };
        let v1 = 0x2::object::id<Curve>(&v0);
        let v2 = CurveCreated{
            curve      : v1,
            creator    : v0.creator,
            symbol     : v0.symbol,
            virt_quote : arg4,
        };
        0x2::event::emit<CurveCreated>(v2);
        0x2::transfer::share_object<Curve>(v0);
        v1
    }

    public fun curve_sell() : u64 {
        793100000000000
    }

    public fun graduate(arg0: &mut Curve, arg1: &Factory, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.graduated, 2);
        assert!(arg0.sold >= 793100000000000, 5);
        arg0.graduated = true;
        let v0 = Graduated{
            curve     : 0x2::object::id<Curve>(arg0),
            sui_to_lp : 0x2::balance::value<0x2::sui::SUI>(&arg0.quote_reserve),
        };
        0x2::event::emit<Graduated>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.quote_reserve), arg2), arg1.admin);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.burn_accrued), arg2), arg1.admin);
    }

    public fun graduated(arg0: &Curve) : bool {
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
    }

    public fun lp_tokens() : u64 {
        206900000000000
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

    public fun reserve(arg0: &Curve) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.quote_reserve)
    }

    public fun sell(arg0: &mut Curve, arg1: &mut Factory, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.graduated, 2);
        assert!(arg2 > 0, 8);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, u64>(&arg0.balances, v0), 11);
        assert!(*0x2::table::borrow<address, u64>(&arg0.balances, v0) >= arg2, 11);
        let v1 = quote_sell(arg0.virt_quote, arg0.sold, 0x2::balance::value<0x2::sui::SUI>(&arg0.quote_reserve), arg2);
        assert!(v1 > 0, 8);
        let v2 = v1 * 100 / 10000;
        let v3 = v1 - v2;
        assert!(v3 >= arg3, 4);
        let v4 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.quote_reserve, v1);
        split_fees(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v2), v1);
        let v5 = 0x2::table::borrow_mut<address, u64>(&mut arg0.balances, v0);
        *v5 = *v5 - arg2;
        if (*v5 == 0) {
            0x2::table::remove<address, u64>(&mut arg0.balances, v0);
        };
        arg0.sold = arg0.sold - arg2;
        arg0.volume = arg0.volume + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg4), v0);
        let v6 = Sold{
            curve     : 0x2::object::id<Curve>(arg0),
            seller    : v0,
            tokens_in : arg2,
            sui_out   : v3,
            sold      : arg0.sold,
            reserve   : 0x2::balance::value<0x2::sui::SUI>(&arg0.quote_reserve),
        };
        0x2::event::emit<Sold>(v6);
    }

    public fun sold(arg0: &Curve) : u64 {
        arg0.sold
    }

    fun split_fees(arg0: &mut Curve, arg1: &mut Factory, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: u64) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg2, arg3 * 70 / 10000));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.burn_accrued, 0x2::balance::split<0x2::sui::SUI>(&mut arg2, arg3 * 10 / 10000));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.aero_fees, arg2);
    }

    public fun total_supply() : u64 {
        1000000000000000
    }

    public fun virt_quote(arg0: &Curve) : u64 {
        arg0.virt_quote
    }

    // decompiled from Move bytecode v7
}

