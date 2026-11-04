module 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        cash: 0x2::balance::Balance<T0>,
        total_shares: u128,
        lent: u64,
        term_ms: u64,
        sale_floor_bps: u64,
        deposit_lock_ms: u64,
        withdraw_delay_ms: u64,
        locked_profit: u64,
        locked_at_ms: u64,
        unlock_end_ms: u64,
        reserved: u64,
        held_coins: u64,
        lending: bool,
        min_loan: u64,
    }

    struct CoinRule has store {
        feed_id: 0x2::object::ID,
        ltv_bps: u64,
        apr_bps: u64,
        cap_bps: u64,
        max_lent: u64,
        enabled: bool,
        lent: u64,
    }

    struct RuleKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct HeldKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct HeldSinceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Share has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        shares: u128,
        unlock_ms: u64,
        pending: u128,
        ready_ms: u64,
        pending_value: u64,
    }

    struct CuratorCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct SaleReceipt<phantom T0, phantom T1> {
        vault_id: 0x2::object::ID,
        sold: u64,
        min_out: u64,
        emptied: bool,
    }

    struct VaultCreated<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        name: 0x1::string::String,
        term_ms: u64,
        sale_floor_bps: u64,
        deposit_lock_ms: u64,
        withdraw_delay_ms: u64,
        min_loan: u64,
    }

    struct MinLoanSet<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        min_loan: u64,
    }

    struct WithdrawRequested<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        share_id: 0x2::object::ID,
        owner: address,
        shares: u128,
        pending: u128,
        ready_ms: u64,
    }

    struct WithdrawCancelled has copy, drop {
        share_id: 0x2::object::ID,
        shares: u128,
    }

    struct HeldWrittenOff<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct ProfitLocked<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        gain: u64,
        locked: u64,
    }

    struct LossBooked<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        loss: u64,
        from_locked: u64,
    }

    struct RuleSet<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        feed_id: 0x2::object::ID,
        ltv_bps: u64,
        apr_bps: u64,
        cap_bps: u64,
        max_lent: u64,
        enabled: bool,
    }

    struct Deposited<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        share_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        shares: u128,
        unlock_ms: u64,
    }

    struct Withdrawn<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        share_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        shares: u128,
    }

    struct VaultLent<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        loan_id: 0x2::object::ID,
        borrower: address,
        amount: u64,
        collateral: u64,
        price_q64: u128,
    }

    struct Collected<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        loan_id: 0x2::object::ID,
        principal: u64,
        received: u64,
    }

    struct DefaultCollected<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        loan_id: 0x2::object::ID,
        principal: u64,
        collateral: u64,
    }

    struct CollateralSold<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        sold: u64,
        received: u64,
    }

    struct SafeRule has store {
        liq_ltv_bps: u64,
    }

    struct SafeKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct SafeRuleSet<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        liq_ltv_bps: u64,
    }

    public fun borrow<T0, T1>(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::Config, arg1: &mut Vault<T0>, arg2: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::oracle::PriceFeed<T1, T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(liq_ltv_bps<T0, T1>(arg1) == 0, 13898673440129810457);
        assert!(arg1.withdraw_delay_ms > arg1.term_ms + 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::grace_ms(arg0), 13895577232566779943);
        let (v0, v1, v2, v3, v4) = lend_out<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v5 = v0;
        let v6 = 0x2::object::id<Vault<T0>>(arg1);
        let v7 = VaultLent<T0, T1>{
            vault_id   : v6,
            loan_id    : 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::loan::open<T1, T0>(v6, 0x2::object::id_to_address(&v6), 0x2::tx_context::sender(arg6), v5, arg4, v2, 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::loan::terms(v4, arg1.term_ms, 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::grace_ms(arg0), 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::penalty_x(arg0), 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::interest_share_bps(arg0), 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::default_fee_bps(arg0), 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::fee_recipient(arg0)), arg5, arg6),
            borrower   : 0x2::tx_context::sender(arg6),
            amount     : arg4,
            collateral : 0x2::balance::value<T1>(&v5),
            price_q64  : v3,
        };
        0x2::event::emit<VaultLent<T0, T1>>(v7);
        v1
    }

    public(friend) fun address_of<T0>(arg0: &Vault<T0>) : address {
        let v0 = 0x2::object::id<Vault<T0>>(arg0);
        0x2::object::id_to_address(&v0)
    }

    fun book_gain<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        if (arg1 == 0) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = locked_profit_at<T0>(arg0, v0);
        let v2 = if (arg0.unlock_end_ms > v0) {
            arg0.unlock_end_ms - v0
        } else {
            0
        };
        arg0.locked_profit = v1 + arg1;
        arg0.locked_at_ms = v0;
        arg0.unlock_end_ms = v0 + ((((v1 as u128) * (v2 as u128) + (arg1 as u128) * (arg0.term_ms as u128)) / ((v1 as u128) + (arg1 as u128))) as u64);
        let v3 = ProfitLocked<T0>{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            gain     : arg1,
            locked   : arg0.locked_profit,
        };
        0x2::event::emit<ProfitLocked<T0>>(v3);
    }

    fun book_loss<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        if (arg1 == 0) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = locked_profit_at<T0>(arg0, v0);
        let v2 = if (arg1 < v1) {
            arg1
        } else {
            v1
        };
        arg0.locked_profit = v1 - v2;
        arg0.locked_at_ms = v0;
        let v3 = LossBooked<T0>{
            vault_id    : 0x2::object::id<Vault<T0>>(arg0),
            loss        : arg1,
            from_locked : v2,
        };
        0x2::event::emit<LossBooked<T0>>(v3);
    }

    public(friend) fun book_return<T0, T1>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.cash, arg1);
        settle_principal<T0, T1>(arg0, arg2);
        if (v0 >= arg2) {
            book_gain<T0>(arg0, v0 - arg2, arg3);
        } else {
            book_loss<T0>(arg0, arg2 - v0, arg3);
        };
    }

    public fun cancel_withdraw<T0>(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::Config, arg1: &mut Vault<T0>, arg2: &mut Share, arg3: &0x2::clock::Clock) {
        0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::assert_version(arg0);
        assert!(arg2.vault_id == 0x2::object::id<Vault<T0>>(arg1), 13896984354045558797);
        let v0 = arg2.pending;
        let v1 = arg2.pending_value;
        let v2 = if (arg1.reserved > v1) {
            arg1.reserved - v1
        } else {
            0
        };
        arg1.reserved = v2;
        let v3 = total_assets<T0>(arg1, arg3);
        let v4 = if (value_of_shares(v0, v3, arg1.total_shares) > v1) {
            let v5 = shares_for_amount(v1, v3 - v1, arg1.total_shares - v0);
            let v6 = if (v5 > v0) {
                v0
            } else {
                v5
            };
            arg1.total_shares = arg1.total_shares - v0 - v6;
            v6
        } else {
            v0
        };
        arg2.shares = arg2.shares + v4;
        arg2.pending = 0;
        arg2.pending_value = 0;
        let v7 = WithdrawCancelled{
            share_id : 0x2::object::id<Share>(arg2),
            shares   : v4,
        };
        0x2::event::emit<WithdrawCancelled>(v7);
    }

    public fun cash<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.cash)
    }

    public fun close_share(arg0: Share) {
        let Share {
            id            : v0,
            vault_id      : _,
            shares        : v2,
            unlock_ms     : _,
            pending       : v4,
            ready_ms      : _,
            pending_value : _,
        } = arg0;
        assert!(v2 == 0 && v4 == 0, 13897265992231157775);
        0x2::object::delete(v0);
    }

    public fun coin_lent<T0, T1>(arg0: &Vault<T0>) : u64 {
        let v0 = RuleKey<T1>{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<RuleKey<T1>, CoinRule>(&arg0.id, v0)) {
            return 0
        };
        let v1 = RuleKey<T1>{dummy_field: false};
        0x2::dynamic_field::borrow<RuleKey<T1>, CoinRule>(&arg0.id, v1).lent
    }

    public fun collateral_for(arg0: u64, arg1: u128, arg2: u64) : u64 {
        let v0 = (arg1 as u256) * (arg2 as u256);
        let v1 = (((arg0 as u256) * (10000 as u256) << 64) + v0 - 1) / v0;
        assert!(v1 > 0 && v1 <= 18446744073709551615, 13897266357303377935);
        (v1 as u64)
    }

    public fun collect<T0, T1>(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::Config, arg1: &mut Vault<T0>, arg2: 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::loan::Loan<T1, T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::assert_version(arg0);
        let v0 = 0x2::object::id<Vault<T0>>(arg1);
        assert!(0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::loan::lender<T1, T0>(&arg2) == 0x2::object::id_to_address(&v0), 13896984920981241869);
        let v1 = 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::loan::principal<T1, T0>(&arg2);
        let v2 = 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::loan::release_repaid<T1, T0>(arg2, arg3, arg4);
        book_return<T0, T1>(arg1, 0x2::coin::into_balance<T0>(v2), v1, arg3);
        let v3 = Collected<T0, T1>{
            vault_id  : 0x2::object::id<Vault<T0>>(arg1),
            loan_id   : 0x2::object::id<0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::loan::Loan<T1, T0>>(&arg2),
            principal : v1,
            received  : 0x2::coin::value<T0>(&v2),
        };
        0x2::event::emit<Collected<T0, T1>>(v3);
    }

    public fun collect_default<T0, T1>(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::Config, arg1: &mut Vault<T0>, arg2: 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::loan::Loan<T1, T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::assert_version(arg0);
        let v0 = 0x2::object::id<Vault<T0>>(arg1);
        assert!(0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::loan::lender<T1, T0>(&arg2) == 0x2::object::id_to_address(&v0), 13896984972520849421);
        let v1 = 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::loan::principal<T1, T0>(&arg2);
        let v2 = 0x2::coin::into_balance<T1>(0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::loan::release_default<T1, T0>(arg2, arg3, arg4));
        let v3 = 0x2::balance::value<T1>(&v2);
        let v4 = HeldKey<T1>{dummy_field: false};
        let v5 = if (0x2::dynamic_field::exists_with_type<HeldKey<T1>, 0x2::balance::Balance<T1>>(&arg1.id, v4)) {
            let v6 = HeldKey<T1>{dummy_field: false};
            let v7 = 0x2::dynamic_field::borrow_mut<HeldKey<T1>, 0x2::balance::Balance<T1>>(&mut arg1.id, v6);
            0x2::balance::join<T1>(v7, v2);
            0x2::balance::value<T1>(v7) == 0
        } else {
            let v8 = HeldKey<T1>{dummy_field: false};
            0x2::dynamic_field::add<HeldKey<T1>, 0x2::balance::Balance<T1>>(&mut arg1.id, v8, v2);
            true
        };
        if (v5 && v3 > 0) {
            arg1.held_coins = arg1.held_coins + 1;
        };
        let v9 = HeldKey<T1>{dummy_field: false};
        if (v3 > 0 && (v3 as u128) * 2 > (0x2::balance::value<T1>(0x2::dynamic_field::borrow<HeldKey<T1>, 0x2::balance::Balance<T1>>(&arg1.id, v9)) as u128)) {
            let v10 = HeldSinceKey<T1>{dummy_field: false};
            if (0x2::dynamic_field::exists_with_type<HeldSinceKey<T1>, u64>(&arg1.id, v10)) {
                let v11 = HeldSinceKey<T1>{dummy_field: false};
                *0x2::dynamic_field::borrow_mut<HeldSinceKey<T1>, u64>(&mut arg1.id, v11) = 0x2::clock::timestamp_ms(arg3);
            } else {
                let v12 = HeldSinceKey<T1>{dummy_field: false};
                0x2::dynamic_field::add<HeldSinceKey<T1>, u64>(&mut arg1.id, v12, 0x2::clock::timestamp_ms(arg3));
            };
        };
        settle_principal<T0, T1>(arg1, v1);
        book_loss<T0>(arg1, v1, arg3);
        let v13 = DefaultCollected<T0, T1>{
            vault_id   : 0x2::object::id<Vault<T0>>(arg1),
            loan_id    : 0x2::object::id<0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::loan::Loan<T1, T0>>(&arg2),
            principal  : v1,
            collateral : v3,
        };
        0x2::event::emit<DefaultCollected<T0, T1>>(v13);
    }

    public fun create<T0>(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::AdminCap, arg1: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::Config, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : CuratorCap {
        0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::assert_version(arg1);
        0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::assert_loan_allowed<T0>(arg1);
        assert!(arg3 >= 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::min_term_ms(arg1) && arg3 <= 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::max_term_ms(arg1), 13905427868906684417);
        assert!(arg4 >= 8000 && arg4 <= 10000, 13905427873201651713);
        assert!(arg5 <= 2592000000, 13905427877496619009);
        assert!(arg6 <= 31622400000, 13905427881791586305);
        assert!(arg7 > 0, 13905427886086553601);
        let v0 = Vault<T0>{
            id                : 0x2::object::new(arg8),
            name              : arg2,
            cash              : 0x2::balance::zero<T0>(),
            total_shares      : 0,
            lent              : 0,
            term_ms           : arg3,
            sale_floor_bps    : arg4,
            deposit_lock_ms   : arg5,
            withdraw_delay_ms : arg6,
            locked_profit     : 0,
            locked_at_ms      : 0,
            unlock_end_ms     : 0,
            reserved          : 0,
            held_coins        : 0,
            lending           : true,
            min_loan          : arg7,
        };
        let v1 = 0x2::object::id<Vault<T0>>(&v0);
        let v2 = VaultCreated<T0>{
            vault_id          : v1,
            name              : v0.name,
            term_ms           : arg3,
            sale_floor_bps    : arg4,
            deposit_lock_ms   : arg5,
            withdraw_delay_ms : arg6,
            min_loan          : arg7,
        };
        0x2::event::emit<VaultCreated<T0>>(v2);
        0x2::transfer::share_object<Vault<T0>>(v0);
        CuratorCap{
            id       : 0x2::object::new(arg8),
            vault_id : v1,
        }
    }

    public fun deposit<T0>(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::Config, arg1: &mut Vault<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Share {
        0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::assert_open(arg0);
        assert!(arg1.held_coins == 0, 13899517272354848799);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 13897265481130049551);
        let v1 = shares_for<T0>(arg1, v0, arg3);
        assert!(v1 > 0, 13897265489719984143);
        0x2::balance::join<T0>(&mut arg1.cash, 0x2::coin::into_balance<T0>(arg2));
        arg1.total_shares = arg1.total_shares + v1;
        let v2 = 0x2::clock::timestamp_ms(arg3) + arg1.deposit_lock_ms;
        let v3 = Share{
            id            : 0x2::object::new(arg4),
            vault_id      : 0x2::object::id<Vault<T0>>(arg1),
            shares        : v1,
            unlock_ms     : v2,
            pending       : 0,
            ready_ms      : 0,
            pending_value : 0,
        };
        let v4 = Deposited<T0>{
            vault_id  : 0x2::object::id<Vault<T0>>(arg1),
            share_id  : 0x2::object::id<Share>(&v3),
            owner     : 0x2::tx_context::sender(arg4),
            amount    : v0,
            shares    : v1,
            unlock_ms : v2,
        };
        0x2::event::emit<Deposited<T0>>(v4);
        v3
    }

    public fun deposit_lock_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.deposit_lock_ms
    }

    public fun held<T0, T1>(arg0: &Vault<T0>) : u64 {
        let v0 = HeldKey<T1>{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<HeldKey<T1>, 0x2::balance::Balance<T1>>(&arg0.id, v0)) {
            return 0
        };
        let v1 = HeldKey<T1>{dummy_field: false};
        0x2::balance::value<T1>(0x2::dynamic_field::borrow<HeldKey<T1>, 0x2::balance::Balance<T1>>(&arg0.id, v1))
    }

    public fun held_coins<T0>(arg0: &Vault<T0>) : u64 {
        arg0.held_coins
    }

    public(friend) fun lend_out<T0, T1>(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::Config, arg1: &mut Vault<T0>, arg2: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::oracle::PriceFeed<T1, T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::coin::Coin<T0>, u64, u128, u64) {
        0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::assert_open(arg0);
        assert!(arg1.lending, 13897547686251331601);
        assert!(arg4 > 0, 13897266215569457167);
        assert!(arg4 >= arg1.min_loan, 13889947870471651369);
        let v0 = RuleKey<T1>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<RuleKey<T1>, CoinRule>(&arg1.id, v0), 13905710473459924995);
        let v1 = RuleKey<T1>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<RuleKey<T1>, CoinRule>(&mut arg1.id, v1);
        assert!(v2.enabled, 13905710486344826883);
        assert!(v2.feed_id == 0x2::object::id<0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::oracle::PriceFeed<T1, T0>>(arg2), 13905991965616635909);
        assert!(((v2.lent + arg4) as u128) * (10000 as u128) <= (total_assets<T0>(arg1, arg5) as u128) * (v2.cap_bps as u128), 13906273453478379527);
        assert!(v2.lent + arg4 <= v2.max_lent, 13906273462068314119);
        let v3 = 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::oracle::loan_price<T1, T0>(arg2, arg5, arg6);
        let v4 = collateral_for(arg4, v3, v2.ltv_bps);
        assert!(0x2::coin::value<T1>(arg3) >= v4, 13906836424906899467);
        v2.lent = v2.lent + arg4;
        let v5 = v2.apr_bps;
        assert!(0x2::balance::value<T0>(&arg1.cash) >= arg1.reserved + arg4, 13906554967109926921);
        let v6 = 0x2::coin::take<T0>(&mut arg1.cash, arg4, arg6);
        let v7 = 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::market::fee_of(arg4, 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::fee_bps(arg0));
        assert!(v7 < arg4, 13898110734989262869);
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v6, v7, arg6), 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::fee_recipient(arg0));
        };
        arg1.lent = arg1.lent + arg4;
        (0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, v4, arg6)), v6, v7, v3, v5)
    }

    public fun lending<T0>(arg0: &Vault<T0>) : bool {
        arg0.lending
    }

    public fun lent<T0>(arg0: &Vault<T0>) : u64 {
        arg0.lent
    }

    public fun liq_ltv_bps<T0, T1>(arg0: &Vault<T0>) : u64 {
        let v0 = SafeKey<T1>{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<SafeKey<T1>, SafeRule>(&arg0.id, v0)) {
            return 0
        };
        let v1 = SafeKey<T1>{dummy_field: false};
        0x2::dynamic_field::borrow<SafeKey<T1>, SafeRule>(&arg0.id, v1).liq_ltv_bps
    }

    public fun locked_profit_at<T0>(arg0: &Vault<T0>, arg1: u64) : u64 {
        let v0 = if (arg0.locked_profit == 0) {
            true
        } else if (arg1 >= arg0.unlock_end_ms) {
            true
        } else {
            arg0.unlock_end_ms <= arg0.locked_at_ms
        };
        if (v0) {
            return 0
        };
        (((arg0.locked_profit as u128) * ((arg0.unlock_end_ms - arg1) as u128) / ((arg0.unlock_end_ms - arg0.locked_at_ms) as u128)) as u64)
    }

    public fun merge(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::Config, arg1: &mut Share, arg2: Share) {
        0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::assert_version(arg0);
        let Share {
            id            : v0,
            vault_id      : v1,
            shares        : v2,
            unlock_ms     : v3,
            pending       : v4,
            ready_ms      : v5,
            pending_value : v6,
        } = arg2;
        assert!(v1 == arg1.vault_id, 13896984461419741197);
        assert!(arg1.pending == 0 || v4 == 0, 13896702990739308577);
        arg1.shares = arg1.shares + v2;
        arg1.pending = arg1.pending + v4;
        arg1.pending_value = arg1.pending_value + v6;
        if (v3 > arg1.unlock_ms) {
            arg1.unlock_ms = v3;
        };
        if (v5 > arg1.ready_ms) {
            arg1.ready_ms = v5;
        };
        0x2::object::delete(v0);
    }

    public fun min_loan<T0>(arg0: &Vault<T0>) : u64 {
        arg0.min_loan
    }

    public fun pending(arg0: &Share) : u128 {
        arg0.pending
    }

    public fun pending_value(arg0: &Share) : u64 {
        arg0.pending_value
    }

    public fun ready_ms(arg0: &Share) : u64 {
        arg0.ready_ms
    }

    public fun request_withdraw<T0>(arg0: &mut Vault<T0>, arg1: &mut Share, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0>>(arg0), 13896984113527390221);
        assert!(arg0.held_coins == 0, 13890228731267776549);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg1.unlock_ms, 13898391514181402647);
        assert!(arg2 > 0 && arg2 <= arg1.shares, 13897265618569003023);
        if (arg1.pending > 0) {
            let v1 = value_of<T0>(arg0, arg1.pending, arg3);
            if (v1 < arg1.pending_value) {
                let v2 = arg1.pending_value - v1;
                let v3 = if (arg0.reserved > v2) {
                    arg0.reserved - v2
                } else {
                    0
                };
                arg0.reserved = v3;
                arg1.pending_value = v1;
            };
        };
        let v4 = value_of<T0>(arg0, arg2, arg3);
        arg0.reserved = arg0.reserved + v4;
        arg1.pending_value = arg1.pending_value + v4;
        arg1.shares = arg1.shares - arg2;
        arg1.pending = arg1.pending + arg2;
        arg1.ready_ms = v0 + arg0.withdraw_delay_ms;
        let v5 = WithdrawRequested<T0>{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            share_id : 0x2::object::id<Share>(arg1),
            owner    : 0x2::tx_context::sender(arg4),
            shares   : arg2,
            pending  : arg1.pending,
            ready_ms : arg1.ready_ms,
        };
        0x2::event::emit<WithdrawRequested<T0>>(v5);
    }

    public fun reserved<T0>(arg0: &Vault<T0>) : u64 {
        arg0.reserved
    }

    public fun rule_feed_id<T0, T1>(arg0: &Vault<T0>) : 0x2::object::ID {
        let v0 = RuleKey<T1>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<RuleKey<T1>, CoinRule>(&arg0.id, v0), 13905711641691029507);
        let v1 = RuleKey<T1>{dummy_field: false};
        0x2::dynamic_field::borrow<RuleKey<T1>, CoinRule>(&arg0.id, v1).feed_id
    }

    public fun safe_min_delay_ms() : u64 {
        3600000
    }

    public fun sell_held<T0, T1>(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::Config, arg1: &CuratorCap, arg2: &mut Vault<T0>, arg3: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::oracle::PriceFeed<T1, T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, SaleReceipt<T0, T1>) {
        0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::assert_version(arg0);
        let v0 = 0x2::object::id<Vault<T0>>(arg2);
        assert!(arg1.vault_id == v0, 13896985543751499789);
        let v1 = RuleKey<T1>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<RuleKey<T1>, CoinRule>(&arg2.id, v1), 13905711272323842051);
        let v2 = RuleKey<T1>{dummy_field: false};
        assert!(0x2::dynamic_field::borrow<RuleKey<T1>, CoinRule>(&arg2.id, v2).feed_id == 0x2::object::id<0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::oracle::PriceFeed<T1, T0>>(arg3), 13905992755890618373);
        let v3 = HeldKey<T1>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<HeldKey<T1>, 0x2::balance::Balance<T1>>(&arg2.id, v3), 13897267035908210703);
        let v4 = HeldKey<T1>{dummy_field: false};
        let v5 = 0x2::dynamic_field::borrow_mut<HeldKey<T1>, 0x2::balance::Balance<T1>>(&mut arg2.id, v4);
        assert!(arg4 > 0 && arg4 <= 0x2::balance::value<T1>(v5), 13897267048793112591);
        let v6 = (((arg4 as u256) * (0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::oracle::ema_price<T1, T0>(arg3, arg5, arg6) as u256) >> 64) * (arg2.sale_floor_bps as u256) + (10000 as u256) - 1) / (10000 as u256);
        let v7 = if (v6 == 0) {
            1
        } else {
            (v6 as u64)
        };
        let v8 = SaleReceipt<T0, T1>{
            vault_id : v0,
            sold     : arg4,
            min_out  : v7,
            emptied  : 0x2::balance::value<T1>(v5) == 0,
        };
        (0x2::coin::take<T1>(v5, arg4, arg6), v8)
    }

    public fun set_lending<T0>(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::AdminCap, arg1: &mut Vault<T0>, arg2: bool) {
        arg1.lending = arg2;
    }

    public fun set_min_loan<T0>(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::AdminCap, arg1: &mut Vault<T0>, arg2: u64) {
        assert!(arg2 > 0, 13905428178144329729);
        arg1.min_loan = arg2;
        let v0 = MinLoanSet<T0>{
            vault_id : 0x2::object::id<Vault<T0>>(arg1),
            min_loan : arg2,
        };
        0x2::event::emit<MinLoanSet<T0>>(v0);
    }

    public fun set_rule<T0, T1>(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::AdminCap, arg1: &mut Vault<T0>, arg2: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::oracle::PriceFeed<T1, T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool) {
        assert!(arg3 > 0 && arg3 <= 5000, 13905428049295310849);
        assert!(arg4 <= 0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::market::max_apr_bps(), 13905428053590278145);
        assert!(arg5 > 0 && arg5 <= 10000, 13905428057885245441);
        let v0 = 0x2::object::id<0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::oracle::PriceFeed<T1, T0>>(arg2);
        let v1 = liq_ltv_bps<T0, T1>(arg1);
        assert!(v1 == 0 || arg3 < v1, 13905428075065114625);
        let v2 = RuleKey<T1>{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<RuleKey<T1>, CoinRule>(&arg1.id, v2)) {
            let v3 = RuleKey<T1>{dummy_field: false};
            let v4 = 0x2::dynamic_field::borrow_mut<RuleKey<T1>, CoinRule>(&mut arg1.id, v3);
            v4.feed_id = v0;
            v4.ltv_bps = arg3;
            v4.apr_bps = arg4;
            v4.cap_bps = arg5;
            v4.max_lent = arg6;
            v4.enabled = arg7;
        } else {
            let v5 = RuleKey<T1>{dummy_field: false};
            let v6 = CoinRule{
                feed_id  : v0,
                ltv_bps  : arg3,
                apr_bps  : arg4,
                cap_bps  : arg5,
                max_lent : arg6,
                enabled  : arg7,
                lent     : 0,
            };
            0x2::dynamic_field::add<RuleKey<T1>, CoinRule>(&mut arg1.id, v5, v6);
        };
        let v7 = RuleSet<T0, T1>{
            vault_id : 0x2::object::id<Vault<T0>>(arg1),
            feed_id  : v0,
            ltv_bps  : arg3,
            apr_bps  : arg4,
            cap_bps  : arg5,
            max_lent : arg6,
            enabled  : arg7,
        };
        0x2::event::emit<RuleSet<T0, T1>>(v7);
    }

    public fun set_safe_rule<T0, T1>(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::AdminCap, arg1: &mut Vault<T0>, arg2: u64) {
        let v0 = RuleKey<T1>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<RuleKey<T1>, CoinRule>(&arg1.id, v0), 13905711121999986691);
        let v1 = RuleKey<T1>{dummy_field: false};
        assert!(arg2 > 0x2::dynamic_field::borrow<RuleKey<T1>, CoinRule>(&arg1.id, v1).ltv_bps && arg2 <= 8000, 13905429655613079553);
        let v2 = SafeKey<T1>{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<SafeKey<T1>, SafeRule>(&arg1.id, v2)) {
            let v3 = SafeKey<T1>{dummy_field: false};
            0x2::dynamic_field::borrow_mut<SafeKey<T1>, SafeRule>(&mut arg1.id, v3).liq_ltv_bps = arg2;
        } else {
            let v4 = SafeKey<T1>{dummy_field: false};
            let v5 = SafeRule{liq_ltv_bps: arg2};
            0x2::dynamic_field::add<SafeKey<T1>, SafeRule>(&mut arg1.id, v4, v5);
        };
        let v6 = SafeRuleSet<T0, T1>{
            vault_id    : 0x2::object::id<Vault<T0>>(arg1),
            liq_ltv_bps : arg2,
        };
        0x2::event::emit<SafeRuleSet<T0, T1>>(v6);
    }

    public(friend) fun settle_principal<T0, T1>(arg0: &mut Vault<T0>, arg1: u64) {
        arg0.lent = arg0.lent - arg1;
        let v0 = RuleKey<T1>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<RuleKey<T1>, CoinRule>(&mut arg0.id, v0);
        v1.lent = v1.lent - arg1;
    }

    public fun settle_sale<T0, T1>(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::Config, arg1: &mut Vault<T0>, arg2: SaleReceipt<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock) {
        0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::assert_version(arg0);
        let SaleReceipt {
            vault_id : v0,
            sold     : v1,
            min_out  : v2,
            emptied  : v3,
        } = arg2;
        assert!(v0 == 0x2::object::id<Vault<T0>>(arg1), 13896985724140126221);
        let v4 = 0x2::coin::value<T0>(&arg3);
        assert!(v4 >= v2, 13897830157660586003);
        0x2::balance::join<T0>(&mut arg1.cash, 0x2::coin::into_balance<T0>(arg3));
        if (v3) {
            arg1.held_coins = arg1.held_coins - 1;
        };
        let v5 = CollateralSold<T0, T1>{
            vault_id : v0,
            sold     : v1,
            received : v4,
        };
        0x2::event::emit<CollateralSold<T0, T1>>(v5);
    }

    public fun share_vault_id(arg0: &Share) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun shares(arg0: &Share) : u128 {
        arg0.shares
    }

    fun shares_for<T0>(arg0: &Vault<T0>, arg1: u64, arg2: &0x2::clock::Clock) : u128 {
        shares_for_amount(arg1, total_assets<T0>(arg0, arg2), arg0.total_shares)
    }

    public fun shares_for_amount(arg0: u64, arg1: u64, arg2: u128) : u128 {
        (((arg0 as u256) * ((arg2 as u256) + 1000000) / ((arg1 as u256) + 1)) as u128)
    }

    public fun term_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.term_ms
    }

    public fun total_assets<T0>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.cash) + arg0.lent;
        let v1 = locked_profit_at<T0>(arg0, 0x2::clock::timestamp_ms(arg1));
        if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    public fun total_shares<T0>(arg0: &Vault<T0>) : u128 {
        arg0.total_shares
    }

    public fun unlock_end_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.unlock_end_ms
    }

    public fun unlock_ms(arg0: &Share) : u64 {
        arg0.unlock_ms
    }

    public fun value_of<T0>(arg0: &Vault<T0>, arg1: u128, arg2: &0x2::clock::Clock) : u64 {
        value_of_shares(arg1, total_assets<T0>(arg0, arg2), arg0.total_shares)
    }

    public fun value_of_shares(arg0: u128, arg1: u64, arg2: u128) : u64 {
        (((arg0 as u256) * ((arg1 as u256) + 1) / ((arg2 as u256) + 1000000)) as u64)
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: &mut Share, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0>>(arg0), 13896984255261310989);
        let v0 = arg1.pending;
        assert!(v0 > 0, 13899236063665979421);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.ready_ms, 13898954592984104987);
        let v1 = value_of<T0>(arg0, v0, arg2);
        let v2 = arg1.pending_value;
        let v3 = if (v1 < v2) {
            v1
        } else {
            v2
        };
        assert!(v3 <= 0x2::balance::value<T0>(&arg0.cash), 13906554434533982217);
        let v4 = if (arg0.reserved > v2) {
            arg0.reserved - v2
        } else {
            0
        };
        arg0.reserved = v4;
        arg1.pending = 0;
        arg1.pending_value = 0;
        arg0.total_shares = arg0.total_shares - v0;
        let v5 = Withdrawn<T0>{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            share_id : 0x2::object::id<Share>(arg1),
            owner    : 0x2::tx_context::sender(arg3),
            amount   : v3,
            shares   : v0,
        };
        0x2::event::emit<Withdrawn<T0>>(v5);
        0x2::coin::take<T0>(&mut arg0.cash, v3, arg3)
    }

    public fun withdraw_delay_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.withdraw_delay_ms
    }

    public fun write_off_held<T0, T1>(arg0: &0xed3220b79cb14da863fe5cb746a3a69a47c1be4080ddc60b63c1defdff98f8c3::config::AdminCap, arg1: &mut Vault<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = HeldKey<T1>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<HeldKey<T1>, 0x2::balance::Balance<T1>>(&arg1.id, v0), 13897267108922654735);
        let v1 = HeldSinceKey<T1>{dummy_field: false};
        assert!(0x2::clock::timestamp_ms(arg2) >= *0x2::dynamic_field::borrow<HeldSinceKey<T1>, u64>(&arg1.id, v1) + 604800000, 13891074668026265635);
        let v2 = HeldKey<T1>{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<HeldKey<T1>, 0x2::balance::Balance<T1>>(&mut arg1.id, v2);
        let v4 = 0x2::balance::value<T1>(v3);
        assert!(v4 > 0, 13897267130397491215);
        arg1.held_coins = arg1.held_coins - 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(v3, v4, arg3), @0x0);
        let v5 = HeldWrittenOff<T0, T1>{
            vault_id : 0x2::object::id<Vault<T0>>(arg1),
            amount   : v4,
        };
        0x2::event::emit<HeldWrittenOff<T0, T1>>(v5);
    }

    // decompiled from Move bytecode v7
}

