module 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::credit {
    struct CreditBudget<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        funds: 0x2::balance::Balance<T0>,
        period: u64,
        granted_in_period: u64,
        credits_total: u64,
        outstanding: u64,
        enroller_epoch: u64,
        purchase_float: 0x2::balance::Balance<T0>,
        ipo_phase: bool,
        stage1_grants: u64,
        cohorts: vector<Cohort>,
        seen: 0x2::table::Table<vector<u8>, bool>,
        att: 0x2::table::Table<0x2::object::ID, Att>,
        hash_vault: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
        attempts: 0x2::table::Table<vector<u8>, u64>,
        vault_owner: 0x2::table::Table<0x2::object::ID, address>,
        open_buys: 0x2::table::Table<address, u64>,
        returned_t: 0x2::balance::Balance<T0>,
        returned_u: 0x2::balance::Balance<T1>,
    }

    struct EnrollerCap has key {
        id: 0x2::object::UID,
        budget: 0x2::object::ID,
        epoch: u64,
        daily_limit: u64,
        day: u64,
        granted_today: u64,
    }

    struct CreditVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        owner: address,
        budget: 0x2::object::ID,
        principal: u64,
        soos: 0x2::balance::Balance<T0>,
        usdc: 0x2::balance::Balance<T1>,
        opened_ms: u64,
        day: u64,
        traded_today: u64,
        closed: bool,
        buy_open: bool,
        held: 0x2::balance::Balance<T0>,
        lots: vector<Lot>,
    }

    struct Abuse has copy, drop {
        vault: 0x2::object::ID,
        why: u8,
    }

    struct Lot has copy, drop, store {
        amount: u64,
        until_ms: u64,
    }

    struct Cohort has copy, drop, store {
        day: u64,
        grants: u64,
        abuse: u64,
    }

    struct Att has drop, store {
        stage1: bool,
        purchased: bool,
        opened_ms: u64,
        principal: u64,
        counted: bool,
        locked: bool,
        abuse: bool,
        gains_frozen: bool,
    }

    struct SaleTicket {
        vault: 0x2::object::ID,
        min_out: u64,
    }

    struct BuyTicket {
        vault: 0x2::object::ID,
        min_out: u64,
    }

    struct Granted has copy, drop {
        vault: 0x2::object::ID,
        owner: address,
        amount: u64,
        period: u64,
    }

    struct Sale has copy, drop {
        vault: 0x2::object::ID,
        soos: u64,
        usdc_value: u64,
        min_out: u64,
        consent: vector<u8>,
    }

    struct Purchased has copy, drop {
        vault: 0x2::object::ID,
        buyer: address,
        usdc: u64,
        soos: u64,
        held_until_ms: u64,
    }

    struct CollisionReported has copy, drop {
        budget: 0x2::object::ID,
        vault: 0x2::object::ID,
        tag: vector<u8>,
        commitment: vector<u8>,
        attempter: address,
        attempt_ms: u64,
        vault_opened_ms: u64,
        enroller_epoch: u64,
        newly_abuse: bool,
    }

    struct AttemptRecorded has copy, drop {
        budget: 0x2::object::ID,
        attempter: address,
        commitment: vector<u8>,
        at_ms: u64,
    }

    struct CountedReturned has copy, drop {
        vault: 0x2::object::ID,
        principal: u64,
    }

    struct PhaseSet has copy, drop {
        budget: 0x2::object::ID,
        ipo_phase: bool,
    }

    struct GiftUnlocked has copy, drop {
        vault: 0x2::object::ID,
    }

    struct Reclaimed has copy, drop {
        vault: 0x2::object::ID,
        soos: u64,
        usdc: u64,
    }

    fun add_cohort<T0, T1>(arg0: &mut CreditBudget<T0, T1>, arg1: u64) {
        let v0 = 0x1::vector::length<Cohort>(&arg0.cohorts);
        if (v0 > 0 && 0x1::vector::borrow<Cohort>(&arg0.cohorts, v0 - 1).day == arg1) {
            let v1 = 0x1::vector::borrow_mut<Cohort>(&mut arg0.cohorts, v0 - 1);
            v1.grants = v1.grants + 1;
        } else {
            let v2 = Cohort{
                day    : arg1,
                grants : 1,
                abuse  : 0,
            };
            0x1::vector::push_back<Cohort>(&mut arg0.cohorts, v2);
        };
    }

    fun assert_active<T0, T1>(arg0: &CreditVault<T0, T1>, arg1: &CreditBudget<T0, T1>, arg2: &0x2::clock::Clock) {
        assert!(!arg0.closed && 0x2::clock::timestamp_ms(arg2) < expires_ms<T0, T1>(arg0, arg1), 204);
    }

    fun assert_unlocked<T0, T1>(arg0: &CreditVault<T0, T1>, arg1: &CreditBudget<T0, T1>) {
        assert!(!0x2::table::borrow<0x2::object::ID, Att>(&arg1.att, 0x2::object::id<CreditVault<T0, T1>>(arg0)).locked, 219);
    }

    fun att_expires(arg0: &Att) : u64 {
        arg0.opened_ms + 30 * 86400000
    }

    fun attempt_key(arg0: vector<u8>, arg1: vector<u8>, arg2: address) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, arg1);
        0x1::vector::append<u8>(&mut arg0, 0x2::address::to_bytes(arg2));
        0x1::hash::sha3_256(arg0)
    }

    public fun begin_buy<T0, T1>(arg0: &mut CreditVault<T0, T1>, arg1: &mut CreditBudget<T0, T1>, arg2: &mut 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::Guard, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::Junction, arg5: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::JunctionHalt, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, BuyTicket) {
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::assert_live(arg4, arg5);
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::sample<T1, T0>(arg2, arg3, arg8, arg9);
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::assert_open(arg2, arg8);
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::assert_sale_sane<T1, T0>(arg2, arg3);
        assert!(0x2::tx_context::sender(arg9) == arg0.owner, 203);
        assert_active<T0, T1>(arg0, arg1, arg8);
        assert_unlocked<T0, T1>(arg0, arg1);
        assert!(!arg0.buy_open, 224);
        arg0.buy_open = true;
        let v0 = arg0.owner;
        if (0x2::table::contains<address, u64>(&arg1.open_buys, v0)) {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg1.open_buys, v0);
            *v1 = *v1 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg1.open_buys, v0, 1);
        };
        let v2 = ((((((arg6 as u128) * 1000000 / (0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::price_lo<T1, T0>(arg2, arg3) as u128)) as u64) as u128) * ((10000 - 100) as u128) / 10000) as u64);
        assert!(v2 > 0, 217);
        let v3 = if (arg7 > v2) {
            arg7
        } else {
            v2
        };
        let v4 = BuyTicket{
            vault   : 0x2::object::id<CreditVault<T0, T1>>(arg0),
            min_out : v3,
        };
        (0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.usdc, arg6), arg9), v4)
    }

    public fun begin_sale<T0, T1>(arg0: &mut CreditVault<T0, T1>, arg1: &CreditBudget<T0, T1>, arg2: &mut 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::Guard, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::Junction, arg5: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::JunctionHalt, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, SaleTicket) {
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::assert_live(arg4, arg5);
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::sample<T1, T0>(arg2, arg3, arg9, arg10);
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::assert_open(arg2, arg9);
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::assert_sale_sane<T1, T0>(arg2, arg3);
        assert!(0x2::tx_context::sender(arg10) == arg0.owner, 203);
        assert!(0x1::vector::length<u8>(&arg8) == 32, 213);
        assert_active<T0, T1>(arg0, arg1, arg9);
        assert_unlocked<T0, T1>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg9) / 86400000;
        if (v0 != arg0.day) {
            arg0.day = v0;
            arg0.traded_today = 0;
        };
        assert!(arg0.traded_today + arg6 <= 3000000000, 206);
        arg0.traded_today = arg0.traded_today + arg6;
        let v1 = 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::usdc_value(arg2, arg6);
        let v2 = ((((((arg6 as u128) * (0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::price_hi<T1, T0>(arg2, arg3) as u128) / 1000000) as u64) as u128) * ((10000 - 100) as u128) / 10000) as u64);
        assert!(v2 > 0, 217);
        let v3 = if (arg7 > v2) {
            arg7
        } else {
            v2
        };
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::record_sale(arg2, v1, arg9);
        let v4 = Sale{
            vault      : 0x2::object::id<CreditVault<T0, T1>>(arg0),
            soos       : arg6,
            usdc_value : v1,
            min_out    : v3,
            consent    : arg8,
        };
        0x2::event::emit<Sale>(v4);
        let v5 = SaleTicket{
            vault   : 0x2::object::id<CreditVault<T0, T1>>(arg0),
            min_out : v3,
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.soos, arg6), arg10), v5)
    }

    public fun commitment(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, arg1);
        0x1::hash::sha3_256(arg0)
    }

    public fun count_expired<T0, T1>(arg0: &mut CreditBudget<T0, T1>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Att>(&mut arg0.att, arg1);
        assert!(!v0.counted && 0x2::clock::timestamp_ms(arg2) >= att_expires(v0), 204);
        v0.counted = true;
        let v1 = v0.principal;
        arg0.outstanding = arg0.outstanding - v1;
        let v2 = CountedReturned{
            vault     : arg1,
            principal : v1,
        };
        0x2::event::emit<CountedReturned>(v2);
    }

    public fun create_budget<T0, T1>(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::Guard, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = CreditBudget<T0, T1>{
            id                : 0x2::object::new(arg3),
            funds             : 0x2::balance::zero<T0>(),
            period            : 0,
            granted_in_period : 0,
            credits_total     : 0,
            outstanding       : 0,
            enroller_epoch    : 0,
            purchase_float    : 0x2::balance::zero<T0>(),
            ipo_phase         : true,
            stage1_grants     : 0,
            cohorts           : 0x1::vector::empty<Cohort>(),
            seen              : 0x2::table::new<vector<u8>, bool>(arg3),
            att               : 0x2::table::new<0x2::object::ID, Att>(arg3),
            hash_vault        : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg3),
            attempts          : 0x2::table::new<vector<u8>, u64>(arg3),
            vault_owner       : 0x2::table::new<0x2::object::ID, address>(arg3),
            open_buys         : 0x2::table::new<address, u64>(arg3),
            returned_t        : 0x2::balance::zero<T0>(),
            returned_u        : 0x2::balance::zero<T1>(),
        };
        let v1 = &mut v0;
        fund<T0, T1>(arg0, v1, arg1, arg2);
        0x2::transfer::share_object<CreditBudget<T0, T1>>(v0);
    }

    public fun credit_amount() : u64 {
        15000000000
    }

    public fun credits_total<T0, T1>(arg0: &CreditBudget<T0, T1>) : u64 {
        arg0.credits_total
    }

    public fun expires_ms<T0, T1>(arg0: &CreditVault<T0, T1>, arg1: &CreditBudget<T0, T1>) : u64 {
        assert!(arg0.budget == 0x2::object::id<CreditBudget<T0, T1>>(arg1), 211);
        att_expires(0x2::table::borrow<0x2::object::ID, Att>(&arg1.att, 0x2::object::id<CreditVault<T0, T1>>(arg0)))
    }

    public fun finish_buy<T0, T1>(arg0: &mut CreditVault<T0, T1>, arg1: &mut CreditBudget<T0, T1>, arg2: BuyTicket, arg3: 0x2::coin::Coin<T0>) {
        let BuyTicket {
            vault   : v0,
            min_out : v1,
        } = arg2;
        assert!(v0 == 0x2::object::id<CreditVault<T0, T1>>(arg0), 211);
        assert!(0x2::coin::value<T0>(&arg3) >= v1, 207);
        assert!(arg0.budget == 0x2::object::id<CreditBudget<T0, T1>>(arg1), 211);
        arg0.buy_open = false;
        let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg1.open_buys, arg0.owner);
        *v2 = *v2 - 1;
        0x2::balance::join<T0>(&mut arg0.soos, 0x2::coin::into_balance<T0>(arg3));
    }

    public fun finish_sale<T0, T1>(arg0: &mut CreditVault<T0, T1>, arg1: SaleTicket, arg2: 0x2::coin::Coin<T1>) {
        let SaleTicket {
            vault   : v0,
            min_out : v1,
        } = arg1;
        assert!(v0 == 0x2::object::id<CreditVault<T0, T1>>(arg0), 211);
        assert!(0x2::coin::value<T1>(&arg2) >= v1, 207);
        0x2::balance::join<T1>(&mut arg0.usdc, 0x2::coin::into_balance<T1>(arg2));
    }

    public fun fund<T0, T1>(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &mut CreditBudget<T0, T1>, arg2: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::Guard, arg3: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg1.funds, 0x2::coin::into_balance<T0>(arg3));
        let v0 = if (0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::twap24(arg2) == 0) {
            1618000000000
        } else {
            period_cap(arg2)
        };
        assert!(0x2::balance::value<T0>(&arg1.funds) <= v0, 200);
    }

    public fun fund_purchase_float<T0, T1>(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &mut CreditBudget<T0, T1>, arg2: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg1.purchase_float, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun funds<T0, T1>(arg0: &CreditBudget<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun gains_frozen<T0, T1>(arg0: &CreditBudget<T0, T1>, arg1: 0x2::object::ID) : bool {
        0x2::table::borrow<0x2::object::ID, Att>(&arg0.att, arg1).gains_frozen
    }

    public fun grant<T0, T1>(arg0: &mut EnrollerCap, arg1: &mut CreditBudget<T0, T1>, arg2: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::Guard, arg3: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::Junction, arg4: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::JunctionHalt, arg5: u8, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::assert_live(arg3, arg4);
        assert!(arg5 <= 2, 214);
        assert!(arg5 == 2 == 0x1::vector::is_empty<u8>(&arg7), 214);
        assert!(arg0.budget == 0x2::object::id<CreditBudget<T0, T1>>(arg1), 211);
        assert!(arg0.epoch == arg1.enroller_epoch, 216);
        let v0 = 0x2::clock::timestamp_ms(arg10);
        let v1 = v0 / 86400000;
        if (v1 != arg0.day) {
            arg0.day = v1;
            arg0.granted_today = 0;
        };
        assert!(arg0.granted_today < arg0.daily_limit, 215);
        arg0.granted_today = arg0.granted_today + 1;
        let v2 = v0 / 2592000000;
        if (v2 != arg1.period) {
            arg1.period = v2;
            arg1.granted_in_period = 0;
        };
        assert!(arg1.granted_in_period + 15000000000 <= period_cap(arg2) && 0x2::balance::value<T0>(&arg1.funds) >= 15000000000, 202);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg1.seen, owner_key(arg9)), 225);
        0x2::table::add<vector<u8>, bool>(&mut arg1.seen, owner_key(arg9), true);
        mark<T0, T1>(arg1, b"z", arg6);
        if (!0x1::vector::is_empty<u8>(&arg7)) {
            mark<T0, T1>(arg1, b"d", arg7);
        };
        mark<T0, T1>(arg1, b"p", arg8);
        arg1.granted_in_period = arg1.granted_in_period + 15000000000;
        arg1.credits_total = arg1.credits_total + 1;
        if (arg1.ipo_phase) {
            arg1.stage1_grants = arg1.stage1_grants + 1;
            add_cohort<T0, T1>(arg1, v0 / 86400000);
        };
        arg1.outstanding = arg1.outstanding + 15000000000;
        let v3 = CreditVault<T0, T1>{
            id           : 0x2::object::new(arg11),
            owner        : arg9,
            budget       : 0x2::object::id<CreditBudget<T0, T1>>(arg1),
            principal    : 15000000000,
            soos         : 0x2::balance::split<T0>(&mut arg1.funds, 15000000000),
            usdc         : 0x2::balance::zero<T1>(),
            opened_ms    : v0,
            day          : 0,
            traded_today : 0,
            closed       : false,
            buy_open     : false,
            held         : 0x2::balance::zero<T0>(),
            lots         : 0x1::vector::empty<Lot>(),
        };
        let v4 = Att{
            stage1       : arg1.ipo_phase,
            purchased    : false,
            opened_ms    : v0,
            principal    : 15000000000,
            counted      : false,
            locked       : arg1.ipo_phase,
            abuse        : false,
            gains_frozen : false,
        };
        0x2::table::add<0x2::object::ID, Att>(&mut arg1.att, 0x2::object::id<CreditVault<T0, T1>>(&v3), v4);
        let v5 = 0x2::object::id<CreditVault<T0, T1>>(&v3);
        0x2::table::add<0x2::object::ID, address>(&mut arg1.vault_owner, v5, arg9);
        record<T0, T1>(arg1, b"z", arg6, v5);
        if (!0x1::vector::is_empty<u8>(&arg7)) {
            record<T0, T1>(arg1, b"d", arg7, v5);
        };
        record<T0, T1>(arg1, b"p", arg8, v5);
        let v6 = Granted{
            vault  : 0x2::object::id<CreditVault<T0, T1>>(&v3),
            owner  : arg9,
            amount : 15000000000,
            period : v2,
        };
        0x2::event::emit<Granted>(v6);
        0x2::transfer::transfer<CreditVault<T0, T1>>(v3, arg9);
    }

    public fun held<T0, T1>(arg0: &CreditVault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.held)
    }

    public fun held_until<T0, T1>(arg0: &CreditVault<T0, T1>) : u64 {
        let v0 = 0;
        let v1 = &arg0.lots;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Lot>(v1)) {
            let v3 = 0x1::vector::borrow<Lot>(v1, v2);
            if (v0 == 0 || v3.until_ms < v0) {
                v0 = v3.until_ms;
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun hold_ms() : u64 {
        604800000
    }

    public fun ipo_phase<T0, T1>(arg0: &CreditBudget<T0, T1>) : bool {
        arg0.ipo_phase
    }

    public fun is_abuse<T0, T1>(arg0: &CreditBudget<T0, T1>, arg1: 0x2::object::ID) : bool {
        0x2::table::borrow<0x2::object::ID, Att>(&arg0.att, arg1).abuse
    }

    public fun is_closed<T0, T1>(arg0: &CreditVault<T0, T1>) : bool {
        arg0.closed
    }

    public fun is_held<T0, T1>(arg0: &CreditVault<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        let v0 = false;
        let v1 = &arg0.lots;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Lot>(v1)) {
            if (0x2::clock::timestamp_ms(arg1) < 0x1::vector::borrow<Lot>(v1, v2).until_ms) {
                v0 = true;
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun is_locked<T0, T1>(arg0: &CreditBudget<T0, T1>, arg1: 0x2::object::ID) : bool {
        0x2::table::borrow<0x2::object::ID, Att>(&arg0.att, arg1).locked
    }

    public fun issue_enroller<T0, T1>(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &CreditBudget<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 <= 100, 215);
        let v0 = EnrollerCap{
            id            : 0x2::object::new(arg3),
            budget        : 0x2::object::id<CreditBudget<T0, T1>>(arg1),
            epoch         : arg1.enroller_epoch,
            daily_limit   : arg2,
            day           : 0,
            granted_today : 0,
        };
        0x2::transfer::transfer<EnrollerCap>(v0, @0x4b178f7855b2e84ae9c1585093009bb6c212cd3b5ccf9c76672dda04be087e0);
    }

    public fun lot_count<T0, T1>(arg0: &CreditVault<T0, T1>) : u64 {
        0x1::vector::length<Lot>(&arg0.lots)
    }

    public fun lot_until<T0, T1>(arg0: &CreditVault<T0, T1>, arg1: u64) : u64 {
        0x1::vector::borrow<Lot>(&arg0.lots, arg1).until_ms
    }

    fun mark<T0, T1>(arg0: &mut CreditBudget<T0, T1>, arg1: vector<u8>, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 210);
        0x1::vector::append<u8>(&mut arg1, arg2);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.seen, arg1), 201);
        0x2::table::add<vector<u8>, bool>(&mut arg0.seen, arg1, true);
    }

    fun mark_abuse<T0, T1>(arg0: &mut CreditBudget<T0, T1>, arg1: 0x2::object::ID, arg2: u8) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Att>(&mut arg0.att, arg1);
        if (!v0.stage1 || v0.abuse) {
            return
        };
        v0.abuse = true;
        let v1 = v0.opened_ms / 86400000;
        let v2 = 0x1::vector::length<Cohort>(&arg0.cohorts);
        while (v2 > 0) {
            v2 = v2 - 1;
            if (0x1::vector::borrow<Cohort>(&arg0.cohorts, v2).day == v1) {
                let v3 = 0x1::vector::borrow_mut<Cohort>(&mut arg0.cohorts, v2);
                v3.abuse = v3.abuse + 1;
                break
            };
        };
        let v4 = Abuse{
            vault : arg1,
            why   : arg2,
        };
        0x2::event::emit<Abuse>(v4);
    }

    public fun matured<T0, T1>(arg0: &CreditBudget<T0, T1>, arg1: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = &arg0.cohorts;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Cohort>(v2)) {
            let v4 = 0x1::vector::borrow<Cohort>(v2, v3);
            if (v4.day + 30 + 1 <= 0x2::clock::timestamp_ms(arg1) / 86400000) {
                v0 = v0 + v4.grants;
                v1 = v1 + v4.abuse;
            };
            v3 = v3 + 1;
        };
        (v0, v1)
    }

    public fun open_buys<T0, T1>(arg0: &CreditBudget<T0, T1>, arg1: address) : u64 {
        open_buys_of<T0, T1>(arg0, arg1)
    }

    fun open_buys_of<T0, T1>(arg0: &CreditBudget<T0, T1>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.open_buys, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.open_buys, arg1)
        } else {
            0
        }
    }

    public fun outstanding<T0, T1>(arg0: &CreditBudget<T0, T1>) : u64 {
        arg0.outstanding
    }

    public fun own_purchase<T0, T1>(arg0: &mut CreditVault<T0, T1>, arg1: &mut CreditBudget<T0, T1>, arg2: &mut 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::Guard, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::Junction, arg5: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::JunctionHalt, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::assert_live(arg4, arg5);
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::sample<T1, T0>(arg2, arg3, arg7, arg8);
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::assert_priced(arg2, arg7);
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::assert_ipo_band<T1, T0>(arg2, arg3);
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::assert_sale_sane<T1, T0>(arg2, arg3);
        assert!(open_buys_of<T0, T1>(arg1, 0x2::tx_context::sender(arg8)) == 0, 224);
        assert!(0x2::tx_context::sender(arg8) == arg0.owner, 203);
        assert!(arg0.budget == 0x2::object::id<CreditBudget<T0, T1>>(arg1), 211);
        assert!(!arg0.buy_open, 224);
        let v0 = 0x2::coin::value<T1>(&arg6);
        assert!(v0 >= 15000000, 212);
        let v1 = (((v0 as u128) * 1000000 / (0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::price_hi<T1, T0>(arg2, arg3) as u128)) as u64);
        assert!(0x2::balance::value<T0>(&arg1.purchase_float) >= v1, 218);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg6, @0x4b178f7855b2e84ae9c1585093009bb6c212cd3b5ccf9c76672dda04be087e0);
        assert!(0x1::vector::length<Lot>(&arg0.lots) < 16, 230);
        let v2 = 0x2::clock::timestamp_ms(arg7) + 604800000;
        0x2::balance::join<T0>(&mut arg0.held, 0x2::balance::split<T0>(&mut arg1.purchase_float, v1));
        let v3 = Lot{
            amount   : v1,
            until_ms : v2,
        };
        0x1::vector::push_back<Lot>(&mut arg0.lots, v3);
        0x2::clock::timestamp_ms(arg7);
        let v4 = 0x2::table::borrow_mut<0x2::object::ID, Att>(&mut arg1.att, 0x2::object::id<CreditVault<T0, T1>>(arg0));
        v4.purchased = true;
        if (v4.locked) {
            v4.locked = false;
            let v5 = GiftUnlocked{vault: 0x2::object::id<CreditVault<T0, T1>>(arg0)};
            0x2::event::emit<GiftUnlocked>(v5);
        };
        let v6 = Purchased{
            vault         : 0x2::object::id<CreditVault<T0, T1>>(arg0),
            buyer         : arg0.owner,
            usdc          : v0,
            soos          : v1,
            held_until_ms : v2,
        };
        0x2::event::emit<Purchased>(v6);
    }

    fun owner_key(arg0: address) : vector<u8> {
        let v0 = b"o";
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        v0
    }

    public fun period_cap(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::Guard) : u64 {
        let v0 = 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::depth_in_soos(arg0);
        if (v0 < 1618000000000) {
            v0
        } else {
            1618000000000
        }
    }

    public fun purchased<T0, T1>(arg0: &CreditBudget<T0, T1>, arg1: 0x2::object::ID) : bool {
        0x2::table::borrow<0x2::object::ID, Att>(&arg0.att, arg1).purchased
    }

    fun record<T0, T1>(arg0: &mut CreditBudget<T0, T1>, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x2::object::ID) {
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg0.hash_vault, arg2, arg3);
    }

    public fun record_attempt<T0, T1>(arg0: &mut CreditBudget<T0, T1>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 210);
        if (0x2::table::contains<vector<u8>, u64>(&arg0.attempts, arg1)) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        0x2::table::add<vector<u8>, u64>(&mut arg0.attempts, arg1, v0);
        let v1 = AttemptRecorded{
            budget     : 0x2::object::id<CreditBudget<T0, T1>>(arg0),
            attempter  : 0x2::tx_context::sender(arg3),
            commitment : arg1,
            at_ms      : v0,
        };
        0x2::event::emit<AttemptRecorded>(v1);
    }

    public fun report_collision<T0, T1>(arg0: &EnrollerCap, arg1: &mut CreditBudget<T0, T1>, arg2: vector<u8>, arg3: vector<u8>, arg4: address) {
        assert!(arg0.budget == 0x2::object::id<CreditBudget<T0, T1>>(arg1), 211);
        assert!(arg0.epoch == arg1.enroller_epoch, 216);
        let v0 = if (0x1::vector::length<u8>(&arg3) == 32) {
            if (arg2 == b"z") {
                true
            } else if (arg2 == b"d") {
                true
            } else {
                arg2 == b"p"
            }
        } else {
            false
        };
        assert!(v0, 210);
        assert!(0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg1.hash_vault, arg3), 226);
        let v1 = *0x2::table::borrow<vector<u8>, 0x2::object::ID>(&arg1.hash_vault, arg3);
        let v2 = attempt_key(arg2, arg3, arg4);
        assert!(0x2::table::contains<vector<u8>, u64>(&arg1.attempts, v2), 228);
        let v3 = *0x2::table::borrow<vector<u8>, u64>(&arg1.attempts, v2);
        let v4 = 0x2::table::borrow<0x2::object::ID, Att>(&arg1.att, v1).opened_ms;
        assert!(v3 > v4 && arg4 != *0x2::table::borrow<0x2::object::ID, address>(&arg1.vault_owner, v1), 228);
        let v5 = 0x2::table::borrow<0x2::object::ID, Att>(&arg1.att, v1).abuse;
        mark_abuse<T0, T1>(arg1, v1, 1);
        let v6 = !v5 && 0x2::table::borrow<0x2::object::ID, Att>(&arg1.att, v1).abuse;
        let v7 = CollisionReported{
            budget          : 0x2::object::id<CreditBudget<T0, T1>>(arg1),
            vault           : v1,
            tag             : arg2,
            commitment      : arg3,
            attempter       : arg4,
            attempt_ms      : v3,
            vault_opened_ms : v4,
            enroller_epoch  : arg0.epoch,
            newly_abuse     : v6,
        };
        0x2::event::emit<CollisionReported>(v7);
    }

    public fun returned_t<T0, T1>(arg0: &CreditBudget<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.returned_t)
    }

    public fun revoke_enrollers<T0, T1>(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &mut CreditBudget<T0, T1>) {
        arg1.enroller_epoch = arg1.enroller_epoch + 1;
    }

    public fun set_phase<T0, T1>(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &mut CreditBudget<T0, T1>, arg2: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::Guard, arg3: bool, arg4: &0x2::clock::Clock) {
        if (!arg3 && arg1.ipo_phase) {
            assert!(0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::depth_held_7d(arg2, 500000000), 220);
            let (v0, v1) = matured<T0, T1>(arg1, arg4);
            assert!(v0 >= 20, 223);
            assert!(v1 * 100 < 5 * v0, 221);
            assert!(0x2::balance::value<T0>(&arg1.funds) <= 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::depth_in_soos(arg2), 222);
        };
        arg1.ipo_phase = arg3;
        let v2 = PhaseSet{
            budget    : 0x2::object::id<CreditBudget<T0, T1>>(arg1),
            ipo_phase : arg3,
        };
        0x2::event::emit<PhaseSet>(v2);
    }

    public fun stage1_abuse_bps<T0, T1>(arg0: &CreditBudget<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        let (v0, v1) = matured<T0, T1>(arg0, arg1);
        if (v0 == 0) {
            10000
        } else {
            v1 * 10000 / v0
        }
    }

    public fun stage1_grants<T0, T1>(arg0: &CreditBudget<T0, T1>) : u64 {
        arg0.stage1_grants
    }

    public fun sweep_returned<T0, T1>(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &mut CreditBudget<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.returned_t), arg2), @0x4b178f7855b2e84ae9c1585093009bb6c212cd3b5ccf9c76672dda04be087e0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg1.returned_u), arg2), @0x4b178f7855b2e84ae9c1585093009bb6c212cd3b5ccf9c76672dda04be087e0);
    }

    public fun touch<T0, T1>(arg0: &mut CreditVault<T0, T1>, arg1: &mut CreditBudget<T0, T1>, arg2: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::Guard, arg3: &0x2::clock::Clock) {
        assert!(arg0.budget == 0x2::object::id<CreditBudget<T0, T1>>(arg1), 211);
        if (arg0.closed || 0x2::clock::timestamp_ms(arg3) < expires_ms<T0, T1>(arg0, arg1)) {
            return
        };
        let v0 = 0x2::object::id<CreditVault<T0, T1>>(arg0);
        if (!0x2::table::borrow<0x2::object::ID, Att>(&arg1.att, v0).counted) {
            count_expired<T0, T1>(arg1, v0, arg3);
        };
        let v1 = 0x2::balance::value<T0>(&arg0.soos);
        let v2 = if (v1 < arg0.principal) {
            v1
        } else {
            arg0.principal
        };
        0x2::balance::join<T0>(&mut arg1.returned_t, 0x2::balance::split<T0>(&mut arg0.soos, v2));
        let v3 = 0;
        if (v2 < arg0.principal) {
            let v4 = 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::usdc_value(arg2, arg0.principal - v2);
            let v5 = if (v4 < 0x2::balance::value<T1>(&arg0.usdc)) {
                v4
            } else {
                0x2::balance::value<T1>(&arg0.usdc)
            };
            v3 = v5;
            0x2::balance::join<T1>(&mut arg1.returned_u, 0x2::balance::split<T1>(&mut arg0.usdc, v5));
        };
        arg0.principal = 0;
        arg0.closed = true;
        let v6 = Reclaimed{
            vault : v0,
            soos  : v2,
            usdc  : v3,
        };
        0x2::event::emit<Reclaimed>(v6);
    }

    public fun vault_owner<T0, T1>(arg0: &CreditVault<T0, T1>) : address {
        arg0.owner
    }

    public fun vault_soos<T0, T1>(arg0: &CreditVault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.soos)
    }

    public fun vault_usdc<T0, T1>(arg0: &CreditVault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.usdc)
    }

    public fun withdraw_gains<T0, T1>(arg0: &mut CreditVault<T0, T1>, arg1: &CreditBudget<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 203);
        assert!(arg0.budget == 0x2::object::id<CreditBudget<T0, T1>>(arg1), 211);
        assert!(0x2::table::borrow<0x2::object::ID, Att>(&arg1.att, 0x2::object::id<CreditVault<T0, T1>>(arg0)).purchased, 208);
        assert!(!0x2::table::borrow<0x2::object::ID, Att>(&arg1.att, 0x2::object::id<CreditVault<T0, T1>>(arg0)).gains_frozen, 229);
        if (!arg0.closed) {
            assert!(0x2::clock::timestamp_ms(arg3) < expires_ms<T0, T1>(arg0, arg1), 204);
        };
        assert!(0x2::balance::value<T0>(&arg0.soos) >= arg0.principal + arg2, 209);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.soos, arg2), arg4)
    }

    public fun withdraw_purchase<T0, T1>(arg0: &mut CreditVault<T0, T1>, arg1: &mut CreditBudget<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 203);
        assert!(arg0.budget == 0x2::object::id<CreditBudget<T0, T1>>(arg1), 211);
        assert!(0x2::balance::value<T0>(&arg0.held) > 0, 227);
        let v0 = false;
        let v1 = &arg0.lots;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Lot>(v1)) {
            if (0x2::clock::timestamp_ms(arg2) < 0x1::vector::borrow<Lot>(v1, v2).until_ms) {
                v0 = true;
            };
            v2 = v2 + 1;
        };
        if (v0) {
            let v3 = 0x2::object::id<CreditVault<T0, T1>>(arg0);
            mark_abuse<T0, T1>(arg1, v3, 2);
            0x2::table::borrow_mut<0x2::object::ID, Att>(&mut arg1.att, v3).gains_frozen = true;
        };
        arg0.lots = 0x1::vector::empty<Lot>();
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.held), arg3)
    }

    public fun withdraw_released<T0, T1>(arg0: &mut CreditVault<T0, T1>, arg1: &CreditBudget<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 203);
        assert!(arg0.budget == 0x2::object::id<CreditBudget<T0, T1>>(arg1), 211);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Lot>(&arg0.lots)) {
            if (0x1::vector::borrow<Lot>(&arg0.lots, v1).until_ms <= 0x2::clock::timestamp_ms(arg2)) {
                v0 = v0 + 0x1::vector::borrow<Lot>(&arg0.lots, v1).amount;
                0x1::vector::remove<Lot>(&mut arg0.lots, v1);
                continue
            };
            v1 = v1 + 1;
        };
        assert!(v0 > 0, 227);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.held, v0), arg3)
    }

    public fun withdraw_usdc_gains<T0, T1>(arg0: &mut CreditVault<T0, T1>, arg1: &CreditBudget<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 203);
        assert!(arg0.budget == 0x2::object::id<CreditBudget<T0, T1>>(arg1), 211);
        assert!(0x2::table::borrow<0x2::object::ID, Att>(&arg1.att, 0x2::object::id<CreditVault<T0, T1>>(arg0)).purchased, 208);
        assert!(!0x2::table::borrow<0x2::object::ID, Att>(&arg1.att, 0x2::object::id<CreditVault<T0, T1>>(arg0)).gains_frozen, 229);
        assert!(arg0.closed, 204);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.usdc, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

