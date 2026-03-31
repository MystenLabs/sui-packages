module 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::interest_model {
    struct InterestModel has copy, drop, store {
        asset_type: 0x1::type_name::TypeName,
        base_borrow_rate_per_sec: 0x1::fixed_point32::FixedPoint32,
        interest_rate_scale: u64,
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

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : (0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::ac_table::AcTable<InterestModels, 0x1::type_name::TypeName, InterestModel>, 0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::ac_table::AcTableCap<InterestModels>) {
        let v0 = InterestModels{dummy_field: false};
        0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::ac_table::new<InterestModels, 0x1::type_name::TypeName, InterestModel>(v0, true, arg0)
    }

    public(friend) fun add_interest_model<T0>(arg0: &mut 0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::ac_table::AcTable<InterestModels, 0x1::type_name::TypeName, InterestModel>, arg1: &0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::ac_table::AcTableCap<InterestModels>, arg2: 0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::one_time_lock_value::OneTimeLockValue<InterestModel>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::one_time_lock_value::get_value<InterestModel>(arg2, arg3);
        let v1 = 0x1::type_name::get<T0>();
        assert!(v0.asset_type == v1, 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::error::interest_model_type_not_match_error());
        if (0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::ac_table::contains<InterestModels, 0x1::type_name::TypeName, InterestModel>(arg0, v1)) {
            0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::ac_table::remove<InterestModels, 0x1::type_name::TypeName, InterestModel>(arg0, arg1, v1);
        };
        0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::ac_table::add<InterestModels, 0x1::type_name::TypeName, InterestModel>(arg0, arg1, v1, v0);
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

    public(friend) fun create_interest_model_change<T0>(arg0: &0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::ac_table::AcTableCap<InterestModels>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::one_time_lock_value::OneTimeLockValue<InterestModel> {
        let v0 = InterestModel{
            asset_type               : 0x1::type_name::get<T0>(),
            base_borrow_rate_per_sec : 0x1::fixed_point32::create_from_rational(arg1, arg3),
            interest_rate_scale      : arg2,
            min_borrow_amount        : arg4,
        };
        let v1 = InterestModelChangeCreated{
            interest_model    : v0,
            current_epoch     : 0x2::tx_context::epoch(arg6),
            delay_epoches     : arg5,
            effective_epoches : 0x2::tx_context::epoch(arg6) + arg5,
        };
        0x2::event::emit<InterestModelChangeCreated>(v1);
        0x32a508db666489592aa1d383ddb775d69b307a4c2ad7067dd8c2b9c8409a0287::one_time_lock_value::new<InterestModel>(v0, arg5, 7, arg6)
    }

    public fun interest_rate_scale(arg0: &InterestModel) : u64 {
        arg0.interest_rate_scale
    }

    public fun min_borrow_amount(arg0: &InterestModel) : u64 {
        arg0.min_borrow_amount
    }

    // decompiled from Move bytecode v6
}

