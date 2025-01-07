module 0x88afe799bc473d4c2918a0b958b91eaacb2d93b7109d648ec3843371106bf9ba::config {
    struct OperatorAdded has copy, drop {
        operator: address,
    }

    struct OperatorRemoved has copy, drop {
        operator: address,
    }

    struct OwnerChanged has copy, drop {
        new_owner: address,
    }

    struct MinPercentageTakenChanged has copy, drop {
        new_fee_percentage_taken: u64,
    }

    struct TimeToLiveLimitOrderChanged has copy, drop {
        new_time_to_live_limit_order: u64,
    }

    struct MaxDcaOrderCountChanged has copy, drop {
        new_max_dca_order_count: u64,
    }

    struct MaxIntervalChanged has copy, drop {
        new_max_interval: u64,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        operators_whitelist: 0x2::vec_set::VecSet<address>,
        owner: address,
        max_time_to_live_limit_order: u64,
        max_dca_order_count: u64,
        max_interval: u64,
        fee_percentage_taken: u64,
    }

    public entry fun add_operator(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        only_owner(arg0, arg2);
        0x2::vec_set::insert<address>(&mut arg0.operators_whitelist, arg1);
        let v0 = OperatorAdded{operator: arg1};
        0x2::event::emit<OperatorAdded>(v0);
    }

    public entry fun change_fee_percentage_taken(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        only_owner(arg0, arg2);
        assert!(arg1 <= 10000, 3);
        arg0.fee_percentage_taken = arg1;
        let v0 = MinPercentageTakenChanged{new_fee_percentage_taken: arg1};
        0x2::event::emit<MinPercentageTakenChanged>(v0);
    }

    public entry fun change_max_dca_order_count(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        only_owner(arg0, arg2);
        arg0.max_dca_order_count = arg1;
        let v0 = MaxDcaOrderCountChanged{new_max_dca_order_count: arg1};
        0x2::event::emit<MaxDcaOrderCountChanged>(v0);
    }

    public entry fun change_max_interval(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        only_owner(arg0, arg2);
        arg0.max_interval = arg1;
        let v0 = MaxIntervalChanged{new_max_interval: arg1};
        0x2::event::emit<MaxIntervalChanged>(v0);
    }

    public entry fun change_owner(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        only_owner(arg0, arg2);
        arg0.owner = arg1;
        let v0 = OwnerChanged{new_owner: arg1};
        0x2::event::emit<OwnerChanged>(v0);
    }

    public entry fun change_time_to_live_limit_order(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        only_owner(arg0, arg2);
        arg0.max_time_to_live_limit_order = arg1;
        let v0 = TimeToLiveLimitOrderChanged{new_time_to_live_limit_order: arg1};
        0x2::event::emit<TimeToLiveLimitOrderChanged>(v0);
    }

    public fun get_fee_percentage_taken(arg0: &GlobalConfig) : u64 {
        arg0.fee_percentage_taken
    }

    public fun get_max_dca_order_count(arg0: &GlobalConfig) : u64 {
        arg0.max_dca_order_count
    }

    public fun get_max_interval(arg0: &GlobalConfig) : u64 {
        arg0.max_interval
    }

    public fun get_max_time_to_live_limit_order(arg0: &GlobalConfig) : u64 {
        arg0.max_time_to_live_limit_order
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = GlobalConfig{
            id                           : 0x2::object::new(arg0),
            operators_whitelist          : 0x2::vec_set::empty<address>(),
            owner                        : v0,
            max_time_to_live_limit_order : 2592000000,
            max_dca_order_count          : 100,
            max_interval                 : 2592000000,
            fee_percentage_taken         : 10,
        };
        let v2 = &mut v1;
        add_operator(v2, v0, arg0);
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public fun is_operator(arg0: &GlobalConfig, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.operators_whitelist, &arg1)
    }

    public fun is_owner(arg0: &GlobalConfig, arg1: address) : bool {
        arg0.owner == arg1
    }

    public fun only_operator(arg0: &GlobalConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(is_operator(arg0, 0x2::tx_context::sender(arg1)), 1);
    }

    public fun only_owner(arg0: &GlobalConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg0, 0x2::tx_context::sender(arg1)), 0);
    }

    public fun only_valid_fee(arg0: &GlobalConfig, arg1: u64, arg2: u64) {
        assert!(arg1 * 10000 <= arg2 * arg0.fee_percentage_taken, 2);
    }

    public entry fun remove_operator(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        only_owner(arg0, arg2);
        0x2::vec_set::remove<address>(&mut arg0.operators_whitelist, &arg1);
        let v0 = OperatorRemoved{operator: arg1};
        0x2::event::emit<OperatorRemoved>(v0);
    }

    // decompiled from Move bytecode v6
}

