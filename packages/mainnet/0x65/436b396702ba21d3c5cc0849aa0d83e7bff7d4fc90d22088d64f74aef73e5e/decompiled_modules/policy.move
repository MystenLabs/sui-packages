module 0x65436b396702ba21d3c5cc0849aa0d83e7bff7d4fc90d22088d64f74aef73e5e::policy {
    struct Config has key {
        id: 0x2::object::UID,
        admin: address,
        authorized_operator: address,
        active_wallets: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct Policy has store, key {
        id: 0x2::object::UID,
        owner: address,
        drift_threshold_bps: u64,
        frequency_secs: u64,
        active: bool,
        created_at: u64,
        last_rebalance: u64,
    }

    struct AutomationCredential has store, key {
        id: 0x2::object::UID,
        owner: address,
        policy_id: 0x2::object::ID,
        encrypted_blob: vector<u8>,
    }

    struct PolicyActivated has copy, drop {
        policy_id: 0x2::object::ID,
        automation_credential_id: 0x2::object::ID,
        owner: address,
        drift_threshold_bps: u64,
        frequency_secs: u64,
        created_at: u64,
    }

    struct PolicyDeactivated has copy, drop {
        policy_id: 0x2::object::ID,
        owner: address,
    }

    struct PolicyReactivated has copy, drop {
        policy_id: 0x2::object::ID,
        owner: address,
    }

    struct PolicyUpdated has copy, drop {
        policy_id: 0x2::object::ID,
        owner: address,
        new_drift_threshold_bps: u64,
        new_frequency_secs: u64,
    }

    struct AutomationCredentialUpdated has copy, drop {
        policy_id: 0x2::object::ID,
        automation_credential_id: 0x2::object::ID,
        owner: address,
    }

    struct AutomationCancelled has copy, drop {
        policy_id: 0x2::object::ID,
        owner: address,
        cancelled_at: u64,
    }

    struct LastRebalanceUpdated has copy, drop {
        policy_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct OperatorRotated has copy, drop {
        old_operator: address,
        new_operator: address,
    }

    public fun activate_policy(arg0: &mut Config, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.active_wallets, 0x2::tx_context::sender(arg5)), 7);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = Policy{
            id                  : 0x2::object::new(arg5),
            owner               : 0x2::tx_context::sender(arg5),
            drift_threshold_bps : arg1,
            frequency_secs      : arg2,
            active              : true,
            created_at          : v0,
            last_rebalance      : 0,
        };
        let v2 = 0x2::object::id<Policy>(&v1);
        let v3 = AutomationCredential{
            id             : 0x2::object::new(arg5),
            owner          : 0x2::tx_context::sender(arg5),
            policy_id      : v2,
            encrypted_blob : arg3,
        };
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.active_wallets, 0x2::tx_context::sender(arg5), v2);
        let v4 = PolicyActivated{
            policy_id                : v2,
            automation_credential_id : 0x2::object::id<AutomationCredential>(&v3),
            owner                    : 0x2::tx_context::sender(arg5),
            drift_threshold_bps      : arg1,
            frequency_secs           : arg2,
            created_at               : v0,
        };
        0x2::event::emit<PolicyActivated>(v4);
        0x2::transfer::share_object<Policy>(v1);
        0x2::transfer::transfer<AutomationCredential>(v3, 0x2::tx_context::sender(arg5));
    }

    public fun admin(arg0: &Config) : address {
        arg0.admin
    }

    public fun authorized_operator(arg0: &Config) : address {
        arg0.authorized_operator
    }

    public fun created_at(arg0: &Policy) : u64 {
        arg0.created_at
    }

    public fun credential_owner(arg0: &AutomationCredential) : address {
        arg0.owner
    }

    public fun credential_policy_id(arg0: &AutomationCredential) : 0x2::object::ID {
        arg0.policy_id
    }

    public fun deactivate_and_delete(arg0: &mut Config, arg1: &mut Policy, arg2: AutomationCredential, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 3);
        assert!(arg2.policy_id == 0x2::object::id<Policy>(arg1), 6);
        arg1.active = false;
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.active_wallets, 0x2::tx_context::sender(arg4))) {
            0x2::table::remove<address, 0x2::object::ID>(&mut arg0.active_wallets, 0x2::tx_context::sender(arg4));
        };
        let AutomationCredential {
            id             : v0,
            owner          : _,
            policy_id      : _,
            encrypted_blob : _,
        } = arg2;
        0x2::object::delete(v0);
        let v4 = AutomationCancelled{
            policy_id    : 0x2::object::id<Policy>(arg1),
            owner        : 0x2::tx_context::sender(arg4),
            cancelled_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AutomationCancelled>(v4);
    }

    public fun deactivate_policy(arg0: &mut Policy, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 3);
        arg0.active = false;
        let v0 = PolicyDeactivated{
            policy_id : 0x2::object::id<Policy>(arg0),
            owner     : arg0.owner,
        };
        0x2::event::emit<PolicyDeactivated>(v0);
    }

    public fun delete_automation_credential(arg0: AutomationCredential, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 3);
        let AutomationCredential {
            id             : v0,
            owner          : _,
            policy_id      : _,
            encrypted_blob : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun drift_threshold_bps(arg0: &Policy) : u64 {
        arg0.drift_threshold_bps
    }

    public fun encrypted_blob(arg0: &AutomationCredential) : vector<u8> {
        arg0.encrypted_blob
    }

    public fun frequency_secs(arg0: &Policy) : u64 {
        arg0.frequency_secs
    }

    public fun has_active_policy(arg0: &Config, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.active_wallets, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                  : 0x2::object::new(arg0),
            admin               : 0x2::tx_context::sender(arg0),
            authorized_operator : 0x2::tx_context::sender(arg0),
            active_wallets      : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun is_active(arg0: &Policy) : bool {
        arg0.active
    }

    public fun last_rebalance(arg0: &Policy) : u64 {
        arg0.last_rebalance
    }

    public fun owner(arg0: &Policy) : address {
        arg0.owner
    }

    public fun reactivate_policy(arg0: &mut Policy, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 3);
        assert!(!arg0.active, 5);
        arg0.active = true;
        let v0 = PolicyReactivated{
            policy_id : 0x2::object::id<Policy>(arg0),
            owner     : arg0.owner,
        };
        0x2::event::emit<PolicyReactivated>(v0);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Config, arg2: &Policy, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.authorized_operator, 0);
        assert!(arg2.active, 2);
    }

    public fun transfer_admin(arg0: &mut Config, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.admin = arg1;
    }

    public fun update_authorized_operator(arg0: &mut Config, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.authorized_operator = arg1;
        let v0 = OperatorRotated{
            old_operator : arg0.authorized_operator,
            new_operator : arg1,
        };
        0x2::event::emit<OperatorRotated>(v0);
    }

    public fun update_automation_credential(arg0: &Policy, arg1: &mut AutomationCredential, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3);
        assert!(arg1.policy_id == 0x2::object::id<Policy>(arg0), 6);
        arg1.encrypted_blob = arg2;
        let v0 = AutomationCredentialUpdated{
            policy_id                : 0x2::object::id<Policy>(arg0),
            automation_credential_id : 0x2::object::id<AutomationCredential>(arg1),
            owner                    : arg0.owner,
        };
        0x2::event::emit<AutomationCredentialUpdated>(v0);
    }

    public fun update_last_rebalance(arg0: &Config, arg1: &mut Policy, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.authorized_operator, 0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg1.last_rebalance > 0) {
            assert!(v0 >= arg1.last_rebalance + arg1.frequency_secs * 1000, 4);
        };
        arg1.last_rebalance = v0;
        let v1 = LastRebalanceUpdated{
            policy_id : 0x2::object::id<Policy>(arg1),
            owner     : arg1.owner,
            timestamp : v0,
        };
        0x2::event::emit<LastRebalanceUpdated>(v1);
    }

    public fun update_policy(arg0: &mut Policy, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3);
        arg0.drift_threshold_bps = arg1;
        arg0.frequency_secs = arg2;
        let v0 = PolicyUpdated{
            policy_id               : 0x2::object::id<Policy>(arg0),
            owner                   : arg0.owner,
            new_drift_threshold_bps : arg1,
            new_frequency_secs      : arg2,
        };
        0x2::event::emit<PolicyUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

