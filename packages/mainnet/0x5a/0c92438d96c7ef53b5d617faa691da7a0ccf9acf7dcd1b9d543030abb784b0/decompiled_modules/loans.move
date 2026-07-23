module 0x5a0c92438d96c7ef53b5d617faa691da7a0ccf9acf7dcd1b9d543030abb784b0::loans {
    struct LoanBook has key {
        id: 0x2::object::UID,
        version: u64,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        loans: 0x2::table::Table<0x2::object::ID, Loan>,
        loans_open: u64,
        principal_outstanding: u64,
        fees_collected: u64,
        max_principal_mist: u64,
        fee_per_period_mist: u64,
        max_periods: u64,
        penalty_mist: u64,
        tip_mist: u64,
        paused: bool,
    }

    struct Loan has store {
        cap: 0x2::kiosk::PurchaseCap<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>,
        borrower: address,
        kiosk_id: 0x2::object::ID,
        principal: u64,
        fee_paid: u64,
        opened_ms: u64,
        due_ms: u64,
    }

    struct LoanAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LoanOpened has copy, drop {
        saint_id: 0x2::object::ID,
        borrower: address,
        kiosk_id: 0x2::object::ID,
        principal_atoms: u64,
        fee_atoms: u64,
        opened_ms: u64,
        due_ms: u64,
    }

    struct LoanRepaid has copy, drop {
        saint_id: 0x2::object::ID,
        borrower: address,
        repayer: address,
        principal_atoms: u64,
    }

    struct LoanLiquidated has copy, drop {
        saint_id: 0x2::object::ID,
        borrower: address,
        liquidator: address,
        principal_atoms: u64,
        recovered_atoms: u64,
        penalty_atoms: u64,
        tip_atoms: u64,
        surplus_atoms: u64,
    }

    struct BookDialsUpdated has copy, drop {
        max_principal_mist: u64,
        fee_per_period_mist: u64,
        max_periods: u64,
        penalty_mist: u64,
        tip_mist: u64,
        paused: bool,
    }

    struct BookLiquidityChanged has copy, drop {
        amount_atoms: u64,
        is_deposit: bool,
        liquidity_atoms: u64,
    }

    fun assert_version(arg0: &LoanBook) {
        assert!(arg0.version == 1, 0);
    }

    public fun deposit(arg0: &mut LoanBook, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_version(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = BookLiquidityChanged{
            amount_atoms    : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            is_deposit      : true,
            liquidity_atoms : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui),
        };
        0x2::event::emit<BookLiquidityChanged>(v0);
    }

    fun emit_dials(arg0: &LoanBook) {
        let v0 = BookDialsUpdated{
            max_principal_mist  : arg0.max_principal_mist,
            fee_per_period_mist : arg0.fee_per_period_mist,
            max_periods         : arg0.max_periods,
            penalty_mist        : arg0.penalty_mist,
            tip_mist            : arg0.tip_mist,
            paused              : arg0.paused,
        };
        0x2::event::emit<BookDialsUpdated>(v0);
    }

    public fun fee_per_period(arg0: &LoanBook) : u64 {
        arg0.fee_per_period_mist
    }

    public fun fees_collected(arg0: &LoanBook) : u64 {
        arg0.fees_collected
    }

    public fun has_loan(arg0: &LoanBook, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, Loan>(&arg0.loans, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LoanBook{
            id                    : 0x2::object::new(arg0),
            version               : 1,
            sui                   : 0x2::balance::zero<0x2::sui::SUI>(),
            loans                 : 0x2::table::new<0x2::object::ID, Loan>(arg0),
            loans_open            : 0,
            principal_outstanding : 0,
            fees_collected        : 0,
            max_principal_mist    : 14000000000,
            fee_per_period_mist   : 100000000,
            max_periods           : 4,
            penalty_mist          : 1000000000,
            tip_mist              : 200000000,
            paused                : true,
        };
        0x2::transfer::share_object<LoanBook>(v0);
        let v1 = LoanAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<LoanAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused(arg0: &LoanBook) : bool {
        arg0.paused
    }

    public fun liquidate(arg0: &mut LoanBook, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::SaintsConfig, arg3: &0x2::transfer_policy::TransferPolicy<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_version(arg0);
        assert!(0x2::table::contains<0x2::object::ID, Loan>(&arg0.loans, arg4), 7);
        let Loan {
            cap       : v0,
            borrower  : v1,
            kiosk_id  : _,
            principal : v3,
            fee_paid  : _,
            opened_ms : _,
            due_ms    : v6,
        } = 0x2::table::remove<0x2::object::ID, Loan>(&mut arg0.loans, arg4);
        assert!(0x2::clock::timestamp_ms(arg5) > v6, 9);
        let (v7, v8) = 0x2::kiosk::purchase_with_cap<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>(arg1, v0, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v9 = v8;
        let v10 = 0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::redeem(arg2, v7, &mut v9, arg6);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>(arg3, v9);
        let v14 = 0x2::coin::value<0x2::sui::SUI>(&v10);
        let v15 = 0x1::u64::min(v3 + arg0.penalty_mist, v14);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v10, v15, arg6)));
        let v16 = 0x1::u64::min(arg0.tip_mist, v15);
        arg0.loans_open = arg0.loans_open - 1;
        arg0.principal_outstanding = arg0.principal_outstanding - v3;
        let v17 = 0x2::coin::value<0x2::sui::SUI>(&v10);
        if (v17 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v10, v1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v10);
        };
        let v18 = LoanLiquidated{
            saint_id        : arg4,
            borrower        : v1,
            liquidator      : 0x2::tx_context::sender(arg6),
            principal_atoms : v3,
            recovered_atoms : v14,
            penalty_atoms   : v15 - 0x1::u64::min(v3, v15),
            tip_atoms       : v16,
            surplus_atoms   : v17,
        };
        0x2::event::emit<LoanLiquidated>(v18);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, v16), arg6)
    }

    public fun liquidity(arg0: &LoanBook) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui)
    }

    public fun loan_info(arg0: &LoanBook, arg1: 0x2::object::ID) : (address, 0x2::object::ID, u64, u64, u64, u64) {
        let v0 = 0x2::table::borrow<0x2::object::ID, Loan>(&arg0.loans, arg1);
        (v0.borrower, v0.kiosk_id, v0.principal, v0.fee_paid, v0.opened_ms, v0.due_ms)
    }

    public fun loans_open(arg0: &LoanBook) : u64 {
        arg0.loans_open
    }

    public fun max_periods(arg0: &LoanBook) : u64 {
        arg0.max_periods
    }

    public fun max_principal(arg0: &LoanBook) : u64 {
        arg0.max_principal_mist
    }

    entry fun migrate(arg0: &LoanAdminCap, arg1: &mut LoanBook) {
        assert!(arg1.version < 1, 11);
        arg1.version = 1;
    }

    public fun open_loan(arg0: &mut LoanBook, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_version(arg0);
        assert!(!arg0.paused, 1);
        assert!(arg5 >= 1 && arg5 <= arg0.max_periods, 2);
        let v0 = arg5 * arg0.fee_per_period_mist;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) == v0, 3);
        assert!(arg4 > 0, 4);
        assert!(arg4 <= arg0.max_principal_mist, 5);
        assert!(arg4 <= 0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::vault_value(0x2::kiosk::borrow<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>(arg1, arg2, arg3)) * 8000 / 10000, 5);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui) >= arg4, 6);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        let v2 = v1 + arg5 * 604800000;
        let v3 = 0x2::tx_context::sender(arg8);
        let v4 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        arg0.fees_collected = arg0.fees_collected + v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg6));
        let v5 = Loan{
            cap       : 0x2::kiosk::list_with_purchase_cap<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>(arg1, arg2, arg3, 0, arg8),
            borrower  : v3,
            kiosk_id  : v4,
            principal : arg4,
            fee_paid  : v0,
            opened_ms : v1,
            due_ms    : v2,
        };
        0x2::table::add<0x2::object::ID, Loan>(&mut arg0.loans, arg3, v5);
        arg0.loans_open = arg0.loans_open + 1;
        arg0.principal_outstanding = arg0.principal_outstanding + arg4;
        let v6 = LoanOpened{
            saint_id        : arg3,
            borrower        : v3,
            kiosk_id        : v4,
            principal_atoms : arg4,
            fee_atoms       : v0,
            opened_ms       : v1,
            due_ms          : v2,
        };
        0x2::event::emit<LoanOpened>(v6);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, arg4), arg8)
    }

    public fun penalty(arg0: &LoanBook) : u64 {
        arg0.penalty_mist
    }

    public fun period_ms() : u64 {
        604800000
    }

    public fun principal_outstanding(arg0: &LoanBook) : u64 {
        arg0.principal_outstanding
    }

    public fun repay(arg0: &mut LoanBook, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::table::contains<0x2::object::ID, Loan>(&arg0.loans, arg2), 7);
        let Loan {
            cap       : v0,
            borrower  : v1,
            kiosk_id  : _,
            principal : v3,
            fee_paid  : _,
            opened_ms : _,
            due_ms    : _,
        } = 0x2::table::remove<0x2::object::ID, Loan>(&mut arg0.loans, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == v3, 8);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        arg0.loans_open = arg0.loans_open - 1;
        arg0.principal_outstanding = arg0.principal_outstanding - v3;
        0x2::kiosk::return_purchase_cap<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>(arg1, v0);
        let v7 = LoanRepaid{
            saint_id        : arg2,
            borrower        : v1,
            repayer         : 0x2::tx_context::sender(arg4),
            principal_atoms : v3,
        };
        0x2::event::emit<LoanRepaid>(v7);
    }

    public fun set_dials(arg0: &LoanAdminCap, arg1: &mut LoanBook, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert_version(arg1);
        assert!(arg2 <= 14000000000, 10);
        assert!(arg3 <= 1000000000, 10);
        assert!(arg4 >= 1 && arg4 <= 8, 10);
        assert!(arg5 <= 2000000000, 10);
        assert!(arg6 <= arg5, 10);
        arg1.max_principal_mist = arg2;
        arg1.fee_per_period_mist = arg3;
        arg1.max_periods = arg4;
        arg1.penalty_mist = arg5;
        arg1.tip_mist = arg6;
        emit_dials(arg1);
    }

    public fun set_paused(arg0: &LoanAdminCap, arg1: &mut LoanBook, arg2: bool) {
        assert_version(arg1);
        arg1.paused = arg2;
        emit_dials(arg1);
    }

    public fun tip(arg0: &LoanBook) : u64 {
        arg0.tip_mist
    }

    public fun withdraw(arg0: &LoanAdminCap, arg1: &mut LoanBook, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_version(arg1);
        let v0 = BookLiquidityChanged{
            amount_atoms    : arg2,
            is_deposit      : false,
            liquidity_atoms : 0x2::balance::value<0x2::sui::SUI>(&arg1.sui),
        };
        0x2::event::emit<BookLiquidityChanged>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

