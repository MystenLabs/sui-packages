module 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::market {
    struct Offer<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        lender: address,
        funds: 0x2::balance::Balance<T1>,
        price: u64,
        apr_bps: u64,
        term_ms: u64,
        min_loan: u64,
        total: u64,
        lent: u64,
        created_ms: u64,
        expires_ms: u64,
    }

    struct Request<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        borrower: address,
        collateral: 0x2::balance::Balance<T0>,
        amount: u64,
        apr_bps: u64,
        term_ms: u64,
        created_ms: u64,
        expires_ms: u64,
    }

    struct OfferListed<phantom T0, phantom T1> has copy, drop {
        offer_id: 0x2::object::ID,
        lender: address,
        total: u64,
        price: u64,
        apr_bps: u64,
        term_ms: u64,
        min_loan: u64,
        created_ms: u64,
        expires_ms: u64,
    }

    struct OfferTaken<phantom T0, phantom T1> has copy, drop {
        offer_id: 0x2::object::ID,
        loan_id: 0x2::object::ID,
        borrower: address,
        amount: u64,
        collateral: u64,
        left: u64,
    }

    struct OfferClosed<phantom T0, phantom T1> has copy, drop {
        offer_id: 0x2::object::ID,
        lender: address,
        reason: u8,
        returned: u64,
        closed_ms: u64,
    }

    struct RequestListed<phantom T0, phantom T1> has copy, drop {
        request_id: 0x2::object::ID,
        borrower: address,
        collateral: u64,
        amount: u64,
        apr_bps: u64,
        term_ms: u64,
        created_ms: u64,
        expires_ms: u64,
    }

    struct RequestClosed<phantom T0, phantom T1> has copy, drop {
        request_id: 0x2::object::ID,
        borrower: address,
        reason: u8,
        loan_id: 0x1::option::Option<0x2::object::ID>,
        returned: u64,
        closed_ms: u64,
    }

    public fun borrow<T0, T1>(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::Config, arg1: &mut Offer<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::assert_open(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 != arg1.lender, 13894731587865018393);
        assert!(0x2::clock::timestamp_ms(arg4) < arg1.expires_ms, 13893042742298935309);
        let v1 = 0x2::balance::value<T1>(&arg1.funds);
        assert!(arg3 > 0 && arg3 <= v1, 13892479800935186441);
        assert!(arg3 >= arg1.min_loan || arg3 == v1, 13893887180114362387);
        let v2 = v1 - arg3;
        assert!(v2 == 0 || v2 >= arg1.min_loan, 13893605713727455249);
        let v3 = collateral_for(arg3, arg1.price);
        assert!(v3 > 0, 13895013101496565787);
        assert!(0x2::coin::value<T0>(arg2) >= v3, 13894168680861007893);
        let v4 = 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, v3, arg5));
        let v5 = 0x2::coin::take<T1>(&mut arg1.funds, arg3, arg5);
        let v6 = &mut v5;
        let v7 = take_fee<T1>(arg0, v6, arg5);
        arg1.lent = arg1.lent + arg3;
        let v8 = OfferTaken<T0, T1>{
            offer_id   : 0x2::object::id<Offer<T0, T1>>(arg1),
            loan_id    : 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::loan::open<T0, T1>(0x2::object::id<Offer<T0, T1>>(arg1), arg1.lender, v0, v4, arg3, v7, loan_terms(arg0, arg1.apr_bps, arg1.term_ms), arg4, arg5),
            borrower   : v0,
            amount     : arg3,
            collateral : v3,
            left       : 0x2::balance::value<T1>(&arg1.funds),
        };
        0x2::event::emit<OfferTaken<T0, T1>>(v8);
        v5
    }

    fun assert_terms(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::Config, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg1 <= 100000, 13891917469456793605);
        assert!(arg2 >= 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::min_term_ms(arg0) && arg2 <= 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::max_term_ms(arg0), 13891635998774919171);
        assert!(arg3 > 0 && arg3 <= 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::max_listing_ms(arg0), 13892198953023569927);
    }

    public fun cancel_offer<T0, T1>(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::Config, arg1: Offer<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::assert_version(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg1.lender, 13892761387581177867);
        let v0 = if (0x2::balance::value<T1>(&arg1.funds) == 0) {
            0
        } else {
            1
        };
        close_offer<T0, T1>(arg1, v0, arg2, arg3);
    }

    public fun cancel_request<T0, T1>(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::Config, arg1: Request<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::assert_version(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg1.borrower, 13892761787013136395);
        close_request<T0, T1>(arg1, 1, arg2, arg3);
    }

    fun close_offer<T0, T1>(arg0: Offer<T0, T1>, arg1: u8, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let Offer {
            id         : v0,
            lender     : v1,
            funds      : v2,
            price      : _,
            apr_bps    : _,
            term_ms    : _,
            min_loan   : _,
            total      : _,
            lent       : _,
            created_ms : _,
            expires_ms : _,
        } = arg0;
        let v11 = v2;
        pay_out<T1>(v11, v1, arg3);
        let v12 = OfferClosed<T0, T1>{
            offer_id  : 0x2::object::id<Offer<T0, T1>>(&arg0),
            lender    : v1,
            reason    : arg1,
            returned  : 0x2::balance::value<T1>(&v11),
            closed_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OfferClosed<T0, T1>>(v12);
        0x2::object::delete(v0);
    }

    fun close_request<T0, T1>(arg0: Request<T0, T1>, arg1: u8, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let Request {
            id         : v0,
            borrower   : v1,
            collateral : v2,
            amount     : _,
            apr_bps    : _,
            term_ms    : _,
            created_ms : _,
            expires_ms : _,
        } = arg0;
        let v8 = v2;
        pay_out<T0>(v8, v1, arg3);
        let v9 = RequestClosed<T0, T1>{
            request_id : 0x2::object::id<Request<T0, T1>>(&arg0),
            borrower   : v1,
            reason     : arg1,
            loan_id    : 0x1::option::none<0x2::object::ID>(),
            returned   : 0x2::balance::value<T0>(&v8),
            closed_ms  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RequestClosed<T0, T1>>(v9);
        0x2::object::delete(v0);
    }

    public fun collateral_for(arg0: u64, arg1: u64) : u64 {
        0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::math::mul_div_up(arg0, 1000000000, arg1)
    }

    public fun fee_of(arg0: u64, arg1: u64) : u64 {
        0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::math::mul_div_up(arg0, arg1, 10000)
    }

    public fun fund_request<T0, T1>(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::Config, arg1: Request<T0, T1>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::assert_open(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 != arg1.borrower, 13894732013066780697);
        assert!(0x2::clock::timestamp_ms(arg3) < arg1.expires_ms, 13893043167500697613);
        assert!(0x2::coin::value<T1>(arg2) >= arg1.amount, 13894450546679873559);
        let v1 = 0x2::object::id<Request<T0, T1>>(&arg1);
        let Request {
            id         : v2,
            borrower   : v3,
            collateral : v4,
            amount     : v5,
            apr_bps    : v6,
            term_ms    : v7,
            created_ms : _,
            expires_ms : _,
        } = arg1;
        0x2::object::delete(v2);
        let v10 = 0x2::coin::split<T1>(arg2, v5, arg4);
        let v11 = &mut v10;
        let v12 = take_fee<T1>(arg0, v11, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v10, v3);
        let v13 = 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::loan::open<T0, T1>(v1, v0, v3, v4, v5, v12, loan_terms(arg0, v6, v7), arg3, arg4);
        let v14 = RequestClosed<T0, T1>{
            request_id : v1,
            borrower   : v3,
            reason     : 0,
            loan_id    : 0x1::option::some<0x2::object::ID>(v13),
            returned   : 0,
            closed_ms  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RequestClosed<T0, T1>>(v14);
        v13
    }

    fun loan_terms(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::Config, arg1: u64, arg2: u64) : 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::loan::Terms {
        0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::loan::terms(arg1, arg2, 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::grace_ms(arg0), 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::penalty_x(arg0), 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::interest_share_bps(arg0), 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::default_fee_bps(arg0), 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::fee_recipient(arg0))
    }

    public fun max_apr_bps() : u64 {
        100000
    }

    public fun offer_apr_bps<T0, T1>(arg0: &Offer<T0, T1>) : u64 {
        arg0.apr_bps
    }

    public fun offer_expires_ms<T0, T1>(arg0: &Offer<T0, T1>) : u64 {
        arg0.expires_ms
    }

    public fun offer_left<T0, T1>(arg0: &Offer<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.funds)
    }

    public fun offer_lender<T0, T1>(arg0: &Offer<T0, T1>) : address {
        arg0.lender
    }

    public fun offer_lent<T0, T1>(arg0: &Offer<T0, T1>) : u64 {
        arg0.lent
    }

    public fun offer_loan<T0, T1>(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::Config, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::assert_open(arg0);
        0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::assert_loan_allowed<T1>(arg0);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 13892479629136494601);
        assert!(arg2 > 0, 13891353733524094977);
        assert_terms(arg0, arg3, arg4, arg6);
        assert!(arg5 > 0 && arg5 <= v0, 13892479642021396489);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        let v2 = Offer<T0, T1>{
            id         : 0x2::object::new(arg8),
            lender     : 0x2::tx_context::sender(arg8),
            funds      : 0x2::coin::into_balance<T1>(arg1),
            price      : arg2,
            apr_bps    : arg3,
            term_ms    : arg4,
            min_loan   : arg5,
            total      : v0,
            lent       : 0,
            created_ms : v1,
            expires_ms : v1 + arg6,
        };
        let v3 = OfferListed<T0, T1>{
            offer_id   : 0x2::object::id<Offer<T0, T1>>(&v2),
            lender     : v2.lender,
            total      : v0,
            price      : arg2,
            apr_bps    : arg3,
            term_ms    : arg4,
            min_loan   : arg5,
            created_ms : v1,
            expires_ms : v2.expires_ms,
        };
        0x2::event::emit<OfferListed<T0, T1>>(v3);
        0x2::transfer::share_object<Offer<T0, T1>>(v2);
    }

    public fun offer_min_loan<T0, T1>(arg0: &Offer<T0, T1>) : u64 {
        arg0.min_loan
    }

    public fun offer_price<T0, T1>(arg0: &Offer<T0, T1>) : u64 {
        arg0.price
    }

    public fun offer_term_ms<T0, T1>(arg0: &Offer<T0, T1>) : u64 {
        arg0.term_ms
    }

    public fun offer_total<T0, T1>(arg0: &Offer<T0, T1>) : u64 {
        arg0.total
    }

    fun pay_out<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun price_scale() : u64 {
        1000000000
    }

    public fun request_amount<T0, T1>(arg0: &Request<T0, T1>) : u64 {
        arg0.amount
    }

    public fun request_apr_bps<T0, T1>(arg0: &Request<T0, T1>) : u64 {
        arg0.apr_bps
    }

    public fun request_borrower<T0, T1>(arg0: &Request<T0, T1>) : address {
        arg0.borrower
    }

    public fun request_collateral<T0, T1>(arg0: &Request<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral)
    }

    public fun request_expires_ms<T0, T1>(arg0: &Request<T0, T1>) : u64 {
        arg0.expires_ms
    }

    public fun request_loan<T0, T1>(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::Config, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::assert_open(arg0);
        0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::assert_loan_allowed<T1>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 13892480080108060681);
        assert!(arg2 > fee_of(arg2, 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::fee_bps(arg0)), 13895294834171445277);
        assert_terms(arg0, arg3, arg4, arg5);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = Request<T0, T1>{
            id         : 0x2::object::new(arg7),
            borrower   : 0x2::tx_context::sender(arg7),
            collateral : 0x2::coin::into_balance<T0>(arg1),
            amount     : arg2,
            apr_bps    : arg3,
            term_ms    : arg4,
            created_ms : v1,
            expires_ms : v1 + arg5,
        };
        let v3 = RequestListed<T0, T1>{
            request_id : 0x2::object::id<Request<T0, T1>>(&v2),
            borrower   : v2.borrower,
            collateral : v0,
            amount     : arg2,
            apr_bps    : arg3,
            term_ms    : arg4,
            created_ms : v1,
            expires_ms : v2.expires_ms,
        };
        0x2::event::emit<RequestListed<T0, T1>>(v3);
        0x2::transfer::share_object<Request<T0, T1>>(v2);
    }

    public fun request_term_ms<T0, T1>(arg0: &Request<T0, T1>) : u64 {
        arg0.term_ms
    }

    public fun sweep_offer<T0, T1>(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::Config, arg1: Offer<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::assert_version(arg0);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.expires_ms, 13893324371894599695);
        close_offer<T0, T1>(arg1, 2, arg2, arg3);
    }

    public fun sweep_request<T0, T1>(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::Config, arg1: Request<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::assert_version(arg0);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.expires_ms, 13893324767031590927);
        close_request<T0, T1>(arg1, 2, arg2, arg3);
    }

    fun take_fee<T0>(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::Config, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = fee_of(0x2::coin::value<T0>(arg1), 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::fee_bps(arg0));
        assert!(v0 < 0x2::coin::value<T0>(arg1), 13895295237898371101);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, v0, arg2), 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::fee_recipient(arg0));
        };
        v0
    }

    // decompiled from Move bytecode v7
}

