module 0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::safe {
    struct SafeLoan<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        borrower: address,
        collateral: 0x2::balance::Balance<T0>,
        principal: u64,
        apr_bps: u64,
        start_ms: u64,
        due_ms: u64,
        grace_ms: u64,
        penalty_x: u64,
        liq_ltv_bps: u64,
        interest_share_bps: u64,
        fee_recipient: address,
    }

    struct LiquidationReceipt<phantom T0, phantom T1> {
        vault_id: 0x2::object::ID,
        principal: u64,
        required: u64,
    }

    struct SafeLent<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        loan_id: 0x2::object::ID,
        borrower: address,
        amount: u64,
        collateral: u64,
        price_q64: u128,
        liq_ltv_bps: u64,
        due_ms: u64,
    }

    struct SafeRepaid<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        loan_id: 0x2::object::ID,
        borrower: address,
        principal: u64,
        interest: u64,
        platform_cut: u64,
    }

    struct SafeLiquidated<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        loan_id: 0x2::object::ID,
        borrower: address,
        liquidator: address,
        debt: u64,
        seized: u64,
        required: u64,
        returned: u64,
        price_q64: u128,
        seize_price_q64: u128,
        late: bool,
    }

    struct LiquidationSettled<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        principal: u64,
        paid: u64,
        loss: u64,
    }

    public fun borrow<T0, T1>(arg0: &0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::config::Config, arg1: &mut 0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::vault::Vault<T0>, arg2: &0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::oracle::PriceFeed<T1, T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::vault::liq_ltv_bps<T0, T1>(arg1);
        assert!(v0 > 0, 13904019909907578881);
        assert!(0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::vault::withdraw_delay_ms<T0>(arg1) >= 0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::vault::safe_min_delay_ms(), 13890509123911417873);
        let (v1, v2, _, v4, v5) = 0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::vault::lend_out<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v6 = 0x2::clock::timestamp_ms(arg5);
        let v7 = SafeLoan<T1, T0>{
            id                 : 0x2::object::new(arg6),
            vault_id           : 0x2::object::id<0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::vault::Vault<T0>>(arg1),
            borrower           : 0x2::tx_context::sender(arg6),
            collateral         : v1,
            principal          : arg4,
            apr_bps            : v5,
            start_ms           : v6,
            due_ms             : v6 + 0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::vault::term_ms<T0>(arg1),
            grace_ms           : 0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::config::grace_ms(arg0),
            penalty_x          : 0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::config::penalty_x(arg0),
            liq_ltv_bps        : v0,
            interest_share_bps : 0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::config::interest_share_bps(arg0),
            fee_recipient      : 0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::config::fee_recipient(arg0),
        };
        assert!(!is_liquidatable<T1, T0>(&v7, v4, v6), 13895857238663102479);
        let v8 = SafeLent<T0, T1>{
            vault_id    : v7.vault_id,
            loan_id     : 0x2::object::id<SafeLoan<T1, T0>>(&v7),
            borrower    : v7.borrower,
            amount      : arg4,
            collateral  : 0x2::balance::value<T1>(&v7.collateral),
            price_q64   : v4,
            liq_ltv_bps : v0,
            due_ms      : v7.due_ms,
        };
        0x2::event::emit<SafeLent<T0, T1>>(v8);
        0x2::transfer::share_object<SafeLoan<T1, T0>>(v7);
        v2
    }

    public fun grace_ms<T0, T1>(arg0: &SafeLoan<T0, T1>) : u64 {
        arg0.grace_ms
    }

    public fun borrower<T0, T1>(arg0: &SafeLoan<T0, T1>) : address {
        arg0.borrower
    }

    public fun collateral_amount<T0, T1>(arg0: &SafeLoan<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral)
    }

    public fun debt_at<T0, T1>(arg0: &SafeLoan<T0, T1>, arg1: u64) : (u64, u64) {
        let v0 = arg0.due_ms + arg0.grace_ms;
        let v1 = if (arg1 > v0) {
            v0
        } else {
            arg1
        };
        let v2 = 0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::loan::interest_at(arg0.principal, arg0.apr_bps, arg0.start_ms, arg0.due_ms, arg0.penalty_x, v1);
        (arg0.principal + v2, v2)
    }

    fun destroy<T0, T1>(arg0: SafeLoan<T0, T1>) : (address, 0x2::balance::Balance<T0>, 0x2::object::ID) {
        let SafeLoan {
            id                 : v0,
            vault_id           : v1,
            borrower           : v2,
            collateral         : v3,
            principal          : _,
            apr_bps            : _,
            start_ms           : _,
            due_ms             : _,
            grace_ms           : _,
            penalty_x          : _,
            liq_ltv_bps        : _,
            interest_share_bps : _,
            fee_recipient      : _,
        } = arg0;
        0x2::object::delete(v0);
        (v2, v3, v1)
    }

    public fun due_ms<T0, T1>(arg0: &SafeLoan<T0, T1>) : u64 {
        arg0.due_ms
    }

    public fun is_liquidatable<T0, T1>(arg0: &SafeLoan<T0, T1>, arg1: u128, arg2: u64) : bool {
        if (arg2 >= arg0.due_ms + arg0.grace_ms) {
            return true
        };
        let (v0, _) = debt_at<T0, T1>(arg0, arg2);
        (v0 as u256) * (10000 as u256) << 64 > (0x2::balance::value<T0>(&arg0.collateral) as u256) * (arg1 as u256) * (arg0.liq_ltv_bps as u256)
    }

    public fun liq_ltv<T0, T1>(arg0: &SafeLoan<T0, T1>) : u64 {
        arg0.liq_ltv_bps
    }

    public fun liquidate<T0, T1>(arg0: &0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::config::Config, arg1: &0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::vault::Vault<T0>, arg2: SafeLoan<T1, T0>, arg3: &0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::oracle::PriceFeed<T1, T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, LiquidationReceipt<T0, T1>) {
        0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::config::assert_version(arg0);
        assert!(arg2.vault_id == 0x2::object::id<0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::vault::Vault<T0>>(arg1), 13904301771431477251);
        assert!(0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::vault::rule_feed_id<T0, T1>(arg1) == 0x2::object::id<0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::oracle::PriceFeed<T1, T0>>(arg3), 13901768500936572939);
        let v0 = 0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::oracle::liquidation_price<T1, T0>(arg3, arg4, arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(is_liquidatable<T1, T0>(&arg2, v0, v1), 13905146213541871625);
        let (v2, _) = debt_at<T1, T0>(&arg2, v1);
        let v4 = 0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::oracle::seize_price<T1, T0>(arg3, arg4, arg5);
        let (v5, v6) = liquidation_amounts(v2, 0x2::balance::value<T1>(&arg2.collateral), v4);
        let (v7, v8, v9) = destroy<T1, T0>(arg2);
        let v10 = v8;
        let v11 = 0x2::balance::value<T1>(&v10);
        if (v11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v10, arg5), v7);
        } else {
            0x2::balance::destroy_zero<T1>(v10);
        };
        let v12 = SafeLiquidated<T0, T1>{
            vault_id        : v9,
            loan_id         : 0x2::object::id<SafeLoan<T1, T0>>(&arg2),
            borrower        : v7,
            liquidator      : 0x2::tx_context::sender(arg5),
            debt            : v2,
            seized          : v5,
            required        : v6,
            returned        : v11,
            price_q64       : v0,
            seize_price_q64 : v4,
            late            : v1 >= arg2.due_ms + arg2.grace_ms,
        };
        0x2::event::emit<SafeLiquidated<T0, T1>>(v12);
        let v13 = LiquidationReceipt<T0, T1>{
            vault_id  : v9,
            principal : arg2.principal,
            required  : v6,
        };
        (0x2::coin::take<T1>(&mut v10, v5, arg5), v13)
    }

    public fun liquidation_amounts(arg0: u64, arg1: u64, arg2: u128) : (u64, u64) {
        let v0 = (arg2 as u256);
        let v1 = (((arg0 as u256) * ((10000 + 1000) as u256) / (10000 as u256) << 64) + v0 - 1) / v0;
        let v2 = if (v1 < (arg1 as u256)) {
            (v1 as u64)
        } else {
            arg1
        };
        let v3 = ((10000 + 600) as u256);
        (v2, (((((v2 as u256) * v0 >> 64) * (10000 as u256) + v3 - 1) / v3) as u64))
    }

    public fun principal<T0, T1>(arg0: &SafeLoan<T0, T1>) : u64 {
        arg0.principal
    }

    public fun receipt_required<T0, T1>(arg0: &LiquidationReceipt<T0, T1>) : u64 {
        arg0.required
    }

    public fun repay<T0, T1>(arg0: &mut 0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::vault::Vault<T0>, arg1: SafeLoan<T1, T0>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1.vault_id == 0x2::object::id<0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::vault::Vault<T0>>(arg0), 13904301603927752707);
        assert!(0x2::tx_context::sender(arg4) == arg1.borrower, 13904583083199561733);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 < arg1.due_ms + arg1.grace_ms, 13904864566766338055);
        let (v1, v2) = debt_at<T1, T0>(&arg1, v0);
        assert!(0x2::coin::value<T0>(arg2) >= v1, 13902049825589559309);
        let v3 = 0x2::coin::split<T0>(arg2, v1, arg4);
        let v4 = 0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::loan::platform_cut(v2, arg1.interest_share_bps);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v3, v4, arg4), arg1.fee_recipient);
        };
        0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::vault::book_return<T0, T1>(arg0, 0x2::coin::into_balance<T0>(v3), arg1.principal, arg3);
        let v5 = SafeRepaid<T0, T1>{
            vault_id     : arg1.vault_id,
            loan_id      : 0x2::object::id<SafeLoan<T1, T0>>(&arg1),
            borrower     : arg1.borrower,
            principal    : arg1.principal,
            interest     : v2,
            platform_cut : v4,
        };
        0x2::event::emit<SafeRepaid<T0, T1>>(v5);
        let (_, v7, _) = destroy<T1, T0>(arg1);
        0x2::coin::from_balance<T1>(v7, arg4)
    }

    public fun settle<T0, T1>(arg0: &0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::config::Config, arg1: &mut 0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::vault::Vault<T0>, arg2: LiquidationReceipt<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock) {
        0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::config::assert_version(arg0);
        let LiquidationReceipt {
            vault_id  : v0,
            principal : v1,
            required  : v2,
        } = arg2;
        assert!(v0 == 0x2::object::id<0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::vault::Vault<T0>>(arg1), 13904301990474809347);
        let v3 = 0x2::coin::value<T0>(&arg3);
        assert!(v3 >= v2, 13902331674228817939);
        0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::vault::book_return<T0, T1>(arg1, 0x2::coin::into_balance<T0>(arg3), v1, arg4);
        let v4 = if (v3 < v1) {
            v1 - v3
        } else {
            0
        };
        let v5 = LiquidationSettled<T0, T1>{
            vault_id  : v0,
            principal : v1,
            paid      : v3,
            loss      : v4,
        };
        0x2::event::emit<LiquidationSettled<T0, T1>>(v5);
    }

    public fun vault_id<T0, T1>(arg0: &SafeLoan<T0, T1>) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v7
}

