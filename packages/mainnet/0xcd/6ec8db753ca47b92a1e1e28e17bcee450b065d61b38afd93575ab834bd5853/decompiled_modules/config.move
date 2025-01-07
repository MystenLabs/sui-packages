module 0xcd6ec8db753ca47b92a1e1e28e17bcee450b065d61b38afd93575ab834bd5853::config {
    struct FeeAdded has copy, drop {
        fee_amount: u64,
    }

    struct OperatorAdded has copy, drop {
        operator: address,
    }

    struct OperatorRemoved has copy, drop {
        operator: address,
    }

    struct FeeClaimed has copy, drop {
        claimed_amount: u64,
        claim_address: address,
    }

    struct OwnerChanged has copy, drop {
        new_owner: address,
    }

    struct MinFeeTakenChanged has copy, drop {
        new_min_fee_taken: u64,
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
    }

    struct GlobalFeeConfig has store, key {
        id: 0x2::object::UID,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        min_fee_taken: u64,
        min_percentage_taken: u64,
    }

    public(friend) fun add_fee(arg0: &mut GlobalFeeConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64) {
        if (arg0.min_fee_taken > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.min_fee_taken, 3);
        } else {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) * 100 * 10000 / arg2 >= arg0.min_percentage_taken, 3);
        };
        let v0 = FeeAdded{fee_amount: 0x2::coin::value<0x2::sui::SUI>(&arg1)};
        0x2::event::emit<FeeAdded>(v0);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.fee_balance, arg1);
    }

    public entry fun add_operator(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        only_owner(arg0, arg2);
        0x2::vec_set::insert<address>(&mut arg0.operators_whitelist, arg1);
        let v0 = OperatorAdded{operator: arg1};
        0x2::event::emit<OperatorAdded>(v0);
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

    public entry fun change_min_fee_taken(arg0: &GlobalConfig, arg1: &mut GlobalFeeConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        only_owner(arg0, arg3);
        arg1.min_fee_taken = arg2;
        arg1.min_percentage_taken = 0;
        let v0 = MinFeeTakenChanged{new_min_fee_taken: arg2};
        0x2::event::emit<MinFeeTakenChanged>(v0);
    }

    public entry fun change_min_percentage_taken(arg0: &GlobalConfig, arg1: &mut GlobalFeeConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        only_owner(arg0, arg3);
        arg1.min_fee_taken = 0;
        arg1.min_percentage_taken = arg2;
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

    public entry fun claim_fee(arg0: &GlobalConfig, arg1: &mut GlobalFeeConfig, arg2: &mut 0x2::tx_context::TxContext) {
        only_owner(arg0, arg2);
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.fee_balance), arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        assert!(v1 > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg0.owner);
        let v2 = FeeClaimed{
            claimed_amount : v1,
            claim_address  : arg0.owner,
        };
        0x2::event::emit<FeeClaimed>(v2);
    }

    public fun get_fee_value(arg0: &GlobalFeeConfig) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance)
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

    public fun get_min_fee_taken(arg0: &GlobalFeeConfig) : u64 {
        arg0.min_fee_taken
    }

    public fun get_min_percentage_taken(arg0: &GlobalFeeConfig) : u64 {
        arg0.min_percentage_taken
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
        };
        let v2 = GlobalFeeConfig{
            id                   : 0x2::object::new(arg0),
            fee_balance          : 0x2::balance::zero<0x2::sui::SUI>(),
            min_fee_taken        : 0,
            min_percentage_taken : 10,
        };
        let v3 = &mut v1;
        add_operator(v3, v0, arg0);
        0x2::transfer::share_object<GlobalFeeConfig>(v2);
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

    public entry fun remove_operator(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        only_owner(arg0, arg2);
        0x2::vec_set::remove<address>(&mut arg0.operators_whitelist, &arg1);
        let v0 = OperatorRemoved{operator: arg1};
        0x2::event::emit<OperatorRemoved>(v0);
    }

    // decompiled from Move bytecode v6
}

