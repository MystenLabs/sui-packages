module 0x7d498659c79fd27867d160d7778a808bd66b320907dca79ae7e4c6b9e19ab093::factory {
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
        sold: u64,
        quote_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        balances: 0x2::table::Table<address, u64>,
        creator_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        burn_accrued: 0x2::balance::Balance<0x2::sui::SUI>,
        migrated: 0x2::table::Table<address, bool>,
        graduated: bool,
    }

    struct Offering has key {
        id: 0x2::object::UID,
        creator: address,
        name: vector<u8>,
        symbol: vector<u8>,
        uri: vector<u8>,
        price_mist_per_token: u64,
        hardcap: 0x2::balance::Balance<0x2::sui::SUI>,
        raised: u64,
        deposits: 0x2::table::Table<address, u64>,
        open: bool,
        graduated: bool,
    }

    struct CurveCreated has copy, drop {
        curve: 0x2::object::ID,
        creator: address,
        symbol: vector<u8>,
    }

    struct Bought has copy, drop {
        curve: 0x2::object::ID,
        buyer: address,
        sui_in: u64,
        tokens_out: u64,
    }

    struct Sold has copy, drop {
        curve: 0x2::object::ID,
        seller: address,
        tokens_in: u64,
        sui_out: u64,
    }

    struct Graduated has copy, drop {
        curve: 0x2::object::ID,
        sui_to_lp: u64,
    }

    struct OfferingCreated has copy, drop {
        offering: 0x2::object::ID,
        creator: address,
        symbol: vector<u8>,
    }

    struct Deposited has copy, drop {
        offering: 0x2::object::ID,
        buyer: address,
        sui_in: u64,
    }

    public fun aero_bps() : u64 {
        20
    }

    public fun balance_of(arg0: &Curve, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.balances, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.balances, arg1)
        } else {
            0
        }
    }

    public fun burn_bps() : u64 {
        10
    }

    public entry fun buy(arg0: &mut Curve, arg1: &mut Factory, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.graduated, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 8);
        let v1 = v0 * 100 / 10000;
        let v2 = quote_buy(arg0.sold, v0 - v1);
        assert!(v2 >= arg3, 4);
        assert!(arg0.sold + v2 <= 793100000000000, 5);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v4 = 0x2::balance::split<0x2::sui::SUI>(&mut v3, v1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v0 * 70 / 10000));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.burn_accrued, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v0 * 10 / 10000));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.aero_fees, v4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.quote_reserve, v3);
        arg0.sold = arg0.sold + v2;
        let v5 = 0x2::tx_context::sender(arg4);
        if (0x2::table::contains<address, u64>(&arg0.balances, v5)) {
            let v6 = 0x2::table::borrow_mut<address, u64>(&mut arg0.balances, v5);
            *v6 = *v6 + v2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.balances, v5, v2);
        };
        let v7 = Bought{
            curve      : 0x2::object::id<Curve>(arg0),
            buyer      : v5,
            sui_in     : v0,
            tokens_out : v2,
        };
        0x2::event::emit<Bought>(v7);
    }

    public entry fun claim_creator_fees(arg0: &mut Curve, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fees)), arg1), arg0.creator);
    }

    public entry fun close_offering(arg0: &mut Offering, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 1);
        assert!(arg0.open, 6);
        arg0.open = false;
    }

    public entry fun collect_aero_fees(arg0: &mut Factory, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.aero_fees), arg1), arg0.admin);
    }

    public entry fun create_curve(arg0: &mut Factory, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        arg0.launch_count = arg0.launch_count + 1;
        let v0 = Curve{
            id            : 0x2::object::new(arg4),
            creator       : 0x2::tx_context::sender(arg4),
            name          : arg1,
            symbol        : arg2,
            uri           : arg3,
            sold          : 0,
            quote_reserve : 0x2::balance::zero<0x2::sui::SUI>(),
            balances      : 0x2::table::new<address, u64>(arg4),
            creator_fees  : 0x2::balance::zero<0x2::sui::SUI>(),
            burn_accrued  : 0x2::balance::zero<0x2::sui::SUI>(),
            migrated      : 0x2::table::new<address, bool>(arg4),
            graduated     : false,
        };
        let v1 = CurveCreated{
            curve   : 0x2::object::id<Curve>(&v0),
            creator : v0.creator,
            symbol  : v0.symbol,
        };
        0x2::event::emit<CurveCreated>(v1);
        0x2::transfer::share_object<Curve>(v0);
    }

    public entry fun create_offering(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Offering{
            id                   : 0x2::object::new(arg4),
            creator              : 0x2::tx_context::sender(arg4),
            name                 : arg0,
            symbol               : arg1,
            uri                  : arg2,
            price_mist_per_token : arg3,
            hardcap              : 0x2::balance::zero<0x2::sui::SUI>(),
            raised               : 0,
            deposits             : 0x2::table::new<address, u64>(arg4),
            open                 : true,
            graduated            : false,
        };
        let v1 = OfferingCreated{
            offering : 0x2::object::id<Offering>(&v0),
            creator  : v0.creator,
            symbol   : v0.symbol,
        };
        0x2::event::emit<OfferingCreated>(v1);
        0x2::transfer::share_object<Offering>(v0);
    }

    public entry fun deposit(arg0: &mut Offering, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.open, 6);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 8);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.hardcap, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.raised = arg0.raised + v0;
        let v1 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, u64>(&arg0.deposits, v1)) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.deposits, v1);
            *v2 = *v2 + v0;
        } else {
            0x2::table::add<address, u64>(&mut arg0.deposits, v1, v0);
        };
        let v3 = Deposited{
            offering : 0x2::object::id<Offering>(arg0),
            buyer    : v1,
            sui_in   : v0,
        };
        0x2::event::emit<Deposited>(v3);
    }

    public entry fun graduate(arg0: &mut Curve, arg1: &Factory, arg2: &mut 0x2::tx_context::TxContext) {
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

    public fun offering_sell_pct() : u64 {
        80
    }

    public fun quote_buy(arg0: u64, arg1: u64) : u64 {
        let v0 = 1073000000000000 - (arg0 as u128);
        let v1 = 30000000000;
        ((v0 - v0 * v1 / (v1 + (arg1 as u128))) as u64)
    }

    public fun quote_sell(arg0: u64, arg1: u64) : u64 {
        let v0 = 1073000000000000 - (arg0 as u128);
        ((30000000000 - v0 * 30000000000 / (v0 + (arg1 as u128))) as u64)
    }

    public entry fun sell(arg0: &mut Curve, arg1: &mut Factory, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.graduated, 2);
        assert!(arg2 > 0, 8);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.balances, v0);
        assert!(*v1 >= arg2, 8);
        let v2 = quote_sell(arg0.sold, arg2);
        let v3 = v2 * 100 / 10000;
        let v4 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.quote_reserve, v2);
        let v5 = 0x2::balance::split<0x2::sui::SUI>(&mut v4, v3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v2 * 70 / 10000));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.burn_accrued, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v2 * 10 / 10000));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.aero_fees, v5);
        *v1 = *v1 - arg2;
        arg0.sold = arg0.sold - arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg4), v0);
        let v6 = Sold{
            curve     : 0x2::object::id<Curve>(arg0),
            seller    : v0,
            tokens_in : arg2,
            sui_out   : v2 - v3,
        };
        0x2::event::emit<Sold>(v6);
    }

    public fun sold(arg0: &Curve) : u64 {
        arg0.sold
    }

    public fun total_supply() : u64 {
        1000000000000000
    }

    public entry fun withdraw(arg0: &mut Offering, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.open, 6);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::table::remove<address, u64>(&mut arg0.deposits, v0);
        arg0.raised = arg0.raised - v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.hardcap, v1), arg1), v0);
    }

    // decompiled from Move bytecode v7
}

