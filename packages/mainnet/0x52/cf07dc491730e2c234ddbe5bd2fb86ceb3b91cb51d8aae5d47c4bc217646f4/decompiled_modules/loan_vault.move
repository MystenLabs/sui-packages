module 0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::loan_vault {
    struct VaultRegistry has key {
        id: 0x2::object::UID,
        vaults: 0x2::table::Table<address, 0x2::object::ID>,
        total_vaults: u64,
        total_locked_value: u64,
    }

    struct LoanVault has store, key {
        id: 0x2::object::UID,
        borrower: address,
        loan_amount: u64,
        locked_collateral: 0x2::balance::Balance<0x2::sui::SUI>,
        interest_rate: u64,
        start_time: u64,
        lock_duration: u64,
        last_payment_timestamp: u64,
        remaining_balance: u64,
        balloon_required: bool,
        balloon_amount: u64,
        balloon_due_timestamp: u64,
        refinanced: bool,
        refinance_count: u64,
        yield_strategy: 0x1::option::Option<address>,
        accumulated_yield: u64,
        is_locked: bool,
        frozen: bool,
        property_value: u64,
        nft_receipt_id: 0x1::option::Option<0x2::object::ID>,
        auto_accelerate_enabled: bool,
        target_payoff_years: u64,
        monthly_payment_amount: u64,
        total_extra_principal_paid: u64,
        original_interest_rate: u64,
    }

    struct VaultNFT has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        borrower: address,
        loan_amount: u64,
        start_time: u64,
        property_address: vector<u8>,
        metadata_uri: vector<u8>,
    }

    struct PriceOracle has key {
        id: 0x2::object::UID,
        sui_usd_price: u64,
        last_update: u64,
        oracle_operator: address,
    }

    struct YieldStrategy has store, key {
        id: 0x2::object::UID,
        strategy_address: address,
        strategy_name: vector<u8>,
        apy: u64,
        risk_level: u8,
        active: bool,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        loan_amount: u64,
        collateral_amount: u64,
        lock_duration: u64,
        timestamp: u64,
    }

    struct CollateralLocked has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        amount: u64,
        timestamp: u64,
    }

    struct PaymentMade has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        payment_amount: u64,
        remaining_balance: u64,
        timestamp: u64,
    }

    struct BalloonPaymentTriggered has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        balloon_amount: u64,
        due_timestamp: u64,
    }

    struct VaultRefinanced has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        old_interest_rate: u64,
        new_interest_rate: u64,
        old_balance: u64,
        new_balance: u64,
        refinance_count: u64,
        timestamp: u64,
    }

    struct CollateralReleased has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        amount: u64,
        timestamp: u64,
    }

    struct YieldDelegated has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_address: address,
        amount: u64,
        timestamp: u64,
    }

    struct CLTVWarning has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        current_cltv: u64,
        threshold: u64,
        timestamp: u64,
    }

    struct AutoAccelerationEnabled has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        target_payoff_years: u64,
        monthly_payment_amount: u64,
        timestamp: u64,
    }

    struct ExtraPrincipalApplied has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        extra_principal: u64,
        new_remaining_balance: u64,
        total_extra_paid: u64,
        estimated_months_saved: u64,
        timestamp: u64,
    }

    struct OraclePriceUpdated has copy, drop {
        sui_usd_price: u64,
        timestamp: u64,
    }

    public entry fun add_collateral(arg0: &mut LoanVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.borrower, 3);
        assert!(!arg0.frozen, 12);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.locked_collateral, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    fun calculate_cltv(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg3 == 0) {
            return 0
        };
        arg0 * 100 / arg3
    }

    fun calculate_min_monthly_payment(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 120000
    }

    fun calculate_monthly_payment(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg2 * 12;
        if (v0 == 0) {
            return 0
        };
        arg0 / v0 + arg0 * arg1 / 120000
    }

    public entry fun create_vault(arg0: &mut VaultRegistry, arg1: &PriceOracle, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: u64, arg10: vector<u8>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg12);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.vaults, v0), 1);
        assert!(arg6 >= 15 && arg6 <= 20, 7);
        let v1 = 0x2::clock::timestamp_ms(arg11) / 1000;
        let v2 = arg6 * 31536000;
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(calculate_cltv(arg3, v3, arg1.sui_usd_price, arg4) <= 80, 10);
        let v4 = 0x2::object::new(arg12);
        let v5 = 0x2::object::uid_to_inner(&v4);
        let v6 = if (arg7) {
            v1 + arg9 * 31536000
        } else {
            0
        };
        let v7 = LoanVault{
            id                         : v4,
            borrower                   : v0,
            loan_amount                : arg3,
            locked_collateral          : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            interest_rate              : arg5,
            start_time                 : v1,
            lock_duration              : v2,
            last_payment_timestamp     : v1,
            remaining_balance          : arg3,
            balloon_required           : arg7,
            balloon_amount             : arg8,
            balloon_due_timestamp      : v6,
            refinanced                 : false,
            refinance_count            : 0,
            yield_strategy             : 0x1::option::none<address>(),
            accumulated_yield          : 0,
            is_locked                  : false,
            frozen                     : false,
            property_value             : arg4,
            nft_receipt_id             : 0x1::option::none<0x2::object::ID>(),
            auto_accelerate_enabled    : false,
            target_payoff_years        : arg6,
            monthly_payment_amount     : calculate_monthly_payment(arg3, arg5, arg6),
            total_extra_principal_paid : 0,
            original_interest_rate     : arg5,
        };
        let v8 = 0x2::object::new(arg12);
        0x2::object::uid_to_inner(&v8);
        let v9 = VaultNFT{
            id               : v8,
            vault_id         : v5,
            borrower         : v0,
            loan_amount      : arg3,
            start_time       : v1,
            property_address : arg10,
            metadata_uri     : b"ipfs://vault-metadata",
        };
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.vaults, v0, v5);
        arg0.total_vaults = arg0.total_vaults + 1;
        arg0.total_locked_value = arg0.total_locked_value + v3;
        let v10 = VaultCreated{
            vault_id          : v5,
            borrower          : v0,
            loan_amount       : arg3,
            collateral_amount : v3,
            lock_duration     : v2,
            timestamp         : v1,
        };
        0x2::event::emit<VaultCreated>(v10);
        let v11 = CollateralLocked{
            vault_id  : v5,
            borrower  : v0,
            amount    : v3,
            timestamp : v1,
        };
        0x2::event::emit<CollateralLocked>(v11);
        0x2::transfer::transfer<VaultNFT>(v9, v0);
        0x2::transfer::share_object<LoanVault>(v7);
    }

    public entry fun create_yield_strategy(arg0: address, arg1: vector<u8>, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = YieldStrategy{
            id               : 0x2::object::new(arg4),
            strategy_address : arg0,
            strategy_name    : arg1,
            apy              : arg2,
            risk_level       : arg3,
            active           : true,
        };
        0x2::transfer::share_object<YieldStrategy>(v0);
    }

    public entry fun delegate_to_strategy(arg0: &mut LoanVault, arg1: &YieldStrategy, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.borrower, 3);
        assert!(!arg0.frozen, 12);
        assert!(arg1.active, 3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.locked_collateral) >= arg2, 5);
        arg0.yield_strategy = 0x1::option::some<address>(arg1.strategy_address);
        let v0 = YieldDelegated{
            vault_id         : 0x2::object::uid_to_inner(&arg0.id),
            strategy_address : arg1.strategy_address,
            amount           : arg2,
            timestamp        : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<YieldDelegated>(v0);
    }

    public entry fun disable_auto_acceleration(arg0: &mut LoanVault, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.borrower, 3);
        arg0.auto_accelerate_enabled = false;
    }

    public entry fun enable_auto_acceleration(arg0: &mut LoanVault, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.borrower, 3);
        assert!(!arg0.frozen, 12);
        arg0.auto_accelerate_enabled = true;
        arg0.target_payoff_years = arg1;
        let v0 = AutoAccelerationEnabled{
            vault_id               : 0x2::object::uid_to_inner(&arg0.id),
            borrower               : arg0.borrower,
            target_payoff_years    : arg1,
            monthly_payment_amount : arg0.monthly_payment_amount,
            timestamp              : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<AutoAccelerationEnabled>(v0);
    }

    fun estimate_months_saved(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        if (calculate_min_monthly_payment(arg0, arg1) == 0) {
            return 0
        };
        arg2 * 12 / arg0 / 240
    }

    public entry fun freeze_vault(arg0: &mut LoanVault, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.frozen = true;
    }

    public fun get_acceleration_stats(arg0: &LoanVault) : (bool, u64, u64, u64, u64) {
        (arg0.auto_accelerate_enabled, arg0.target_payoff_years, arg0.monthly_payment_amount, arg0.total_extra_principal_paid, arg0.original_interest_rate)
    }

    public fun get_oracle_price(arg0: &PriceOracle) : u64 {
        arg0.sui_usd_price
    }

    public fun get_vault_details(arg0: &LoanVault) : (address, u64, u64, u64, u64, u64, bool, u64) {
        (arg0.borrower, arg0.loan_amount, arg0.remaining_balance, arg0.interest_rate, arg0.start_time, arg0.lock_duration, arg0.refinanced, arg0.refinance_count)
    }

    public fun get_vault_status(arg0: &LoanVault, arg1: &PriceOracle) : (u64, u64, u64, bool) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.locked_collateral);
        (arg0.remaining_balance, v0 * arg1.sui_usd_price / 100, calculate_cltv(arg0.remaining_balance, v0, arg1.sui_usd_price, arg0.property_value), arg0.is_locked)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultRegistry{
            id                 : 0x2::object::new(arg0),
            vaults             : 0x2::table::new<address, 0x2::object::ID>(arg0),
            total_vaults       : 0,
            total_locked_value : 0,
        };
        0x2::transfer::share_object<VaultRegistry>(v0);
        let v1 = PriceOracle{
            id              : 0x2::object::new(arg0),
            sui_usd_price   : 100,
            last_update     : 0,
            oracle_operator : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<PriceOracle>(v1);
    }

    public entry fun make_payment(arg0: &mut LoanVault, arg1: &PriceOracle, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.borrower, 3);
        assert!(!arg0.frozen, 12);
        assert!(!arg0.is_locked, 13);
        arg0.is_locked = true;
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v2 = v0 * arg1.sui_usd_price / 100;
        assert!(v2 > 0, 5);
        let v3 = calculate_min_monthly_payment(arg0.remaining_balance, arg0.interest_rate);
        let v4 = 0;
        if (arg0.auto_accelerate_enabled && v2 > v3) {
            let v5 = v2 - v3;
            v4 = v5;
            arg0.total_extra_principal_paid = arg0.total_extra_principal_paid + v5;
        };
        if (v2 >= arg0.remaining_balance) {
            arg0.remaining_balance = 0;
        } else {
            arg0.remaining_balance = arg0.remaining_balance - v2;
        };
        arg0.last_payment_timestamp = v1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.locked_collateral, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        if (v4 > 0) {
            let v6 = ExtraPrincipalApplied{
                vault_id               : 0x2::object::uid_to_inner(&arg0.id),
                borrower               : arg0.borrower,
                extra_principal        : v4,
                new_remaining_balance  : arg0.remaining_balance,
                total_extra_paid       : arg0.total_extra_principal_paid,
                estimated_months_saved : estimate_months_saved(arg0.remaining_balance, arg0.interest_rate, v4),
                timestamp              : v1,
            };
            0x2::event::emit<ExtraPrincipalApplied>(v6);
        };
        let v7 = calculate_cltv(arg0.remaining_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.locked_collateral), arg1.sui_usd_price, arg0.property_value);
        if (v7 >= 75) {
            let v8 = CLTVWarning{
                vault_id     : 0x2::object::uid_to_inner(&arg0.id),
                borrower     : arg0.borrower,
                current_cltv : v7,
                threshold    : 75,
                timestamp    : v1,
            };
            0x2::event::emit<CLTVWarning>(v8);
        };
        let v9 = PaymentMade{
            vault_id          : 0x2::object::uid_to_inner(&arg0.id),
            borrower          : arg0.borrower,
            payment_amount    : v0,
            remaining_balance : arg0.remaining_balance,
            timestamp         : v1,
        };
        0x2::event::emit<PaymentMade>(v9);
        arg0.is_locked = false;
    }

    public entry fun refinance_vault(arg0: &mut LoanVault, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.borrower, 3);
        assert!(!arg0.frozen, 12);
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = arg0.interest_rate;
        if (arg0.refinance_count == 0) {
            arg0.original_interest_rate = arg0.interest_rate;
        };
        arg0.interest_rate = arg1;
        arg0.refinanced = true;
        arg0.refinance_count = arg0.refinance_count + 1;
        if (arg2 && arg1 < v1) {
            arg0.auto_accelerate_enabled = true;
            let v2 = AutoAccelerationEnabled{
                vault_id               : 0x2::object::uid_to_inner(&arg0.id),
                borrower               : arg0.borrower,
                target_payoff_years    : arg0.target_payoff_years,
                monthly_payment_amount : arg0.monthly_payment_amount,
                timestamp              : v0,
            };
            0x2::event::emit<AutoAccelerationEnabled>(v2);
        };
        let v3 = VaultRefinanced{
            vault_id          : 0x2::object::uid_to_inner(&arg0.id),
            borrower          : arg0.borrower,
            old_interest_rate : v1,
            new_interest_rate : arg1,
            old_balance       : arg0.remaining_balance,
            new_balance       : arg0.remaining_balance,
            refinance_count   : arg0.refinance_count,
            timestamp         : v0,
        };
        0x2::event::emit<VaultRefinanced>(v3);
    }

    public entry fun release_collateral(arg0: &mut VaultRegistry, arg1: LoanVault, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.borrower, 3);
        assert!(arg1.remaining_balance == 0, 6);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(v0 >= arg1.start_time + arg1.lock_duration || arg1.remaining_balance == 0, 4);
        let v1 = arg1.borrower;
        let LoanVault {
            id                         : v2,
            borrower                   : _,
            loan_amount                : _,
            locked_collateral          : v5,
            interest_rate              : _,
            start_time                 : _,
            lock_duration              : _,
            last_payment_timestamp     : _,
            remaining_balance          : _,
            balloon_required           : _,
            balloon_amount             : _,
            balloon_due_timestamp      : _,
            refinanced                 : _,
            refinance_count            : _,
            yield_strategy             : _,
            accumulated_yield          : _,
            is_locked                  : _,
            frozen                     : _,
            property_value             : _,
            nft_receipt_id             : _,
            auto_accelerate_enabled    : _,
            target_payoff_years        : _,
            monthly_payment_amount     : _,
            total_extra_principal_paid : _,
            original_interest_rate     : _,
        } = arg1;
        let v27 = v5;
        let v28 = 0x2::balance::value<0x2::sui::SUI>(&v27);
        0x2::table::remove<address, 0x2::object::ID>(&mut arg0.vaults, v1);
        arg0.total_vaults = arg0.total_vaults - 1;
        arg0.total_locked_value = arg0.total_locked_value - v28;
        let v29 = CollateralReleased{
            vault_id  : 0x2::object::uid_to_inner(&arg1.id),
            borrower  : v1,
            amount    : v28,
            timestamp : v0,
        };
        0x2::event::emit<CollateralReleased>(v29);
        0x2::object::delete(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v27, arg3), v1);
    }

    public entry fun trigger_balloon_payment(arg0: &mut LoanVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.borrower, 3);
        assert!(arg0.balloon_required, 9);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 >= arg0.balloon_due_timestamp, 9);
        let v0 = BalloonPaymentTriggered{
            vault_id       : 0x2::object::uid_to_inner(&arg0.id),
            borrower       : arg0.borrower,
            balloon_amount : arg0.balloon_amount,
            due_timestamp  : arg0.balloon_due_timestamp,
        };
        0x2::event::emit<BalloonPaymentTriggered>(v0);
    }

    public entry fun unfreeze_vault(arg0: &mut LoanVault, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.frozen = false;
    }

    public entry fun update_oracle_price(arg0: &mut PriceOracle, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.oracle_operator, 3);
        assert!(arg1 > 0, 11);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        arg0.sui_usd_price = arg1;
        arg0.last_update = v0;
        let v1 = OraclePriceUpdated{
            sui_usd_price : arg1,
            timestamp     : v0,
        };
        0x2::event::emit<OraclePriceUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

