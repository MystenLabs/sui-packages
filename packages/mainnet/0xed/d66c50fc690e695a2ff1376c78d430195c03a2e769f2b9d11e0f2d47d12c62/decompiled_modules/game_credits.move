module 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits {
    struct GameCreditsLedger has key {
        id: 0x2::object::UID,
        distribution_pool: u64,
        active_supply: u64,
        lifetime_created_total: u128,
        burned_total: u128,
        expired_total: u128,
        game_credit_creation_renounced: bool,
        game_credit_distribution_renounced: bool,
        balances: 0x2::table::Table<address, GameCreditAccount>,
        expires_by_day: 0x2::table::Table<u64, u64>,
    }

    struct GameCreditAccount has store {
        balance: u64,
        expires_at_ms: u64,
        settlement_nonce: u64,
    }

    struct GameCreditsCreatedFromTreasuryBurn has copy, drop {
        treasury_object_id: 0x2::object::ID,
        amount_rflh_burned: u64,
        game_credits_created: u64,
        active_supply_after: u64,
        lifetime_created_total_after: u128,
        created_total_after: u128,
        distribution_pool_after: u64,
        rflh_tracked_supply_after: u64,
    }

    struct GameCreditsDistributed has copy, drop {
        recipient: address,
        amount: u64,
        recipient_balance_after: u64,
        distribution_pool_after: u64,
        expires_at_ms: u64,
    }

    struct GameCreditCreationRenounced has copy, drop {
        ledger_id: 0x2::object::ID,
        admin: address,
    }

    struct GameCreditDistributionRenounced has copy, drop {
        ledger_id: 0x2::object::ID,
        admin: address,
    }

    struct GameCreditsExpiryBucketProcessed has copy, drop {
        expires_at_ms: u64,
        amount: u64,
        active_supply_after: u64,
        expired_total_after: u128,
    }

    struct GameCreditsBurned has copy, drop {
        owner: address,
        amount: u64,
        owner_balance_after: u64,
        burned_total_after: u128,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : GameCreditsLedger {
        GameCreditsLedger{
            id                                 : 0x2::object::new(arg0),
            distribution_pool                  : 0,
            active_supply                      : 0,
            lifetime_created_total             : 0,
            burned_total                       : 0,
            expired_total                      : 0,
            game_credit_creation_renounced     : false,
            game_credit_distribution_renounced : false,
            balances                           : 0x2::table::new<address, GameCreditAccount>(arg0),
            expires_by_day                     : 0x2::table::new<u64, u64>(arg0),
        }
    }

    public fun game_credits_max_supply() : u64 {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::constants::game_credits_max_supply()
    }

    public fun active_supply(arg0: &GameCreditsLedger) : u64 {
        arg0.active_supply
    }

    public fun admin_create_game_credits_from_treasury_burn(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config::AdminCap, arg1: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::Treasury, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::AuthorityVault, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg4: &mut GameCreditsLedger, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg4.game_credit_creation_renounced, 5);
        assert!(arg5 > 0, 1);
        assert!(arg5 <= game_credits_max_supply() - arg4.active_supply, 4);
        assert!(0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::burn_rflh_internal(arg2, arg3, 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::take_for_game_credit_burn(arg1, arg5, arg6)) == arg5, 1);
        arg4.active_supply = arg4.active_supply + arg5;
        arg4.lifetime_created_total = arg4.lifetime_created_total + (arg5 as u128);
        arg4.distribution_pool = arg4.distribution_pool + arg5;
        let v0 = GameCreditsCreatedFromTreasuryBurn{
            treasury_object_id           : 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::id(arg1),
            amount_rflh_burned           : arg5,
            game_credits_created         : arg5,
            active_supply_after          : arg4.active_supply,
            lifetime_created_total_after : arg4.lifetime_created_total,
            created_total_after          : arg4.lifetime_created_total,
            distribution_pool_after      : arg4.distribution_pool,
            rflh_tracked_supply_after    : 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::current_total_tracked_supply(arg2),
        };
        0x2::event::emit<GameCreditsCreatedFromTreasuryBurn>(v0);
    }

    public fun admin_distribute_game_credits(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config::AdminCap, arg1: &mut GameCreditsLedger, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(!arg1.game_credit_distribution_renounced, 5);
        assert!(arg3 > 0, 1);
        assert!(arg1.distribution_pool >= arg3, 2);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = expires_at_for_distribution(v0);
        let v2 = if (0x2::table::contains<address, GameCreditAccount>(&arg1.balances, arg2)) {
            let v3 = 0x2::table::borrow<address, GameCreditAccount>(&arg1.balances, arg2);
            let v4 = v3.balance;
            let v5 = v3.expires_at_ms;
            let v6 = if (v5 <= v0) {
                if (0x2::table::contains<u64, u64>(&arg1.expires_by_day, v5)) {
                    decrement_expiry_bucket(arg1, v5, v4);
                    arg1.active_supply = arg1.active_supply - v4;
                    arg1.expired_total = arg1.expired_total + (v4 as u128);
                };
                0
            } else {
                if (v5 != v1 && v4 > 0) {
                    decrement_expiry_bucket(arg1, v5, v4);
                };
                v4
            };
            let v7 = v6 + arg3;
            let v8 = 0x2::table::borrow_mut<address, GameCreditAccount>(&mut arg1.balances, arg2);
            v8.balance = v7;
            v8.expires_at_ms = v1;
            if (v5 == v1 && v5 > v0) {
                increment_expiry_bucket(arg1, v1, arg3);
            } else {
                increment_expiry_bucket(arg1, v1, v7);
            };
            v7
        } else {
            let v9 = GameCreditAccount{
                balance          : arg3,
                expires_at_ms    : v1,
                settlement_nonce : 0,
            };
            0x2::table::add<address, GameCreditAccount>(&mut arg1.balances, arg2, v9);
            increment_expiry_bucket(arg1, v1, arg3);
            arg3
        };
        arg1.distribution_pool = arg1.distribution_pool - arg3;
        let v10 = GameCreditsDistributed{
            recipient               : arg2,
            amount                  : arg3,
            recipient_balance_after : v2,
            distribution_pool_after : arg1.distribution_pool,
            expires_at_ms           : v1,
        };
        0x2::event::emit<GameCreditsDistributed>(v10);
    }

    public fun admin_renounce_game_credit_creation(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config::AdminCap, arg1: &mut GameCreditsLedger, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg1.game_credit_creation_renounced, 6);
        arg1.game_credit_creation_renounced = true;
        let v0 = GameCreditCreationRenounced{
            ledger_id : 0x2::object::id<GameCreditsLedger>(arg1),
            admin     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<GameCreditCreationRenounced>(v0);
    }

    public fun admin_renounce_game_credit_distribution(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config::AdminCap, arg1: &mut GameCreditsLedger, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg1.game_credit_distribution_renounced, 6);
        arg1.game_credit_distribution_renounced = true;
        let v0 = GameCreditDistributionRenounced{
            ledger_id : 0x2::object::id<GameCreditsLedger>(arg1),
            admin     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<GameCreditDistributionRenounced>(v0);
    }

    public fun assert_balance_at_least<T0: drop>(arg0: T0, arg1: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg2: &GameCreditsLedger, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<T0>(arg1);
        assert!(spendable_balance_of(arg2, arg3, arg5) >= arg4, 3);
    }

    public fun balance_of(arg0: &GameCreditsLedger, arg1: address) : u64 {
        if (0x2::table::contains<address, GameCreditAccount>(&arg0.balances, arg1)) {
            0x2::table::borrow<address, GameCreditAccount>(&arg0.balances, arg1).balance
        } else {
            0
        }
    }

    public fun burned_total(arg0: &GameCreditsLedger) : u128 {
        arg0.burned_total
    }

    public fun created_total(arg0: &GameCreditsLedger) : u128 {
        arg0.lifetime_created_total
    }

    public fun day_ms() : u64 {
        86400000
    }

    public fun debit_loss<T0: drop>(arg0: T0, arg1: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg2: &mut GameCreditsLedger, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<T0>(arg1);
        debit_loss_internal(arg2, arg3, arg4, arg5);
    }

    fun debit_loss_internal(arg0: &mut GameCreditsLedger, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(0x2::table::contains<address, GameCreditAccount>(&arg0.balances, arg1), 3);
        let v0 = 0x2::table::borrow_mut<address, GameCreditAccount>(&mut arg0.balances, arg1);
        assert!(v0.expires_at_ms > 0x2::clock::timestamp_ms(arg3), 3);
        assert!(v0.balance >= arg2, 3);
        v0.balance = v0.balance - arg2;
        v0.settlement_nonce = v0.settlement_nonce + 1;
        let v1 = v0.balance;
        let v2 = v0.expires_at_ms;
        assert!(0x2::table::contains<u64, u64>(&arg0.expires_by_day, v2), 7);
        let v3 = 0x2::table::borrow_mut<u64, u64>(&mut arg0.expires_by_day, v2);
        let v4 = *v3;
        let v5 = decoded_expiry_bucket_amount(v4);
        assert!(v5 >= arg2, 3);
        let v6 = if (v4 % 2 == 0) {
            1
        } else {
            0
        };
        *v3 = encode_expiry_bucket(v5 - arg2, v6);
        arg0.active_supply = arg0.active_supply - arg2;
        arg0.burned_total = arg0.burned_total + (arg2 as u128);
        let v7 = GameCreditsBurned{
            owner               : arg1,
            amount              : arg2,
            owner_balance_after : v1,
            burned_total_after  : arg0.burned_total,
        };
        0x2::event::emit<GameCreditsBurned>(v7);
    }

    fun decoded_expiry_bucket_amount(arg0: u64) : u64 {
        arg0 / 2
    }

    fun decrement_expiry_bucket(arg0: &mut GameCreditsLedger, arg1: u64, arg2: u64) {
        assert!(0x2::table::contains<u64, u64>(&arg0.expires_by_day, arg1), 7);
        let v0 = *0x2::table::borrow<u64, u64>(&arg0.expires_by_day, arg1);
        let v1 = decoded_expiry_bucket_amount(v0);
        assert!(v1 >= arg2, 3);
        if (v1 == arg2) {
            0x2::table::remove<u64, u64>(&mut arg0.expires_by_day, arg1);
        } else {
            *0x2::table::borrow_mut<u64, u64>(&mut arg0.expires_by_day, arg1) = encode_expiry_bucket(v1 - arg2, v0 % 2);
        };
    }

    public fun distribution_pool(arg0: &GameCreditsLedger) : u64 {
        arg0.distribution_pool
    }

    fun encode_expiry_bucket(arg0: u64, arg1: u64) : u64 {
        arg0 * 2 + arg1 % 2
    }

    public fun expired_total(arg0: &GameCreditsLedger) : u128 {
        arg0.expired_total
    }

    fun expires_at_for_distribution(arg0: u64) : u64 {
        next_utc_midnight_at_or_after(arg0 + 30 * 86400000)
    }

    public fun expiry_bucket_amount(arg0: &GameCreditsLedger, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.expires_by_day, arg1)) {
            decoded_expiry_bucket_amount(*0x2::table::borrow<u64, u64>(&arg0.expires_by_day, arg1))
        } else {
            0
        }
    }

    public fun expiry_days() : u64 {
        30
    }

    public fun fixed_supply() : u64 {
        game_credits_max_supply()
    }

    public fun game_credit_creation_renounced(arg0: &GameCreditsLedger) : bool {
        arg0.game_credit_creation_renounced
    }

    public fun game_credit_distribution_renounced(arg0: &GameCreditsLedger) : bool {
        arg0.game_credit_distribution_renounced
    }

    fun increment_expiry_bucket(arg0: &mut GameCreditsLedger, arg1: u64, arg2: u64) {
        if (0x2::table::contains<u64, u64>(&arg0.expires_by_day, arg1)) {
            let v0 = 0x2::table::borrow_mut<u64, u64>(&mut arg0.expires_by_day, arg1);
            let v1 = *v0;
            *v0 = encode_expiry_bucket(decoded_expiry_bucket_amount(v1) + arg2, v1 % 2);
        } else {
            0x2::table::add<u64, u64>(&mut arg0.expires_by_day, arg1, encode_expiry_bucket(arg2, 0));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<GameCreditsLedger>(new(arg0));
    }

    public fun lifetime_created_total(arg0: &GameCreditsLedger) : u128 {
        arg0.lifetime_created_total
    }

    public fun max_active_supply() : u64 {
        game_credits_max_supply()
    }

    fun next_utc_midnight_at_or_after(arg0: u64) : u64 {
        let v0 = arg0 % 86400000;
        if (v0 == 0) {
            arg0
        } else {
            arg0 + 86400000 - v0
        }
    }

    public fun process_expired_game_credit_buckets(arg0: &mut GameCreditsLedger, arg1: vector<u64>, arg2: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            let v1 = *0x1::vector::borrow<u64>(&arg1, v0);
            if (v1 <= 0x2::clock::timestamp_ms(arg2) && 0x2::table::contains<u64, u64>(&arg0.expires_by_day, v1)) {
                let v2 = decoded_expiry_bucket_amount(0x2::table::remove<u64, u64>(&mut arg0.expires_by_day, v1));
                arg0.active_supply = arg0.active_supply - v2;
                arg0.expired_total = arg0.expired_total + (v2 as u128);
                let v3 = GameCreditsExpiryBucketProcessed{
                    expires_at_ms       : v1,
                    amount              : v2,
                    active_supply_after : arg0.active_supply,
                    expired_total_after : arg0.expired_total,
                };
                0x2::event::emit<GameCreditsExpiryBucketProcessed>(v3);
            };
            v0 = v0 + 1;
        };
    }

    public fun spendable_balance_of(arg0: &GameCreditsLedger, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        if (0x2::table::contains<address, GameCreditAccount>(&arg0.balances, arg1)) {
            let v1 = 0x2::table::borrow<address, GameCreditAccount>(&arg0.balances, arg1);
            if (v1.expires_at_ms > 0x2::clock::timestamp_ms(arg2)) {
                v1.balance
            } else {
                0
            }
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

