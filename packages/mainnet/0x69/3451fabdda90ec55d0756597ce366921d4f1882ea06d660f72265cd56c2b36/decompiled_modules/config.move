module 0x693451fabdda90ec55d0756597ce366921d4f1882ea06d660f72265cd56c2b36::config {
    struct CONFIG has drop {
        dummy_field: bool,
    }

    struct SubscriptionPlan has copy, drop, store {
        id: u64,
        price: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        plans: 0x2::vec_map::VecMap<u64, SubscriptionPlan>,
        admin_wallet: address,
        paused: bool,
    }

    public fun add_plan(arg0: &mut Config, arg1: &0x693451fabdda90ec55d0756597ce366921d4f1882ea06d660f72265cd56c2b36::admin::AdminCap, arg2: u64, arg3: u64) {
        assert!(!0x2::vec_map::contains<u64, SubscriptionPlan>(&arg0.plans, &arg2), 107);
        assert!(arg3 > 0, 105);
        let v0 = SubscriptionPlan{
            id    : arg2,
            price : arg3,
        };
        0x2::vec_map::insert<u64, SubscriptionPlan>(&mut arg0.plans, arg2, v0);
    }

    public fun assert_not_paused(arg0: &Config) {
        assert!(!arg0.paused, 109);
    }

    public(friend) fun create_config(arg0: &CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<CONFIG>(arg0), 103);
        let v0 = Config{
            id           : 0x2::object::new(arg1),
            plans        : 0x2::vec_map::empty<u64, SubscriptionPlan>(),
            admin_wallet : 0x2::tx_context::sender(arg1),
            paused       : false,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun get_admin_wallet(arg0: &Config) : address {
        arg0.admin_wallet
    }

    public fun get_plan(arg0: &Config, arg1: u64) : SubscriptionPlan {
        *0x2::vec_map::get<u64, SubscriptionPlan>(&arg0.plans, &arg1)
    }

    public fun get_plan_id(arg0: &SubscriptionPlan) : u64 {
        arg0.id
    }

    public fun get_plan_price(arg0: &SubscriptionPlan) : u64 {
        arg0.price
    }

    public fun get_plans(arg0: &Config) : &0x2::vec_map::VecMap<u64, SubscriptionPlan> {
        &arg0.plans
    }

    fun init(arg0: CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        create_config(&arg0, arg1);
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun remove_plan(arg0: &mut Config, arg1: &0x693451fabdda90ec55d0756597ce366921d4f1882ea06d660f72265cd56c2b36::admin::AdminCap, arg2: u64) {
        assert!(0x2::vec_map::contains<u64, SubscriptionPlan>(&arg0.plans, &arg2), 102);
        let (_, _) = 0x2::vec_map::remove<u64, SubscriptionPlan>(&mut arg0.plans, &arg2);
    }

    public fun set_paused(arg0: &mut Config, arg1: &0x693451fabdda90ec55d0756597ce366921d4f1882ea06d660f72265cd56c2b36::admin::AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public fun update_admin_wallet(arg0: &mut Config, arg1: &0x693451fabdda90ec55d0756597ce366921d4f1882ea06d660f72265cd56c2b36::admin::AdminCap, arg2: address) {
        arg0.admin_wallet = arg2;
    }

    public fun update_plan(arg0: &mut Config, arg1: &0x693451fabdda90ec55d0756597ce366921d4f1882ea06d660f72265cd56c2b36::admin::AdminCap, arg2: u64, arg3: u64) {
        assert!(0x2::vec_map::contains<u64, SubscriptionPlan>(&arg0.plans, &arg2), 102);
        assert!(arg3 > 0, 105);
        let (_, _) = 0x2::vec_map::remove<u64, SubscriptionPlan>(&mut arg0.plans, &arg2);
        let v2 = SubscriptionPlan{
            id    : arg2,
            price : arg3,
        };
        0x2::vec_map::insert<u64, SubscriptionPlan>(&mut arg0.plans, arg2, v2);
    }

    // decompiled from Move bytecode v6
}

