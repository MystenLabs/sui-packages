module 0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::closing_disbursement {
    struct ClosingVault has store, key {
        id: 0x2::object::UID,
        mortgage_id: u64,
        vault_address: address,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        total_amount: u64,
        title_cleared: bool,
        inspection_passed: bool,
        appraisal_completed: bool,
        borrower_signed: bool,
        dao_approved: bool,
        funds_disbursed: bool,
        borrower: address,
        lender: address,
        dao_treasury: address,
        property_address: vector<u8>,
        closing_date: u64,
        created_at: u64,
    }

    struct DisbursementRecipient has drop, store {
        recipient_type: vector<u8>,
        recipient_address: address,
        amount: u64,
        paid: bool,
    }

    struct DisbursementPlan has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        recipients: vector<DisbursementRecipient>,
        total_amount: u64,
        platform_fees_total: u64,
        treasury_address: address,
        executed: bool,
        created_by: address,
        created_at: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DAOApprovalCap has store, key {
        id: 0x2::object::UID,
        dao_address: address,
    }

    struct ClosingVaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        mortgage_id: u64,
        borrower: address,
        total_amount: u64,
        closing_date: u64,
    }

    struct FundsDeposited has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        new_balance: u64,
    }

    struct ValidationCompleted has copy, drop {
        vault_id: 0x2::object::ID,
        validation_type: vector<u8>,
        completed_by: address,
    }

    struct DisbursementPlanCreated has copy, drop {
        plan_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        total_recipients: u64,
        total_amount: u64,
        platform_fees: u64,
        treasury_address: address,
    }

    struct FundsDisbursed has copy, drop {
        vault_id: 0x2::object::ID,
        recipient_type: vector<u8>,
        recipient_address: address,
        amount: u64,
        timestamp: u64,
    }

    struct PlatformFeesCollected has copy, drop {
        vault_id: 0x2::object::ID,
        total_fees: u64,
        treasury_address: address,
        timestamp: u64,
    }

    struct ClosingCompleted has copy, drop {
        vault_id: 0x2::object::ID,
        mortgage_id: u64,
        total_disbursed: u64,
        platform_fees_collected: u64,
        timestamp: u64,
    }

    public entry fun approve_appraisal(arg0: &mut ClosingVault, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.appraisal_completed = true;
        let v0 = ValidationCompleted{
            vault_id        : 0x2::object::uid_to_inner(&arg0.id),
            validation_type : b"appraisal_completed",
            completed_by    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ValidationCompleted>(v0);
    }

    public entry fun approve_inspection(arg0: &mut ClosingVault, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.inspection_passed = true;
        let v0 = ValidationCompleted{
            vault_id        : 0x2::object::uid_to_inner(&arg0.id),
            validation_type : b"inspection_passed",
            completed_by    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ValidationCompleted>(v0);
    }

    public entry fun approve_title_clearance(arg0: &mut ClosingVault, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.title_cleared = true;
        let v0 = ValidationCompleted{
            vault_id        : 0x2::object::uid_to_inner(&arg0.id),
            validation_type : b"title_cleared",
            completed_by    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ValidationCompleted>(v0);
    }

    public entry fun borrower_sign_closing(arg0: &mut ClosingVault, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.borrower, 1);
        arg0.borrower_signed = true;
        let v0 = ValidationCompleted{
            vault_id        : 0x2::object::uid_to_inner(&arg0.id),
            validation_type : b"borrower_signed",
            completed_by    : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<ValidationCompleted>(v0);
    }

    public entry fun create_closing_vault(arg0: u64, arg1: address, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ClosingVault{
            id                  : 0x2::object::new(arg4),
            mortgage_id         : arg0,
            vault_address       : 0x2::tx_context::sender(arg4),
            funds               : 0x2::balance::zero<0x2::sui::SUI>(),
            total_amount        : 0,
            title_cleared       : false,
            inspection_passed   : false,
            appraisal_completed : false,
            borrower_signed     : false,
            dao_approved        : false,
            funds_disbursed     : false,
            borrower            : 0x2::tx_context::sender(arg4),
            lender              : 0x2::tx_context::sender(arg4),
            dao_treasury        : arg1,
            property_address    : arg2,
            closing_date        : arg3,
            created_at          : 0x2::tx_context::epoch(arg4),
        };
        let v1 = ClosingVaultCreated{
            vault_id     : 0x2::object::uid_to_inner(&v0.id),
            mortgage_id  : arg0,
            borrower     : 0x2::tx_context::sender(arg4),
            total_amount : 0,
            closing_date : arg3,
        };
        0x2::event::emit<ClosingVaultCreated>(v1);
        0x2::transfer::share_object<ClosingVault>(v0);
    }

    public entry fun dao_approve_disbursement(arg0: &mut ClosingVault, arg1: &DAOApprovalCap, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.dao_approved = true;
        let v0 = ValidationCompleted{
            vault_id        : 0x2::object::uid_to_inner(&arg0.id),
            validation_type : b"dao_approved",
            completed_by    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ValidationCompleted>(v0);
    }

    public entry fun deposit_funds(arg0: &mut ClosingVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.funds, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_amount = arg0.total_amount + v0;
        let v1 = FundsDeposited{
            vault_id    : 0x2::object::uid_to_inner(&arg0.id),
            amount      : v0,
            new_balance : arg0.total_amount,
        };
        0x2::event::emit<FundsDeposited>(v1);
    }

    public entry fun execute_disbursement(arg0: &mut ClosingVault, arg1: &AdminCap, arg2: address, arg3: u64, arg4: address, arg5: u64, arg6: address, arg7: u64, arg8: address, arg9: u64, arg10: address, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.funds_disbursed, 2);
        assert!(arg0.title_cleared, 5);
        assert!(arg0.inspection_passed, 5);
        assert!(arg0.appraisal_completed, 5);
        assert!(arg0.borrower_signed, 5);
        assert!(arg0.dao_approved, 5);
        let v0 = arg3 + arg5 + arg7 + arg9 + arg11 + arg12;
        assert!(arg0.total_amount >= v0, 3);
        let v1 = 0x2::tx_context::epoch(arg13);
        if (arg3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.funds, arg3, arg13), arg2);
            let v2 = FundsDisbursed{
                vault_id          : 0x2::object::uid_to_inner(&arg0.id),
                recipient_type    : b"builder",
                recipient_address : arg2,
                amount            : arg3,
                timestamp         : v1,
            };
            0x2::event::emit<FundsDisbursed>(v2);
        };
        if (arg5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.funds, arg5, arg13), arg4);
            let v3 = FundsDisbursed{
                vault_id          : 0x2::object::uid_to_inner(&arg0.id),
                recipient_type    : b"seller_agent",
                recipient_address : arg4,
                amount            : arg5,
                timestamp         : v1,
            };
            0x2::event::emit<FundsDisbursed>(v3);
        };
        if (arg7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.funds, arg7, arg13), arg6);
            let v4 = FundsDisbursed{
                vault_id          : 0x2::object::uid_to_inner(&arg0.id),
                recipient_type    : b"buyer_agent",
                recipient_address : arg6,
                amount            : arg7,
                timestamp         : v1,
            };
            0x2::event::emit<FundsDisbursed>(v4);
        };
        if (arg9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.funds, arg9, arg13), arg8);
            let v5 = FundsDisbursed{
                vault_id          : 0x2::object::uid_to_inner(&arg0.id),
                recipient_type    : b"lien_holder",
                recipient_address : arg8,
                amount            : arg9,
                timestamp         : v1,
            };
            0x2::event::emit<FundsDisbursed>(v5);
        };
        if (arg11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.funds, arg11, arg13), arg10);
            let v6 = FundsDisbursed{
                vault_id          : 0x2::object::uid_to_inner(&arg0.id),
                recipient_type    : b"lien_holder",
                recipient_address : arg10,
                amount            : arg11,
                timestamp         : v1,
            };
            0x2::event::emit<FundsDisbursed>(v6);
        };
        if (arg12 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.funds, arg12, arg13), arg0.dao_treasury);
            let v7 = PlatformFeesCollected{
                vault_id         : 0x2::object::uid_to_inner(&arg0.id),
                total_fees       : arg12,
                treasury_address : arg0.dao_treasury,
                timestamp        : v1,
            };
            0x2::event::emit<PlatformFeesCollected>(v7);
        };
        arg0.funds_disbursed = true;
        let v8 = ClosingCompleted{
            vault_id                : 0x2::object::uid_to_inner(&arg0.id),
            mortgage_id             : arg0.mortgage_id,
            total_disbursed         : v0,
            platform_fees_collected : arg12,
            timestamp               : v1,
        };
        0x2::event::emit<ClosingCompleted>(v8);
    }

    public fun get_mortgage_id(arg0: &ClosingVault) : u64 {
        arg0.mortgage_id
    }

    public fun get_vault_balance(arg0: &ClosingVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.funds)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_disbursed(arg0: &ClosingVault) : bool {
        arg0.funds_disbursed
    }

    public fun is_ready_for_disbursement(arg0: &ClosingVault) : bool {
        if (arg0.title_cleared) {
            if (arg0.inspection_passed) {
                if (arg0.appraisal_completed) {
                    if (arg0.borrower_signed) {
                        if (arg0.dao_approved) {
                            !arg0.funds_disbursed
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

