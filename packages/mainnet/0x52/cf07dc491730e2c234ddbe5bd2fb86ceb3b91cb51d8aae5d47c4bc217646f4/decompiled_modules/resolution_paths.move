module 0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::resolution_paths {
    struct ResolutionRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        dao_treasury: address,
        total_resolutions: u64,
        active_resolutions: u64,
        completed_resolutions: u64,
        total_savings_usd: u64,
        protocol_fees_collected: u64,
        deed_in_lieu_enabled: bool,
        short_sale_enabled: bool,
        assumption_enabled: bool,
        relocation_credit_min: u64,
        relocation_credit_max: u64,
        short_sale_fee_bps: u64,
        assumption_fee_bps: u64,
    }

    struct ResolutionRequest has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        borrower: address,
        option_type: u8,
        status: u8,
        loan_balance: u64,
        property_value: u64,
        collateral_value: u64,
        hardship_reason: 0x1::string::String,
        ai_recommendation: u8,
        ai_confidence: u64,
        dao_proposal_id: 0x1::option::Option<0x2::object::ID>,
        initiated_at: u64,
        expires_at: u64,
        completed_at: 0x1::option::Option<u64>,
    }

    struct DeedInLieuDetails has store, key {
        id: 0x2::object::UID,
        resolution_id: 0x2::object::ID,
        rent_back_approved: bool,
        rent_back_months: u64,
        rent_back_monthly_amount: u64,
        relocation_credit_approved: bool,
        relocation_credit_amount: u64,
        relocation_disbursed: bool,
        deficiency_waived: bool,
        deficiency_amount: u64,
        vault_nft_transferred: bool,
        thirty_day_deadline: u64,
        borrower_vacate_date: 0x1::option::Option<u64>,
    }

    struct ShortSaleDetails has store, key {
        id: 0x2::object::UID,
        resolution_id: 0x2::object::ID,
        ai_recommended_price: u64,
        list_price: u64,
        current_offer: u64,
        current_buyer: 0x1::option::Option<address>,
        final_sale_price: 0x1::option::Option<u64>,
        buyer_address: 0x1::option::Option<address>,
        deficiency_forgiveness_approved: bool,
        deficiency_forgiveness_amount: u64,
        protocol_fee_amount: u64,
        protocol_fee_collected: bool,
        listing_expiry: u64,
    }

    struct AssumptionDetails has store, key {
        id: 0x2::object::UID,
        resolution_id: 0x2::object::ID,
        new_borrower: 0x1::option::Option<address>,
        new_borrower_qualified: bool,
        new_borrower_score: u64,
        new_borrower_dti: u64,
        loan_balance_assumed: u64,
        interest_rate_assumed: u64,
        remaining_term_months: u64,
        assumption_fee_amount: u64,
        assumption_fee_paid: bool,
        equity_amount: u64,
        equity_to_original_borrower: u64,
        equity_disbursed: bool,
        original_borrower_released: bool,
    }

    struct DAOResolutionProposal has store, key {
        id: 0x2::object::UID,
        resolution_id: 0x2::object::ID,
        proposal_type: 0x1::string::String,
        description: 0x1::string::String,
        financial_impact: u64,
        votes_for: u64,
        votes_against: u64,
        voting_end: u64,
        quorum_reached: bool,
        executed: bool,
    }

    struct ResolutionInitiated has copy, drop {
        resolution_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        borrower: address,
        option_type: u8,
        loan_balance: u64,
        timestamp: u64,
    }

    struct ResolutionStatusChanged has copy, drop {
        resolution_id: 0x2::object::ID,
        previous_status: u8,
        new_status: u8,
        actor: address,
        timestamp: u64,
    }

    struct DeedTransferCompleted has copy, drop {
        resolution_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        original_borrower: address,
        relocation_credit: u64,
        deficiency_waived: bool,
        timestamp: u64,
    }

    struct ShortSaleCompleted has copy, drop {
        resolution_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        sale_price: u64,
        buyer: address,
        protocol_fee: u64,
        deficiency_forgiven: u64,
        timestamp: u64,
    }

    struct LoanAssumptionCompleted has copy, drop {
        resolution_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        original_borrower: address,
        new_borrower: address,
        loan_balance: u64,
        assumption_fee: u64,
        equity_to_seller: u64,
        timestamp: u64,
    }

    struct RelocationCreditDisbursed has copy, drop {
        resolution_id: 0x2::object::ID,
        borrower: address,
        amount: u64,
        timestamp: u64,
    }

    public fun apply_for_assumption(arg0: &mut ResolutionRequest, arg1: &mut AssumptionDetails, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0 || arg0.status == 1, 2);
        assert!(0x2::clock::timestamp_ms(arg4) < arg0.expires_at, 3);
        arg1.new_borrower = 0x1::option::some<address>(0x2::tx_context::sender(arg5));
        arg1.new_borrower_score = arg2;
        arg1.new_borrower_dti = arg3;
        arg0.status = 1;
    }

    public fun approve_buyer_qualification(arg0: &ResolutionRegistry, arg1: &mut ResolutionRequest, arg2: &mut AssumptionDetails, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 1);
        assert!(arg1.status == 1, 2);
        arg2.new_borrower_qualified = arg3;
        if (arg3) {
            arg1.status = 3;
        } else {
            arg1.status = 4;
        };
        let v0 = ResolutionStatusChanged{
            resolution_id   : 0x2::object::id<ResolutionRequest>(arg1),
            previous_status : 1,
            new_status      : arg1.status,
            actor           : 0x2::tx_context::sender(arg5),
            timestamp       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ResolutionStatusChanged>(v0);
    }

    public fun approve_deed_transfer(arg0: &mut ResolutionRegistry, arg1: &mut ResolutionRequest, arg2: &mut DeedInLieuDetails, arg3: bool, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg10) == arg0.admin, 1);
        assert!(arg1.status == 0 || arg1.status == 1, 2);
        arg2.rent_back_approved = arg3;
        if (arg3) {
            arg2.rent_back_months = arg4;
            arg2.rent_back_monthly_amount = arg5;
        };
        arg2.relocation_credit_approved = arg6;
        if (arg6) {
            let v0 = if (arg7 < arg0.relocation_credit_min) {
                arg0.relocation_credit_min
            } else if (arg7 > arg0.relocation_credit_max) {
                arg0.relocation_credit_max
            } else {
                arg7
            };
            arg2.relocation_credit_amount = v0;
        };
        arg2.deficiency_waived = arg8;
        arg1.status = 3;
        let v1 = ResolutionStatusChanged{
            resolution_id   : 0x2::object::id<ResolutionRequest>(arg1),
            previous_status : arg1.status,
            new_status      : 3,
            actor           : 0x2::tx_context::sender(arg10),
            timestamp       : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<ResolutionStatusChanged>(v1);
    }

    public fun cancel_resolution(arg0: &mut ResolutionRegistry, arg1: &mut ResolutionRequest, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.borrower || v0 == arg0.admin, 1);
        assert!(arg1.status != 6 && arg1.status != 7, 2);
        arg1.status = 7;
        arg0.active_resolutions = arg0.active_resolutions - 1;
        let v1 = ResolutionStatusChanged{
            resolution_id   : 0x2::object::id<ResolutionRequest>(arg1),
            previous_status : arg1.status,
            new_status      : 7,
            actor           : v0,
            timestamp       : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ResolutionStatusChanged>(v1);
    }

    public fun complete_assumption<T0>(arg0: &mut ResolutionRegistry, arg1: &mut ResolutionRequest, arg2: &mut AssumptionDetails, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 3, 2);
        assert!(arg2.new_borrower_qualified, 6);
        assert!(0x1::option::is_some<address>(&arg2.new_borrower), 6);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = arg1.borrower;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, arg0.dao_treasury);
        arg2.assumption_fee_paid = true;
        arg0.protocol_fees_collected = arg0.protocol_fees_collected + arg2.assumption_fee_amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, v1);
        arg2.equity_disbursed = true;
        arg2.original_borrower_released = true;
        arg1.status = 6;
        arg1.completed_at = 0x1::option::some<u64>(v0);
        arg0.active_resolutions = arg0.active_resolutions - 1;
        arg0.completed_resolutions = arg0.completed_resolutions + 1;
        arg0.total_savings_usd = arg0.total_savings_usd + 15000000000000;
        let v2 = LoanAssumptionCompleted{
            resolution_id     : 0x2::object::id<ResolutionRequest>(arg1),
            vault_id          : arg1.vault_id,
            original_borrower : v1,
            new_borrower      : *0x1::option::borrow<address>(&arg2.new_borrower),
            loan_balance      : arg2.loan_balance_assumed,
            assumption_fee    : arg2.assumption_fee_amount,
            equity_to_seller  : arg2.equity_to_original_borrower,
            timestamp         : v0,
        };
        0x2::event::emit<LoanAssumptionCompleted>(v2);
    }

    public fun complete_deed_transfer<T0>(arg0: &mut ResolutionRegistry, arg1: &mut ResolutionRequest, arg2: &mut DeedInLieuDetails, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 3, 2);
        assert!(arg2.relocation_credit_approved, 9);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = arg1.borrower;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v1);
        arg2.relocation_disbursed = true;
        arg1.status = 6;
        arg1.completed_at = 0x1::option::some<u64>(v0);
        arg2.vault_nft_transferred = true;
        arg0.active_resolutions = arg0.active_resolutions - 1;
        arg0.completed_resolutions = arg0.completed_resolutions + 1;
        arg0.total_savings_usd = arg0.total_savings_usd + 25000000000000;
        let v2 = DeedTransferCompleted{
            resolution_id     : 0x2::object::id<ResolutionRequest>(arg1),
            vault_id          : arg1.vault_id,
            original_borrower : v1,
            relocation_credit : arg2.relocation_credit_amount,
            deficiency_waived : arg2.deficiency_waived,
            timestamp         : v0,
        };
        0x2::event::emit<DeedTransferCompleted>(v2);
        let v3 = RelocationCreditDisbursed{
            resolution_id : 0x2::object::id<ResolutionRequest>(arg1),
            borrower      : v1,
            amount        : arg2.relocation_credit_amount,
            timestamp     : v0,
        };
        0x2::event::emit<RelocationCreditDisbursed>(v3);
    }

    public fun complete_short_sale<T0>(arg0: &mut ResolutionRegistry, arg1: &mut ResolutionRequest, arg2: &mut ShortSaleDetails, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 5, 2);
        assert!(0x1::option::is_some<address>(&arg2.current_buyer), 6);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = *0x1::option::borrow<address>(&arg2.current_buyer);
        let v2 = 0x2::coin::value<T0>(&arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, arg0.dao_treasury);
        arg2.protocol_fee_collected = true;
        arg0.protocol_fees_collected = arg0.protocol_fees_collected + arg2.protocol_fee_amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, arg0.dao_treasury);
        arg2.final_sale_price = 0x1::option::some<u64>(v2);
        arg2.buyer_address = 0x1::option::some<address>(v1);
        if (arg1.loan_balance > v2 && arg2.deficiency_forgiveness_approved) {
            arg2.deficiency_forgiveness_amount = arg1.loan_balance - v2;
        };
        arg1.status = 6;
        arg1.completed_at = 0x1::option::some<u64>(v0);
        arg0.active_resolutions = arg0.active_resolutions - 1;
        arg0.completed_resolutions = arg0.completed_resolutions + 1;
        arg0.total_savings_usd = arg0.total_savings_usd + 20000000000000;
        let v3 = ShortSaleCompleted{
            resolution_id       : 0x2::object::id<ResolutionRequest>(arg1),
            vault_id            : arg1.vault_id,
            sale_price          : v2,
            buyer               : v1,
            protocol_fee        : arg2.protocol_fee_amount,
            deficiency_forgiven : arg2.deficiency_forgiveness_amount,
            timestamp           : v0,
        };
        0x2::event::emit<ShortSaleCompleted>(v3);
    }

    public fun get_borrower(arg0: &ResolutionRequest) : address {
        arg0.borrower
    }

    public fun get_option_type(arg0: &ResolutionRequest) : u8 {
        arg0.option_type
    }

    public fun get_registry_stats(arg0: &ResolutionRegistry) : (u64, u64, u64, u64) {
        (arg0.total_resolutions, arg0.active_resolutions, arg0.completed_resolutions, arg0.protocol_fees_collected)
    }

    public fun get_resolution_status(arg0: &ResolutionRequest) : u8 {
        arg0.status
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ResolutionRegistry{
            id                      : 0x2::object::new(arg0),
            admin                   : 0x2::tx_context::sender(arg0),
            dao_treasury            : 0x2::tx_context::sender(arg0),
            total_resolutions       : 0,
            active_resolutions      : 0,
            completed_resolutions   : 0,
            total_savings_usd       : 0,
            protocol_fees_collected : 0,
            deed_in_lieu_enabled    : true,
            short_sale_enabled      : true,
            assumption_enabled      : true,
            relocation_credit_min   : 2000000000000,
            relocation_credit_max   : 5000000000000,
            short_sale_fee_bps      : 200,
            assumption_fee_bps      : 100,
        };
        0x2::transfer::share_object<ResolutionRegistry>(v0);
    }

    public fun initiate_assumption(arg0: &mut ResolutionRegistry, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (ResolutionRequest, AssumptionDetails) {
        assert!(arg0.assumption_enabled, 10);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        let v2 = ResolutionRequest{
            id                : 0x2::object::new(arg8),
            vault_id          : arg1,
            borrower          : v0,
            option_type       : 3,
            status            : 0,
            loan_balance      : arg2,
            property_value    : arg3,
            collateral_value  : arg4,
            hardship_reason   : 0x1::string::utf8(b"Loan Assumption Request"),
            ai_recommendation : 0,
            ai_confidence     : 0,
            dao_proposal_id   : 0x1::option::none<0x2::object::ID>(),
            initiated_at      : v1,
            expires_at        : v1 + 5184000000,
            completed_at      : 0x1::option::none<u64>(),
        };
        let v3 = 0x2::object::id<ResolutionRequest>(&v2);
        let v4 = if (arg3 > arg2) {
            arg3 - arg2
        } else {
            0
        };
        let v5 = AssumptionDetails{
            id                          : 0x2::object::new(arg8),
            resolution_id               : v3,
            new_borrower                : 0x1::option::none<address>(),
            new_borrower_qualified      : false,
            new_borrower_score          : 0,
            new_borrower_dti            : 0,
            loan_balance_assumed        : arg2,
            interest_rate_assumed       : arg5,
            remaining_term_months       : arg6,
            assumption_fee_amount       : arg2 * arg0.assumption_fee_bps / 10000,
            assumption_fee_paid         : false,
            equity_amount               : v4,
            equity_to_original_borrower : v4 * 90 / 100,
            equity_disbursed            : false,
            original_borrower_released  : false,
        };
        arg0.total_resolutions = arg0.total_resolutions + 1;
        arg0.active_resolutions = arg0.active_resolutions + 1;
        let v6 = ResolutionInitiated{
            resolution_id : v3,
            vault_id      : arg1,
            borrower      : v0,
            option_type   : 3,
            loan_balance  : arg2,
            timestamp     : v1,
        };
        0x2::event::emit<ResolutionInitiated>(v6);
        (v2, v5)
    }

    public fun initiate_deed_in_lieu(arg0: &mut ResolutionRegistry, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (ResolutionRequest, DeedInLieuDetails) {
        assert!(arg0.deed_in_lieu_enabled, 10);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        let v2 = 2592000000;
        let v3 = ResolutionRequest{
            id                : 0x2::object::new(arg9),
            vault_id          : arg1,
            borrower          : v0,
            option_type       : 1,
            status            : 0,
            loan_balance      : arg2,
            property_value    : arg3,
            collateral_value  : arg4,
            hardship_reason   : 0x1::string::utf8(arg5),
            ai_recommendation : 0,
            ai_confidence     : 0,
            dao_proposal_id   : 0x1::option::none<0x2::object::ID>(),
            initiated_at      : v1,
            expires_at        : v1 + v2,
            completed_at      : 0x1::option::none<u64>(),
        };
        let v4 = 0x2::object::id<ResolutionRequest>(&v3);
        let v5 = if (arg2 > arg3) {
            arg2 - arg3
        } else {
            0
        };
        let v6 = if (arg6) {
            6
        } else {
            0
        };
        let v7 = if (arg7) {
            arg0.relocation_credit_min
        } else {
            0
        };
        let v8 = DeedInLieuDetails{
            id                         : 0x2::object::new(arg9),
            resolution_id              : v4,
            rent_back_approved         : false,
            rent_back_months           : v6,
            rent_back_monthly_amount   : 0,
            relocation_credit_approved : false,
            relocation_credit_amount   : v7,
            relocation_disbursed       : false,
            deficiency_waived          : false,
            deficiency_amount          : v5,
            vault_nft_transferred      : false,
            thirty_day_deadline        : v1 + v2,
            borrower_vacate_date       : 0x1::option::none<u64>(),
        };
        arg0.total_resolutions = arg0.total_resolutions + 1;
        arg0.active_resolutions = arg0.active_resolutions + 1;
        let v9 = ResolutionInitiated{
            resolution_id : v4,
            vault_id      : arg1,
            borrower      : v0,
            option_type   : 1,
            loan_balance  : arg2,
            timestamp     : v1,
        };
        0x2::event::emit<ResolutionInitiated>(v9);
        (v3, v8)
    }

    public fun initiate_short_sale(arg0: &mut ResolutionRegistry, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (ResolutionRequest, ShortSaleDetails) {
        assert!(arg0.short_sale_enabled, 10);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        let v2 = 7776000000;
        let v3 = ResolutionRequest{
            id                : 0x2::object::new(arg8),
            vault_id          : arg1,
            borrower          : v0,
            option_type       : 2,
            status            : 0,
            loan_balance      : arg2,
            property_value    : arg3,
            collateral_value  : arg4,
            hardship_reason   : 0x1::string::utf8(arg5),
            ai_recommendation : 0,
            ai_confidence     : 0,
            dao_proposal_id   : 0x1::option::none<0x2::object::ID>(),
            initiated_at      : v1,
            expires_at        : v1 + v2,
            completed_at      : 0x1::option::none<u64>(),
        };
        let v4 = 0x2::object::id<ResolutionRequest>(&v3);
        let v5 = ShortSaleDetails{
            id                              : 0x2::object::new(arg8),
            resolution_id                   : v4,
            ai_recommended_price            : arg6,
            list_price                      : arg6,
            current_offer                   : 0,
            current_buyer                   : 0x1::option::none<address>(),
            final_sale_price                : 0x1::option::none<u64>(),
            buyer_address                   : 0x1::option::none<address>(),
            deficiency_forgiveness_approved : false,
            deficiency_forgiveness_amount   : 0,
            protocol_fee_amount             : arg6 * arg0.short_sale_fee_bps / 10000,
            protocol_fee_collected          : false,
            listing_expiry                  : v1 + v2,
        };
        arg0.total_resolutions = arg0.total_resolutions + 1;
        arg0.active_resolutions = arg0.active_resolutions + 1;
        let v6 = ResolutionInitiated{
            resolution_id : v4,
            vault_id      : arg1,
            borrower      : v0,
            option_type   : 2,
            loan_balance  : arg2,
            timestamp     : v1,
        };
        0x2::event::emit<ResolutionInitiated>(v6);
        (v3, v5)
    }

    public fun is_assumption_enabled(arg0: &ResolutionRegistry) : bool {
        arg0.assumption_enabled
    }

    public fun is_deed_in_lieu_enabled(arg0: &ResolutionRegistry) : bool {
        arg0.deed_in_lieu_enabled
    }

    public fun is_short_sale_enabled(arg0: &ResolutionRegistry) : bool {
        arg0.short_sale_enabled
    }

    public fun record_short_sale_offer(arg0: &mut ResolutionRequest, arg1: &mut ShortSaleDetails, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 3 || arg0.status == 5, 2);
        assert!(0x2::clock::timestamp_ms(arg4) < arg1.listing_expiry, 3);
        arg1.current_offer = arg2;
        arg1.current_buyer = 0x1::option::some<address>(arg3);
        arg0.status = 5;
    }

    public fun set_dao_treasury(arg0: &mut ResolutionRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.dao_treasury = arg1;
    }

    public fun update_registry_config(arg0: &mut ResolutionRegistry, arg1: bool, arg2: bool, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == arg0.admin, 1);
        arg0.deed_in_lieu_enabled = arg1;
        arg0.short_sale_enabled = arg2;
        arg0.assumption_enabled = arg3;
        arg0.relocation_credit_min = arg4;
        arg0.relocation_credit_max = arg5;
        arg0.short_sale_fee_bps = arg6;
        arg0.assumption_fee_bps = arg7;
    }

    // decompiled from Move bytecode v6
}

