module 0x7bdcfc15b008f89b67804c86f3368c4de5acba972eaf5acbabadc9d5aaa2bc0::floating_vouchers {
    struct FloatingVoucher has key {
        id: 0x2::object::UID,
        voucher_id: u64,
        target_block_number: u64,
        principal_amount: u64,
        premium_amount: u64,
        total_payout: u64,
        beneficiary: address,
        developer_address: address,
        collateral_locked: u64,
        collateral_pool_id: 0x2::object::ID,
        is_paid: bool,
        is_claimed: bool,
        issued_at: u64,
        paid_at: 0x1::option::Option<u64>,
        grants_priority_juice: bool,
        priority_juice_amount: u64,
    }

    struct BlockDebtRegistry has key {
        id: 0x2::object::UID,
        block_debts: 0x2::table::Table<u64, BlockDebt>,
        current_block_number: u64,
        current_block_funds_required: u64,
        current_block_funds_available: u64,
        outstanding_vouchers: vector<0x2::object::ID>,
        total_vouchers_issued: u64,
        total_vouchers_paid: u64,
        voucher_market: 0x2::table::Table<0x2::object::ID, VoucherListing>,
        ai_governor: address,
        is_paused: bool,
    }

    struct BlockDebt has copy, drop, store {
        block_number: u64,
        total_required: u64,
        total_collected: u64,
        is_satisfied: bool,
        voucher_ids: vector<0x2::object::ID>,
    }

    struct VoucherListing has store, key {
        id: 0x2::object::UID,
        voucher_id: 0x2::object::ID,
        seller: address,
        asking_price: u64,
        listed_at: u64,
    }

    struct VoucherIssued has copy, drop {
        voucher_id: u64,
        target_block: u64,
        principal: u64,
        premium: u64,
        beneficiary: address,
        timestamp: u64,
    }

    struct BlockDebtSatisfied has copy, drop {
        block_number: u64,
        total_required: u64,
        total_collected: u64,
        timestamp: u64,
    }

    struct VoucherPaid has copy, drop {
        voucher_id: u64,
        payout_amount: u64,
        beneficiary: address,
        timestamp: u64,
    }

    struct VoucherListed has copy, drop {
        voucher_id: u64,
        seller: address,
        asking_price: u64,
        timestamp: u64,
    }

    struct ProcurementRequest has key {
        id: 0x2::object::UID,
        compute_type: 0x1::string::String,
        compute_amount: u64,
        duration_hours: u64,
        max_budget: u64,
        actual_cost: u64,
        is_fulfilled: bool,
        provider_address: address,
        requested_at: u64,
        fulfilled_at: 0x1::option::Option<u64>,
    }

    public fun add_block_funds(arg0: &mut BlockDebtRegistry, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<u64, BlockDebt>(&arg0.block_debts, arg1)) {
            let v0 = 0x2::table::borrow_mut<u64, BlockDebt>(&mut arg0.block_debts, arg1);
            v0.total_collected = v0.total_collected + arg2;
            if (v0.total_collected >= v0.total_required) {
                v0.is_satisfied = true;
                let v1 = BlockDebtSatisfied{
                    block_number    : arg1,
                    total_required  : v0.total_required,
                    total_collected : v0.total_collected,
                    timestamp       : 0x2::clock::timestamp_ms(arg3),
                };
                0x2::event::emit<BlockDebtSatisfied>(v1);
            };
        };
        arg0.current_block_funds_available = arg0.current_block_funds_available + arg2;
    }

    public fun buy_voucher(arg0: &mut BlockDebtRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<0x2::object::ID, VoucherListing>(&arg0.voucher_market, arg1), 1);
        let v0 = 0x2::table::remove<0x2::object::ID, VoucherListing>(&mut arg0.voucher_market, arg1);
        0x2::table::add<0x2::object::ID, VoucherListing>(&mut arg0.voucher_market, arg1, v0);
    }

    public fun can_mint_block(arg0: &BlockDebtRegistry, arg1: u64) : bool {
        0x2::table::contains<u64, BlockDebt>(&arg0.block_debts, arg1) && 0x2::table::borrow<u64, BlockDebt>(&arg0.block_debts, arg1).is_satisfied || true
    }

    public fun change_governor(arg0: &mut BlockDebtRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.ai_governor, 0);
        arg0.ai_governor = arg1;
    }

    public fun current_block_funds(arg0: &BlockDebtRegistry) : (u64, u64) {
        (arg0.current_block_funds_required, arg0.current_block_funds_available)
    }

    public fun current_block_number(arg0: &BlockDebtRegistry) : u64 {
        arg0.current_block_number
    }

    fun extract_voucher_id(arg0: 0x2::object::ID) : u64 {
        0
    }

    public fun fulfill_procurement(arg0: &mut ProcurementRequest, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_fulfilled, 3);
        assert!(arg1 <= arg0.max_budget, 2);
        arg0.actual_cost = arg1;
        arg0.is_fulfilled = true;
        arg0.provider_address = arg2;
        arg0.fulfilled_at = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg3));
    }

    public fun increment_block_number(arg0: &mut BlockDebtRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.ai_governor, 0);
        let v0 = arg0.current_block_number;
        if (0x2::table::contains<u64, BlockDebt>(&arg0.block_debts, v0)) {
            assert!(0x2::table::borrow<u64, BlockDebt>(&arg0.block_debts, v0).is_satisfied, 2);
        };
        arg0.current_block_number = arg0.current_block_number + 1;
        arg0.current_block_funds_required = 0;
        arg0.current_block_funds_available = 0;
    }

    public fun initialize_voucher_system(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BlockDebtRegistry{
            id                            : 0x2::object::new(arg1),
            block_debts                   : 0x2::table::new<u64, BlockDebt>(arg1),
            current_block_number          : 0,
            current_block_funds_required  : 0,
            current_block_funds_available : 0,
            outstanding_vouchers          : 0x1::vector::empty<0x2::object::ID>(),
            total_vouchers_issued         : 0,
            total_vouchers_paid           : 0,
            voucher_market                : 0x2::table::new<0x2::object::ID, VoucherListing>(arg1),
            ai_governor                   : arg0,
            is_paused                     : false,
        };
        0x2::transfer::share_object<BlockDebtRegistry>(v0);
    }

    public fun issue_floating_voucher(arg0: &mut BlockDebtRegistry, arg1: address, arg2: u64, arg3: u64, arg4: 0x2::object::ID, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 0);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = arg2 * 5 / 100;
        let v2 = arg2 + v1;
        let v3 = if (arg5) {
            arg2 / 10
        } else {
            0
        };
        let v4 = FloatingVoucher{
            id                    : 0x2::object::new(arg7),
            voucher_id            : arg0.total_vouchers_issued + 1,
            target_block_number   : arg3,
            principal_amount      : arg2,
            premium_amount        : v1,
            total_payout          : v2,
            beneficiary           : arg1,
            developer_address     : arg1,
            collateral_locked     : 0,
            collateral_pool_id    : arg4,
            is_paid               : false,
            is_claimed            : false,
            issued_at             : v0,
            paid_at               : 0x1::option::none<u64>(),
            grants_priority_juice : arg5,
            priority_juice_amount : v3,
        };
        let v5 = 0x2::object::uid_to_inner(&v4.id);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.outstanding_vouchers, v5);
        arg0.total_vouchers_issued = arg0.total_vouchers_issued + 1;
        if (0x2::table::contains<u64, BlockDebt>(&arg0.block_debts, arg3)) {
            let v6 = 0x2::table::borrow_mut<u64, BlockDebt>(&mut arg0.block_debts, arg3);
            v6.total_required = v6.total_required + v2;
            0x1::vector::push_back<0x2::object::ID>(&mut v6.voucher_ids, v5);
        } else {
            let v7 = BlockDebt{
                block_number    : arg3,
                total_required  : v2,
                total_collected : 0,
                is_satisfied    : false,
                voucher_ids     : 0x1::vector::singleton<0x2::object::ID>(v5),
            };
            0x2::table::add<u64, BlockDebt>(&mut arg0.block_debts, arg3, v7);
        };
        0x2::transfer::transfer<FloatingVoucher>(v4, arg1);
        let v8 = VoucherIssued{
            voucher_id   : extract_voucher_id(v5),
            target_block : arg3,
            principal    : arg2,
            premium      : v1,
            beneficiary  : arg1,
            timestamp    : v0,
        };
        0x2::event::emit<VoucherIssued>(v8);
    }

    public fun list_voucher_for_sale(arg0: &mut BlockDebtRegistry, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v2 = VoucherListing{
            id           : 0x2::object::new(arg3),
            voucher_id   : arg1,
            seller       : v0,
            asking_price : arg2,
            listed_at    : v1,
        };
        0x2::table::add<0x2::object::ID, VoucherListing>(&mut arg0.voucher_market, 0x2::object::uid_to_inner(&v2.id), v2);
        let v3 = VoucherListed{
            voucher_id   : extract_voucher_id(arg1),
            seller       : v0,
            asking_price : arg2,
            timestamp    : v1,
        };
        0x2::event::emit<VoucherListed>(v3);
    }

    public fun outstanding_voucher_count(arg0: &BlockDebtRegistry) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.outstanding_vouchers)
    }

    public fun pause_voucher_system(arg0: &mut BlockDebtRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.ai_governor, 0);
        arg0.is_paused = true;
    }

    public fun pay_voucher(arg0: &mut BlockDebtRegistry, arg1: FloatingVoucher, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_paid, 3);
        let v0 = arg1.beneficiary;
        arg0.total_vouchers_paid = arg0.total_vouchers_paid + 1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg0.outstanding_vouchers)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&arg0.outstanding_vouchers, v1) == 0x2::object::uid_to_inner(&arg1.id)) {
                0x1::vector::remove<0x2::object::ID>(&mut arg0.outstanding_vouchers, v1);
                break
            };
            v1 = v1 + 1;
        };
        let v2 = VoucherPaid{
            voucher_id    : arg1.voucher_id,
            payout_amount : arg1.total_payout,
            beneficiary   : v0,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<VoucherPaid>(v2);
        0x2::transfer::transfer<FloatingVoucher>(arg1, v0);
    }

    public fun request_external_compute(arg0: &mut BlockDebtRegistry, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ProcurementRequest{
            id               : 0x2::object::new(arg5),
            compute_type     : arg1,
            compute_amount   : arg2,
            duration_hours   : arg3,
            max_budget       : arg4,
            actual_cost      : 0,
            is_fulfilled     : false,
            provider_address : @0x0,
            requested_at     : 0x2::tx_context::epoch_timestamp_ms(arg5),
            fulfilled_at     : 0x1::option::none<u64>(),
        };
        0x2::transfer::share_object<ProcurementRequest>(v0);
    }

    public fun total_vouchers_issued(arg0: &BlockDebtRegistry) : u64 {
        arg0.total_vouchers_issued
    }

    public fun total_vouchers_paid(arg0: &BlockDebtRegistry) : u64 {
        arg0.total_vouchers_paid
    }

    public fun unpause_voucher_system(arg0: &mut BlockDebtRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.ai_governor, 0);
        arg0.is_paused = false;
    }

    // decompiled from Move bytecode v6
}

