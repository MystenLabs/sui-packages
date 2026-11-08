module 0xc894db8fba8696dd1a8b246744582a78279410b4523126b82ed68ce8ca40f55d::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        operator_cap_id: 0x2::object::ID,
        free: 0x2::balance::Balance<T0>,
        obligations: 0x2::vec_map::VecMap<u64, Obligation<T0>>,
        next_obligation_id: u64,
        agent_policy: 0x1::option::Option<AgentPolicy>,
    }

    struct Obligation<phantom T0> has store {
        name: 0x1::string::String,
        payee: address,
        target: u64,
        kind: u8,
        cycle_ms: u64,
        next_due_ms: u64,
        priority: u8,
        cadence_label: 0x1::string::String,
        reserve: 0x2::balance::Balance<T0>,
    }

    struct AgentPolicy has copy, drop, store {
        agent: address,
        max_per_request: u64,
        max_per_day: u64,
        spent_in_window: u64,
        window_start_ms: u64,
        expires_ms: u64,
        paused: bool,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        operator: address,
        operator_cap_id: 0x2::object::ID,
    }

    struct Deposited has copy, drop {
        vault_id: 0x2::object::ID,
        from: address,
        amount: u64,
        free_after: u64,
    }

    struct Withdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        to: address,
        amount: u64,
        free_after: u64,
    }

    struct ObligationAdded has copy, drop {
        vault_id: 0x2::object::ID,
        id: u64,
        name: 0x1::string::String,
        payee: address,
        target: u64,
        kind: u8,
        cycle_ms: u64,
        next_due_ms: u64,
        priority: u8,
        cadence_label: 0x1::string::String,
        reserved: u64,
        free_after: u64,
    }

    struct ObligationTargetChanged has copy, drop {
        vault_id: 0x2::object::ID,
        id: u64,
        old_target: u64,
        new_target: u64,
        reserve_after: u64,
        free_after: u64,
    }

    struct ObligationRemoved has copy, drop {
        vault_id: 0x2::object::ID,
        id: u64,
        name: 0x1::string::String,
        released: u64,
        free_after: u64,
    }

    struct ReservesFunded has copy, drop {
        vault_id: 0x2::object::ID,
        moved: u64,
        free_after: u64,
        reserved_total: u64,
    }

    struct ObligationPaid has copy, drop {
        vault_id: 0x2::object::ID,
        id: u64,
        name: 0x1::string::String,
        payee: address,
        bill: u64,
        from_reserve: u64,
        from_free: u64,
        uncovered: u64,
        next_due_ms: u64,
        removed: bool,
        free_after: u64,
    }

    struct ReleasedToAgent has copy, drop {
        vault_id: 0x2::object::ID,
        agent: address,
        request_id: vector<u8>,
        amount: u64,
        free_after: u64,
        spent_in_window: u64,
    }

    struct AgentPolicySet has copy, drop {
        vault_id: 0x2::object::ID,
        agent: address,
        max_per_request: u64,
        max_per_day: u64,
        expires_ms: u64,
    }

    struct AgentPaused has copy, drop {
        vault_id: 0x2::object::ID,
        agent: address,
    }

    struct AgentResumed has copy, drop {
        vault_id: 0x2::object::ID,
        agent: address,
    }

    struct AgentRevoked has copy, drop {
        vault_id: 0x2::object::ID,
        agent: address,
    }

    struct EmergencyWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        to: address,
        amount: u64,
        obligations_removed: u64,
    }

    struct OperatorRotated has copy, drop {
        vault_id: 0x2::object::ID,
        old_cap_id: 0x2::object::ID,
        new_cap_id: 0x2::object::ID,
        new_operator: address,
    }

    public fun add_obligation<T0>(arg0: &mut Vault<T0>, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u8, arg8: 0x1::string::String, arg9: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_owner<T0>(arg0, arg9);
        assert!(arg3 > 0, 13835903618379415565);
        assert!(arg4 == 0 || arg4 == 1, 13837029522581749781);
        assert!(arg7 == 0 || arg7 == 1, 13837311001853558807);
        assert!(0x2::vec_map::length<u64, Obligation<T0>>(&arg0.obligations) < 16, 13836466581218000913);
        let v0 = min(arg3, 0x2::balance::value<T0>(&arg0.free));
        let v1 = arg0.next_obligation_id;
        arg0.next_obligation_id = v1 + 1;
        let v2 = Obligation<T0>{
            name          : arg1,
            payee         : arg2,
            target        : arg3,
            kind          : arg4,
            cycle_ms      : arg5,
            next_due_ms   : arg6,
            priority      : arg7,
            cadence_label : arg8,
            reserve       : 0x2::balance::split<T0>(&mut arg0.free, v0),
        };
        0x2::vec_map::insert<u64, Obligation<T0>>(&mut arg0.obligations, v1, v2);
        let v3 = ObligationAdded{
            vault_id      : 0x2::object::id<Vault<T0>>(arg0),
            id            : v1,
            name          : arg1,
            payee         : arg2,
            target        : arg3,
            kind          : arg4,
            cycle_ms      : arg5,
            next_due_ms   : arg6,
            priority      : arg7,
            cadence_label : arg8,
            reserved      : v0,
            free_after    : 0x2::balance::value<T0>(&arg0.free),
        };
        0x2::event::emit<ObligationAdded>(v3);
    }

    public fun agent_policy<T0>(arg0: &Vault<T0>) : 0x1::option::Option<AgentPolicy> {
        arg0.agent_policy
    }

    fun assert_operator<T0>(arg0: &Vault<T0>, arg1: &OperatorCap) {
        assert!(0x2::object::id<OperatorCap>(arg1) == arg0.operator_cap_id && arg1.vault_id == 0x2::object::id<Vault<T0>>(arg0), 13835341883901476873);
    }

    fun assert_owner<T0>(arg0: &Vault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 13835060391744765959);
    }

    fun assert_version<T0>(arg0: &Vault<T0>) {
        assert!(arg0.version == 1, 13835623324518580235);
    }

    public fun cap_vault_id(arg0: &OperatorCap) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun create_vault<T0>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = OperatorCap{
            id       : 0x2::object::new(arg1),
            vault_id : v1,
        };
        let v3 = 0x2::object::id<OperatorCap>(&v2);
        let v4 = Vault<T0>{
            id                 : v0,
            version            : 1,
            owner              : 0x2::tx_context::sender(arg1),
            operator_cap_id    : v3,
            free               : 0x2::balance::zero<T0>(),
            obligations        : 0x2::vec_map::empty<u64, Obligation<T0>>(),
            next_obligation_id : 0,
            agent_policy       : 0x1::option::none<AgentPolicy>(),
        };
        let v5 = VaultCreated{
            vault_id        : v1,
            owner           : 0x2::tx_context::sender(arg1),
            operator        : arg0,
            operator_cap_id : v3,
        };
        0x2::event::emit<VaultCreated>(v5);
        0x2::transfer::share_object<Vault<T0>>(v4);
        0x2::transfer::public_transfer<OperatorCap>(v2, arg0);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 13835903386451181581);
        0x2::balance::join<T0>(&mut arg0.free, 0x2::coin::into_balance<T0>(arg1));
        let v1 = Deposited{
            vault_id   : 0x2::object::id<Vault<T0>>(arg0),
            from       : 0x2::tx_context::sender(arg2),
            amount     : v0,
            free_after : 0x2::balance::value<T0>(&arg0.free),
        };
        0x2::event::emit<Deposited>(v1);
    }

    public fun emergency_withdraw_all<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_owner<T0>(arg0, arg1);
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.free);
        let v1 = 0;
        while (!0x2::vec_map::is_empty<u64, Obligation<T0>>(&arg0.obligations)) {
            let (_, v3) = 0x2::vec_map::pop<u64, Obligation<T0>>(&mut arg0.obligations);
            let Obligation {
                name          : _,
                payee         : _,
                target        : _,
                kind          : _,
                cycle_ms      : _,
                next_due_ms   : _,
                priority      : _,
                cadence_label : _,
                reserve       : v12,
            } = v3;
            0x2::balance::join<T0>(&mut v0, v12);
            v1 = v1 + 1;
        };
        let v13 = 0x2::balance::value<T0>(&v0);
        if (v13 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg1), arg0.owner);
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
        let v14 = EmergencyWithdrawn{
            vault_id            : 0x2::object::id<Vault<T0>>(arg0),
            to                  : arg0.owner,
            amount              : v13,
            obligations_removed : v1,
        };
        0x2::event::emit<EmergencyWithdrawn>(v14);
    }

    public fun free_value<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.free)
    }

    public fun fund_reserves<T0>(arg0: &mut Vault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_owner<T0>(arg0, arg1);
        fund_reserves_internal<T0>(arg0);
    }

    public fun fund_reserves_as_operator<T0>(arg0: &mut Vault<T0>, arg1: &OperatorCap) {
        assert_version<T0>(arg0);
        assert_operator<T0>(arg0, arg1);
        fund_reserves_internal<T0>(arg0);
    }

    fun fund_reserves_internal<T0>(arg0: &mut Vault<T0>) {
        let v0 = 0;
        let v1 = 0;
        while (v1 <= 1) {
            let v2 = 0;
            while (v2 < 0x2::vec_map::length<u64, Obligation<T0>>(&arg0.obligations)) {
                let (_, v4) = 0x2::vec_map::get_entry_by_idx_mut<u64, Obligation<T0>>(&mut arg0.obligations, v2);
                if (v4.priority == v1) {
                    let v5 = 0x2::balance::value<T0>(&v4.reserve);
                    if (v5 < v4.target) {
                        let v6 = min(v4.target - v5, 0x2::balance::value<T0>(&arg0.free));
                        0x2::balance::join<T0>(&mut v4.reserve, 0x2::balance::split<T0>(&mut arg0.free, v6));
                        v0 = v0 + v6;
                    };
                };
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
        let v7 = ReservesFunded{
            vault_id       : 0x2::object::id<Vault<T0>>(arg0),
            moved          : v0,
            free_after     : 0x2::balance::value<T0>(&arg0.free),
            reserved_total : reserved_total<T0>(arg0),
        };
        0x2::event::emit<ReservesFunded>(v7);
    }

    public fun has_agent_policy<T0>(arg0: &Vault<T0>) : bool {
        0x1::option::is_some<AgentPolicy>(&arg0.agent_policy)
    }

    public fun has_obligation<T0>(arg0: &Vault<T0>, arg1: u64) : bool {
        0x2::vec_map::contains<u64, Obligation<T0>>(&arg0.obligations, &arg1)
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun obligation<T0>(arg0: &Vault<T0>, arg1: u64) : &Obligation<T0> {
        assert!(0x2::vec_map::contains<u64, Obligation<T0>>(&arg0.obligations, &arg1), 13836749275965554707);
        let (_, v1) = 0x2::vec_map::get_entry_by_idx<u64, Obligation<T0>>(&arg0.obligations, 0x2::vec_map::get_idx<u64, Obligation<T0>>(&arg0.obligations, &arg1));
        v1
    }

    public fun obligation_cadence_label<T0>(arg0: &Vault<T0>, arg1: u64) : 0x1::string::String {
        obligation<T0>(arg0, arg1).cadence_label
    }

    public fun obligation_count<T0>(arg0: &Vault<T0>) : u64 {
        0x2::vec_map::length<u64, Obligation<T0>>(&arg0.obligations)
    }

    public fun obligation_cycle_ms<T0>(arg0: &Vault<T0>, arg1: u64) : u64 {
        obligation<T0>(arg0, arg1).cycle_ms
    }

    public fun obligation_ids<T0>(arg0: &Vault<T0>) : vector<u64> {
        0x2::vec_map::keys<u64, Obligation<T0>>(&arg0.obligations)
    }

    public fun obligation_kind<T0>(arg0: &Vault<T0>, arg1: u64) : u8 {
        obligation<T0>(arg0, arg1).kind
    }

    public fun obligation_name<T0>(arg0: &Vault<T0>, arg1: u64) : 0x1::string::String {
        obligation<T0>(arg0, arg1).name
    }

    public fun obligation_next_due_ms<T0>(arg0: &Vault<T0>, arg1: u64) : u64 {
        obligation<T0>(arg0, arg1).next_due_ms
    }

    public fun obligation_payee<T0>(arg0: &Vault<T0>, arg1: u64) : address {
        obligation<T0>(arg0, arg1).payee
    }

    public fun obligation_priority<T0>(arg0: &Vault<T0>, arg1: u64) : u8 {
        obligation<T0>(arg0, arg1).priority
    }

    public fun obligation_reserve<T0>(arg0: &Vault<T0>, arg1: u64) : u64 {
        0x2::balance::value<T0>(&obligation<T0>(arg0, arg1).reserve)
    }

    public fun obligation_target<T0>(arg0: &Vault<T0>, arg1: u64) : u64 {
        obligation<T0>(arg0, arg1).target
    }

    public fun operator_cap_id<T0>(arg0: &Vault<T0>) : 0x2::object::ID {
        arg0.operator_cap_id
    }

    public fun owner<T0>(arg0: &Vault<T0>) : address {
        arg0.owner
    }

    public fun pause_agent<T0>(arg0: &mut Vault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_owner<T0>(arg0, arg1);
        assert!(0x1::option::is_some<AgentPolicy>(&arg0.agent_policy), 13838437537416085535);
        let v0 = 0x1::option::borrow_mut<AgentPolicy>(&mut arg0.agent_policy);
        v0.paused = true;
        let v1 = AgentPaused{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            agent    : v0.agent,
        };
        0x2::event::emit<AgentPaused>(v1);
    }

    public fun pay_obligation<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_owner<T0>(arg0, arg4);
        pay_obligation_internal<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun pay_obligation_as_operator<T0>(arg0: &mut Vault<T0>, arg1: &OperatorCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_operator<T0>(arg0, arg1);
        pay_obligation_internal<T0>(arg0, arg2, arg3, arg4, arg5);
    }

    fun pay_obligation_internal<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 13835904992768950285);
        assert!(0x2::vec_map::contains<u64, Obligation<T0>>(&arg0.obligations, &arg1), 13836749421994442771);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = &mut arg0.free;
        let v2 = 0x2::vec_map::get_mut<u64, Obligation<T0>>(&mut arg0.obligations, &arg1);
        assert!(v0 >= v2.next_due_ms, 13837593872694771737);
        if (v2.kind == 0) {
            assert!(arg2 == v2.target, 13837875356261548059);
        } else {
            assert!(arg2 <= v2.target * 3, 13838156839828324381);
        };
        let v3 = min(arg2, 0x2::balance::value<T0>(&v2.reserve));
        let v4 = 0x2::balance::split<T0>(&mut v2.reserve, v3);
        let v5 = min(arg2 - v3, 0x2::balance::value<T0>(v1));
        0x2::balance::join<T0>(&mut v4, 0x2::balance::split<T0>(v1, v5));
        let v6 = v2.payee;
        let v7 = v2.cycle_ms == 0;
        let v8 = if (v7) {
            0
        } else {
            v2.next_due_ms + ((v0 - v2.next_due_ms) / v2.cycle_ms + 1) * v2.cycle_ms
        };
        if (!v7) {
            v2.next_due_ms = v8;
        };
        if (0x2::balance::value<T0>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg4), v6);
        } else {
            0x2::balance::destroy_zero<T0>(v4);
        };
        if (v7) {
            let (_, v10) = 0x2::vec_map::remove<u64, Obligation<T0>>(&mut arg0.obligations, &arg1);
            let Obligation {
                name          : _,
                payee         : _,
                target        : _,
                kind          : _,
                cycle_ms      : _,
                next_due_ms   : _,
                priority      : _,
                cadence_label : _,
                reserve       : v19,
            } = v10;
            0x2::balance::join<T0>(&mut arg0.free, v19);
        };
        let v20 = ObligationPaid{
            vault_id     : 0x2::object::id<Vault<T0>>(arg0),
            id           : arg1,
            name         : v2.name,
            payee        : v6,
            bill         : arg2,
            from_reserve : v3,
            from_free    : v5,
            uncovered    : arg2 - v3 - v5,
            next_due_ms  : v8,
            removed      : v7,
            free_after   : 0x2::balance::value<T0>(&arg0.free),
        };
        0x2::event::emit<ObligationPaid>(v20);
    }

    public fun policy_agent(arg0: &AgentPolicy) : address {
        arg0.agent
    }

    public fun policy_expires_ms(arg0: &AgentPolicy) : u64 {
        arg0.expires_ms
    }

    public fun policy_max_per_day(arg0: &AgentPolicy) : u64 {
        arg0.max_per_day
    }

    public fun policy_max_per_request(arg0: &AgentPolicy) : u64 {
        arg0.max_per_request
    }

    public fun policy_paused(arg0: &AgentPolicy) : bool {
        arg0.paused
    }

    public fun policy_spent_in_window(arg0: &AgentPolicy) : u64 {
        arg0.spent_in_window
    }

    public fun release_to_agent<T0>(arg0: &mut Vault<T0>, arg1: &OperatorCap, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_operator<T0>(arg0, arg1);
        assert!(arg2 > 0, 13835904417243332621);
        assert!(0x1::option::is_some<AgentPolicy>(&arg0.agent_policy), 13838437696329875487);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x1::option::borrow_mut<AgentPolicy>(&mut arg0.agent_policy);
        assert!(!v1.paused, 13838719188486586401);
        assert!(v0 < v1.expires_ms, 13839000667758395427);
        assert!(arg2 <= v1.max_per_request, 13839282147030204453);
        if (v0 >= v1.window_start_ms + 86400000) {
            v1.window_start_ms = v0;
            v1.spent_in_window = 0;
        };
        assert!(v1.spent_in_window + arg2 <= v1.max_per_day, 13839563643481882663);
        assert!(arg2 <= 0x2::balance::value<T0>(&arg0.free), 13836185948054749199);
        v1.spent_in_window = v1.spent_in_window + arg2;
        let v2 = v1.agent;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.free, arg2), arg5), v2);
        let v3 = ReleasedToAgent{
            vault_id        : 0x2::object::id<Vault<T0>>(arg0),
            agent           : v2,
            request_id      : arg3,
            amount          : arg2,
            free_after      : 0x2::balance::value<T0>(&arg0.free),
            spent_in_window : v1.spent_in_window,
        };
        0x2::event::emit<ReleasedToAgent>(v3);
    }

    public fun remove_obligation<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_owner<T0>(arg0, arg2);
        assert!(0x2::vec_map::contains<u64, Obligation<T0>>(&arg0.obligations, &arg1), 13836748339662684179);
        let (_, v1) = 0x2::vec_map::remove<u64, Obligation<T0>>(&mut arg0.obligations, &arg1);
        let Obligation {
            name          : v2,
            payee         : _,
            target        : _,
            kind          : _,
            cycle_ms      : _,
            next_due_ms   : _,
            priority      : _,
            cadence_label : _,
            reserve       : v10,
        } = v1;
        let v11 = v10;
        0x2::balance::join<T0>(&mut arg0.free, v11);
        let v12 = ObligationRemoved{
            vault_id   : 0x2::object::id<Vault<T0>>(arg0),
            id         : arg1,
            name       : v2,
            released   : 0x2::balance::value<T0>(&v11),
            free_after : 0x2::balance::value<T0>(&arg0.free),
        };
        0x2::event::emit<ObligationRemoved>(v12);
    }

    public fun reserved_total<T0>(arg0: &Vault<T0>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<u64, Obligation<T0>>(&arg0.obligations)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<u64, Obligation<T0>>(&arg0.obligations, v1);
            v0 = v0 + 0x2::balance::value<T0>(&v3.reserve);
            v1 = v1 + 1;
        };
        v0
    }

    public fun resume_agent<T0>(arg0: &mut Vault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_owner<T0>(arg0, arg1);
        assert!(0x1::option::is_some<AgentPolicy>(&arg0.agent_policy), 13838437580365758495);
        let v0 = 0x1::option::borrow_mut<AgentPolicy>(&mut arg0.agent_policy);
        v0.paused = false;
        let v1 = AgentResumed{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            agent    : v0.agent,
        };
        0x2::event::emit<AgentResumed>(v1);
    }

    public fun revoke_agent<T0>(arg0: &mut Vault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_owner<T0>(arg0, arg1);
        assert!(0x1::option::is_some<AgentPolicy>(&arg0.agent_policy), 13838437623315431455);
        let v0 = 0x1::option::extract<AgentPolicy>(&mut arg0.agent_policy);
        let v1 = AgentRevoked{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            agent    : v0.agent,
        };
        0x2::event::emit<AgentRevoked>(v1);
    }

    public fun rotate_operator<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_owner<T0>(arg0, arg2);
        let v0 = 0x2::object::id<Vault<T0>>(arg0);
        let v1 = OperatorCap{
            id       : 0x2::object::new(arg2),
            vault_id : v0,
        };
        let v2 = 0x2::object::id<OperatorCap>(&v1);
        arg0.operator_cap_id = v2;
        0x2::transfer::public_transfer<OperatorCap>(v1, arg1);
        let v3 = OperatorRotated{
            vault_id     : v0,
            old_cap_id   : arg0.operator_cap_id,
            new_cap_id   : v2,
            new_operator : arg1,
        };
        0x2::event::emit<OperatorRotated>(v3);
    }

    public fun set_agent_policy<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_owner<T0>(arg0, arg6);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = if (arg2 > 0) {
            if (arg2 <= arg3) {
                arg4 > v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 13839844817811013673);
        let (v2, v3) = if (0x1::option::is_some<AgentPolicy>(&arg0.agent_policy) && 0x1::option::borrow<AgentPolicy>(&arg0.agent_policy).agent == arg1) {
            let v4 = 0x1::option::borrow<AgentPolicy>(&arg0.agent_policy);
            (v4.spent_in_window, v4.window_start_ms)
        } else {
            (0, v0)
        };
        let v5 = AgentPolicy{
            agent           : arg1,
            max_per_request : arg2,
            max_per_day     : arg3,
            spent_in_window : v2,
            window_start_ms : v3,
            expires_ms      : arg4,
            paused          : false,
        };
        arg0.agent_policy = 0x1::option::some<AgentPolicy>(v5);
        let v6 = AgentPolicySet{
            vault_id        : 0x2::object::id<Vault<T0>>(arg0),
            agent           : arg1,
            max_per_request : arg2,
            max_per_day     : arg3,
            expires_ms      : arg4,
        };
        0x2::event::emit<AgentPolicySet>(v6);
    }

    public fun set_obligation_target<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_owner<T0>(arg0, arg3);
        assert!(arg2 > 0, 13835903794473074701);
        assert!(0x2::vec_map::contains<u64, Obligation<T0>>(&arg0.obligations, &arg1), 13836748223698567187);
        let v0 = &mut arg0.free;
        let v1 = 0x2::vec_map::get_mut<u64, Obligation<T0>>(&mut arg0.obligations, &arg1);
        v1.target = arg2;
        let v2 = 0x2::balance::value<T0>(&v1.reserve);
        if (arg2 > v2) {
            0x2::balance::join<T0>(&mut v1.reserve, 0x2::balance::split<T0>(v0, min(arg2 - v2, 0x2::balance::value<T0>(v0))));
        } else if (v2 > arg2) {
            0x2::balance::join<T0>(v0, 0x2::balance::split<T0>(&mut v1.reserve, v2 - arg2));
        };
        let v3 = ObligationTargetChanged{
            vault_id      : 0x2::object::id<Vault<T0>>(arg0),
            id            : arg1,
            old_target    : v1.target,
            new_target    : arg2,
            reserve_after : 0x2::balance::value<T0>(&v1.reserve),
            free_after    : 0x2::balance::value<T0>(&arg0.free),
        };
        0x2::event::emit<ObligationTargetChanged>(v3);
    }

    public fun version<T0>(arg0: &Vault<T0>) : u64 {
        arg0.version
    }

    public fun withdraw_free<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_owner<T0>(arg0, arg2);
        assert!(arg1 > 0, 13835903425105887245);
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0.free), 13836184904377696271);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.free, arg1), arg2), arg0.owner);
        let v0 = Withdrawn{
            vault_id   : 0x2::object::id<Vault<T0>>(arg0),
            to         : arg0.owner,
            amount     : arg1,
            free_after : 0x2::balance::value<T0>(&arg0.free),
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

