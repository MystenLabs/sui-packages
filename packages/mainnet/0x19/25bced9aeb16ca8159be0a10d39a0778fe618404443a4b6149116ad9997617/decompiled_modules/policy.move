module 0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::policy {
    struct AgentPolicy has key {
        id: 0x2::object::UID,
        version: u16,
        owner: address,
        agent: address,
        budget_mist: u64,
        spent_mist: u64,
        max_per_tx_mist: u64,
        max_slippage_bps: u64,
        allowed_coins: vector<vector<u8>>,
        allowed_protocols: vector<address>,
        allowed_recipients: vector<address>,
        expiry_ms: u64,
        revoked: bool,
        created_ms: u64,
    }

    struct PolicyOwnerCap has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
    }

    struct PolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        owner: address,
        agent: address,
        budget_mist: u64,
        max_per_tx_mist: u64,
        expiry_ms: u64,
    }

    struct PolicyRevoked has copy, drop {
        policy_id: 0x2::object::ID,
        by: address,
    }

    struct BudgetToppedUp has copy, drop {
        policy_id: 0x2::object::ID,
        added_mist: u64,
        budget_mist: u64,
    }

    struct AgentRotated has copy, drop {
        policy_id: 0x2::object::ID,
        old_agent: address,
        new_agent: address,
    }

    struct PolicyMigrated has copy, drop {
        policy_id: 0x2::object::ID,
        from_version: u16,
        to_version: u16,
    }

    struct RecipientsSet has copy, drop {
        policy_id: 0x2::object::ID,
        count: u64,
    }

    struct ProtocolAllowlistChanged has copy, drop {
        policy_id: 0x2::object::ID,
        count: u64,
    }

    struct CoinAllowlistChanged has copy, drop {
        policy_id: 0x2::object::ID,
        count: u64,
    }

    public fun version(arg0: &AgentPolicy) : u16 {
        arg0.version
    }

    public fun add_allowed_coin(arg0: &mut AgentPolicy, arg1: &PolicyOwnerCap, arg2: vector<u8>) {
        assert_owner(arg0, arg1);
        if (0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::allowlist::insert_bytes(&mut arg0.allowed_coins, arg2)) {
            emit_coin_changed(arg0);
        };
    }

    public fun add_allowed_protocol(arg0: &mut AgentPolicy, arg1: &PolicyOwnerCap, arg2: address) {
        assert_owner(arg0, arg1);
        if (0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::allowlist::insert_addr(&mut arg0.allowed_protocols, arg2)) {
            emit_protocol_changed(arg0);
        };
    }

    public fun agent(arg0: &AgentPolicy) : address {
        arg0.agent
    }

    public fun allowed_coins(arg0: &AgentPolicy) : vector<vector<u8>> {
        arg0.allowed_coins
    }

    public fun allowed_protocols(arg0: &AgentPolicy) : vector<address> {
        arg0.allowed_protocols
    }

    public fun allowed_recipients(arg0: &AgentPolicy) : vector<address> {
        arg0.allowed_recipients
    }

    fun assert_current_version(arg0: &AgentPolicy) {
        assert!(arg0.version == 0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::constants::version(), 10);
    }

    fun assert_owner(arg0: &AgentPolicy, arg1: &PolicyOwnerCap) {
        assert!(arg1.policy_id == 0x2::object::id<AgentPolicy>(arg0), 7);
    }

    public fun assert_recipient_allowed(arg0: &AgentPolicy, arg1: address) {
        assert!(recipient_allowed(arg0, arg1), 9);
    }

    public fun budget_mist(arg0: &AgentPolicy) : u64 {
        arg0.budget_mist
    }

    fun coin_allowed(arg0: &AgentPolicy, arg1: &vector<u8>) : bool {
        0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::allowlist::allows_bytes(&arg0.allowed_coins, arg1)
    }

    entry fun create_policy(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: vector<vector<u8>>, arg5: vector<address>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_policy(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<PolicyOwnerCap>(v1, 0x2::tx_context::sender(arg8));
        0x2::transfer::share_object<AgentPolicy>(v0);
    }

    fun emit_coin_changed(arg0: &AgentPolicy) {
        let v0 = CoinAllowlistChanged{
            policy_id : 0x2::object::id<AgentPolicy>(arg0),
            count     : 0x1::vector::length<vector<u8>>(&arg0.allowed_coins),
        };
        0x2::event::emit<CoinAllowlistChanged>(v0);
    }

    fun emit_protocol_changed(arg0: &AgentPolicy) {
        let v0 = ProtocolAllowlistChanged{
            policy_id : 0x2::object::id<AgentPolicy>(arg0),
            count     : 0x1::vector::length<address>(&arg0.allowed_protocols),
        };
        0x2::event::emit<ProtocolAllowlistChanged>(v0);
    }

    public fun enforce_spend<T0>(arg0: &mut AgentPolicy, arg1: u64, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::receipt::ActionReceipt {
        assert_current_version(arg0);
        assert!(0x2::tx_context::sender(arg6) == arg0.agent, 0);
        assert!(!arg0.revoked, 1);
        assert!(arg1 > 0, 8);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg0.expiry_ms == 0 || v0 <= arg0.expiry_ms, 2);
        assert!(arg1 <= arg0.max_per_tx_mist, 3);
        assert!(arg0.spent_mist + arg1 <= arg0.budget_mist, 4);
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        assert!(coin_allowed(arg0, &v1), 5);
        assert!(protocol_allowed(arg0, arg2), 6);
        arg0.spent_mist = arg0.spent_mist + arg1;
        0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::receipt::issue(0x2::object::id<AgentPolicy>(arg0), arg0.agent, arg3, v1, arg2, arg1, arg0.spent_mist, arg4, v0, arg6)
    }

    public fun expiry_ms(arg0: &AgentPolicy) : u64 {
        arg0.expiry_ms
    }

    public fun is_expired(arg0: &AgentPolicy, arg1: &0x2::clock::Clock) : bool {
        arg0.expiry_ms != 0 && 0x2::clock::timestamp_ms(arg1) > arg0.expiry_ms
    }

    public fun is_revoked(arg0: &AgentPolicy) : bool {
        arg0.revoked
    }

    public fun max_per_tx_mist(arg0: &AgentPolicy) : u64 {
        arg0.max_per_tx_mist
    }

    public fun max_slippage_bps(arg0: &AgentPolicy) : u64 {
        arg0.max_slippage_bps
    }

    public fun migrate(arg0: &mut AgentPolicy, arg1: &PolicyOwnerCap) {
        assert_owner(arg0, arg1);
        let v0 = arg0.version;
        assert!(v0 < 0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::constants::version(), 11);
        arg0.version = 0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::constants::version();
        let v1 = PolicyMigrated{
            policy_id    : 0x2::object::id<AgentPolicy>(arg0),
            from_version : v0,
            to_version   : arg0.version,
        };
        0x2::event::emit<PolicyMigrated>(v1);
    }

    public fun new_policy(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: vector<vector<u8>>, arg5: vector<address>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (AgentPolicy, PolicyOwnerCap) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = AgentPolicy{
            id                 : 0x2::object::new(arg8),
            version            : 0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::constants::version(),
            owner              : v0,
            agent              : arg0,
            budget_mist        : arg1,
            spent_mist         : 0,
            max_per_tx_mist    : arg2,
            max_slippage_bps   : arg3,
            allowed_coins      : arg4,
            allowed_protocols  : arg5,
            allowed_recipients : vector[],
            expiry_ms          : arg6,
            revoked            : false,
            created_ms         : 0x2::clock::timestamp_ms(arg7),
        };
        let v2 = 0x2::object::id<AgentPolicy>(&v1);
        let v3 = PolicyOwnerCap{
            id        : 0x2::object::new(arg8),
            policy_id : v2,
        };
        let v4 = PolicyCreated{
            policy_id       : v2,
            owner           : v0,
            agent           : arg0,
            budget_mist     : arg1,
            max_per_tx_mist : arg2,
            expiry_ms       : arg6,
        };
        0x2::event::emit<PolicyCreated>(v4);
        (v1, v3)
    }

    public fun owner(arg0: &AgentPolicy) : address {
        arg0.owner
    }

    public fun owner_cap_policy_id(arg0: &PolicyOwnerCap) : 0x2::object::ID {
        arg0.policy_id
    }

    fun protocol_allowed(arg0: &AgentPolicy, arg1: address) : bool {
        arg1 == 0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::constants::no_protocol() || 0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::allowlist::allows_addr(&arg0.allowed_protocols, arg1)
    }

    public fun recipient_allowed(arg0: &AgentPolicy, arg1: address) : bool {
        0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::allowlist::allows_addr(&arg0.allowed_recipients, arg1)
    }

    entry fun record_action<T0>(arg0: &mut AgentPolicy, arg1: u64, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.owner;
        0x2::transfer::public_transfer<0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::receipt::ActionReceipt>(enforce_spend<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6), v0);
    }

    public fun remaining_mist(arg0: &AgentPolicy) : u64 {
        arg0.budget_mist - arg0.spent_mist
    }

    public fun remove_allowed_coin(arg0: &mut AgentPolicy, arg1: &PolicyOwnerCap, arg2: vector<u8>) {
        assert_owner(arg0, arg1);
        if (0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::allowlist::remove_bytes(&mut arg0.allowed_coins, &arg2)) {
            emit_coin_changed(arg0);
        };
    }

    public fun remove_allowed_protocol(arg0: &mut AgentPolicy, arg1: &PolicyOwnerCap, arg2: address) {
        assert_owner(arg0, arg1);
        if (0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::allowlist::remove_addr(&mut arg0.allowed_protocols, arg2)) {
            emit_protocol_changed(arg0);
        };
    }

    public fun revoke(arg0: &mut AgentPolicy, arg1: &PolicyOwnerCap, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        arg0.revoked = true;
        let v0 = PolicyRevoked{
            policy_id : 0x2::object::id<AgentPolicy>(arg0),
            by        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PolicyRevoked>(v0);
    }

    public fun rotate_agent(arg0: &mut AgentPolicy, arg1: &PolicyOwnerCap, arg2: address) {
        assert_owner(arg0, arg1);
        arg0.agent = arg2;
        let v0 = AgentRotated{
            policy_id : 0x2::object::id<AgentPolicy>(arg0),
            old_agent : arg0.agent,
            new_agent : arg2,
        };
        0x2::event::emit<AgentRotated>(v0);
    }

    public fun set_allowed_coins(arg0: &mut AgentPolicy, arg1: &PolicyOwnerCap, arg2: vector<vector<u8>>) {
        assert_owner(arg0, arg1);
        arg0.allowed_coins = arg2;
        emit_coin_changed(arg0);
    }

    public fun set_allowed_protocols(arg0: &mut AgentPolicy, arg1: &PolicyOwnerCap, arg2: vector<address>) {
        assert_owner(arg0, arg1);
        arg0.allowed_protocols = arg2;
        emit_protocol_changed(arg0);
    }

    public fun set_allowed_recipients(arg0: &mut AgentPolicy, arg1: &PolicyOwnerCap, arg2: vector<address>) {
        assert_owner(arg0, arg1);
        arg0.allowed_recipients = arg2;
        let v0 = RecipientsSet{
            policy_id : 0x2::object::id<AgentPolicy>(arg0),
            count     : 0x1::vector::length<address>(&arg0.allowed_recipients),
        };
        0x2::event::emit<RecipientsSet>(v0);
    }

    public fun share_policy(arg0: AgentPolicy) {
        0x2::transfer::share_object<AgentPolicy>(arg0);
    }

    public fun spent_mist(arg0: &AgentPolicy) : u64 {
        arg0.spent_mist
    }

    public fun top_up(arg0: &mut AgentPolicy, arg1: &PolicyOwnerCap, arg2: u64) {
        assert_owner(arg0, arg1);
        arg0.budget_mist = arg0.budget_mist + arg2;
        let v0 = BudgetToppedUp{
            policy_id   : 0x2::object::id<AgentPolicy>(arg0),
            added_mist  : arg2,
            budget_mist : arg0.budget_mist,
        };
        0x2::event::emit<BudgetToppedUp>(v0);
    }

    public fun would_allow<T0>(arg0: &AgentPolicy, arg1: u64, arg2: address, arg3: &0x2::clock::Clock) : bool {
        if (arg0.version == 0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::constants::version()) {
            if (!arg0.revoked) {
                if (arg1 > 0) {
                    if (arg0.expiry_ms == 0 || 0x2::clock::timestamp_ms(arg3) <= arg0.expiry_ms) {
                        if (arg1 <= arg0.max_per_tx_mist) {
                            if (arg0.spent_mist + arg1 <= arg0.budget_mist) {
                                let v1 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
                                if (coin_allowed(arg0, &v1)) {
                                    protocol_allowed(arg0, arg2)
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v7
}

