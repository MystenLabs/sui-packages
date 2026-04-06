module 0x179af5a6954da7be035339a9fb4aa9aecd0be6b0dfc6f92775bfc4588cc29832::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        total_deposited: u64,
        total_withdrawn: u64,
        created_at: u64,
        agent_count: u8,
        risk_profile: u8,
        is_active: bool,
    }

    struct VaultOwnerCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct VaultAgent has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        agent_type: u8,
        name: 0x1::string::String,
        allocated_amount: u64,
        max_per_tx: u64,
        max_daily: u64,
        spent_today: u64,
        last_reset_epoch: u64,
        is_active: bool,
        total_yield_earned: u64,
        total_costs: u64,
        action_count: u64,
    }

    struct VaultAction has copy, drop, store {
        agent_type: u8,
        action_type: 0x1::string::String,
        amount: u64,
        description: 0x1::string::String,
        timestamp: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        risk_profile: u8,
    }

    struct DepositMade has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        new_total: u64,
    }

    struct WithdrawalMade has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        new_total: u64,
    }

    struct AgentCreated has copy, drop {
        vault_id: 0x2::object::ID,
        agent_type: u8,
        name: 0x1::string::String,
        allocated_amount: u64,
    }

    struct AgentActionRecorded has copy, drop {
        vault_id: 0x2::object::ID,
        agent_type: u8,
        action_type: 0x1::string::String,
        amount: u64,
    }

    struct AllocationChanged has copy, drop {
        vault_id: 0x2::object::ID,
        agent_type: u8,
        old_amount: u64,
        new_amount: u64,
    }

    struct EmergencyRecall has copy, drop {
        vault_id: 0x2::object::ID,
        total_recalled: u64,
    }

    public fun add_agent(arg0: &mut Vault, arg1: &VaultOwnerCap, arg2: u8, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : VaultAgent {
        assert_owner(arg0, arg1);
        assert!(arg0.is_active, 1);
        assert!(arg2 <= 2, 7);
        assert!(arg0.agent_count < 10, 10);
        arg0.agent_count = arg0.agent_count + 1;
        let v0 = 0x2::object::id<Vault>(arg0);
        let v1 = AgentCreated{
            vault_id         : v0,
            agent_type       : arg2,
            name             : arg3,
            allocated_amount : arg4,
        };
        0x2::event::emit<AgentCreated>(v1);
        VaultAgent{
            id                 : 0x2::object::new(arg7),
            vault_id           : v0,
            agent_type         : arg2,
            name               : arg3,
            allocated_amount   : arg4,
            max_per_tx         : arg5,
            max_daily          : arg6,
            spent_today        : 0,
            last_reset_epoch   : 0x2::tx_context::epoch(arg7),
            is_active          : true,
            total_yield_earned : 0,
            total_costs        : 0,
            action_count       : 0,
        }
    }

    entry fun add_agent_and_transfer(arg0: &mut Vault, arg1: &VaultOwnerCap, arg2: u8, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = add_agent(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::transfer<VaultAgent>(v0, 0x2::tx_context::sender(arg7));
    }

    fun assert_owner(arg0: &Vault, arg1: &VaultOwnerCap) {
        assert!(0x2::object::id<Vault>(arg0) == arg1.vault_id, 0);
    }

    fun check_spending_limit_internal(arg0: &VaultAgent, arg1: u64) {
        assert!(arg1 <= arg0.max_per_tx, 4);
        assert!(arg0.spent_today + arg1 <= arg0.max_daily, 5);
        assert!(arg1 <= arg0.allocated_amount, 8);
    }

    entry fun create_and_transfer(arg0: 0x1::string::String, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_vault(arg0, arg1, arg2);
        0x2::transfer::transfer<Vault>(v0, 0x2::tx_context::sender(arg2));
        0x2::transfer::transfer<VaultOwnerCap>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun create_vault(arg0: 0x1::string::String, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : (Vault, VaultOwnerCap) {
        assert!(arg1 <= 3, 6);
        let v0 = Vault{
            id              : 0x2::object::new(arg2),
            owner           : 0x2::tx_context::sender(arg2),
            name            : arg0,
            total_deposited : 0,
            total_withdrawn : 0,
            created_at      : 0x2::tx_context::epoch(arg2),
            agent_count     : 0,
            risk_profile    : arg1,
            is_active       : true,
        };
        let v1 = 0x2::object::id<Vault>(&v0);
        let v2 = VaultOwnerCap{
            id       : 0x2::object::new(arg2),
            vault_id : v1,
        };
        let v3 = VaultCreated{
            vault_id     : v1,
            owner        : 0x2::tx_context::sender(arg2),
            risk_profile : arg1,
        };
        0x2::event::emit<VaultCreated>(v3);
        (v0, v2)
    }

    public fun deposit(arg0: &mut Vault, arg1: &VaultOwnerCap, arg2: u64) {
        assert_owner(arg0, arg1);
        assert!(arg0.is_active, 1);
        arg0.total_deposited = arg0.total_deposited + arg2;
        let v0 = DepositMade{
            vault_id  : 0x2::object::id<Vault>(arg0),
            amount    : arg2,
            new_total : arg0.total_deposited,
        };
        0x2::event::emit<DepositMade>(v0);
    }

    entry fun emergency_recall_single(arg0: &Vault, arg1: &VaultOwnerCap, arg2: &mut VaultAgent) {
        emit_emergency_recall(arg0, arg1, recall_agent(arg0, arg1, arg2));
    }

    public fun emit_emergency_recall(arg0: &Vault, arg1: &VaultOwnerCap, arg2: u64) {
        assert_owner(arg0, arg1);
        let v0 = EmergencyRecall{
            vault_id       : 0x2::object::id<Vault>(arg0),
            total_recalled : arg2,
        };
        0x2::event::emit<EmergencyRecall>(v0);
    }

    public fun get_agent_action_count(arg0: &VaultAgent) : u64 {
        arg0.action_count
    }

    public fun get_agent_allocated(arg0: &VaultAgent) : u64 {
        arg0.allocated_amount
    }

    public fun get_agent_costs(arg0: &VaultAgent) : u64 {
        arg0.total_costs
    }

    public fun get_agent_count(arg0: &Vault) : u8 {
        arg0.agent_count
    }

    public fun get_agent_max_daily(arg0: &VaultAgent) : u64 {
        arg0.max_daily
    }

    public fun get_agent_max_per_tx(arg0: &VaultAgent) : u64 {
        arg0.max_per_tx
    }

    public fun get_agent_name(arg0: &VaultAgent) : 0x1::string::String {
        arg0.name
    }

    public fun get_agent_remaining_daily(arg0: &VaultAgent) : u64 {
        if (arg0.spent_today >= arg0.max_daily) {
            0
        } else {
            arg0.max_daily - arg0.spent_today
        }
    }

    public fun get_agent_spent_today(arg0: &VaultAgent) : u64 {
        arg0.spent_today
    }

    public fun get_agent_summary(arg0: &VaultAgent) : (u8, u64, u64, u64, u64, u64, bool) {
        (arg0.agent_type, arg0.allocated_amount, arg0.spent_today, arg0.total_yield_earned, arg0.total_costs, arg0.action_count, arg0.is_active)
    }

    public fun get_agent_type(arg0: &VaultAgent) : u8 {
        arg0.agent_type
    }

    public fun get_agent_vault_id(arg0: &VaultAgent) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun get_agent_yield(arg0: &VaultAgent) : u64 {
        arg0.total_yield_earned
    }

    public fun get_balance(arg0: &Vault) : u64 {
        arg0.total_deposited - arg0.total_withdrawn
    }

    public fun get_created_at(arg0: &Vault) : u64 {
        arg0.created_at
    }

    public fun get_name(arg0: &Vault) : 0x1::string::String {
        arg0.name
    }

    public fun get_owner(arg0: &Vault) : address {
        arg0.owner
    }

    public fun get_risk_profile(arg0: &Vault) : u8 {
        arg0.risk_profile
    }

    public fun get_total_deposited(arg0: &Vault) : u64 {
        arg0.total_deposited
    }

    public fun get_total_withdrawn(arg0: &Vault) : u64 {
        arg0.total_withdrawn
    }

    public fun get_vault_summary(arg0: &Vault) : (u64, u64, u64, u8, u8, bool) {
        (get_balance(arg0), arg0.total_deposited, arg0.total_withdrawn, arg0.agent_count, arg0.risk_profile, arg0.is_active)
    }

    public fun is_agent_active(arg0: &VaultAgent) : bool {
        arg0.is_active
    }

    public fun is_vault_active(arg0: &Vault) : bool {
        arg0.is_active
    }

    public fun pause_agent(arg0: &Vault, arg1: &VaultOwnerCap, arg2: &mut VaultAgent) {
        assert_owner(arg0, arg1);
        assert!(arg2.vault_id == 0x2::object::id<Vault>(arg0), 9);
        arg2.is_active = false;
    }

    public fun pause_vault(arg0: &mut Vault, arg1: &VaultOwnerCap) {
        assert_owner(arg0, arg1);
        arg0.is_active = false;
    }

    public fun reallocate(arg0: &Vault, arg1: &VaultOwnerCap, arg2: &mut VaultAgent, arg3: u64) {
        assert_owner(arg0, arg1);
        assert!(arg2.vault_id == 0x2::object::id<Vault>(arg0), 9);
        arg2.allocated_amount = arg3;
        let v0 = AllocationChanged{
            vault_id   : arg2.vault_id,
            agent_type : arg2.agent_type,
            old_amount : arg2.allocated_amount,
            new_amount : arg3,
        };
        0x2::event::emit<AllocationChanged>(v0);
    }

    public fun recall_agent(arg0: &Vault, arg1: &VaultOwnerCap, arg2: &mut VaultAgent) : u64 {
        assert_owner(arg0, arg1);
        assert!(arg2.vault_id == 0x2::object::id<Vault>(arg0), 9);
        arg2.allocated_amount = 0;
        arg2.is_active = false;
        arg2.allocated_amount
    }

    public fun record_action(arg0: &Vault, arg1: &mut VaultAgent, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 1);
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 9);
        assert!(arg1.is_active, 2);
        reset_daily_spending_internal(arg1, 0x2::tx_context::epoch(arg5));
        if (arg3 > 0) {
            check_spending_limit_internal(arg1, arg3);
            arg1.spent_today = arg1.spent_today + arg3;
            arg1.total_costs = arg1.total_costs + arg3;
        };
        arg1.action_count = arg1.action_count + 1;
        let v0 = AgentActionRecorded{
            vault_id    : arg1.vault_id,
            agent_type  : arg1.agent_type,
            action_type : arg2,
            amount      : arg3,
        };
        0x2::event::emit<AgentActionRecorded>(v0);
    }

    public fun record_yield(arg0: &Vault, arg1: &mut VaultAgent, arg2: &VaultOwnerCap, arg3: u64) {
        assert_owner(arg0, arg2);
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 9);
        arg1.total_yield_earned = arg1.total_yield_earned + arg3;
    }

    fun reset_daily_spending_internal(arg0: &mut VaultAgent, arg1: u64) {
        if (arg1 > arg0.last_reset_epoch) {
            arg0.spent_today = 0;
            arg0.last_reset_epoch = arg1;
        };
    }

    public fun resume_agent(arg0: &Vault, arg1: &VaultOwnerCap, arg2: &mut VaultAgent) {
        assert_owner(arg0, arg1);
        assert!(arg2.vault_id == 0x2::object::id<Vault>(arg0), 9);
        arg2.is_active = true;
    }

    public fun resume_vault(arg0: &mut Vault, arg1: &VaultOwnerCap) {
        assert_owner(arg0, arg1);
        arg0.is_active = true;
    }

    public fun withdraw(arg0: &mut Vault, arg1: &VaultOwnerCap, arg2: u64) {
        assert_owner(arg0, arg1);
        assert!(arg0.is_active, 1);
        assert!(arg0.total_deposited >= arg0.total_withdrawn + arg2, 3);
        arg0.total_withdrawn = arg0.total_withdrawn + arg2;
        let v0 = WithdrawalMade{
            vault_id  : 0x2::object::id<Vault>(arg0),
            amount    : arg2,
            new_total : arg0.total_withdrawn,
        };
        0x2::event::emit<WithdrawalMade>(v0);
    }

    // decompiled from Move bytecode v7
}

