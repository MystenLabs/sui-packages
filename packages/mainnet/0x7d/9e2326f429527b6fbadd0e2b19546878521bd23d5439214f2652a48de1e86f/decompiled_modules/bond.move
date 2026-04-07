module 0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::bond {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct BondAccount has key {
        id: 0x2::object::UID,
        provider: address,
        mode: u8,
        category: u8,
        category_settled: u64,
        pool: 0x2::coin::Coin<USDC>,
        pool_capacity: u64,
        pool_active: u64,
        credit_drawn: u64,
        btc_collateral_usdc: u64,
        created_at: u64,
    }

    struct TransactionBond has key {
        id: 0x2::object::UID,
        intent_id: 0x2::object::ID,
        provider: address,
        bond_amount: u64,
        mode: u8,
        cash: 0x2::coin::Coin<USDC>,
        locked_at: u64,
        fulfil_by: u64,
    }

    struct BondAccountCreated has copy, drop {
        account_id: 0x2::object::ID,
        provider: address,
        mode: u8,
        category: u8,
    }

    struct BondLocked has copy, drop {
        bond_id: 0x2::object::ID,
        intent_id: 0x2::object::ID,
        provider: address,
        amount: u64,
        mode: u8,
    }

    struct BondReleased has copy, drop {
        bond_id: 0x2::object::ID,
        intent_id: 0x2::object::ID,
        amount: u64,
        reason: u8,
    }

    struct MarginCall has copy, drop {
        account_id: 0x2::object::ID,
        provider: address,
        current_ltv: u64,
        required_action: u8,
    }

    public fun bond_rate_bps(arg0: u8, arg1: u8) : u64 {
        let v0 = vector[200, 150, 100, 50, 500, 300, 200, 100, 1000, 700, 500, 200, 1500, 1200, 800, 500, 2000, 1500, 1000, 500, 2500, 2000, 1500, 1000];
        *0x1::vector::borrow<u64>(&v0, (arg0 as u64) * 4 + (arg1 as u64))
    }

    public fun cat_digital() : u8 {
        0
    }

    public fun cat_financial() : u8 {
        5
    }

    public fun cat_physical_goods() : u8 {
        2
    }

    public fun cat_physical_mail() : u8 {
        1
    }

    public fun cat_services() : u8 {
        3
    }

    public fun cat_travel() : u8 {
        4
    }

    public fun consume_bond_for_job(arg0: TransactionBond, arg1: &mut BondAccount) : (u64, u8, 0x2::coin::Coin<USDC>) {
        let TransactionBond {
            id          : v0,
            intent_id   : _,
            provider    : _,
            bond_amount : v3,
            mode        : v4,
            cash        : v5,
            locked_at   : _,
            fulfil_by   : _,
        } = arg0;
        let v8 = v0;
        0x2::object::uid_to_inner(&v8);
        0x2::object::delete(v8);
        (v3, v4, v5)
    }

    public entry fun create_cash_account(arg0: u8, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BondAccount{
            id                  : 0x2::object::new(arg2),
            provider            : 0x2::tx_context::sender(arg2),
            mode                : 0,
            category            : arg0,
            category_settled    : 0,
            pool                : 0x2::coin::zero<USDC>(arg2),
            pool_capacity       : 0,
            pool_active         : 0,
            credit_drawn        : 0,
            btc_collateral_usdc : 0,
            created_at          : 0x2::clock::timestamp_ms(arg1),
        };
        let v1 = BondAccountCreated{
            account_id : 0x2::object::id<BondAccount>(&v0),
            provider   : 0x2::tx_context::sender(arg2),
            mode       : 0,
            category   : arg0,
        };
        0x2::event::emit<BondAccountCreated>(v1);
        0x2::transfer::transfer<BondAccount>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun create_pool_account(arg0: u8, arg1: 0x2::coin::Coin<USDC>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = BondAccount{
            id                  : 0x2::object::new(arg4),
            provider            : 0x2::tx_context::sender(arg4),
            mode                : 1,
            category            : arg0,
            category_settled    : 0,
            pool                : arg1,
            pool_capacity       : arg2,
            pool_active         : 0,
            credit_drawn        : 0,
            btc_collateral_usdc : 0,
            created_at          : 0x2::clock::timestamp_ms(arg3),
        };
        let v1 = BondAccountCreated{
            account_id : 0x2::object::id<BondAccount>(&v0),
            provider   : 0x2::tx_context::sender(arg4),
            mode       : 1,
            category   : arg0,
        };
        0x2::event::emit<BondAccountCreated>(v1);
        0x2::transfer::transfer<BondAccount>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun current_ltv_bps(arg0: &BondAccount) : u64 {
        if (arg0.btc_collateral_usdc == 0) {
            return 0
        };
        arg0.credit_drawn * 10000 / arg0.btc_collateral_usdc
    }

    public entry fun lock_cash_bond(arg0: &mut BondAccount, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::coin::Coin<USDC>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mode == 0, 1);
        assert!(arg0.provider == 0x2::tx_context::sender(arg5), 2);
        let v0 = required_bond(arg2, arg0.category, rep_tier(arg0.category_settled));
        assert!(0x2::coin::value<USDC>(&arg3) >= v0, 3);
        if (0x2::coin::value<USDC>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(arg3, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<USDC>(arg3);
        };
        let v1 = TransactionBond{
            id          : 0x2::object::new(arg5),
            intent_id   : arg1,
            provider    : 0x2::tx_context::sender(arg5),
            bond_amount : v0,
            mode        : 0,
            cash        : 0x2::coin::split<USDC>(&mut arg3, v0, arg5),
            locked_at   : 0x2::clock::timestamp_ms(arg4),
            fulfil_by   : 0x2::clock::timestamp_ms(arg4) + 259200000,
        };
        let v2 = BondLocked{
            bond_id   : 0x2::object::id<TransactionBond>(&v1),
            intent_id : arg1,
            provider  : 0x2::tx_context::sender(arg5),
            amount    : v0,
            mode      : 0,
        };
        0x2::event::emit<BondLocked>(v2);
        0x2::transfer::share_object<TransactionBond>(v1);
    }

    public entry fun lock_pool_bond(arg0: &mut BondAccount, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mode == 1, 1);
        assert!(arg0.provider == 0x2::tx_context::sender(arg4), 2);
        assert!(arg0.pool_active < arg0.pool_capacity, 4);
        let v0 = required_bond(arg2, arg0.category, rep_tier(arg0.category_settled));
        assert!(0x2::coin::value<USDC>(&arg0.pool) >= v0, 5);
        arg0.pool_active = arg0.pool_active + 1;
        let v1 = TransactionBond{
            id          : 0x2::object::new(arg4),
            intent_id   : arg1,
            provider    : 0x2::tx_context::sender(arg4),
            bond_amount : v0,
            mode        : 1,
            cash        : 0x2::coin::zero<USDC>(arg4),
            locked_at   : 0x2::clock::timestamp_ms(arg3),
            fulfil_by   : 0x2::clock::timestamp_ms(arg3) + 259200000,
        };
        let v2 = BondLocked{
            bond_id   : 0x2::object::id<TransactionBond>(&v1),
            intent_id : arg1,
            provider  : 0x2::tx_context::sender(arg4),
            amount    : v0,
            mode      : 1,
        };
        0x2::event::emit<BondLocked>(v2);
        0x2::transfer::share_object<TransactionBond>(v1);
    }

    public fun ltv_initial_bps() : u64 {
        3500
    }

    public fun ltv_liquidation_bps() : u64 {
        7500
    }

    public fun ltv_margin_call_bps() : u64 {
        6500
    }

    public fun pool_utilization(arg0: &BondAccount) : u64 {
        if (arg0.pool_capacity == 0) {
            return 0
        };
        arg0.pool_active * 10000 / arg0.pool_capacity
    }

    public fun record_settlement(arg0: &mut BondAccount) {
        arg0.category_settled = arg0.category_settled + 1;
        if (arg0.pool_active > 0) {
            arg0.pool_active = arg0.pool_active - 1;
        };
    }

    public entry fun release_on_settle(arg0: TransactionBond, arg1: &mut BondAccount, arg2: &mut 0x2::tx_context::TxContext) {
        let TransactionBond {
            id          : v0,
            intent_id   : v1,
            provider    : v2,
            bond_amount : v3,
            mode        : v4,
            cash        : v5,
            locked_at   : _,
            fulfil_by   : _,
        } = arg0;
        let v8 = v0;
        0x2::object::delete(v8);
        let v9 = BondReleased{
            bond_id   : 0x2::object::uid_to_inner(&v8),
            intent_id : v1,
            amount    : v3,
            reason    : 0,
        };
        0x2::event::emit<BondReleased>(v9);
        if (v4 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(v5, v2);
        } else {
            0x2::coin::destroy_zero<USDC>(v5);
            if (arg1.pool_active > 0) {
                arg1.pool_active = arg1.pool_active - 1;
            };
        };
        arg1.category_settled = arg1.category_settled + 1;
    }

    public fun release_pool_slot(arg0: &mut BondAccount) {
        if (arg0.pool_active > 0) {
            arg0.pool_active = arg0.pool_active - 1;
        };
    }

    public fun rep_emerging() : u8 {
        1
    }

    public fun rep_established() : u8 {
        2
    }

    public fun rep_new() : u8 {
        0
    }

    public fun rep_tier(arg0: u64) : u8 {
        if (arg0 >= 1000) {
            3
        } else if (arg0 >= 100) {
            2
        } else if (arg0 >= 10) {
            1
        } else {
            0
        }
    }

    public fun rep_trusted() : u8 {
        3
    }

    public fun required_bond(arg0: u64, arg1: u8, arg2: u8) : u64 {
        let v0 = vector[200, 150, 100, 50, 500, 300, 200, 100, 1000, 700, 500, 200, 1500, 1200, 800, 500, 2000, 1500, 1000, 500, 2500, 2000, 1500, 1000];
        if (arg1 == 0 && arg2 == 3) {
            return 500000
        };
        let v1 = arg0 * *0x1::vector::borrow<u64>(&v0, (arg1 as u64) * 4 + (arg2 as u64)) / 10000;
        let v2 = if (v1 < 500000) {
            500000
        } else {
            v1
        };
        if (v2 > 10000000000) {
            10000000000
        } else {
            v2
        }
    }

    public entry fun slash_on_dispute(arg0: TransactionBond, arg1: &mut BondAccount, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let TransactionBond {
            id          : v0,
            intent_id   : v1,
            provider    : _,
            bond_amount : v3,
            mode        : v4,
            cash        : v5,
            locked_at   : _,
            fulfil_by   : _,
        } = arg0;
        let v8 = v0;
        0x2::object::delete(v8);
        let v9 = BondReleased{
            bond_id   : 0x2::object::uid_to_inner(&v8),
            intent_id : v1,
            amount    : v3,
            reason    : 1,
        };
        0x2::event::emit<BondReleased>(v9);
        if (v4 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(v5, arg2);
        } else {
            0x2::coin::destroy_zero<USDC>(v5);
            0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::split<USDC>(&mut arg1.pool, v3, arg3), arg2);
            if (arg1.pool_active > 0) {
                arg1.pool_active = arg1.pool_active - 1;
            };
        };
    }

    public entry fun slash_on_silence(arg0: TransactionBond, arg1: &mut BondAccount, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) > arg0.fulfil_by, 6);
        let TransactionBond {
            id          : v0,
            intent_id   : v1,
            provider    : _,
            bond_amount : v3,
            mode        : v4,
            cash        : v5,
            locked_at   : _,
            fulfil_by   : _,
        } = arg0;
        let v8 = v0;
        0x2::object::delete(v8);
        let v9 = BondReleased{
            bond_id   : 0x2::object::uid_to_inner(&v8),
            intent_id : v1,
            amount    : v3,
            reason    : 2,
        };
        0x2::event::emit<BondReleased>(v9);
        if (v4 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(v5, arg2);
        } else {
            0x2::coin::destroy_zero<USDC>(v5);
            0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::split<USDC>(&mut arg1.pool, v3, arg4), arg2);
            if (arg1.pool_active > 0) {
                arg1.pool_active = arg1.pool_active - 1;
            };
        };
    }

    public fun slash_pool_to_address(arg0: &mut BondAccount, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::split<USDC>(&mut arg0.pool, arg1, arg3), arg2);
        if (arg0.pool_active > 0) {
            arg0.pool_active = arg0.pool_active - 1;
        };
    }

    public entry fun top_up_pool(arg0: &mut BondAccount, arg1: 0x2::coin::Coin<USDC>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.provider == 0x2::tx_context::sender(arg3), 0);
        0x2::coin::join<USDC>(&mut arg0.pool, arg1);
        arg0.pool_capacity = arg2;
    }

    public entry fun update_btc_price(arg0: &mut BondAccount, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.btc_collateral_usdc = arg1;
        if (arg0.mode == 2 && arg0.credit_drawn > 0) {
            let v0 = arg0.credit_drawn * 10000 / arg1;
            if (v0 >= 6500) {
                let v1 = if (v0 >= 7500) {
                    1
                } else {
                    0
                };
                let v2 = MarginCall{
                    account_id      : 0x2::object::id<BondAccount>(arg0),
                    provider        : arg0.provider,
                    current_ltv     : v0,
                    required_action : v1,
                };
                0x2::event::emit<MarginCall>(v2);
            };
        };
    }

    // decompiled from Move bytecode v6
}

