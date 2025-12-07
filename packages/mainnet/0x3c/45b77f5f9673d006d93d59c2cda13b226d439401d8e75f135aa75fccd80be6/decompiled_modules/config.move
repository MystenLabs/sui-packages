module 0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::config {
    struct CONFIG has drop {
        dummy_field: bool,
    }

    struct SubscriptionPlan has copy, drop, store {
        id: u64,
        name: vector<u8>,
        tier: u8,
        original_price: u64,
        paid_price: u64,
        period: u8,
        upgrade_fee: u64,
        immediate_upgrade_fee: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        plans: 0x2::vec_map::VecMap<u64, SubscriptionPlan>,
        admin_wallet: address,
        paused: bool,
    }

    public fun add_plan(arg0: &mut Config, arg1: &0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::admin::AdminCap, arg2: u64, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64) {
        assert!(!0x2::vec_map::contains<u64, SubscriptionPlan>(&arg0.plans, &arg2), 107);
        assert!(0x1::vector::length<u8>(&arg3) > 0, 106);
        assert!(arg4 <= 3, 108);
        assert!(arg5 > 0, 105);
        assert!(arg6 > 0, 105);
        assert!(arg7 <= 2, 104);
        let v0 = SubscriptionPlan{
            id                    : arg2,
            name                  : arg3,
            tier                  : arg4,
            original_price        : arg5,
            paid_price            : arg6,
            period                : arg7,
            upgrade_fee           : arg8,
            immediate_upgrade_fee : arg9,
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

    public fun get_plan_immediate_upgrade_fee(arg0: &SubscriptionPlan) : u64 {
        arg0.immediate_upgrade_fee
    }

    public fun get_plan_name(arg0: &SubscriptionPlan) : vector<u8> {
        arg0.name
    }

    public fun get_plan_original_price(arg0: &SubscriptionPlan) : u64 {
        arg0.original_price
    }

    public fun get_plan_paid_price(arg0: &SubscriptionPlan) : u64 {
        arg0.paid_price
    }

    public fun get_plan_period(arg0: &SubscriptionPlan) : u8 {
        arg0.period
    }

    public fun get_plan_tier(arg0: &SubscriptionPlan) : u8 {
        arg0.tier
    }

    public fun get_plan_upgrade_fee(arg0: &SubscriptionPlan) : u64 {
        arg0.upgrade_fee
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

    public fun remove_plan(arg0: &mut Config, arg1: &0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::admin::AdminCap, arg2: u64) {
        assert!(0x2::vec_map::contains<u64, SubscriptionPlan>(&arg0.plans, &arg2), 102);
        let (_, _) = 0x2::vec_map::remove<u64, SubscriptionPlan>(&mut arg0.plans, &arg2);
    }

    public fun set_paused(arg0: &mut Config, arg1: &0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::admin::AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public fun update_admin_wallet(arg0: &mut Config, arg1: &0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::admin::AdminCap, arg2: address) {
        arg0.admin_wallet = arg2;
    }

    public fun update_plan(arg0: &mut Config, arg1: &0x3c45b77f5f9673d006d93d59c2cda13b226d439401d8e75f135aa75fccd80be6::admin::AdminCap, arg2: u64, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64) {
        assert!(0x2::vec_map::contains<u64, SubscriptionPlan>(&arg0.plans, &arg2), 102);
        assert!(0x1::vector::length<u8>(&arg3) > 0, 106);
        assert!(arg4 <= 3, 108);
        assert!(arg5 > 0, 105);
        assert!(arg6 > 0, 105);
        assert!(arg7 <= 2, 104);
        let (_, _) = 0x2::vec_map::remove<u64, SubscriptionPlan>(&mut arg0.plans, &arg2);
        let v2 = SubscriptionPlan{
            id                    : arg2,
            name                  : arg3,
            tier                  : arg4,
            original_price        : arg5,
            paid_price            : arg6,
            period                : arg7,
            upgrade_fee           : arg8,
            immediate_upgrade_fee : arg9,
        };
        0x2::vec_map::insert<u64, SubscriptionPlan>(&mut arg0.plans, arg2, v2);
    }

    // decompiled from Move bytecode v6
}

