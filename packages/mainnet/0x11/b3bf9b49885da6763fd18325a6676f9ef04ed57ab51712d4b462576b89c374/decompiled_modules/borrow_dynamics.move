module 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::borrow_dynamics {
    struct BorrowDynamics has drop {
        dummy_field: bool,
    }

    struct BorrowDynamic has copy, store {
        interest_rate: 0x1::fixed_point32::FixedPoint32,
        interest_rate_scale: u64,
        borrow_index: u64,
        last_updated: u64,
    }

    public fun borrow_index(arg0: &BorrowDynamic) : u64 {
        arg0.borrow_index
    }

    public fun borrow_index_by_type(arg0: &0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::wit_table::WitTable<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>, arg1: 0x1::type_name::TypeName) : u64 {
        0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::wit_table::borrow<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>(arg0, arg1).borrow_index
    }

    public fun interest_rate(arg0: &BorrowDynamic) : 0x1::fixed_point32::FixedPoint32 {
        arg0.interest_rate
    }

    public fun interest_rate_scale(arg0: &BorrowDynamic) : u64 {
        arg0.interest_rate_scale
    }

    public fun last_updated(arg0: &BorrowDynamic) : u64 {
        arg0.last_updated
    }

    public fun last_updated_by_type(arg0: &0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::wit_table::WitTable<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>, arg1: 0x1::type_name::TypeName) : u64 {
        0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::wit_table::borrow<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>(arg0, arg1).last_updated
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : 0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::wit_table::WitTable<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic> {
        let v0 = BorrowDynamics{dummy_field: false};
        0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::wit_table::new<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>(v0, true, arg0)
    }

    public(friend) fun register_coin<T0>(arg0: &mut 0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::wit_table::WitTable<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>, arg1: 0x1::fixed_point32::FixedPoint32, arg2: u64, arg3: u64) {
        let v0 = BorrowDynamic{
            interest_rate       : arg1,
            interest_rate_scale : arg2,
            borrow_index        : 0x2::math::pow(10, 9),
            last_updated        : arg3,
        };
        let v1 = BorrowDynamics{dummy_field: false};
        0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::wit_table::add<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>(v1, arg0, 0x1::type_name::get<T0>(), v0);
    }

    public(friend) fun update_borrow_index(arg0: &mut 0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::wit_table::WitTable<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = BorrowDynamics{dummy_field: false};
        let v1 = 0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::wit_table::borrow_mut<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>(v0, arg0, arg1);
        if (v1.last_updated == arg2) {
            return
        };
        v1.borrow_index = v1.borrow_index + 0x1::fixed_point32::multiply_u64(v1.borrow_index, 0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::mul(0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::from_u64(arg2 - v1.last_updated), v1.interest_rate)) / v1.interest_rate_scale;
        v1.last_updated = arg2;
    }

    public(friend) fun update_interest_rate(arg0: &mut 0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::wit_table::WitTable<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>, arg1: 0x1::type_name::TypeName, arg2: 0x1::fixed_point32::FixedPoint32, arg3: u64) {
        let v0 = BorrowDynamics{dummy_field: false};
        let v1 = 0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::wit_table::borrow_mut<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>(v0, arg0, arg1);
        v1.interest_rate = arg2;
        v1.interest_rate_scale = arg3;
    }

    // decompiled from Move bytecode v6
}

