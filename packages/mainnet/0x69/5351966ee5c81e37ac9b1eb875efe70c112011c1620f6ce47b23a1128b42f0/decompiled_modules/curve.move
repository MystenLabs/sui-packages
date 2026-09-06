module 0x695351966ee5c81e37ac9b1eb875efe70c112011c1620f6ce47b23a1128b42f0::curve {
    struct LaunchpadConfig has key {
        id: 0x2::object::UID,
        launches: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Curve<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        tokens: 0x2::balance::Balance<T0>,
        treasury: 0x2::coin::TreasuryCap<T0>,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        creator_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        protocol_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        tokens_sold: u64,
        sui_collected: u64,
        initial_price: u64,
        price_increment: u64,
        graduation_threshold: u64,
        creator_tax_bps: u64,
        graduation_ready: bool,
        graduated: bool,
    }

    struct CurveCreated has copy, drop {
        curve_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        creator: address,
        total_supply: u64,
        initial_price: u64,
        price_increment: u64,
        graduation_threshold: u64,
        creator_tax_bps: u64,
    }

    struct Bought has copy, drop {
        curve_id: 0x2::object::ID,
        buyer: address,
        sui_in: u64,
        fee: u64,
        tokens_out: u64,
        tokens_sold: u64,
        sui_collected: u64,
    }

    struct Sold has copy, drop {
        curve_id: 0x2::object::ID,
        seller: address,
        tokens_in: u64,
        sui_out: u64,
        fee: u64,
        tokens_sold: u64,
        sui_collected: u64,
    }

    struct GraduationReady has copy, drop {
        curve_id: 0x2::object::ID,
        sui_collected: u64,
    }

    struct Graduated has copy, drop {
        curve_id: 0x2::object::ID,
        tokens_remaining: u64,
        sui_reserve: u64,
    }

    struct FeesClaimed has copy, drop {
        curve_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        is_creator: bool,
    }

    public fun buy<T0>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.graduation_ready && !arg0.graduated, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 3);
        let v1 = v0 * (25 + arg0.creator_tax_bps) / 10000;
        let v2 = v0 - v1;
        let v3 = tokens_for_sui(arg0.initial_price, arg0.price_increment, arg0.tokens_sold, v2);
        let v4 = v3;
        let v5 = 0x2::balance::value<T0>(&arg0.tokens);
        if (v3 > v5) {
            v4 = v5;
        };
        assert!(v4 > 0 && v4 >= arg2, 2);
        let v6 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v7 = &mut v6;
        split_fee<T0>(arg0, v7, v0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, v6);
        arg0.tokens_sold = arg0.tokens_sold + v4;
        arg0.sui_collected = arg0.sui_collected + v2;
        if (arg0.sui_collected >= arg0.graduation_threshold) {
            arg0.graduation_ready = true;
            let v8 = GraduationReady{
                curve_id      : 0x2::object::id<Curve<T0>>(arg0),
                sui_collected : arg0.sui_collected,
            };
            0x2::event::emit<GraduationReady>(v8);
        };
        let v9 = Bought{
            curve_id      : 0x2::object::id<Curve<T0>>(arg0),
            buyer         : 0x2::tx_context::sender(arg3),
            sui_in        : v0,
            fee           : v1,
            tokens_out    : v4,
            tokens_sold   : arg0.tokens_sold,
            sui_collected : arg0.sui_collected,
        };
        0x2::event::emit<Bought>(v9);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.tokens, v4), arg3)
    }

    public fun claim_creator_fees<T0>(arg0: &mut Curve<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 6);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fees);
        assert!(v0 > 0, 3);
        let v1 = FeesClaimed{
            curve_id   : 0x2::object::id<Curve<T0>>(arg0),
            recipient  : 0x2::tx_context::sender(arg1),
            amount     : v0,
            is_creator : true,
        };
        0x2::event::emit<FeesClaimed>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.creator_fees), arg1)
    }

    public fun claim_protocol_fees<T0>(arg0: &AdminCap, arg1: &mut Curve<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.protocol_fees);
        assert!(v0 > 0, 3);
        let v1 = FeesClaimed{
            curve_id   : 0x2::object::id<Curve<T0>>(arg1),
            recipient  : 0x2::tx_context::sender(arg2),
            amount     : v0,
            is_creator : false,
        };
        0x2::event::emit<FeesClaimed>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.protocol_fees), arg2)
    }

    fun cost_for_tokens(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg3 as u256);
        let v1 = (arg1 as u256);
        let v2 = (arg0 as u256) * 1000000000 + v1 * (arg2 as u256);
        if ((v2 * v0 + v1 * v0 * v0 / 2) % 1000000000 * 1000000000 > 0) {
            (((v2 * v0 + v1 * v0 * v0 / 2) / 1000000000 * 1000000000 + 1) as u64)
        } else {
            (((v2 * v0 + v1 * v0 * v0 / 2) / 1000000000 * 1000000000) as u64)
        }
    }

    public fun create_curve<T0>(arg0: &mut LaunchpadConfig, arg1: 0x2::coin::TreasuryCap<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = if (arg2 > 0) {
            if (arg3 > 0) {
                arg5 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
        assert!(arg6 <= 200, 5);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 7);
        let v1 = Curve<T0>{
            id                   : 0x2::object::new(arg7),
            creator              : 0x2::tx_context::sender(arg7),
            tokens               : 0x2::coin::mint_balance<T0>(&mut arg1, arg2),
            treasury             : arg1,
            sui_reserve          : 0x2::balance::zero<0x2::sui::SUI>(),
            creator_fees         : 0x2::balance::zero<0x2::sui::SUI>(),
            protocol_fees        : 0x2::balance::zero<0x2::sui::SUI>(),
            tokens_sold          : 0,
            sui_collected        : 0,
            initial_price        : arg3,
            price_increment      : arg4,
            graduation_threshold : arg5,
            creator_tax_bps      : arg6,
            graduation_ready     : false,
            graduated            : false,
        };
        let v2 = 0x2::object::id<Curve<T0>>(&v1);
        arg0.launches = arg0.launches + 1;
        let v3 = CurveCreated{
            curve_id             : v2,
            coin_type            : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            creator              : 0x2::tx_context::sender(arg7),
            total_supply         : arg2,
            initial_price        : arg3,
            price_increment      : arg4,
            graduation_threshold : arg5,
            creator_tax_bps      : arg6,
        };
        0x2::event::emit<CurveCreated>(v3);
        0x2::transfer::share_object<Curve<T0>>(v1);
        v2
    }

    public fun creator<T0>(arg0: &Curve<T0>) : address {
        arg0.creator
    }

    public fun creator_fees_accrued<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fees)
    }

    public fun current_price<T0>(arg0: &Curve<T0>) : u64 {
        (((arg0.initial_price as u256) + (arg0.price_increment as u256) * (arg0.tokens_sold as u256) / 1000000000) as u64)
    }

    public fun extract_graduation_liquidity<T0>(arg0: &AdminCap, arg1: &mut Curve<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg1.graduated, 4);
        (0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.tokens), arg2), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.sui_reserve), arg2))
    }

    public fun graduate<T0>(arg0: &mut Curve<T0>) {
        assert!(arg0.graduation_ready, 4);
        assert!(!arg0.graduated, 9);
        arg0.graduated = true;
        let v0 = Graduated{
            curve_id         : 0x2::object::id<Curve<T0>>(arg0),
            tokens_remaining : 0x2::balance::value<T0>(&arg0.tokens),
            sui_reserve      : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve),
        };
        0x2::event::emit<Graduated>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LaunchpadConfig{
            id       : 0x2::object::new(arg0),
            launches : 0,
        };
        0x2::transfer::share_object<LaunchpadConfig>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun inventory<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.tokens)
    }

    public fun is_graduated<T0>(arg0: &Curve<T0>) : bool {
        arg0.graduated
    }

    public fun is_graduation_ready<T0>(arg0: &Curve<T0>) : bool {
        arg0.graduation_ready
    }

    fun isqrt(arg0: u256) : u256 {
        if (arg0 < 2) {
            return arg0
        };
        let v0 = arg0 / 2 + 1;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 / 2;
        };
        arg0
    }

    public fun protocol_fees_accrued<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.protocol_fees)
    }

    public fun quote_buy<T0>(arg0: &Curve<T0>, arg1: u64) : u64 {
        tokens_for_sui(arg0.initial_price, arg0.price_increment, arg0.tokens_sold, arg1 - arg1 * (25 + arg0.creator_tax_bps) / 10000)
    }

    public fun quote_cost<T0>(arg0: &Curve<T0>, arg1: u64) : u64 {
        cost_for_tokens(arg0.initial_price, arg0.price_increment, arg0.tokens_sold, arg1)
    }

    public fun quote_sell<T0>(arg0: &Curve<T0>, arg1: u64) : u64 {
        let v0 = sui_for_tokens(arg0.initial_price, arg0.price_increment, arg0.tokens_sold, arg1);
        v0 - v0 * (25 + arg0.creator_tax_bps) / 10000
    }

    public fun reserve<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve)
    }

    public fun sell<T0>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!arg0.graduation_ready && !arg0.graduated, 1);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3);
        assert!(v0 <= arg0.tokens_sold, 8);
        let v1 = sui_for_tokens(arg0.initial_price, arg0.price_increment, arg0.tokens_sold, v0);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve);
        let v3 = if (v1 > v2) {
            v2
        } else {
            v1
        };
        let v4 = v3 * (25 + arg0.creator_tax_bps) / 10000;
        let v5 = v3 - v4;
        assert!(v5 > 0 && v5 >= arg2, 2);
        0x2::balance::join<T0>(&mut arg0.tokens, 0x2::coin::into_balance<T0>(arg1));
        arg0.tokens_sold = arg0.tokens_sold - v0;
        arg0.sui_collected = arg0.sui_collected - v3;
        let v6 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v3);
        let v7 = &mut v6;
        split_fee<T0>(arg0, v7, v3);
        let v8 = Sold{
            curve_id      : 0x2::object::id<Curve<T0>>(arg0),
            seller        : 0x2::tx_context::sender(arg3),
            tokens_in     : v0,
            sui_out       : v5,
            fee           : v4,
            tokens_sold   : arg0.tokens_sold,
            sui_collected : arg0.sui_collected,
        };
        0x2::event::emit<Sold>(v8);
        0x2::coin::from_balance<0x2::sui::SUI>(v6, arg3)
    }

    fun split_fee<T0>(arg0: &mut Curve<T0>, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: u64) {
        let v0 = arg2 * 25 / 10000;
        let v1 = v0 * 8000 / 10000;
        let v2 = v1 + arg2 * arg0.creator_tax_bps / 10000;
        let v3 = v0 - v1;
        if (v2 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::balance::split<0x2::sui::SUI>(arg1, v2));
        };
        if (v3 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.protocol_fees, 0x2::balance::split<0x2::sui::SUI>(arg1, v3));
        };
    }

    public fun sui_collected<T0>(arg0: &Curve<T0>) : u64 {
        arg0.sui_collected
    }

    fun sui_for_tokens(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg3 as u256);
        let v1 = (arg1 as u256);
        (((((arg0 as u256) * 1000000000 + v1 * (arg2 as u256)) * v0 - v1 * v0 * v0 / 2) / 1000000000 * 1000000000) as u64)
    }

    fun tokens_for_sui(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg3 as u256);
        if (v0 == 0) {
            return 0
        };
        let v1 = (arg1 as u256);
        let v2 = (arg0 as u256) * 1000000000 + v1 * (arg2 as u256);
        if (v1 == 0) {
            return ((v0 * 1000000000 * 1000000000 / v2) as u64)
        };
        (((isqrt(v2 * v2 + 2 * v1 * v0 * 1000000000 * 1000000000) - v2) / v1) as u64)
    }

    public fun tokens_sold<T0>(arg0: &Curve<T0>) : u64 {
        arg0.tokens_sold
    }

    // decompiled from Move bytecode v7
}

