module 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::policy {
    struct Recent has copy, drop, store {
        intent_id: 0x2::object::ID,
        at_ms: u64,
        amount: u64,
    }

    struct PendingLimits has copy, drop, store {
        approval_threshold: u64,
        period_budget: u64,
        delay_ms: u64,
        ready_at_ms: u64,
    }

    struct Policy has key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        agent: address,
        allowed_sellers: 0x2::vec_set::VecSet<0x2::object::ID>,
        approval_threshold: u64,
        recent: vector<Recent>,
        period_ms: u64,
        period_budget: u64,
        period_start_ms: u64,
        spent: u64,
        reserved: u64,
        revoked: bool,
        delay_ms: u64,
        pending_sellers: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        pending_limits: 0x1::option::Option<PendingLimits>,
        coins: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        pending_coins: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        previous_agent: 0x1::option::Option<address>,
    }

    struct PolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        owner: address,
        agent: address,
    }

    struct PolicyRevoked has copy, drop {
        policy_id: 0x2::object::ID,
    }

    struct AgentRotated has copy, drop {
        policy_id: 0x2::object::ID,
        agent: address,
    }

    struct SellerAllowed has copy, drop {
        policy_id: 0x2::object::ID,
        seller_id: 0x2::object::ID,
        allowed: bool,
    }

    struct SellerProposed has copy, drop {
        policy_id: 0x2::object::ID,
        seller_id: 0x2::object::ID,
        ready_at_ms: u64,
    }

    struct LimitsChanged has copy, drop {
        policy_id: 0x2::object::ID,
        approval_threshold: u64,
        period_budget: u64,
        delay_ms: u64,
    }

    struct LimitsProposed has copy, drop {
        policy_id: 0x2::object::ID,
        approval_threshold: u64,
        period_budget: u64,
        delay_ms: u64,
        ready_at_ms: u64,
    }

    struct LimitsProposalCancelled has copy, drop {
        policy_id: 0x2::object::ID,
    }

    struct CoinAllowed has copy, drop {
        policy_id: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        allowed: bool,
    }

    struct CoinProposed has copy, drop {
        policy_id: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        ready_at_ms: u64,
    }

    struct BindingKey has copy, drop, store {
        coin: 0x1::type_name::TypeName,
    }

    struct Binding has drop, store {
        label: 0x1::string::String,
        used: 0x2::vec_set::VecSet<0x1::string::String>,
    }

    struct CountedFrom has copy, drop, store {
        intent_id: 0x2::object::ID,
    }

    public(friend) fun spend_permit() : 0x2::allowance::SpendPermit<Policy> {
        0x2::allowance::spend_permit<Policy>(0x1::internal::permit<Policy>())
    }

    public fun new<T0>(arg0: 0x2::allowance::AllowanceProposal<0x2::balance::Balance<T0>>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: vector<0x2::object::ID>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : Policy {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        let v0 = 0x2::allowance::allowance_proposal_settings<0x2::balance::Balance<T0>>(&arg0);
        let v1 = 0x2::allowance::funder(v0);
        let v2 = 0x2::allowance::spender(v0);
        assert!(v1 == 0x2::tx_context::sender(arg8), 16);
        assert!(0x1::option::is_some<address>(&v2), 18);
        let v3 = 0x1::option::destroy_some<address>(v2);
        0x2::allowance::issue<0x2::balance::Balance<T0>, Policy>(arg0, 0x2::allowance::settings_permit<Policy>(0x1::internal::permit<Policy>()), arg8);
        let v4 = 0x2::vec_set::empty<0x2::object::ID>();
        0x1::vector::reverse<0x2::object::ID>(&mut arg2);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut v4, 0x1::vector::pop_back<0x2::object::ID>(&mut arg2));
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg2);
        let v6 = Policy{
            id                 : 0x2::object::new(arg8),
            version            : 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::current(),
            owner              : v1,
            agent              : v3,
            allowed_sellers    : v4,
            approval_threshold : arg3,
            recent             : 0x1::vector::empty<Recent>(),
            period_ms          : arg4,
            period_budget      : arg5,
            period_start_ms    : 0x2::clock::timestamp_ms(arg7),
            spent              : 0,
            reserved           : 0,
            revoked            : false,
            delay_ms           : arg6,
            pending_sellers    : 0x2::vec_map::empty<0x2::object::ID, u64>(),
            pending_limits     : 0x1::option::none<PendingLimits>(),
            coins              : 0x2::vec_set::singleton<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>()),
            pending_coins      : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            previous_agent     : 0x1::option::none<address>(),
        };
        let v7 = &mut v6;
        bind_allowance(v7, 0x1::type_name::with_defining_ids<T0>(), *0x2::allowance::name(0x2::allowance::allowance_proposal_settings<0x2::balance::Balance<T0>>(&arg0)));
        let v8 = PolicyCreated{
            policy_id : 0x2::object::id<Policy>(&v6),
            owner     : v1,
            agent     : v3,
        };
        0x2::event::emit<PolicyCreated>(v8);
        v6
    }

    public fun add_coin<T0>(arg0: &mut Policy, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: 0x2::allowance::AllowanceProposal<0x2::balance::Balance<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 16);
        let v0 = 0x2::allowance::allowance_proposal_settings<0x2::balance::Balance<T0>>(&arg2);
        assert!(0x2::allowance::funder(v0) == arg0.owner, 16);
        assert!(0x2::allowance::spender(v0) == 0x1::option::some<address>(arg0.agent), 18);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.coins, &v1) && !0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.pending_coins, &v1), 53);
        bind_allowance(arg0, v1, *0x2::allowance::name(0x2::allowance::allowance_proposal_settings<0x2::balance::Balance<T0>>(&arg2)));
        0x2::allowance::issue<0x2::balance::Balance<T0>, Policy>(arg2, 0x2::allowance::settings_permit<Policy>(0x1::internal::permit<Policy>()), arg4);
        if (arg0.delay_ms == 0) {
            insert_coin(arg0, v1);
            return
        };
        let v2 = 0x2::clock::timestamp_ms(arg3) + arg0.delay_ms;
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.pending_coins, v1, v2);
        let v3 = CoinProposed{
            policy_id   : 0x2::object::id<Policy>(arg0),
            coin        : v1,
            ready_at_ms : v2,
        };
        0x2::event::emit<CoinProposed>(v3);
    }

    public fun version(arg0: &Policy) : u64 {
        arg0.version
    }

    fun add_seller(arg0: &mut Policy, arg1: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_sellers, arg1);
        let v0 = SellerAllowed{
            policy_id : 0x2::object::id<Policy>(arg0),
            seller_id : arg1,
            allowed   : true,
        };
        0x2::event::emit<SellerAllowed>(v0);
    }

    public fun agent(arg0: &Policy) : address {
        arg0.agent
    }

    public fun allow_seller(arg0: &mut Policy, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 16);
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_sellers, &arg2)) {
            return
        };
        if (arg0.delay_ms == 0) {
            add_seller(arg0, arg2);
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg3) + arg0.delay_ms;
        if (0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.pending_sellers, &arg2)) {
            return
        };
        0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg0.pending_sellers, arg2, v0);
        let v1 = SellerProposed{
            policy_id   : 0x2::object::id<Policy>(arg0),
            seller_id   : arg2,
            ready_at_ms : v0,
        };
        0x2::event::emit<SellerProposed>(v1);
    }

    public fun approval_threshold(arg0: &Policy) : u64 {
        arg0.approval_threshold
    }

    public(friend) fun assert_allowance<T0>(arg0: &Policy, arg1: &0x2::allowance::Allowance<0x2::balance::Balance<T0>>) {
        let v0 = 0x2::allowance::allowance_settings<0x2::balance::Balance<T0>>(arg1);
        assert!(0x2::allowance::funder(v0) == arg0.owner, 17);
        let v1 = 0x2::allowance::spender(v0);
        assert!(0x1::option::contains<address>(&v1, &arg0.agent), 17);
        let v2 = 0x2::allowance::app(v0);
        let v3 = 0x1::type_name::with_defining_ids<Policy>();
        assert!(0x1::option::contains<0x1::type_name::TypeName>(&v2, &v3), 17);
        assert_coin<T0>(arg0);
        assert_bound<T0>(arg0, arg1);
    }

    fun assert_bound<T0>(arg0: &Policy, arg1: &0x2::allowance::Allowance<0x2::balance::Balance<T0>>) {
        let v0 = BindingKey{coin: 0x1::type_name::with_defining_ids<T0>()};
        if (0x2::dynamic_field::exists_<BindingKey>(&arg0.id, v0)) {
            assert!(0x2::allowance::name(0x2::allowance::allowance_settings<0x2::balance::Balance<T0>>(arg1)) == &0x2::dynamic_field::borrow<BindingKey, Binding>(&arg0.id, v0).label, 17);
        };
    }

    public(friend) fun assert_can_spend(arg0: &Policy, arg1: address) {
        assert!(arg0.agent == arg1, 10);
        assert!(!arg0.revoked, 11);
    }

    public(friend) fun assert_coin<T0>(arg0: &Policy) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.coins, &v0), 52);
    }

    public(friend) fun assert_seller_allowed(arg0: &Policy, arg1: 0x2::object::ID) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_sellers, &arg1), 14);
    }

    fun bind_allowance(arg0: &mut Policy, arg1: 0x1::type_name::TypeName, arg2: 0x1::string::String) {
        let v0 = BindingKey{coin: arg1};
        if (0x2::dynamic_field::exists_<BindingKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<BindingKey, Binding>(&mut arg0.id, v0);
            assert!(!0x2::vec_set::contains<0x1::string::String>(&v1.used, &arg2), 64);
            0x2::vec_set::insert<0x1::string::String>(&mut v1.used, arg2);
            v1.label = arg2;
        } else {
            let v2 = Binding{
                label : arg2,
                used  : 0x2::vec_set::singleton<0x1::string::String>(arg2),
            };
            0x2::dynamic_field::add<BindingKey, Binding>(&mut arg0.id, v0, v2);
        };
    }

    public fun bound_label<T0>(arg0: &Policy) : 0x1::option::Option<0x1::string::String> {
        let v0 = BindingKey{coin: 0x1::type_name::with_defining_ids<T0>()};
        if (0x2::dynamic_field::exists_<BindingKey>(&arg0.id, v0)) {
            0x1::option::some<0x1::string::String>(0x2::dynamic_field::borrow<BindingKey, Binding>(&arg0.id, v0).label)
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public fun cancel_limits(arg0: &mut Policy, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 16);
        if (0x1::option::is_none<PendingLimits>(&arg0.pending_limits)) {
            return
        };
        arg0.pending_limits = 0x1::option::none<PendingLimits>();
        let v0 = LimitsProposalCancelled{policy_id: 0x2::object::id<Policy>(arg0)};
        0x2::event::emit<LimitsProposalCancelled>(v0);
    }

    public fun coin_ready_at<T0>(arg0: &Policy) : 0x1::option::Option<u64> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.pending_coins, &v0)) {
            0x1::option::some<u64>(*0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.pending_coins, &v0))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun coins(arg0: &Policy) : vector<0x1::type_name::TypeName> {
        0x2::vec_set::into_keys<0x1::type_name::TypeName>(arg0.coins)
    }

    public fun create<T0>(arg0: 0x2::allowance::AllowanceProposal<0x2::balance::Balance<T0>>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: vector<0x2::object::ID>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        let v0 = new<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        share(v0);
        0x2::object::id<Policy>(&v0)
    }

    fun cutoff(arg0: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        if (v0 > 86400000) {
            v0 - 86400000
        } else {
            0
        }
    }

    public fun delay_ms(arg0: &Policy) : u64 {
        arg0.delay_ms
    }

    public fun disallow_seller(arg0: &mut Policy, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 16);
        if (0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.pending_sellers, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x2::object::ID, u64>(&mut arg0.pending_sellers, &arg1);
        };
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_sellers, &arg1)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_sellers, &arg1);
        };
        let v2 = SellerAllowed{
            policy_id : 0x2::object::id<Policy>(arg0),
            seller_id : arg1,
            allowed   : false,
        };
        0x2::event::emit<SellerAllowed>(v2);
    }

    fun emit_limits(arg0: &Policy) {
        let v0 = LimitsChanged{
            policy_id          : 0x2::object::id<Policy>(arg0),
            approval_threshold : arg0.approval_threshold,
            period_budget      : arg0.period_budget,
            delay_ms           : arg0.delay_ms,
        };
        0x2::event::emit<LimitsChanged>(v0);
    }

    public fun finalize_coin<T0>(arg0: &mut Policy, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: &0x2::clock::Clock) {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.pending_coins, &v0), 51);
        let (_, v2) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.pending_coins, &v0);
        assert!(0x2::clock::timestamp_ms(arg2) >= v2, 50);
        insert_coin(arg0, v0);
    }

    public fun finalize_limits(arg0: &mut Policy, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: &0x2::clock::Clock) {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        assert!(0x1::option::is_some<PendingLimits>(&arg0.pending_limits), 51);
        let v0 = 0x1::option::extract<PendingLimits>(&mut arg0.pending_limits);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.ready_at_ms, 50);
        arg0.approval_threshold = v0.approval_threshold;
        arg0.period_budget = v0.period_budget;
        arg0.delay_ms = v0.delay_ms;
        emit_limits(arg0);
    }

    public fun finalize_seller(arg0: &mut Policy, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.pending_sellers, &arg2), 51);
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, u64>(&mut arg0.pending_sellers, &arg2);
        assert!(0x2::clock::timestamp_ms(arg3) >= v1, 50);
        add_seller(arg0, arg2);
    }

    fun forget_counted_from(arg0: &mut Policy, arg1: 0x2::object::ID) {
        let v0 = CountedFrom{intent_id: arg1};
        if (0x2::dynamic_field::exists_<CountedFrom>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<CountedFrom, u64>(&mut arg0.id, v0);
        };
    }

    public fun has_coin<T0>(arg0: &Policy) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.coins, &v0)
    }

    fun insert_coin(arg0: &mut Policy, arg1: 0x1::type_name::TypeName) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.coins, arg1);
        let v0 = CoinAllowed{
            policy_id : 0x2::object::id<Policy>(arg0),
            coin      : arg1,
            allowed   : true,
        };
        0x2::event::emit<CoinAllowed>(v0);
    }

    public fun is_seller_allowed(arg0: &Policy, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_sellers, &arg1)
    }

    public fun needs_approval(arg0: &Policy, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        if (arg1 > arg0.approval_threshold) {
            true
        } else if (unapproved_recent(arg0, arg2) + arg1 > arg0.approval_threshold) {
            true
        } else {
            recent_count(arg0, arg2) >= 100
        }
    }

    public fun owner(arg0: &Policy) : address {
        arg0.owner
    }

    public fun pending_approval_threshold(arg0: &PendingLimits) : u64 {
        arg0.approval_threshold
    }

    public fun pending_delay_ms(arg0: &PendingLimits) : u64 {
        arg0.delay_ms
    }

    public fun pending_limits(arg0: &Policy) : 0x1::option::Option<PendingLimits> {
        arg0.pending_limits
    }

    public fun pending_period_budget(arg0: &PendingLimits) : u64 {
        arg0.period_budget
    }

    public fun pending_ready_at_ms(arg0: &PendingLimits) : u64 {
        arg0.ready_at_ms
    }

    public fun period_budget(arg0: &Policy) : u64 {
        arg0.period_budget
    }

    fun prune(arg0: &mut Policy, arg1: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Recent>(&arg0.recent)) {
            if (0x1::vector::borrow<Recent>(&arg0.recent, v0).at_ms <= cutoff(arg1)) {
                let v1 = 0x1::vector::swap_remove<Recent>(&mut arg0.recent, v0);
                forget_counted_from(arg0, v1.intent_id);
                continue
            };
            v0 = v0 + 1;
        };
    }

    public fun recent_count(arg0: &Policy, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        let v1 = &arg0.recent;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Recent>(v1)) {
            if (0x1::vector::borrow<Recent>(v1, v2).at_ms > cutoff(arg1)) {
                v0 = v0 + 1;
            };
            v2 = v2 + 1;
        };
        v0
    }

    public(friend) fun record_unapproved(arg0: &mut Policy, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        prune(arg0, arg4);
        assert!(unapproved_recent(arg0, arg4) + arg3 <= arg0.approval_threshold, 12);
        let v0 = &arg0.recent;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<Recent>(v0)) {
            if (0x1::vector::borrow<Recent>(v0, v1).intent_id == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 8 */
                if (0x1::option::is_some<u64>(&v2)) {
                    let v3 = 0x1::vector::borrow_mut<Recent>(&mut arg0.recent, 0x1::option::destroy_some<u64>(v2));
                    v3.amount = v3.amount + arg3;
                    v3.at_ms = 0x2::clock::timestamp_ms(arg4);
                } else {
                    assert!(0x1::vector::length<Recent>(&arg0.recent) < 100, 12);
                    let v4 = Recent{
                        intent_id : arg1,
                        at_ms     : 0x2::clock::timestamp_ms(arg4),
                        amount    : arg3,
                    };
                    0x1::vector::push_back<Recent>(&mut arg0.recent, v4);
                    forget_counted_from(arg0, arg1);
                    let v5 = CountedFrom{intent_id: arg1};
                    0x2::dynamic_field::add<CountedFrom, u64>(&mut arg0.id, v5, arg2);
                };
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 8 */
    }

    public(friend) fun release_unapproved(arg0: &mut Policy, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        prune(arg0, arg4);
        if (arg3 == 0) {
            return
        };
        let v0 = &arg0.recent;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<Recent>(v0)) {
            if (0x1::vector::borrow<Recent>(v0, v1).intent_id == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 9 */
                if (0x1::option::is_none<u64>(&v2)) {
                    return
                };
                let v3 = CountedFrom{intent_id: arg1};
                if (0x2::dynamic_field::exists_<CountedFrom>(&arg0.id, v3) && arg2 < *0x2::dynamic_field::borrow<CountedFrom, u64>(&arg0.id, v3)) {
                    return
                };
                let v4 = 0x1::option::destroy_some<u64>(v2);
                let v5 = 0x1::vector::borrow_mut<Recent>(&mut arg0.recent, v4);
                let v6 = if (v5.amount > arg3) {
                    v5.amount - arg3
                } else {
                    0
                };
                v5.amount = v6;
                if (v5.amount == 0) {
                    0x1::vector::swap_remove<Recent>(&mut arg0.recent, v4);
                    forget_counted_from(arg0, arg1);
                };
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 9 */
    }

    public fun remove_coin<T0>(arg0: &mut Policy, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 16);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.pending_coins, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.pending_coins, &v0);
        };
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.coins, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.coins, &v0);
        };
        let v3 = CoinAllowed{
            policy_id : 0x2::object::id<Policy>(arg0),
            coin      : v0,
            allowed   : false,
        };
        0x2::event::emit<CoinAllowed>(v3);
    }

    public(friend) fun reserve(arg0: &mut Policy, arg1: u64, arg2: &0x2::clock::Clock) {
        roll(arg0, arg2);
        assert!(arg0.spent + arg0.reserved + arg1 <= arg0.period_budget, 13);
        arg0.reserved = arg0.reserved + arg1;
    }

    public fun reserved(arg0: &Policy) : u64 {
        arg0.reserved
    }

    public fun revoke(arg0: &mut Policy, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 16);
        arg0.revoked = true;
        let v0 = PolicyRevoked{policy_id: 0x2::object::id<Policy>(arg0)};
        0x2::event::emit<PolicyRevoked>(v0);
    }

    public fun revoked(arg0: &Policy) : bool {
        arg0.revoked
    }

    fun roll(arg0: &mut Policy, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.period_start_ms + arg0.period_ms) {
            arg0.period_start_ms = v0;
            arg0.spent = 0;
        };
    }

    public fun rotate_agent<T0>(arg0: &mut Policy, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 16);
        let v0 = 0x2::allowance::allowance_settings<0x2::balance::Balance<T0>>(arg2);
        assert!(0x2::allowance::funder(v0) == arg0.owner, 17);
        let v1 = 0x2::allowance::app(v0);
        let v2 = 0x1::type_name::with_defining_ids<Policy>();
        assert!(0x1::option::contains<0x1::type_name::TypeName>(&v1, &v2), 17);
        assert_coin<T0>(arg0);
        assert_bound<T0>(arg0, arg2);
        let v3 = 0x2::allowance::spender(v0);
        let v4 = if (arg0.agent == arg3) {
            if (0x1::option::is_some<address>(&arg0.previous_agent)) {
                v3 == arg0.previous_agent
            } else {
                false
            }
        } else {
            false
        };
        let v5 = if (0x1::option::contains<address>(&v3, &arg0.agent)) {
            true
        } else if (0x1::option::contains<address>(&v3, &arg3)) {
            true
        } else {
            v4
        };
        assert!(v5, 17);
        0x2::allowance::rotate_spender<0x2::balance::Balance<T0>, Policy>(arg2, 0x2::allowance::settings_permit<Policy>(0x1::internal::permit<Policy>()), arg3);
        if (arg0.agent != arg3) {
            arg0.previous_agent = 0x1::option::some<address>(arg0.agent);
            arg0.agent = arg3;
            let v6 = AgentRotated{
                policy_id : 0x2::object::id<Policy>(arg0),
                agent     : arg3,
            };
            0x2::event::emit<AgentRotated>(v6);
        };
    }

    public fun seller_ready_at(arg0: &Policy, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        if (0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.pending_sellers, &arg1)) {
            0x1::option::some<u64>(*0x2::vec_map::get<0x2::object::ID, u64>(&arg0.pending_sellers, &arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun set_limits(arg0: &mut Policy, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        assert!(0x2::tx_context::sender(arg6) == arg0.owner, 16);
        let v0 = if (arg2 > arg0.approval_threshold) {
            true
        } else if (arg3 > arg0.period_budget) {
            true
        } else {
            arg4 < arg0.delay_ms
        };
        let v1 = arg0.delay_ms;
        if (arg2 < arg0.approval_threshold) {
            arg0.approval_threshold = arg2;
        };
        if (arg3 < arg0.period_budget) {
            arg0.period_budget = arg3;
        };
        if (arg4 > arg0.delay_ms) {
            arg0.delay_ms = arg4;
        };
        arg0.pending_limits = 0x1::option::none<PendingLimits>();
        if (v0 && v1 > 0) {
            let v2 = 0x2::clock::timestamp_ms(arg5) + v1;
            let v3 = PendingLimits{
                approval_threshold : arg2,
                period_budget      : arg3,
                delay_ms           : arg4,
                ready_at_ms        : v2,
            };
            arg0.pending_limits = 0x1::option::some<PendingLimits>(v3);
            let v4 = LimitsProposed{
                policy_id          : 0x2::object::id<Policy>(arg0),
                approval_threshold : arg2,
                period_budget      : arg3,
                delay_ms           : arg4,
                ready_at_ms        : v2,
            };
            0x2::event::emit<LimitsProposed>(v4);
        } else if (v0) {
            arg0.approval_threshold = arg2;
            arg0.period_budget = arg3;
            arg0.delay_ms = arg4;
        };
        emit_limits(arg0);
    }

    public(friend) fun settle(arg0: &mut Policy, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        roll(arg0, arg3);
        let v0 = arg1 + arg2;
        let v1 = if (arg0.reserved > v0) {
            arg0.reserved - v0
        } else {
            0
        };
        arg0.reserved = v1;
        arg0.spent = arg0.spent + arg2;
    }

    public fun share(arg0: Policy) {
        0x2::transfer::share_object<Policy>(arg0);
    }

    public fun spent(arg0: &Policy) : u64 {
        arg0.spent
    }

    public fun unapproved_recent(arg0: &Policy, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        let v1 = &arg0.recent;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Recent>(v1)) {
            let v3 = 0x1::vector::borrow<Recent>(v1, v2);
            if (v3.at_ms > cutoff(arg1)) {
                v0 = v0 + v3.amount;
            };
            v2 = v2 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

