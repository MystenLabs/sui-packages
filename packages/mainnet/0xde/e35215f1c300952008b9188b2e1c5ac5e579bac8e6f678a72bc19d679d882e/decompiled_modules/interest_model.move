module 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::interest_model {
    struct InterestModel has copy, drop, store {
        asset_type: 0x1::type_name::TypeName,
        base_borrow_rate_per_sec: 0x1::fixed_point32::FixedPoint32,
        interest_rate_scale: u64,
        revenue_factor: 0x1::fixed_point32::FixedPoint32,
        min_borrow_amount: u64,
    }

    struct InterestModelChangeCreated has copy, drop {
        interest_model: InterestModel,
        current_epoch: u64,
        delay_epoches: u64,
        effective_epoches: u64,
    }

    struct InterestModelAdded has copy, drop {
        interest_model: InterestModel,
        current_epoch: u64,
    }

    struct InterestModels has drop {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : (0x7fb55558c7c89958aa04003966e7521c7334acf876762dfe5fe63f9465e36794::ac_table::AcTable<InterestModels, 0x1::type_name::TypeName, InterestModel>, 0x7fb55558c7c89958aa04003966e7521c7334acf876762dfe5fe63f9465e36794::ac_table::AcTableCap<InterestModels>) {
        let v0 = InterestModels{dummy_field: false};
        0x7fb55558c7c89958aa04003966e7521c7334acf876762dfe5fe63f9465e36794::ac_table::new<InterestModels, 0x1::type_name::TypeName, InterestModel>(v0, true, arg0)
    }

    public(friend) fun add_interest_model<T0>(arg0: &mut 0x7fb55558c7c89958aa04003966e7521c7334acf876762dfe5fe63f9465e36794::ac_table::AcTable<InterestModels, 0x1::type_name::TypeName, InterestModel>, arg1: &0x7fb55558c7c89958aa04003966e7521c7334acf876762dfe5fe63f9465e36794::ac_table::AcTableCap<InterestModels>, arg2: 0x7fb55558c7c89958aa04003966e7521c7334acf876762dfe5fe63f9465e36794::one_time_lock_value::OneTimeLockValue<InterestModel>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7fb55558c7c89958aa04003966e7521c7334acf876762dfe5fe63f9465e36794::one_time_lock_value::get_value<InterestModel>(arg2, arg3);
        let v1 = 0x1::type_name::get<T0>();
        assert!(v0.asset_type == v1, 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::error::interest_model_type_not_match_error());
        if (0x7fb55558c7c89958aa04003966e7521c7334acf876762dfe5fe63f9465e36794::ac_table::contains<InterestModels, 0x1::type_name::TypeName, InterestModel>(arg0, v1)) {
            0x7fb55558c7c89958aa04003966e7521c7334acf876762dfe5fe63f9465e36794::ac_table::remove<InterestModels, 0x1::type_name::TypeName, InterestModel>(arg0, arg1, v1);
        };
        0x7fb55558c7c89958aa04003966e7521c7334acf876762dfe5fe63f9465e36794::ac_table::add<InterestModels, 0x1::type_name::TypeName, InterestModel>(arg0, arg1, v1, v0);
        let v2 = InterestModelAdded{
            interest_model : v0,
            current_epoch  : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<InterestModelAdded>(v2);
    }

    public fun asset_type(arg0: &InterestModel) : 0x1::type_name::TypeName {
        arg0.asset_type
    }

    public fun base_borrow_rate(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.base_borrow_rate_per_sec
    }

    public(friend) fun create_interest_model_change<T0>(arg0: &0x7fb55558c7c89958aa04003966e7521c7334acf876762dfe5fe63f9465e36794::ac_table::AcTableCap<InterestModels>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x7fb55558c7c89958aa04003966e7521c7334acf876762dfe5fe63f9465e36794::one_time_lock_value::OneTimeLockValue<InterestModel> {
        let v0 = InterestModel{
            asset_type               : 0x1::type_name::get<T0>(),
            base_borrow_rate_per_sec : 0x1::fixed_point32::create_from_rational(arg1, arg4),
            interest_rate_scale      : arg2,
            revenue_factor           : 0x1::fixed_point32::create_from_rational(arg3, arg4),
            min_borrow_amount        : arg5,
        };
        let v1 = InterestModelChangeCreated{
            interest_model    : v0,
            current_epoch     : 0x2::tx_context::epoch(arg7),
            delay_epoches     : arg6,
            effective_epoches : 0x2::tx_context::epoch(arg7) + arg6,
        };
        0x2::event::emit<InterestModelChangeCreated>(v1);
        0x7fb55558c7c89958aa04003966e7521c7334acf876762dfe5fe63f9465e36794::one_time_lock_value::new<InterestModel>(v0, arg6, 7, arg7)
    }

    public fun interest_rate_scale(arg0: &InterestModel) : u64 {
        arg0.interest_rate_scale
    }

    public fun min_borrow_amount(arg0: &InterestModel) : u64 {
        arg0.min_borrow_amount
    }

    public fun revenue_factor(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.revenue_factor
    }

    // decompiled from Move bytecode v6
}

