module 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book {
    struct CollateralVaultKey has copy, drop, store {
        request_id: u64,
    }

    struct TokenDecimalsKey has copy, drop, store {
        token: address,
    }

    struct OfferBookAdminCap has store, key {
        id: 0x2::object::UID,
        book_id: 0x2::object::ID,
    }

    struct LoanRequest has copy, drop, store {
        id: u64,
        borrower: address,
        principal_token: address,
        collateral_token: address,
        principal_token_decimals: u8,
        collateral_token_decimals: u8,
        principal: u64,
        min_principal_amount: u64,
        interest_rate_schedule: vector<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::InterestRateTier>,
        duration_secs: u64,
        funding_window_secs: u64,
        created_at_ms: u64,
        collateral_required: u64,
        oracle_feed_id: 0x1::option::Option<0x2::object::ID>,
        liquidation_price: 0x1::option::Option<u64>,
        ltv_bps: u64,
        collateral_policy: u8,
        liquidation_trigger: u8,
        status: u8,
        matched_lender: address,
        vault_deployed: bool,
        has_lp_deposits: bool,
    }

    struct RequestMatchWhitelist has store {
        request_id: u64,
        matchers: vector<address>,
    }

    struct OfferBook has key {
        id: 0x2::object::UID,
        admin: address,
        pending_admin: 0x1::option::Option<address>,
        paused: bool,
        next_request_id: u64,
        requests: vector<LoanRequest>,
        match_whitelists: vector<RequestMatchWhitelist>,
        whitelisted_borrowers: vector<address>,
        whitelisted_lenders: vector<address>,
        whitelisted_tokens: vector<address>,
        whitelisted_oracles: vector<0x2::object::ID>,
        borrower_whitelist_enabled: bool,
        lender_whitelist_enabled: bool,
    }

    public fun accept_admin(arg0: &mut OfferBook, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.pending_admin), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        let v0 = *0x1::option::borrow<address>(&arg0.pending_admin);
        assert!(0x2::tx_context::sender(arg2) == v0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        arg0.admin = v0;
        arg0.pending_admin = 0x1::option::none<address>();
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_admin_transferred(0x2::object::id<OfferBook>(arg0), arg0.admin, v0, 0x2::clock::timestamp_ms(arg1));
    }

    public fun add_whitelisted_borrower(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        if (!vec_contains_addr(&arg0.whitelisted_borrowers, arg2)) {
            0x1::vector::push_back<address>(&mut arg0.whitelisted_borrowers, arg2);
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_borrower_listed(arg2, 0x2::clock::timestamp_ms(arg3));
        };
    }

    public fun add_whitelisted_lender(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        if (!vec_contains_addr(&arg0.whitelisted_lenders, arg2)) {
            0x1::vector::push_back<address>(&mut arg0.whitelisted_lenders, arg2);
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_lender_listed(arg2, 0x2::clock::timestamp_ms(arg3));
        };
    }

    public fun add_whitelisted_oracle(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        if (!vec_contains_id(&arg0.whitelisted_oracles, arg2)) {
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.whitelisted_oracles, arg2);
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_oracle_whitelisted(arg2, 0x2::clock::timestamp_ms(arg3));
        };
    }

    public fun add_whitelisted_token(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        if (!vec_contains_addr(&arg0.whitelisted_tokens, arg2)) {
            0x1::vector::push_back<address>(&mut arg0.whitelisted_tokens, arg2);
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_token_listed(arg2, 0x2::clock::timestamp_ms(arg3));
        };
    }

    fun assert_no_lp_deposits(arg0: &LoanRequest) {
        assert!(!arg0.has_lp_deposits, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::request_has_deposits());
    }

    public fun assert_request_oracle_matches(arg0: &OfferBook, arg1: u64, arg2: 0x2::object::ID) {
        let v0 = get_request(arg0, arg1);
        if (0x1::option::is_some<0x2::object::ID>(&v0.oracle_feed_id)) {
            assert!(*0x1::option::borrow<0x2::object::ID>(&v0.oracle_feed_id) == arg2, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        };
    }

    public(friend) fun authorize_match(arg0: &mut OfferBook, arg1: u64, arg2: address, arg3: bool, arg4: &0x2::clock::Clock) {
        assert!(!arg0.paused, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::paused());
        let v0 = get_request(arg0, arg1);
        assert!(v0.borrower != arg2, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::self_match_forbidden());
        if (!arg3) {
            let v1 = borrow_match_whitelist(arg0, arg1);
            if (0x1::vector::length<address>(&v1.matchers) > 0) {
                assert!(vec_contains_addr(&v1.matchers, arg2), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::matcher_not_whitelisted());
            };
        };
        assert!(v0.status == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::request_active(), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        assert!(0x2::clock::timestamp_ms(arg4) < v0.created_at_ms + v0.funding_window_secs * 1000, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::funding_window_expired());
        let v2 = borrow_request_mut(arg0, arg1);
        v2.status = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::request_matched();
        v2.matched_lender = arg2;
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_request_matched(arg1, arg2, 0x2::clock::timestamp_ms(arg4));
    }

    fun borrow_match_whitelist(arg0: &OfferBook, arg1: u64) : &RequestMatchWhitelist {
        let v0 = 0;
        while (v0 < 0x1::vector::length<RequestMatchWhitelist>(&arg0.match_whitelists)) {
            let v1 = 0x1::vector::borrow<RequestMatchWhitelist>(&arg0.match_whitelists, v0);
            if (v1.request_id == arg1) {
                return v1
            };
            v0 = v0 + 1;
        };
        abort 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::not_found()
    }

    fun borrow_match_whitelist_mut(arg0: &mut OfferBook, arg1: u64) : &mut RequestMatchWhitelist {
        let v0 = 0;
        while (v0 < 0x1::vector::length<RequestMatchWhitelist>(&arg0.match_whitelists)) {
            let v1 = 0x1::vector::borrow_mut<RequestMatchWhitelist>(&mut arg0.match_whitelists, v0);
            if (v1.request_id == arg1) {
                return v1
            };
            v0 = v0 + 1;
        };
        abort 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::not_found()
    }

    fun borrow_request_mut(arg0: &mut OfferBook, arg1: u64) : &mut LoanRequest {
        let v0 = 0;
        while (v0 < 0x1::vector::length<LoanRequest>(&arg0.requests)) {
            let v1 = 0x1::vector::borrow_mut<LoanRequest>(&mut arg0.requests, v0);
            if (v1.id == arg1) {
                return v1
            };
            v0 = v0 + 1;
        };
        abort 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::not_found()
    }

    public fun create_offer_book(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : OfferBookAdminCap {
        let v0 = OfferBook{
            id                         : 0x2::object::new(arg1),
            admin                      : arg0,
            pending_admin              : 0x1::option::none<address>(),
            paused                     : false,
            next_request_id            : 1,
            requests                   : 0x1::vector::empty<LoanRequest>(),
            match_whitelists           : 0x1::vector::empty<RequestMatchWhitelist>(),
            whitelisted_borrowers      : vector[],
            whitelisted_lenders        : vector[],
            whitelisted_tokens         : vector[],
            whitelisted_oracles        : 0x1::vector::empty<0x2::object::ID>(),
            borrower_whitelist_enabled : false,
            lender_whitelist_enabled   : false,
        };
        0x2::transfer::share_object<OfferBook>(v0);
        OfferBookAdminCap{
            id      : 0x2::object::new(arg1),
            book_id : 0x2::object::id<OfferBook>(&v0),
        }
    }

    public fun create_request(arg0: &mut OfferBook, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::vector::empty<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::InterestRateTier>();
        0x1::vector::push_back<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::InterestRateTier>(&mut v0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::new_interest_rate_tier(0, arg4));
        let v1 = require_token_decimals(arg0, arg1);
        let v2 = require_token_decimals(arg0, arg2);
        create_request_with_window_and_coins(arg0, arg1, arg2, v1, v2, arg3, v0, arg5, arg6, arg7, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::collateral_policy_direct_claim(), 0x1::option::none<u64>(), arg8, arg9)
    }

    public fun create_request_with_window_and_coins(arg0: &mut OfferBook, arg1: address, arg2: address, arg3: u8, arg4: u8, arg5: u64, arg6: vector<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::InterestRateTier>, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: 0x1::option::Option<u64>, arg12: &0x2::clock::Clock, arg13: &0x2::tx_context::TxContext) : u64 {
        assert!(!arg0.paused, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::paused());
        assert!(arg5 > 0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_amount());
        assert!(arg9 > 0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_amount());
        assert!(arg7 > 0 && arg7 <= 31536000, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_duration());
        assert!(arg8 > 0 && arg8 <= 2592000, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_duration());
        assert!(arg3 <= 18 && arg4 <= 18, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        validate_schedule(&arg6);
        assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::is_valid_collateral_policy(arg10), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        if (0x1::option::is_some<u64>(&arg11)) {
            assert!(*0x1::option::borrow<u64>(&arg11) > 0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::oracle_price_invalid());
        };
        assert!(is_whitelisted_token(arg0, arg1), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::token_not_whitelisted());
        assert!(is_whitelisted_token(arg0, arg2), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::token_not_whitelisted());
        let v0 = require_token_decimals(arg0, arg1);
        let v1 = require_token_decimals(arg0, arg2);
        assert!(v0 == arg3, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        assert!(v1 == arg4, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        let v2 = 0x2::tx_context::sender(arg13);
        assert!(is_borrower_allowed(arg0, v2), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::borrower_not_whitelisted());
        let v3 = arg0.next_request_id;
        arg0.next_request_id = v3 + 1;
        let v4 = LoanRequest{
            id                        : v3,
            borrower                  : v2,
            principal_token           : arg1,
            collateral_token          : arg2,
            principal_token_decimals  : v0,
            collateral_token_decimals : v1,
            principal                 : arg5,
            min_principal_amount      : arg5,
            interest_rate_schedule    : arg6,
            duration_secs             : arg7,
            funding_window_secs       : arg8,
            created_at_ms             : 0x2::clock::timestamp_ms(arg12),
            collateral_required       : arg9,
            oracle_feed_id            : 0x1::option::none<0x2::object::ID>(),
            liquidation_price         : arg11,
            ltv_bps                   : 6000,
            collateral_policy         : arg10,
            liquidation_trigger       : 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::liquidation_trigger_open(),
            status                    : 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::request_active(),
            matched_lender            : @0x0,
            vault_deployed            : false,
            has_lp_deposits           : false,
        };
        0x1::vector::push_back<LoanRequest>(&mut arg0.requests, v4);
        let v5 = RequestMatchWhitelist{
            request_id : v3,
            matchers   : vector[],
        };
        0x1::vector::push_back<RequestMatchWhitelist>(&mut arg0.match_whitelists, v5);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_request_created(v3, v2, arg1, arg5, arg5, arg2, arg9, arg6, arg7, arg8, arg10, arg11, 0x1::option::none<0x2::object::ID>(), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::liquidation_trigger_open(), 6000, 0x2::clock::timestamp_ms(arg12));
        v3
    }

    public fun get_admin(arg0: &OfferBook) : address {
        arg0.admin
    }

    public fun get_match_whitelist(arg0: &OfferBook, arg1: u64) : vector<address> {
        let v0 = borrow_match_whitelist(arg0, arg1);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v0.matchers)) {
            0x1::vector::push_back<address>(&mut v1, *0x1::vector::borrow<address>(&v0.matchers, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_request(arg0: &OfferBook, arg1: u64) : LoanRequest {
        let v0 = 0;
        while (v0 < 0x1::vector::length<LoanRequest>(&arg0.requests)) {
            let v1 = 0x1::vector::borrow<LoanRequest>(&arg0.requests, v0);
            if (v1.id == arg1) {
                return *v1
            };
            v0 = v0 + 1;
        };
        abort 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::not_found()
    }

    public fun is_borrower_allowed(arg0: &OfferBook, arg1: address) : bool {
        if (!arg0.borrower_whitelist_enabled) {
            return true
        };
        vec_contains_addr(&arg0.whitelisted_borrowers, arg1)
    }

    public fun is_lender_allowed(arg0: &OfferBook, arg1: address) : bool {
        if (!arg0.lender_whitelist_enabled) {
            return true
        };
        vec_contains_addr(&arg0.whitelisted_lenders, arg1)
    }

    public fun is_paused(arg0: &OfferBook) : bool {
        arg0.paused
    }

    public fun is_whitelisted_oracle(arg0: &OfferBook, arg1: 0x2::object::ID) : bool {
        vec_contains_id(&arg0.whitelisted_oracles, arg1)
    }

    public fun is_whitelisted_token(arg0: &OfferBook, arg1: address) : bool {
        vec_contains_addr(&arg0.whitelisted_tokens, arg1)
    }

    public(friend) fun mark_cancelled(arg0: &mut OfferBook, arg1: u64) {
        let v0 = borrow_request_mut(arg0, arg1);
        assert!(v0.status == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::request_active(), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        v0.status = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::request_cancelled();
    }

    public(friend) fun mark_lp_deposits(arg0: &mut OfferBook, arg1: u64) {
        borrow_request_mut(arg0, arg1).has_lp_deposits = true;
    }

    public fun pause(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        arg0.paused = true;
        let v0 = 0x2::clock::timestamp_ms(arg2);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_admin_action(0x2::object::id<OfferBook>(arg0), 0x2::tx_context::sender(arg3), 1, v0);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_protocol_paused(0x2::object::id<OfferBook>(arg0), 0x2::tx_context::sender(arg3), v0);
    }

    public fun propose_admin(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x1::option::is_none<address>(&arg0.pending_admin), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        arg0.pending_admin = 0x1::option::some<address>(arg2);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_admin_proposed(0x2::object::id<OfferBook>(arg0), arg0.admin, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public(friend) fun register_collateral_vault(arg0: &mut OfferBook, arg1: u64, arg2: 0x2::object::ID) {
        let v0 = CollateralVaultKey{request_id: arg1};
        assert!(!0x2::dynamic_field::exists_<CollateralVaultKey>(&arg0.id, v0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        0x2::dynamic_field::add<CollateralVaultKey, 0x2::object::ID>(&mut arg0.id, v0, arg2);
    }

    public(friend) fun register_vault(arg0: &mut OfferBook, arg1: u64, arg2: address) {
        let v0 = borrow_request_mut(arg0, arg1);
        assert!(v0.status == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::request_active(), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        assert!(!v0.vault_deployed, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::vault_already_deployed());
        v0.vault_deployed = true;
        let v1 = borrow_match_whitelist_mut(arg0, arg1);
        if (!vec_contains_addr(&v1.matchers, arg2)) {
            0x1::vector::push_back<address>(&mut v1.matchers, arg2);
        };
    }

    public fun registered_collateral_vault(arg0: &OfferBook, arg1: u64) : 0x1::option::Option<0x2::object::ID> {
        let v0 = CollateralVaultKey{request_id: arg1};
        if (0x2::dynamic_field::exists_<CollateralVaultKey>(&arg0.id, v0)) {
            0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<CollateralVaultKey, 0x2::object::ID>(&arg0.id, v0))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun registered_vault_addr(arg0: &OfferBook, arg1: u64) : 0x1::option::Option<address> {
        let v0 = borrow_match_whitelist(arg0, arg1);
        if (0x1::vector::length<address>(&v0.matchers) > 0) {
            0x1::option::some<address>(*0x1::vector::borrow<address>(&v0.matchers, 0))
        } else {
            0x1::option::none<address>()
        }
    }

    fun remove_address_from_vector(arg0: &mut vector<address>, arg1: address) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                0x1::vector::remove<address>(arg0, v0);
                return
            };
            v0 = v0 + 1;
        };
    }

    fun remove_id_from_vector(arg0: &mut vector<0x2::object::ID>, arg1: 0x2::object::ID) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(arg0, v0) == arg1) {
                0x1::vector::remove<0x2::object::ID>(arg0, v0);
                return
            };
            v0 = v0 + 1;
        };
    }

    public fun remove_whitelisted_borrower(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        if (vec_contains_addr(&arg0.whitelisted_borrowers, arg2)) {
            let v0 = &mut arg0.whitelisted_borrowers;
            remove_address_from_vector(v0, arg2);
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_borrower_unlisted(arg2, 0x2::clock::timestamp_ms(arg3));
        };
    }

    public fun remove_whitelisted_lender(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        if (vec_contains_addr(&arg0.whitelisted_lenders, arg2)) {
            let v0 = &mut arg0.whitelisted_lenders;
            remove_address_from_vector(v0, arg2);
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_lender_unlisted(arg2, 0x2::clock::timestamp_ms(arg3));
        };
    }

    public fun remove_whitelisted_oracle(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        if (vec_contains_id(&arg0.whitelisted_oracles, arg2)) {
            let v0 = &mut arg0.whitelisted_oracles;
            remove_id_from_vector(v0, arg2);
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_oracle_removed(arg2, 0x2::clock::timestamp_ms(arg3));
        };
    }

    public fun remove_whitelisted_token(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        if (vec_contains_addr(&arg0.whitelisted_tokens, arg2)) {
            let v0 = &mut arg0.whitelisted_tokens;
            remove_address_from_vector(v0, arg2);
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_token_unlisted(arg2, 0x2::clock::timestamp_ms(arg3));
        };
    }

    public fun request_borrower(arg0: &OfferBook, arg1: u64) : address {
        let v0 = get_request(arg0, arg1);
        v0.borrower
    }

    public fun request_collateral_policy(arg0: &OfferBook, arg1: u64) : u8 {
        let v0 = get_request(arg0, arg1);
        v0.collateral_policy
    }

    public fun request_collateral_required(arg0: &OfferBook, arg1: u64) : u64 {
        let v0 = get_request(arg0, arg1);
        v0.collateral_required
    }

    public fun request_collateral_token(arg0: &OfferBook, arg1: u64) : address {
        let v0 = get_request(arg0, arg1);
        v0.collateral_token
    }

    public fun request_collateral_token_decimals(arg0: &OfferBook, arg1: u64) : u8 {
        let v0 = get_request(arg0, arg1);
        v0.collateral_token_decimals
    }

    public fun request_created_at_ms(arg0: &OfferBook, arg1: u64) : u64 {
        let v0 = get_request(arg0, arg1);
        v0.created_at_ms
    }

    public fun request_duration_secs(arg0: &OfferBook, arg1: u64) : u64 {
        let v0 = get_request(arg0, arg1);
        v0.duration_secs
    }

    public fun request_funding_window_secs(arg0: &OfferBook, arg1: u64) : u64 {
        let v0 = get_request(arg0, arg1);
        v0.funding_window_secs
    }

    public fun request_has_lp_deposits(arg0: &OfferBook, arg1: u64) : bool {
        let v0 = get_request(arg0, arg1);
        v0.has_lp_deposits
    }

    public fun request_has_oracle(arg0: &OfferBook, arg1: u64) : bool {
        let v0 = get_request(arg0, arg1);
        0x1::option::is_some<0x2::object::ID>(&v0.oracle_feed_id)
    }

    public fun request_interest_rate_schedule(arg0: &OfferBook, arg1: u64) : vector<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::InterestRateTier> {
        let v0 = get_request(arg0, arg1);
        let v1 = 0x1::vector::empty<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::InterestRateTier>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::InterestRateTier>(&v0.interest_rate_schedule)) {
            0x1::vector::push_back<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::InterestRateTier>(&mut v1, *0x1::vector::borrow<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::InterestRateTier>(&v0.interest_rate_schedule, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun request_liquidation_price(arg0: &OfferBook, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = get_request(arg0, arg1);
        v0.liquidation_price
    }

    public fun request_liquidation_trigger(arg0: &OfferBook, arg1: u64) : u8 {
        let v0 = get_request(arg0, arg1);
        v0.liquidation_trigger
    }

    public fun request_ltv_bps(arg0: &OfferBook, arg1: u64) : u64 {
        let v0 = get_request(arg0, arg1);
        v0.ltv_bps
    }

    public fun request_min_principal(arg0: &OfferBook, arg1: u64) : u64 {
        let v0 = get_request(arg0, arg1);
        v0.min_principal_amount
    }

    public fun request_oracle_feed_id(arg0: &OfferBook, arg1: u64) : 0x1::option::Option<0x2::object::ID> {
        let v0 = get_request(arg0, arg1);
        v0.oracle_feed_id
    }

    public fun request_principal(arg0: &OfferBook, arg1: u64) : u64 {
        let v0 = get_request(arg0, arg1);
        v0.principal
    }

    public fun request_principal_token(arg0: &OfferBook, arg1: u64) : address {
        let v0 = get_request(arg0, arg1);
        v0.principal_token
    }

    public fun request_principal_token_decimals(arg0: &OfferBook, arg1: u64) : u8 {
        let v0 = get_request(arg0, arg1);
        v0.principal_token_decimals
    }

    public fun request_status(arg0: &OfferBook, arg1: u64) : u8 {
        let v0 = get_request(arg0, arg1);
        v0.status
    }

    public fun request_vault_deployed(arg0: &OfferBook, arg1: u64) : bool {
        let v0 = get_request(arg0, arg1);
        v0.vault_deployed
    }

    fun require_token_decimals(arg0: &OfferBook, arg1: address) : u8 {
        let v0 = token_decimals(arg0, arg1);
        assert!(0x1::option::is_some<u8>(&v0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::token_decimals_not_registered());
        *0x1::option::borrow<u8>(&v0)
    }

    public fun set_borrower_whitelist_enabled(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        arg0.borrower_whitelist_enabled = arg2;
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_borrower_whitelist_enabled_set(arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_lender_whitelist_enabled(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        arg0.lender_whitelist_enabled = arg2;
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_lender_whitelist_enabled_set(arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_liquidation_trigger(arg0: &mut OfferBook, arg1: address, arg2: u64, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::is_valid_liquidation_trigger(arg3), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        let v0 = borrow_request_mut(arg0, arg2);
        assert!(v0.borrower == arg1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(v0.status == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::request_active(), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        assert_no_lp_deposits(v0);
        v0.liquidation_trigger = arg3;
    }

    public fun set_ltv_bps(arg0: &mut OfferBook, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        let v0 = borrow_request_mut(arg0, arg2);
        assert!(v0.borrower == arg1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(v0.status == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::request_active(), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        assert_no_lp_deposits(v0);
        assert!(arg3 > 0 && arg3 < 10000, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_ltv());
        v0.ltv_bps = arg3;
    }

    public fun set_match_whitelist(arg0: &mut OfferBook, arg1: address, arg2: u64, arg3: vector<address>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        let v0 = get_request(arg0, arg2);
        assert!(v0.borrower == arg1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(v0.status == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::request_active(), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        assert!(!v0.has_lp_deposits, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::request_has_deposits());
        if (v0.vault_deployed) {
            let v1 = registered_vault_addr(arg0, arg2);
            if (0x1::option::is_some<address>(&v1)) {
                let v2 = *0x1::option::borrow<address>(&v1);
                if (!vec_contains_addr(&arg3, v2)) {
                    0x1::vector::push_back<address>(&mut arg3, v2);
                };
            };
        };
        borrow_match_whitelist_mut(arg0, arg2).matchers = arg3;
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_match_whitelist_set(arg2, 0x1::vector::length<address>(&arg3), 0x2::clock::timestamp_ms(arg4));
    }

    public fun set_min_principal_amount(arg0: &mut OfferBook, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        let v0 = borrow_request_mut(arg0, arg2);
        assert!(v0.borrower == arg1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(v0.status == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::request_active(), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        assert!(!v0.vault_deployed, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::vault_already_deployed());
        assert!(arg3 > 0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        assert!(arg3 <= v0.principal, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        v0.min_principal_amount = arg3;
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_min_principal_updated(arg2, arg3, 0x2::clock::timestamp_ms(arg4));
    }

    public fun set_oracle(arg0: &mut OfferBook, arg1: address, arg2: u64, arg3: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::OracleFeed, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        let v0 = 0x2::object::id<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::OracleFeed>(arg3);
        assert!(is_whitelisted_oracle(arg0, v0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::oracle_not_whitelisted());
        let v1 = borrow_request_mut(arg0, arg2);
        assert!(v1.borrower == arg1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(v1.status == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::request_active(), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        assert_no_lp_deposits(v1);
        assert!(0x1::option::is_some<u64>(&v1.liquidation_price), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        assert!(*0x1::option::borrow<u64>(&v1.liquidation_price) > 0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::oracle_price_invalid());
        v1.oracle_feed_id = 0x1::option::some<0x2::object::ID>(v0);
    }

    public fun set_token_decimals(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: address, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(arg3 <= 18, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        let v0 = TokenDecimalsKey{token: arg2};
        if (0x2::dynamic_field::exists_<TokenDecimalsKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<TokenDecimalsKey, u8>(&mut arg0.id, v0) = arg3;
        } else {
            0x2::dynamic_field::add<TokenDecimalsKey, u8>(&mut arg0.id, v0, arg3);
        };
    }

    public fun token_decimals(arg0: &OfferBook, arg1: address) : 0x1::option::Option<u8> {
        let v0 = TokenDecimalsKey{token: arg1};
        if (0x2::dynamic_field::exists_<TokenDecimalsKey>(&arg0.id, v0)) {
            0x1::option::some<u8>(*0x2::dynamic_field::borrow<TokenDecimalsKey, u8>(&arg0.id, v0))
        } else {
            0x1::option::none<u8>()
        }
    }

    public fun unpause(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        arg0.paused = false;
        let v0 = 0x2::clock::timestamp_ms(arg2);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_admin_action(0x2::object::id<OfferBook>(arg0), 0x2::tx_context::sender(arg3), 2, v0);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_protocol_unpaused(0x2::object::id<OfferBook>(arg0), 0x2::tx_context::sender(arg3), v0);
    }

    fun validate_schedule(arg0: &vector<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::InterestRateTier>) {
        assert!(0x1::vector::length<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::InterestRateTier>(arg0) > 0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_interest_schedule());
        assert!(0x1::vector::length<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::InterestRateTier>(arg0) <= 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::max_interest_tiers(), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_interest_schedule());
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::InterestRateTier>(arg0)) {
            let v2 = 0x1::vector::borrow<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::InterestRateTier>(arg0, v0);
            if (v0 == 0) {
                assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::tier_from_seconds(v2) == 0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_interest_schedule());
            } else {
                assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::tier_from_seconds(v2) > v1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_interest_schedule());
            };
            assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::tier_from_seconds(v2) <= 31536000, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_interest_schedule());
            assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::tier_rate_bps(v2) > 0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_interest_rate());
            assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::tier_rate_bps(v2) <= 10000, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::max_rate_exceeded());
            v1 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::tier_from_seconds(v2);
            v0 = v0 + 1;
        };
    }

    fun vec_contains_addr(arg0: &vector<address>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun vec_contains_id(arg0: &vector<0x2::object::ID>, arg1: 0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    // decompiled from Move bytecode v7
}

