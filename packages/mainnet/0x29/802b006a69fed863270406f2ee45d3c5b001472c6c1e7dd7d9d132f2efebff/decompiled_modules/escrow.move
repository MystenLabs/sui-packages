module 0x29802b006a69fed863270406f2ee45d3c5b001472c6c1e7dd7d9d132f2efebff::escrow {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        admin_cap: 0x2::object::ID,
        chain: vector<u8>,
        quote_key: vector<u8>,
        predict_package: address,
        predict_account: address,
        executor: address,
        settler: address,
        treasurer: address,
        paused: bool,
        spread_enabled: bool,
        intents: 0x2::table::Table<address, IntentRecord>,
        pending_rotation: 0x1::option::Option<RoleRotation>,
        retired_quote_keys: vector<vector<u8>>,
    }

    struct IntentRecord has store {
        escrow: 0x2::object::ID,
        expiry_digest: vector<u8>,
    }

    struct RoleRotation has drop, store {
        quote_key: vector<u8>,
        executor: address,
        settler: address,
        treasurer: address,
        activate_after_ms: u64,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        version: u64,
        config: 0x2::object::ID,
        free: 0x2::balance::Balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>,
        positions: 0x2::table::Table<vector<u8>, address>,
    }

    struct Terms has copy, drop, store {
        domain: vector<u8>,
        chain: vector<u8>,
        config: address,
        version: u64,
        owner: address,
        trading_account: address,
        intent_id: address,
        nonce: u64,
        predict_package: address,
        predict_account: address,
        market: address,
        strike: u64,
        expiry_ms: u64,
        side: u8,
        quantity: u64,
        max_debit: u64,
        venue_cap: u64,
        spread: u64,
        fee: u64,
        conversion_numerator: u64,
        conversion_denominator: u64,
        max_payout: u64,
        admission_deadline_ms: u64,
        execution_deadline_ms: u64,
    }

    struct Escrow has key {
        id: 0x2::object::UID,
        version: u64,
        config: 0x2::object::ID,
        terms: Terms,
        state: u8,
        execution_consumed: bool,
        resolved_payout: u64,
        locked: 0x2::balance::Balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>,
        claimable: 0x2::balance::Balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>,
        reserve: 0x2::balance::Balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>,
        execution_digest: vector<u8>,
        position_id: vector<u8>,
        lock_digest: vector<u8>,
        history: vector<vector<u8>>,
    }

    struct OrderEvent has copy, drop {
        config: 0x2::object::ID,
        escrow: 0x2::object::ID,
        intent_id: address,
        owner: address,
        state: u8,
        amount: u64,
        spread: u64,
        fee: u64,
        evidence: vector<u8>,
        trading_account: address,
        market: address,
        position_id: vector<u8>,
    }

    struct ControlEvent has copy, drop {
        config: 0x2::object::ID,
        paused: bool,
        spread_enabled: bool,
    }

    struct TreasuryEvent has copy, drop {
        config: 0x2::object::ID,
        treasury: 0x2::object::ID,
        deposit: bool,
        amount: u64,
    }

    struct ExecutionPermitConsumed has copy, drop {
        config: 0x2::object::ID,
        escrow: 0x2::object::ID,
        intent_id: address,
        executor: address,
    }

    struct QuoteExpired has copy, drop {
        config: 0x2::object::ID,
        intent_id: address,
        owner: address,
        trading_account: address,
        max_debit: u64,
    }

    struct RotationEvent has copy, drop {
        config: 0x2::object::ID,
        action: u8,
        quote_key: vector<u8>,
        executor: address,
        settler: address,
        treasurer: address,
        activate_after_ms: u64,
    }

    struct ClaimEvent has copy, drop {
        config: 0x2::object::ID,
        escrow: 0x2::object::ID,
        intent_id: address,
        owner: address,
        amount: u64,
    }

    struct MigrationEvent has copy, drop {
        config: 0x2::object::ID,
        object: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
    }

    fun emit(arg0: &Escrow, arg1: u64, arg2: vector<u8>) {
        let v0 = OrderEvent{
            config          : arg0.config,
            escrow          : 0x2::object::id<Escrow>(arg0),
            intent_id       : arg0.terms.intent_id,
            owner           : arg0.terms.owner,
            state           : arg0.state,
            amount          : arg1,
            spread          : arg0.terms.spread,
            fee             : arg0.terms.fee,
            evidence        : arg2,
            trading_account : arg0.terms.trading_account,
            market          : arg0.terms.market,
            position_id     : arg0.position_id,
        };
        0x2::event::emit<OrderEvent>(v0);
    }

    public fun admit_execution(arg0: &Config, arg1: &mut Treasury, arg2: &mut Escrow, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check(arg0, arg1, arg2);
        assert!(!arg0.paused, 8);
        assert!(0x2::tx_context::sender(arg4) == arg0.executor, 1);
        assert!(arg2.state == 0, 2);
        assert!(0x2::clock::timestamp_ms(arg3) < arg2.terms.admission_deadline_ms, 3);
        assert!(0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg1.free) >= arg2.terms.max_payout, 7);
        0x2::balance::join<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg2.reserve, 0x2::balance::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg1.free, arg2.terms.max_payout));
        arg2.state = 1;
        remember(arg2, arg4);
        emit(arg2, arg2.terms.max_payout, b"");
    }

    public fun apply_rotation(arg0: &mut Config, arg1: &0x2::clock::Clock) {
        assert_current(arg0.version);
        assert!(0x1::option::is_some<RoleRotation>(&arg0.pending_rotation), 10);
        assert!(0x2::clock::timestamp_ms(arg1) >= 0x1::option::borrow<RoleRotation>(&arg0.pending_rotation).activate_after_ms, 10);
        check_key_history_capacity(arg0, &0x1::option::borrow<RoleRotation>(&arg0.pending_rotation).quote_key);
        let RoleRotation {
            quote_key         : v0,
            executor          : v1,
            settler           : v2,
            treasurer         : v3,
            activate_after_ms : v4,
        } = 0x1::option::extract<RoleRotation>(&mut arg0.pending_rotation);
        if (v0 != arg0.quote_key && !0x1::vector::contains<vector<u8>>(&arg0.retired_quote_keys, &arg0.quote_key)) {
            0x1::vector::push_back<vector<u8>>(&mut arg0.retired_quote_keys, arg0.quote_key);
        };
        arg0.quote_key = v0;
        arg0.executor = v1;
        arg0.settler = v2;
        arg0.treasurer = v3;
        let v5 = RotationEvent{
            config            : 0x2::object::id<Config>(arg0),
            action            : 2,
            quote_key         : v0,
            executor          : v1,
            settler           : v2,
            treasurer         : v3,
            activate_after_ms : v4,
        };
        0x2::event::emit<RotationEvent>(v5);
    }

    fun assert_current(arg0: u64) {
        assert!(arg0 == 1, 11);
    }

    public fun assert_execution_window(arg0: &Config, arg1: &Escrow, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_current(arg0.version);
        assert_current(arg1.version);
        assert!(arg1.config == 0x2::object::id<Config>(arg0) && 0x2::tx_context::sender(arg3) == arg0.executor, 1);
        assert!(!arg0.paused, 8);
        assert!(arg1.state == 1 && !arg1.execution_consumed, 2);
        assert!(0x2::clock::timestamp_ms(arg2) < arg1.terms.execution_deadline_ms, 3);
    }

    public fun cancel_rotation(arg0: &AdminCap, arg1: &mut Config) {
        assert_current(arg1.version);
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap, 1);
        assert!(0x1::option::is_some<RoleRotation>(&arg1.pending_rotation), 10);
        let RoleRotation {
            quote_key         : v0,
            executor          : v1,
            settler           : v2,
            treasurer         : v3,
            activate_after_ms : v4,
        } = 0x1::option::extract<RoleRotation>(&mut arg1.pending_rotation);
        let v5 = RotationEvent{
            config            : 0x2::object::id<Config>(arg1),
            action            : 1,
            quote_key         : v0,
            executor          : v1,
            settler           : v2,
            treasurer         : v3,
            activate_after_ms : v4,
        };
        0x2::event::emit<RotationEvent>(v5);
    }

    public fun cancel_unadmitted(arg0: &mut Escrow, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert_current(arg0.version);
        assert!(arg0.state == 0, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.terms.owner || 0x2::clock::timestamp_ms(arg1) >= arg0.terms.admission_deadline_ms, 1);
        let v0 = 0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg0.locked);
        0x2::balance::join<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.claimable, 0x2::balance::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.locked, v0));
        arg0.state = 3;
        remember(arg0, arg2);
        emit(arg0, v0, b"");
    }

    fun check(arg0: &Config, arg1: &Treasury, arg2: &Escrow) {
        assert_current(arg0.version);
        assert_current(arg1.version);
        assert_current(arg2.version);
        assert!(arg1.config == 0x2::object::id<Config>(arg0) && arg2.config == 0x2::object::id<Config>(arg0), 1);
    }

    fun check_key_history_capacity(arg0: &Config, arg1: &vector<u8>) {
        let v0 = if (*arg1 == arg0.quote_key) {
            true
        } else if (0x1::vector::contains<vector<u8>>(&arg0.retired_quote_keys, &arg0.quote_key)) {
            true
        } else {
            0x1::vector::length<vector<u8>>(&arg0.retired_quote_keys) < 32
        };
        assert!(v0, 10);
    }

    public fun claim(arg0: &mut Escrow, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD> {
        assert_current(arg0.version);
        assert!(0x2::tx_context::sender(arg1) == arg0.terms.owner, 1);
        let v0 = 0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg0.claimable);
        assert!(v0 > 0, 7);
        remember(arg0, arg1);
        let v1 = ClaimEvent{
            config    : arg0.config,
            escrow    : 0x2::object::id<Escrow>(arg0),
            intent_id : arg0.terms.intent_id,
            owner     : 0x2::tx_context::sender(arg1),
            amount    : v0,
        };
        0x2::event::emit<ClaimEvent>(v1);
        0x2::coin::from_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(0x2::balance::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.claimable, v0), arg1)
    }

    public fun claimable(arg0: &Escrow) : u64 {
        0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg0.claimable)
    }

    public fun consume_execution_permit(arg0: &Config, arg1: &mut Escrow, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_execution_window(arg0, arg1, arg2, arg3);
        arg1.execution_consumed = true;
        arg1.execution_digest = *0x2::tx_context::digest(arg3);
        remember(arg1, arg3);
        let v0 = ExecutionPermitConsumed{
            config    : arg1.config,
            escrow    : 0x2::object::id<Escrow>(arg1),
            intent_id : arg1.terms.intent_id,
            executor  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ExecutionPermitConsumed>(v0);
    }

    fun convert(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0 && arg2 > 0, 4);
        let v0 = (arg0 as u128) * (arg1 as u128);
        let v1 = if (v0 % (arg2 as u128) > 0) {
            1
        } else {
            0
        };
        let v2 = v0 / (arg2 as u128) + v1;
        assert!(v2 <= 18446744073709551615, 4);
        (v2 as u64)
    }

    public fun create_config(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: address, arg5: address, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = if (!0x1::vector::is_empty<u8>(&arg1)) {
            if (0x1::vector::length<u8>(&arg1) <= 64) {
                0x1::vector::length<u8>(&arg2) == 32
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 4);
        validate_roles(arg5, arg6, arg7);
        let v1 = Config{
            id                 : 0x2::object::new(arg8),
            version            : 1,
            admin_cap          : 0x2::object::id<AdminCap>(arg0),
            chain              : arg1,
            quote_key          : arg2,
            predict_package    : arg3,
            predict_account    : arg4,
            executor           : arg5,
            settler            : arg6,
            treasurer          : arg7,
            paused             : false,
            spread_enabled     : false,
            intents            : 0x2::table::new<address, IntentRecord>(arg8),
            pending_rotation   : 0x1::option::none<RoleRotation>(),
            retired_quote_keys : vector[],
        };
        let v2 = Treasury{
            id        : 0x2::object::new(arg8),
            version   : 1,
            config    : 0x2::object::id<Config>(&v1),
            free      : 0x2::balance::zero<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(),
            positions : 0x2::table::new<vector<u8>, address>(arg8),
        };
        0x2::transfer::share_object<Config>(v1);
        0x2::transfer::share_object<Treasury>(v2);
    }

    fun decode_terms(arg0: vector<u8>) : Terms {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = Terms{
            domain                 : 0x2::bcs::peel_vec_u8(&mut v0),
            chain                  : 0x2::bcs::peel_vec_u8(&mut v0),
            config                 : 0x2::bcs::peel_address(&mut v0),
            version                : 0x2::bcs::peel_u64(&mut v0),
            owner                  : 0x2::bcs::peel_address(&mut v0),
            trading_account        : 0x2::bcs::peel_address(&mut v0),
            intent_id              : 0x2::bcs::peel_address(&mut v0),
            nonce                  : 0x2::bcs::peel_u64(&mut v0),
            predict_package        : 0x2::bcs::peel_address(&mut v0),
            predict_account        : 0x2::bcs::peel_address(&mut v0),
            market                 : 0x2::bcs::peel_address(&mut v0),
            strike                 : 0x2::bcs::peel_u64(&mut v0),
            expiry_ms              : 0x2::bcs::peel_u64(&mut v0),
            side                   : 0x2::bcs::peel_u8(&mut v0),
            quantity               : 0x2::bcs::peel_u64(&mut v0),
            max_debit              : 0x2::bcs::peel_u64(&mut v0),
            venue_cap              : 0x2::bcs::peel_u64(&mut v0),
            spread                 : 0x2::bcs::peel_u64(&mut v0),
            fee                    : 0x2::bcs::peel_u64(&mut v0),
            conversion_numerator   : 0x2::bcs::peel_u64(&mut v0),
            conversion_denominator : 0x2::bcs::peel_u64(&mut v0),
            max_payout             : 0x2::bcs::peel_u64(&mut v0),
            admission_deadline_ms  : 0x2::bcs::peel_u64(&mut v0),
            execution_deadline_ms  : 0x2::bcs::peel_u64(&mut v0),
        };
        let v2 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v2), 4);
        v1
    }

    public fun escrow_id(arg0: &Escrow) : 0x2::object::ID {
        0x2::object::id<Escrow>(arg0)
    }

    public fun execution_consumed(arg0: &Escrow) : bool {
        arg0.execution_consumed
    }

    public fun execution_digest(arg0: &Escrow) : vector<u8> {
        arg0.execution_digest
    }

    public fun expire_unlocked_quote(arg0: &mut Config, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_current(arg0.version);
        assert!(0x1::vector::length<u8>(&arg1) <= 1024, 4);
        assert!(verify_expiry_signature(arg0, &arg1, &arg2), 5);
        expire_verified(arg0, decode_terms(arg1), arg3, arg4);
    }

    fun expire_verified(arg0: &mut Config, arg1: Terms, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        validate_domain(arg0, &arg1);
        let v0 = if (arg1.owner != @0x0) {
            if (arg1.trading_account != @0x0) {
                arg1.max_debit > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 4);
        assert!(arg1.admission_deadline_ms <= arg1.execution_deadline_ms && arg1.execution_deadline_ms < arg1.expiry_ms, 4);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.admission_deadline_ms, 3);
        assert!(!0x2::table::contains<address, IntentRecord>(&arg0.intents, arg1.intent_id), 6);
        let v1 = IntentRecord{
            escrow        : 0x2::object::id_from_address(@0x0),
            expiry_digest : *0x2::tx_context::digest(arg3),
        };
        0x2::table::add<address, IntentRecord>(&mut arg0.intents, arg1.intent_id, v1);
        let v2 = QuoteExpired{
            config          : 0x2::object::id<Config>(arg0),
            intent_id       : arg1.intent_id,
            owner           : arg1.owner,
            trading_account : arg1.trading_account,
            max_debit       : arg1.max_debit,
        };
        0x2::event::emit<QuoteExpired>(v2);
    }

    public fun expiry_digest(arg0: &Config, arg1: address) : vector<u8> {
        0x2::table::borrow<address, IntentRecord>(&arg0.intents, arg1).expiry_digest
    }

    public fun finalize_fill(arg0: &Config, arg1: &mut Treasury, arg2: &mut Escrow, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::tx_context::TxContext) {
        check(arg0, arg1, arg2);
        assert!(0x2::tx_context::sender(arg6) == arg0.settler, 1);
        assert!(arg2.state == 1 && arg2.execution_consumed, 2);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 9);
        validate_position_id(&arg5);
        assert!(arg4 == arg2.execution_digest, 9);
        assert!(!0x2::table::contains<vector<u8>, address>(&arg1.positions, arg5), 6);
        assert!(arg3 > 0 && arg3 <= arg2.terms.venue_cap, 4);
        let v0 = (convert(arg3, arg2.terms.conversion_numerator, arg2.terms.conversion_denominator) as u128) + (arg2.terms.spread as u128) + (arg2.terms.fee as u128);
        assert!(v0 <= (arg2.terms.max_debit as u128), 4);
        let v1 = (v0 as u64);
        0x2::balance::join<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg1.free, 0x2::balance::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg2.locked, v1));
        0x2::balance::join<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg2.claimable, 0x2::balance::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg2.locked, 0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg2.locked)));
        0x2::table::add<vector<u8>, address>(&mut arg1.positions, arg5, arg2.terms.intent_id);
        arg2.position_id = arg5;
        arg2.state = 2;
        remember(arg2, arg6);
        emit(arg2, v1, arg4);
    }

    public fun finalize_no_fill(arg0: &Config, arg1: &mut Treasury, arg2: &mut Escrow, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        check(arg0, arg1, arg2);
        assert!(0x2::tx_context::sender(arg4) == arg0.settler, 1);
        assert!(arg2.state == 1 && !arg2.execution_consumed, 2);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 9);
        refund(arg1, arg2, arg3, arg4);
    }

    public fun free(arg0: &Treasury) : u64 {
        0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg0.free)
    }

    public fun fund_treasury(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>) {
        assert_current(arg0.version);
        0x2::balance::join<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.free, 0x2::coin::into_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(arg1));
        let v0 = TreasuryEvent{
            config   : arg0.config,
            treasury : 0x2::object::id<Treasury>(arg0),
            deposit  : true,
            amount   : 0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg1),
        };
        0x2::event::emit<TreasuryEvent>(v0);
    }

    public fun history(arg0: &Escrow) : &vector<vector<u8>> {
        &arg0.history
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun intent_id(arg0: &Escrow) : address {
        arg0.terms.intent_id
    }

    public fun intents_table_id(arg0: &Config) : 0x2::object::ID {
        0x2::object::id<0x2::table::Table<address, IntentRecord>>(&arg0.intents)
    }

    public fun lock_digest(arg0: &Escrow) : vector<u8> {
        arg0.lock_digest
    }

    public fun lock_order(arg0: &mut Config, arg1: &0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 8);
        assert!(0x1::vector::length<u8>(&arg2) <= 1024, 4);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.quote_key, &arg2), 5);
        0x2::transfer::share_object<Escrow>(lock_verified(arg0, arg1, decode_terms(arg2), arg4, arg5, arg6));
    }

    fun lock_verified(arg0: &mut Config, arg1: &0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg2: Terms, arg3: 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Escrow {
        assert_current(arg0.version);
        assert!(!arg0.paused, 8);
        assert!(!0x2::table::contains<address, IntentRecord>(&arg0.intents, arg2.intent_id), 6);
        validate_terms(arg0, arg1, &arg2, 0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg3), 0x2::clock::timestamp_ms(arg4), 0x2::tx_context::sender(arg5));
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, *0x2::tx_context::digest(arg5));
        let v1 = Escrow{
            id                 : 0x2::object::new(arg5),
            version            : 1,
            config             : 0x2::object::id<Config>(arg0),
            terms              : arg2,
            state              : 0,
            execution_consumed : false,
            resolved_payout    : 0,
            locked             : 0x2::coin::into_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(arg3),
            claimable          : 0x2::balance::zero<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(),
            reserve            : 0x2::balance::zero<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(),
            execution_digest   : b"",
            position_id        : b"",
            lock_digest        : *0x2::tx_context::digest(arg5),
            history            : v0,
        };
        let v2 = IntentRecord{
            escrow        : 0x2::object::id<Escrow>(&v1),
            expiry_digest : b"",
        };
        0x2::table::add<address, IntentRecord>(&mut arg0.intents, arg2.intent_id, v2);
        emit(&v1, v1.terms.max_debit, b"");
        v1
    }

    public fun lookup_escrow(arg0: &Config, arg1: address) : 0x2::object::ID {
        0x2::table::borrow<address, IntentRecord>(&arg0.intents, arg1).escrow
    }

    public fun migrate_config(arg0: &AdminCap, arg1: &mut Config) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap, 1);
        assert!(arg1.version < 1, 11);
        let v0 = MigrationEvent{
            config       : 0x2::object::id<Config>(arg1),
            object       : 0x2::object::id<Config>(arg1),
            from_version : arg1.version,
            to_version   : 1,
        };
        0x2::event::emit<MigrationEvent>(v0);
        arg1.version = 1;
    }

    public fun migrate_escrow(arg0: &AdminCap, arg1: &Config, arg2: &mut Escrow) {
        assert_current(arg1.version);
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap && arg2.config == 0x2::object::id<Config>(arg1), 1);
        assert!(arg2.version < 1, 11);
        let v0 = MigrationEvent{
            config       : 0x2::object::id<Config>(arg1),
            object       : 0x2::object::id<Escrow>(arg2),
            from_version : arg2.version,
            to_version   : 1,
        };
        0x2::event::emit<MigrationEvent>(v0);
        arg2.version = 1;
    }

    public fun migrate_treasury(arg0: &AdminCap, arg1: &Config, arg2: &mut Treasury) {
        assert_current(arg1.version);
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap && arg2.config == 0x2::object::id<Config>(arg1), 1);
        assert!(arg2.version < 1, 11);
        let v0 = MigrationEvent{
            config       : 0x2::object::id<Config>(arg1),
            object       : 0x2::object::id<Treasury>(arg2),
            from_version : arg2.version,
            to_version   : 1,
        };
        0x2::event::emit<MigrationEvent>(v0);
        arg2.version = 1;
    }

    public fun record_resolution(arg0: &Config, arg1: &mut Treasury, arg2: &mut Escrow, arg3: bool, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        check(arg0, arg1, arg2);
        assert!(0x2::tx_context::sender(arg6) == arg0.settler, 1);
        assert!(arg2.state == 2, 2);
        assert!(0x2::clock::timestamp_ms(arg5) >= arg2.terms.expiry_ms, 3);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 9);
        let v0 = if (arg3) {
            arg2.terms.max_payout
        } else {
            0
        };
        arg2.resolved_payout = v0;
        0x2::balance::join<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg2.claimable, 0x2::balance::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg2.reserve, v0));
        0x2::balance::join<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg1.free, 0x2::balance::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg2.reserve, 0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg2.reserve)));
        arg2.state = 4;
        remember(arg2, arg6);
        emit(arg2, v0, arg4);
    }

    fun refund(arg0: &mut Treasury, arg1: &mut Escrow, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        0x2::balance::join<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.free, 0x2::balance::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg1.reserve, 0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg1.reserve)));
        let v0 = 0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg1.locked);
        0x2::balance::join<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg1.claimable, 0x2::balance::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg1.locked, v0));
        arg1.state = 3;
        remember(arg1, arg3);
        emit(arg1, v0, arg2);
    }

    public fun refund_expired_unexecuted(arg0: &Config, arg1: &mut Treasury, arg2: &mut Escrow, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check(arg0, arg1, arg2);
        assert!(arg2.state == 1 && !arg2.execution_consumed, 2);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg2.terms.execution_deadline_ms, 3);
        refund(arg1, arg2, b"", arg4);
    }

    fun remember(arg0: &mut Escrow, arg1: &0x2::tx_context::TxContext) {
        let v0 = *0x2::tx_context::digest(arg1);
        if (!0x1::vector::contains<vector<u8>>(&arg0.history, &v0)) {
            assert!(0x1::vector::length<vector<u8>>(&arg0.history) < 16, 2);
            0x1::vector::push_back<vector<u8>>(&mut arg0.history, v0);
        };
    }

    public fun reserved(arg0: &Escrow) : u64 {
        0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg0.reserve)
    }

    public fun resolved_payout(arg0: &Escrow) : u64 {
        arg0.resolved_payout
    }

    public fun set_controls(arg0: &AdminCap, arg1: &mut Config, arg2: bool, arg3: bool) {
        assert_current(arg1.version);
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap, 1);
        arg1.paused = arg2;
        arg1.spread_enabled = arg3;
        let v0 = ControlEvent{
            config         : 0x2::object::id<Config>(arg1),
            paused         : arg2,
            spread_enabled : arg3,
        };
        0x2::event::emit<ControlEvent>(v0);
    }

    public fun stage_rotation(arg0: &AdminCap, arg1: &mut Config, arg2: vector<u8>, arg3: address, arg4: address, arg5: address, arg6: &0x2::clock::Clock) {
        assert_current(arg1.version);
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap, 1);
        assert!(0x1::option::is_none<RoleRotation>(&arg1.pending_rotation), 10);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 4);
        validate_roles(arg3, arg4, arg5);
        check_key_history_capacity(arg1, &arg2);
        let v0 = 0x2::clock::timestamp_ms(arg6) + 86400000;
        let v1 = RoleRotation{
            quote_key         : arg2,
            executor          : arg3,
            settler           : arg4,
            treasurer         : arg5,
            activate_after_ms : v0,
        };
        0x1::option::fill<RoleRotation>(&mut arg1.pending_rotation, v1);
        let v2 = RotationEvent{
            config            : 0x2::object::id<Config>(arg1),
            action            : 0,
            quote_key         : arg2,
            executor          : arg3,
            settler           : arg4,
            treasurer         : arg5,
            activate_after_ms : v0,
        };
        0x2::event::emit<RotationEvent>(v2);
    }

    public fun state(arg0: &Escrow) : u8 {
        arg0.state
    }

    public fun terms(arg0: &Escrow) : &Terms {
        &arg0.terms
    }

    fun validate_domain(arg0: &Config, arg1: &Terms) {
        assert_current(arg0.version);
        assert!(arg1.domain == b"YOSO_PREDICT_PROXY_V1" && arg1.version == 1, 4);
        let v0 = if (arg1.chain == arg0.chain) {
            let v1 = 0x2::object::id<Config>(arg0);
            arg1.config == 0x2::object::id_to_address(&v1)
        } else {
            false
        };
        assert!(v0, 4);
        assert!(arg1.predict_package == arg0.predict_package && arg1.predict_account == arg0.predict_account, 4);
    }

    fun validate_position_id(arg0: &vector<u8>) {
        assert!(!0x1::vector::is_empty<u8>(arg0) && 0x1::vector::length<u8>(arg0) <= 78, 9);
        assert!(0x1::vector::length<u8>(arg0) == 1 || *0x1::vector::borrow<u8>(arg0, 0) != 48, 9);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            assert!(v2 >= 48 && v2 <= 57, 9);
            let v3 = ((v2 - 48) as u256);
            assert!(v0 <= (115792089237316195423570985008687907853269984665640564039457584007913129639935 - v3) / 10, 9);
            let v4 = v0 * 10;
            v0 = v4 + v3;
            v1 = v1 + 1;
        };
    }

    fun validate_roles(arg0: address, arg1: address, arg2: address) {
        let v0 = if (arg0 != @0x0) {
            if (arg1 != @0x0) {
                arg2 != @0x0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 4);
    }

    fun validate_terms(arg0: &Config, arg1: &0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg2: &Terms, arg3: u64, arg4: u64, arg5: address) {
        validate_domain(arg0, arg2);
        assert!(arg2.owner == arg5 && 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::owner(arg1) == arg5, 1);
        let v0 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::id(arg1);
        assert!(arg2.trading_account == 0x2::object::id_to_address(&v0), 1);
        let v1 = if (arg2.side <= 1) {
            if (arg2.quantity > 0) {
                if (arg2.max_payout > 0) {
                    arg2.venue_cap > 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 4);
        assert!(arg3 == arg2.max_debit && arg2.max_debit > 0, 4);
        assert!(arg0.spread_enabled || arg2.spread == 0, 4);
        let v2 = if (arg4 < arg2.admission_deadline_ms) {
            if (arg2.admission_deadline_ms <= arg2.execution_deadline_ms) {
                arg2.execution_deadline_ms < arg2.expiry_ms
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 3);
        assert!((convert(arg2.venue_cap, arg2.conversion_numerator, arg2.conversion_denominator) as u128) + (arg2.spread as u128) + (arg2.fee as u128) <= (arg2.max_debit as u128), 4);
    }

    fun verify_expiry_signature(arg0: &Config, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        if (0x2::ed25519::ed25519_verify(arg2, &arg0.quote_key, arg1)) {
            return true
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0.retired_quote_keys)) {
            if (0x2::ed25519::ed25519_verify(arg2, 0x1::vector::borrow<vector<u8>>(&arg0.retired_quote_keys, v0), arg1)) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun withdraw_free_treasury(arg0: &Config, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD> {
        assert_current(arg0.version);
        assert_current(arg1.version);
        assert!(0x2::tx_context::sender(arg3) == arg0.treasurer && arg1.config == 0x2::object::id<Config>(arg0), 1);
        assert!(arg2 <= 0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg1.free), 7);
        let v0 = TreasuryEvent{
            config   : arg1.config,
            treasury : 0x2::object::id<Treasury>(arg1),
            deposit  : false,
            amount   : arg2,
        };
        0x2::event::emit<TreasuryEvent>(v0);
        0x2::coin::from_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(0x2::balance::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg1.free, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

