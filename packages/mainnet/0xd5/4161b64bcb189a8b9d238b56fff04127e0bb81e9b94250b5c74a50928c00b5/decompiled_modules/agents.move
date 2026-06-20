module 0xd54161b64bcb189a8b9d238b56fff04127e0bb81e9b94250b5c74a50928c00b5::agents {
    struct AgentConfig has drop, store {
        max_per_tx: u64,
        daily_limit: u64,
    }

    struct AgentState has drop, store {
        spent_in_window: u64,
        window_start_ms: u64,
        is_paused: bool,
    }

    struct AgentSpendHub<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        config: AgentConfig,
        agents: 0x2::table::Table<address, AgentState>,
    }

    struct AgentAdminCap has store, key {
        id: 0x2::object::UID,
        hub_id: 0x2::object::ID,
    }

    struct AgentTransferEvent<phantom T0> has copy, drop {
        hub_id: 0x2::object::ID,
        agent_key: address,
        recipient: address,
        amount: u64,
        timestamp_ms: u64,
    }

    public fun admin_withdraw<T0>(arg0: &AgentAdminCap, arg1: &mut AgentSpendHub<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg1);
        let v0 = 0x2::balance::value<T0>(&arg1.balance);
        assert!(v0 > 0, 7);
        0x2::coin::send_funds<T0>(0x2::coin::take<T0>(&mut arg1.balance, v0, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun agent_transfer<T0>(arg0: &mut AgentSpendHub<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 7);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, AgentState>(&arg0.agents, v0), 2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg2 <= arg0.config.max_per_tx, 4);
        let v2 = 0x2::table::borrow_mut<address, AgentState>(&mut arg0.agents, v0);
        assert!(!v2.is_paused, 3);
        if (v1 >= v2.window_start_ms + 86400000) {
            v2.window_start_ms = v1;
            v2.spent_in_window = 0;
        };
        assert!(v2.spent_in_window + arg2 <= arg0.config.daily_limit, 5);
        v2.spent_in_window = v2.spent_in_window + arg2;
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg2, 6);
        0x2::coin::send_funds<T0>(0x2::coin::take<T0>(&mut arg0.balance, arg2, arg4), arg3);
        let v3 = AgentTransferEvent<T0>{
            hub_id       : 0x2::object::id<AgentSpendHub<T0>>(arg0),
            agent_key    : v0,
            recipient    : arg3,
            amount       : arg2,
            timestamp_ms : v1,
        };
        0x2::event::emit<AgentTransferEvent<T0>>(v3);
    }

    fun assert_admin<T0>(arg0: &AgentAdminCap, arg1: &AgentSpendHub<T0>) {
        assert!(arg0.hub_id == 0x2::object::id<AgentSpendHub<T0>>(arg1), 0);
    }

    fun create_hub<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : AgentSpendHub<T0> {
        let v0 = AgentConfig{
            max_per_tx  : arg0,
            daily_limit : arg1,
        };
        AgentSpendHub<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<T0>(),
            config  : v0,
            agents  : 0x2::table::new<address, AgentState>(arg2),
        }
    }

    public fun deposit_funds<T0>(arg0: &mut AgentSpendHub<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun initialize_hub<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = create_hub<T0>(arg0, arg1, arg2);
        share_new_hub<T0>(v0, arg2);
    }

    public fun initialize_hub_with_agent<T0>(arg0: address, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = create_hub<T0>(arg1, arg2, arg3);
        let v1 = AgentState{
            spent_in_window : 0,
            window_start_ms : 0,
            is_paused       : false,
        };
        0x2::table::add<address, AgentState>(&mut v0.agents, arg0, v1);
        share_new_hub<T0>(v0, arg3);
    }

    public fun register_agent<T0>(arg0: &AgentAdminCap, arg1: &mut AgentSpendHub<T0>, arg2: address) {
        assert_admin<T0>(arg0, arg1);
        assert!(!0x2::table::contains<address, AgentState>(&arg1.agents, arg2), 1);
        let v0 = AgentState{
            spent_in_window : 0,
            window_start_ms : 0,
            is_paused       : false,
        };
        0x2::table::add<address, AgentState>(&mut arg1.agents, arg2, v0);
    }

    public fun revoke_agent<T0>(arg0: &AgentAdminCap, arg1: &mut AgentSpendHub<T0>, arg2: address) {
        assert_admin<T0>(arg0, arg1);
        assert!(0x2::table::contains<address, AgentState>(&arg1.agents, arg2), 2);
        let AgentState {
            spent_in_window : _,
            window_start_ms : _,
            is_paused       : _,
        } = 0x2::table::remove<address, AgentState>(&mut arg1.agents, arg2);
    }

    public fun set_agent_config<T0>(arg0: &AgentAdminCap, arg1: &mut AgentSpendHub<T0>, arg2: u64, arg3: u64) {
        assert_admin<T0>(arg0, arg1);
        arg1.config.max_per_tx = arg2;
        arg1.config.daily_limit = arg3;
    }

    public fun set_agent_paused<T0>(arg0: &AgentAdminCap, arg1: &mut AgentSpendHub<T0>, arg2: address, arg3: bool) {
        assert_admin<T0>(arg0, arg1);
        assert!(0x2::table::contains<address, AgentState>(&arg1.agents, arg2), 2);
        0x2::table::borrow_mut<address, AgentState>(&mut arg1.agents, arg2).is_paused = arg3;
    }

    fun share_new_hub<T0>(arg0: AgentSpendHub<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AgentAdminCap{
            id     : 0x2::object::new(arg1),
            hub_id : 0x2::object::id<AgentSpendHub<T0>>(&arg0),
        };
        0x2::transfer::share_object<AgentSpendHub<T0>>(arg0);
        0x2::transfer::transfer<AgentAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

