module 0x6a4d51232e33fc37e860083ae5605d53ea8204445806faaae336a658d95cebd5::config {
    struct CONFIG has drop {
        dummy_field: bool,
    }

    struct SubscriptionPlan has copy, drop, store {
        id: u64,
        ptype: u8,
        month_interval: u8,
        price: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        plans: 0x2::vec_map::VecMap<u64, SubscriptionPlan>,
        fee_receiver: address,
        paused: bool,
        accepted_payment_type: 0x1::ascii::String,
    }

    public fun add_plan(arg0: &mut Config, arg1: &0x6a4d51232e33fc37e860083ae5605d53ea8204445806faaae336a658d95cebd5::admin::AdminCap, arg2: u64, arg3: u8, arg4: u8, arg5: u64) {
        assert!(!0x2::vec_map::contains<u64, SubscriptionPlan>(&arg0.plans, &arg2), 107);
        let v0 = SubscriptionPlan{
            id             : arg2,
            ptype          : arg3,
            month_interval : arg4,
            price          : arg5,
        };
        0x2::vec_map::insert<u64, SubscriptionPlan>(&mut arg0.plans, arg2, v0);
    }

    public fun assert_not_paused(arg0: &Config) {
        assert!(!arg0.paused, 109);
    }

    public fun assert_payment_type_accepted<T0>(arg0: &Config) {
        assert!(is_payment_type_accepted<T0>(arg0), 110);
    }

    public(friend) fun create_config(arg0: &CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<CONFIG>(arg0), 103);
        let v0 = Config{
            id                    : 0x2::object::new(arg1),
            plans                 : 0x2::vec_map::empty<u64, SubscriptionPlan>(),
            fee_receiver          : 0x2::tx_context::sender(arg1),
            paused                : false,
            accepted_payment_type : 0x1::ascii::string(b"0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC"),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun get_fee_receiver(arg0: &Config) : address {
        arg0.fee_receiver
    }

    public fun get_paid_price(arg0: &SubscriptionPlan) : u64 {
        arg0.price * (arg0.month_interval as u64)
    }

    public fun get_plan(arg0: &Config, arg1: u64) : SubscriptionPlan {
        assert!(0x2::vec_map::contains<u64, SubscriptionPlan>(&arg0.plans, &arg1), 102);
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

    public fun is_cu_plan(arg0: &SubscriptionPlan) : bool {
        arg0.ptype == 2
    }

    public fun is_cycle_plan(arg0: &SubscriptionPlan) : bool {
        arg0.ptype == 1
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun is_payment_type_accepted<T0>(arg0: &Config) : bool {
        0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()) == arg0.accepted_payment_type
    }

    public fun remove_plan(arg0: &mut Config, arg1: &0x6a4d51232e33fc37e860083ae5605d53ea8204445806faaae336a658d95cebd5::admin::AdminCap, arg2: u64) {
        assert!(0x2::vec_map::contains<u64, SubscriptionPlan>(&arg0.plans, &arg2), 102);
        let (_, _) = 0x2::vec_map::remove<u64, SubscriptionPlan>(&mut arg0.plans, &arg2);
    }

    public fun set_accepted_payment_type<T0>(arg0: &mut Config, arg1: &0x6a4d51232e33fc37e860083ae5605d53ea8204445806faaae336a658d95cebd5::admin::AdminCap) {
        arg0.accepted_payment_type = 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>());
    }

    public fun set_paused(arg0: &mut Config, arg1: &0x6a4d51232e33fc37e860083ae5605d53ea8204445806faaae336a658d95cebd5::admin::AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public fun update_fee_receiver(arg0: &mut Config, arg1: &0x6a4d51232e33fc37e860083ae5605d53ea8204445806faaae336a658d95cebd5::admin::AdminCap, arg2: address) {
        arg0.fee_receiver = arg2;
    }

    public fun update_plan(arg0: &mut Config, arg1: &0x6a4d51232e33fc37e860083ae5605d53ea8204445806faaae336a658d95cebd5::admin::AdminCap, arg2: u64, arg3: u8, arg4: u8, arg5: u64) {
        assert!(0x2::vec_map::contains<u64, SubscriptionPlan>(&arg0.plans, &arg2), 102);
        let (_, _) = 0x2::vec_map::remove<u64, SubscriptionPlan>(&mut arg0.plans, &arg2);
        let v2 = SubscriptionPlan{
            id             : arg2,
            ptype          : arg3,
            month_interval : arg4,
            price          : arg5,
        };
        0x2::vec_map::insert<u64, SubscriptionPlan>(&mut arg0.plans, arg2, v2);
    }

    // decompiled from Move bytecode v6
}

