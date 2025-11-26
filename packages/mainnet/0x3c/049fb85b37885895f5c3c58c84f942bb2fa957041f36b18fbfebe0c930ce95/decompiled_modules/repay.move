module 0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::repay {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ClaimsTable has store {
        claims: 0x2::table::Table<address, u64>,
        total_claimed: u64,
        total_allocated: u64,
    }

    struct RepayRegistry has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::neom::NEOM>,
        claims_by_token: 0x2::table::Table<0x1::type_name::TypeName, ClaimsTable>,
        balances: 0x2::bag::Bag,
        max_neom_token_supply: u64,
        is_claim_started: bool,
    }

    struct ClaimsSetEvent has copy, drop {
        token_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct ClaimStartSetEvent has copy, drop {
        start: bool,
    }

    struct ClaimsAddedEvent has copy, drop {
        token_type: 0x1::type_name::TypeName,
        count: u64,
        total_amount: u64,
    }

    struct ClaimEvent has copy, drop {
        user: address,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct ClaimsRemovedEvent has copy, drop {
        user: address,
        token_type: 0x1::type_name::TypeName,
    }

    struct TokenTypeRegisteredEvent has copy, drop {
        token_type: 0x1::type_name::TypeName,
    }

    public fun add_balance<T0: drop>(arg0: &0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::version::Version, arg1: &mut RepayRegistry, arg2: 0x2::coin::Coin<T0>, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::version::assert_current_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, ClaimsTable>(&arg1.claims_by_token, v0), 4099);
        if (!0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg1.balances, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0), 0x2::coin::into_balance<T0>(arg2));
    }

    public fun batch_add_claims<T0: drop>(arg0: &0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::version::Version, arg1: &mut RepayRegistry, arg2: &AdminCap, arg3: vector<address>, arg4: vector<u64>, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::version::assert_current_version(arg0);
        assert!(!arg1.is_claim_started, 4116);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, ClaimsTable>(&arg1.claims_by_token, v0), 4099);
        let v1 = 0x1::vector::length<address>(&arg3);
        assert!(v1 == 0x1::vector::length<u64>(&arg4), 4101);
        assert!(v1 > 0, 4102);
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, ClaimsTable>(&mut arg1.claims_by_token, v0);
        let v3 = 0;
        let v4 = 0;
        while (v3 < v1) {
            let v5 = *0x1::vector::borrow<address>(&arg3, v3);
            let v6 = *0x1::vector::borrow<u64>(&arg4, v3);
            if (0x2::table::contains<address, u64>(&v2.claims, v5)) {
                let v7 = 0x2::table::borrow_mut<address, u64>(&mut v2.claims, v5);
                *v7 = *v7 + v6;
            } else {
                0x2::table::add<address, u64>(&mut v2.claims, v5, v6);
            };
            v4 = v4 + v6;
            v3 = v3 + 1;
        };
        assert!(v4 == arg5, 4103);
        v2.total_allocated = v2.total_allocated + v4;
        if (v0 == 0x1::type_name::get<0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::neom::NEOM>()) {
            assert!(v2.total_allocated <= arg1.max_neom_token_supply, 4105);
        } else {
            assert!(v2.total_allocated - v2.total_claimed <= 0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg1.balances, v0)), 4113);
        };
        let v8 = ClaimsAddedEvent{
            token_type   : v0,
            count        : v1,
            total_amount : v4,
        };
        0x2::event::emit<ClaimsAddedEvent>(v8);
    }

    public fun claim_neom(arg0: &0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::version::Version, arg1: &mut RepayRegistry, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::neom::NEOM> {
        0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::version::assert_current_version(arg0);
        assert!(arg1.is_claim_started, 4115);
        let v0 = 0x1::type_name::get<0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::neom::NEOM>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, ClaimsTable>(&arg1.claims_by_token, v0), 4099);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, ClaimsTable>(&mut arg1.claims_by_token, v0);
        assert!(0x2::table::contains<address, u64>(&v2.claims, v1), 4098);
        let v3 = 0x2::table::remove<address, u64>(&mut v2.claims, v1);
        v2.total_claimed = v2.total_claimed + v3;
        let v4 = ClaimEvent{
            user       : v1,
            token_type : v0,
            amount     : v3,
        };
        0x2::event::emit<ClaimEvent>(v4);
        0x2::coin::mint<0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::neom::NEOM>(&mut arg1.treasury_cap, v3, arg2)
    }

    public fun claim_yield_tokens<T0: drop>(arg0: &0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::version::Version, arg1: &mut RepayRegistry, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::version::assert_current_version(arg0);
        assert!(arg1.is_claim_started, 4115);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, ClaimsTable>(&arg1.claims_by_token, v0), 4099);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, ClaimsTable>(&mut arg1.claims_by_token, v0);
        assert!(0x2::table::contains<address, u64>(&v2.claims, v1), 4098);
        let v3 = 0x2::table::remove<address, u64>(&mut v2.claims, v1);
        v2.total_claimed = v2.total_claimed + v3;
        let v4 = ClaimEvent{
            user       : v1,
            token_type : v0,
            amount     : v3,
        };
        0x2::event::emit<ClaimEvent>(v4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0), v3), arg2)
    }

    public fun emergency_rescue_yield_tokens<T0: drop>(arg0: &0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::version::Version, arg1: &mut RepayRegistry, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::version::assert_current_version(arg0);
        let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, 0x1::type_name::get<T0>());
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, 0x2::balance::value<T0>(v0)), arg3)
    }

    public fun get_claim_amount<T0: drop>(arg0: &RepayRegistry, arg1: address) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, ClaimsTable>(&arg0.claims_by_token, v0)) {
            return 0
        };
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, ClaimsTable>(&arg0.claims_by_token, v0);
        if (0x2::table::contains<address, u64>(&v1.claims, arg1)) {
            *0x2::table::borrow<address, u64>(&v1.claims, arg1)
        } else {
            0
        }
    }

    public fun get_max_neom_token_supply(arg0: &RepayRegistry) : u64 {
        arg0.max_neom_token_supply
    }

    public fun get_yield_token_balance_value<T0: drop>(arg0: &RepayRegistry) : u64 {
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, 0x1::type_name::get<T0>()))
    }

    public fun has_claim<T0: drop>(arg0: &RepayRegistry, arg1: address) : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, ClaimsTable>(&arg0.claims_by_token, v0)) {
            return false
        };
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, ClaimsTable>(&arg0.claims_by_token, v0);
        0x2::table::contains<address, u64>(&v1.claims, arg1) && *0x2::table::borrow<address, u64>(&v1.claims, arg1) > 0
    }

    public fun init_registry(arg0: 0x2::coin::TreasuryCap<0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::neom::NEOM>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::neom::NEOM>(&arg0) == 0, 4112);
        let v0 = RepayRegistry{
            id                    : 0x2::object::new(arg2),
            treasury_cap          : arg0,
            claims_by_token       : 0x2::table::new<0x1::type_name::TypeName, ClaimsTable>(arg2),
            balances              : 0x2::bag::new(arg2),
            max_neom_token_supply : arg1,
            is_claim_started      : false,
        };
        let v1 = ClaimsTable{
            claims          : 0x2::table::new<address, u64>(arg2),
            total_claimed   : 0,
            total_allocated : 0,
        };
        0x2::table::add<0x1::type_name::TypeName, ClaimsTable>(&mut v0.claims_by_token, 0x1::type_name::get<0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::neom::NEOM>(), v1);
        0x2::transfer::share_object<RepayRegistry>(v0);
        let v2 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg2));
    }

    public fun is_token_type_registered<T0: drop>(arg0: &RepayRegistry) : bool {
        0x2::table::contains<0x1::type_name::TypeName, ClaimsTable>(&arg0.claims_by_token, 0x1::type_name::get<T0>())
    }

    public fun register_token_type<T0: drop>(arg0: &0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::version::Version, arg1: &mut RepayRegistry, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::version::assert_current_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, ClaimsTable>(&arg1.claims_by_token, v0), 4100);
        let v1 = ClaimsTable{
            claims          : 0x2::table::new<address, u64>(arg3),
            total_claimed   : 0,
            total_allocated : 0,
        };
        0x2::table::add<0x1::type_name::TypeName, ClaimsTable>(&mut arg1.claims_by_token, v0, v1);
        if (!0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg1.balances, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0, 0x2::balance::zero<T0>());
        };
        let v2 = TokenTypeRegisteredEvent{token_type: v0};
        0x2::event::emit<TokenTypeRegisteredEvent>(v2);
    }

    public fun remove_claim<T0: drop>(arg0: &0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::version::Version, arg1: &mut RepayRegistry, arg2: &AdminCap, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::version::assert_current_version(arg0);
        assert!(!arg1.is_claim_started, 4116);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, ClaimsTable>(&arg1.claims_by_token, v0), 4099);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, ClaimsTable>(&mut arg1.claims_by_token, v0);
        assert!(0x2::table::contains<address, u64>(&v1.claims, arg3), 4098);
        v1.total_allocated = v1.total_allocated - *0x2::table::borrow<address, u64>(&v1.claims, arg3);
        0x2::table::remove<address, u64>(&mut v1.claims, arg3);
        let v2 = ClaimsRemovedEvent{
            user       : arg3,
            token_type : v0,
        };
        0x2::event::emit<ClaimsRemovedEvent>(v2);
    }

    public fun set_claim<T0: drop>(arg0: &0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::version::Version, arg1: &mut RepayRegistry, arg2: &AdminCap, arg3: address, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::version::assert_current_version(arg0);
        assert!(arg4 > 0, 4104);
        assert!(!arg1.is_claim_started, 4116);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, ClaimsTable>(&arg1.claims_by_token, v0), 4099);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, ClaimsTable>(&mut arg1.claims_by_token, v0);
        if (0x2::table::contains<address, u64>(&v1.claims, arg3)) {
            v1.total_allocated = v1.total_allocated - *0x2::table::borrow<address, u64>(&v1.claims, arg3) + arg4;
            *0x2::table::borrow_mut<address, u64>(&mut v1.claims, arg3) = arg4;
        } else {
            v1.total_allocated = v1.total_allocated + arg4;
            0x2::table::add<address, u64>(&mut v1.claims, arg3, arg4);
        };
        if (v0 == 0x1::type_name::get<0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::neom::NEOM>()) {
            assert!(v1.total_allocated <= arg1.max_neom_token_supply, 4105);
        } else {
            assert!(v1.total_allocated - v1.total_claimed <= 0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg1.balances, v0)), 4113);
        };
        let v2 = ClaimsSetEvent{
            token_type : v0,
            amount     : arg4,
        };
        0x2::event::emit<ClaimsSetEvent>(v2);
    }

    public fun skim_excess_yield_tokens<T0: drop>(arg0: &0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::version::Version, arg1: &mut RepayRegistry, arg2: u64, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::version::assert_current_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, ClaimsTable>(&arg1.claims_by_token, v0);
        assert!(0x2::balance::value<T0>(v1) >= v2.total_allocated - v2.total_claimed + arg2, 4114);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg2), arg4)
    }

    public fun start_claim(arg0: &0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::version::Version, arg1: &mut RepayRegistry, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::version::assert_current_version(arg0);
        assert!(!arg1.is_claim_started, 4116);
        arg1.is_claim_started = true;
        let v0 = ClaimStartSetEvent{start: true};
        0x2::event::emit<ClaimStartSetEvent>(v0);
    }

    public fun stop_claim(arg0: &0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::version::Version, arg1: &mut RepayRegistry, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x3c049fb85b37885895f5c3c58c84f942bb2fa957041f36b18fbfebe0c930ce95::version::assert_current_version(arg0);
        assert!(arg1.is_claim_started, 4115);
        arg1.is_claim_started = false;
        let v0 = ClaimStartSetEvent{start: false};
        0x2::event::emit<ClaimStartSetEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

