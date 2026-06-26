module 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book {
    struct OfferBookAdminCap has store, key {
        id: 0x2::object::UID,
        book_id: 0x2::object::ID,
    }

    struct OfferBookOperatorCap has store, key {
        id: 0x2::object::UID,
        book_id: 0x2::object::ID,
    }

    struct LoanRequest has copy, drop, store {
        id: u64,
        borrower: address,
        principal_token: address,
        collateral_token: address,
        principal: u64,
        min_principal_amount: u64,
        interest_rate_schedule: vector<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>,
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
        lender_whitelist: vector<address>,
    }

    struct RequestMatchWhitelist has store {
        request_id: u64,
        matchers: vector<address>,
    }

    struct OfferBook has key {
        id: 0x2::object::UID,
        admin: address,
        operator: address,
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

    public fun add_whitelisted_borrower(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        if (!vec_contains_addr(&arg0.whitelisted_borrowers, arg2)) {
            0x1::vector::push_back<address>(&mut arg0.whitelisted_borrowers, arg2);
        };
    }

    public fun add_whitelisted_lender(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        if (!vec_contains_addr(&arg0.whitelisted_lenders, arg2)) {
            0x1::vector::push_back<address>(&mut arg0.whitelisted_lenders, arg2);
        };
    }

    public fun add_whitelisted_oracle(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        if (!vec_contains_id(&arg0.whitelisted_oracles, arg2)) {
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.whitelisted_oracles, arg2);
        };
    }

    public fun add_whitelisted_token(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        if (!vec_contains_addr(&arg0.whitelisted_tokens, arg2)) {
            0x1::vector::push_back<address>(&mut arg0.whitelisted_tokens, arg2);
        };
    }

    public fun assert_request_oracle_matches(arg0: &OfferBook, arg1: u64, arg2: 0x2::object::ID) {
        let v0 = get_request(arg0, arg1);
        if (0x1::option::is_some<0x2::object::ID>(&v0.oracle_feed_id)) {
            assert!(*0x1::option::borrow<0x2::object::ID>(&v0.oracle_feed_id) == arg2, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        };
    }

    public(friend) fun authorize_match(arg0: &mut OfferBook, arg1: u64, arg2: address, arg3: bool, arg4: &0x2::clock::Clock) {
        assert!(!arg0.paused, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::paused());
        let v0 = get_request(arg0, arg1);
        assert!(v0.borrower != arg2, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::self_match_forbidden());
        if (!arg3) {
            let v1 = borrow_match_whitelist(arg0, arg1);
            if (0x1::vector::length<address>(&v1.matchers) > 0) {
                assert!(vec_contains_addr(&v1.matchers, arg2), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::matcher_not_whitelisted());
            };
        };
        assert!(v0.status == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::request_active(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        assert!(0x2::clock::timestamp_ms(arg4) < v0.created_at_ms + v0.funding_window_secs * 1000, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::funding_window_expired());
        let v2 = borrow_request_mut(arg0, arg1);
        v2.status = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::request_matched();
        v2.matched_lender = arg2;
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_request_matched(arg1, arg2, 0x2::clock::timestamp_ms(arg4));
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
        abort 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::not_found()
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
        abort 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::not_found()
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
        abort 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::not_found()
    }

    public fun create_offer_book(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (OfferBookAdminCap, OfferBookOperatorCap) {
        let v0 = OfferBook{
            id                         : 0x2::object::new(arg2),
            admin                      : arg0,
            operator                   : arg1,
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
        let v1 = 0x2::object::id<OfferBook>(&v0);
        0x2::transfer::share_object<OfferBook>(v0);
        let v2 = OfferBookAdminCap{
            id      : 0x2::object::new(arg2),
            book_id : v1,
        };
        let v3 = OfferBookOperatorCap{
            id      : 0x2::object::new(arg2),
            book_id : v1,
        };
        (v2, v3)
    }

    public fun create_request(arg0: &mut OfferBook, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::vector::empty<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>();
        0x1::vector::push_back<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>(&mut v0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::new_interest_rate_tier(0, arg4));
        create_request_with_window_and_coins(arg0, arg1, arg2, arg3, v0, arg5, 300, arg6, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::collateral_policy_direct_claim(), 0x1::option::none<u64>(), arg7, arg8)
    }

    public fun create_request_with_window_and_coins(arg0: &mut OfferBook, arg1: address, arg2: address, arg3: u64, arg4: vector<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: 0x1::option::Option<u64>, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) : u64 {
        assert!(!arg0.paused, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::paused());
        assert!(arg3 > 0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_amount());
        assert!(arg7 > 0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_amount());
        assert!(arg5 > 0 && arg5 <= 86400, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_duration());
        assert!(arg6 > 0 && arg6 <= 86400, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_duration());
        validate_schedule(&arg4);
        assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::is_valid_collateral_policy(arg8), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        assert!(is_whitelisted_token(arg0, arg1), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::token_not_whitelisted());
        assert!(is_whitelisted_token(arg0, arg2), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::token_not_whitelisted());
        let v0 = 0x2::tx_context::sender(arg11);
        assert!(is_borrower_allowed(arg0, v0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::borrower_not_whitelisted());
        let v1 = arg0.next_request_id;
        arg0.next_request_id = v1 + 1;
        let v2 = LoanRequest{
            id                     : v1,
            borrower               : v0,
            principal_token        : arg1,
            collateral_token       : arg2,
            principal              : arg3,
            min_principal_amount   : arg3,
            interest_rate_schedule : arg4,
            duration_secs          : arg5,
            funding_window_secs    : arg6,
            created_at_ms          : 0x2::clock::timestamp_ms(arg10),
            collateral_required    : arg7,
            oracle_feed_id         : 0x1::option::none<0x2::object::ID>(),
            liquidation_price      : arg9,
            ltv_bps                : 6000,
            collateral_policy      : arg8,
            liquidation_trigger    : 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::liquidation_trigger_open(),
            status                 : 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::request_active(),
            matched_lender         : @0x0,
            vault_deployed         : false,
            lender_whitelist       : vector[],
        };
        0x1::vector::push_back<LoanRequest>(&mut arg0.requests, v2);
        let v3 = RequestMatchWhitelist{
            request_id : v1,
            matchers   : vector[],
        };
        0x1::vector::push_back<RequestMatchWhitelist>(&mut arg0.match_whitelists, v3);
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_request_created(v1, v0, arg1, arg3, arg3, arg2, arg7, arg4, arg5, arg6, arg8, arg9, 0x1::option::none<0x2::object::ID>(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::liquidation_trigger_open(), 6000, 0x2::clock::timestamp_ms(arg10));
        v1
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
        abort 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::not_found()
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

    public fun is_request_lender_allowed(arg0: &OfferBook, arg1: u64, arg2: address) : bool {
        let v0 = get_request(arg0, arg1);
        if (0x1::vector::length<address>(&v0.lender_whitelist) == 0) {
            return true
        };
        vec_contains_addr(&v0.lender_whitelist, arg2)
    }

    public fun is_whitelisted_oracle(arg0: &OfferBook, arg1: 0x2::object::ID) : bool {
        vec_contains_id(&arg0.whitelisted_oracles, arg1)
    }

    public fun is_whitelisted_token(arg0: &OfferBook, arg1: address) : bool {
        vec_contains_addr(&arg0.whitelisted_tokens, arg1)
    }

    public(friend) fun mark_cancelled(arg0: &mut OfferBook, arg1: u64) {
        let v0 = borrow_request_mut(arg0, arg1);
        assert!(v0.status == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::request_active(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        v0.status = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::request_cancelled();
    }

    public fun pause(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        arg0.paused = true;
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_admin_action(0x2::object::id<OfferBook>(arg0), 0x2::tx_context::sender(arg3), 1, 0x2::clock::timestamp_ms(arg2));
    }

    public(friend) fun register_vault(arg0: &mut OfferBook, arg1: u64, arg2: address) {
        let v0 = borrow_request_mut(arg0, arg1);
        assert!(v0.status == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::request_active(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        assert!(!v0.vault_deployed, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::vault_already_deployed());
        v0.vault_deployed = true;
        let v1 = borrow_match_whitelist_mut(arg0, arg1);
        if (!vec_contains_addr(&v1.matchers, arg2)) {
            0x1::vector::push_back<address>(&mut v1.matchers, arg2);
        };
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

    public fun remove_whitelisted_borrower(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        let v0 = &mut arg0.whitelisted_borrowers;
        remove_address_from_vector(v0, arg2);
    }

    public fun remove_whitelisted_lender(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        let v0 = &mut arg0.whitelisted_lenders;
        remove_address_from_vector(v0, arg2);
    }

    public fun remove_whitelisted_oracle(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        let v0 = &mut arg0.whitelisted_oracles;
        remove_id_from_vector(v0, arg2);
    }

    public fun remove_whitelisted_token(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        let v0 = &mut arg0.whitelisted_tokens;
        remove_address_from_vector(v0, arg2);
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

    public fun request_has_oracle(arg0: &OfferBook, arg1: u64) : bool {
        let v0 = get_request(arg0, arg1);
        0x1::option::is_some<0x2::object::ID>(&v0.oracle_feed_id)
    }

    public fun request_interest_rate_schedule(arg0: &OfferBook, arg1: u64) : vector<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier> {
        let v0 = get_request(arg0, arg1);
        let v1 = 0x1::vector::empty<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>(&v0.interest_rate_schedule)) {
            0x1::vector::push_back<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>(&mut v1, *0x1::vector::borrow<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>(&v0.interest_rate_schedule, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun request_lender_whitelist(arg0: &OfferBook, arg1: u64) : vector<address> {
        let v0 = get_request(arg0, arg1);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v0.lender_whitelist)) {
            0x1::vector::push_back<address>(&mut v1, *0x1::vector::borrow<address>(&v0.lender_whitelist, v2));
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

    public fun request_status(arg0: &OfferBook, arg1: u64) : u8 {
        let v0 = get_request(arg0, arg1);
        v0.status
    }

    public fun request_vault_deployed(arg0: &OfferBook, arg1: u64) : bool {
        let v0 = get_request(arg0, arg1);
        v0.vault_deployed
    }

    public fun set_borrower_whitelist_enabled(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        arg0.borrower_whitelist_enabled = arg2;
    }

    public fun set_collateral_policy(arg0: &mut OfferBook, arg1: address, arg2: u64, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::is_valid_collateral_policy(arg3), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        let v0 = borrow_request_mut(arg0, arg2);
        assert!(v0.borrower == arg1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(v0.status == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::request_active(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        assert!(!v0.vault_deployed, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::vault_already_deployed());
        v0.collateral_policy = arg3;
    }

    public fun set_interest_rate_schedule(arg0: &mut OfferBook, arg1: address, arg2: u64, arg3: vector<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        validate_schedule(&arg3);
        let v0 = borrow_request_mut(arg0, arg2);
        assert!(v0.borrower == arg1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(v0.status == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::request_active(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        assert!(!v0.vault_deployed, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::vault_already_deployed());
        v0.interest_rate_schedule = arg3;
    }

    public fun set_lender_whitelist_enabled(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        arg0.lender_whitelist_enabled = arg2;
    }

    public fun set_liquidation_price(arg0: &mut OfferBook, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        let v0 = borrow_request_mut(arg0, arg2);
        assert!(v0.borrower == arg1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(v0.status == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::request_active(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        assert!(!v0.vault_deployed, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::vault_already_deployed());
        assert!(arg3 > 0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::oracle_price_invalid());
        v0.liquidation_price = 0x1::option::some<u64>(arg3);
    }

    public fun set_liquidation_trigger(arg0: &mut OfferBook, arg1: address, arg2: u64, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::is_valid_liquidation_trigger(arg3), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        let v0 = borrow_request_mut(arg0, arg2);
        assert!(v0.borrower == arg1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(v0.status == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::request_active(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        assert!(!v0.vault_deployed, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::vault_already_deployed());
        v0.liquidation_trigger = arg3;
    }

    public fun set_ltv_bps(arg0: &mut OfferBook, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        let v0 = borrow_request_mut(arg0, arg2);
        assert!(v0.borrower == arg1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(v0.status == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::request_active(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        assert!(!v0.vault_deployed, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::vault_already_deployed());
        assert!(arg3 > 0 && arg3 < 10000, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_ltv());
        v0.ltv_bps = arg3;
    }

    public fun set_match_whitelist(arg0: &mut OfferBook, arg1: address, arg2: u64, arg3: vector<address>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        let v0 = get_request(arg0, arg2);
        assert!(v0.borrower == arg1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(v0.status == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::request_active(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
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
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_match_whitelist_set(arg2, 0x1::vector::length<address>(&arg3), 0x2::clock::timestamp_ms(arg4));
    }

    public fun set_min_principal_amount(arg0: &mut OfferBook, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        let v0 = borrow_request_mut(arg0, arg2);
        assert!(v0.borrower == arg1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(v0.status == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::request_active(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        assert!(!v0.vault_deployed, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::vault_already_deployed());
        assert!(arg3 > 0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        assert!(arg3 <= v0.principal, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        v0.min_principal_amount = arg3;
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_min_principal_updated(arg2, arg3, 0x2::clock::timestamp_ms(arg4));
    }

    public fun set_oracle(arg0: &mut OfferBook, arg1: address, arg2: u64, arg3: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_oracle_iface::OracleFeed, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        let v0 = 0x2::object::id<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_oracle_iface::OracleFeed>(arg3);
        assert!(is_whitelisted_oracle(arg0, v0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::oracle_not_whitelisted());
        let v1 = borrow_request_mut(arg0, arg2);
        assert!(v1.borrower == arg1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(v1.status == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::request_active(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        assert!(!v1.vault_deployed, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::vault_already_deployed());
        assert!(0x1::option::is_some<u64>(&v1.liquidation_price), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        v1.oracle_feed_id = 0x1::option::some<0x2::object::ID>(v0);
    }

    public fun set_request_lender_whitelist(arg0: &mut OfferBook, arg1: address, arg2: u64, arg3: vector<address>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        let v0 = borrow_request_mut(arg0, arg2);
        assert!(v0.borrower == arg1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(v0.status == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::request_active(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        assert!(!v0.vault_deployed, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::vault_already_deployed());
        v0.lender_whitelist = arg3;
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_request_lender_whitelist_set(arg2, 0x1::vector::length<address>(&arg3), 0x2::clock::timestamp_ms(arg4));
    }

    public fun unpause(arg0: &mut OfferBook, arg1: &OfferBookAdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.book_id == 0x2::object::id<OfferBook>(arg0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        arg0.paused = false;
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_admin_action(0x2::object::id<OfferBook>(arg0), 0x2::tx_context::sender(arg3), 2, 0x2::clock::timestamp_ms(arg2));
    }

    fun validate_schedule(arg0: &vector<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>) {
        assert!(0x1::vector::length<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>(arg0) > 0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_interest_schedule());
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>(arg0)) {
            let v2 = 0x1::vector::borrow<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>(arg0, v0);
            if (v0 == 0) {
                assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::tier_from_seconds(v2) == 0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_interest_schedule());
            } else {
                assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::tier_from_seconds(v2) > v1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_interest_schedule());
            };
            assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::tier_rate_bps(v2) > 0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_interest_rate());
            assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::tier_rate_bps(v2) <= 10000, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::max_rate_exceeded());
            v1 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::tier_from_seconds(v2);
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

