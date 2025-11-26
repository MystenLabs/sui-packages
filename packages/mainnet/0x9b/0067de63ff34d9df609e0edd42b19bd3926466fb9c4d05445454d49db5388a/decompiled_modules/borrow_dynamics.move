module 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::borrow_dynamics {
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

    public fun borrow_index_by_type(arg0: &0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::WitTable<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>, arg1: 0x1::type_name::TypeName) : u64 {
        0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::borrow<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>(arg0, arg1).borrow_index
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

    public fun last_updated_by_type(arg0: &0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::WitTable<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>, arg1: 0x1::type_name::TypeName) : u64 {
        0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::borrow<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>(arg0, arg1).last_updated
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::WitTable<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic> {
        let v0 = BorrowDynamics{dummy_field: false};
        0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::new<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>(v0, true, arg0)
    }

    public(friend) fun register_coin<T0>(arg0: &mut 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::WitTable<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>, arg1: 0x1::fixed_point32::FixedPoint32, arg2: u64, arg3: u64) {
        let v0 = BorrowDynamic{
            interest_rate       : arg1,
            interest_rate_scale : arg2,
            borrow_index        : 0x2::math::pow(10, 9),
            last_updated        : arg3,
        };
        let v1 = BorrowDynamics{dummy_field: false};
        0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::add<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>(v1, arg0, 0x1::type_name::get<T0>(), v0);
    }

    public(friend) fun update_borrow_index(arg0: &mut 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::WitTable<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = BorrowDynamics{dummy_field: false};
        let v1 = 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::borrow_mut<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>(v0, arg0, arg1);
        if (v1.last_updated == arg2) {
            return
        };
        v1.borrow_index = v1.borrow_index + 0x1::fixed_point32::multiply_u64(v1.borrow_index, 0x47aee540b4cf13763b58341097db066dc43dfa0574cd74729b64694f097a4d5d::fixed_point32_empower::mul(0x47aee540b4cf13763b58341097db066dc43dfa0574cd74729b64694f097a4d5d::fixed_point32_empower::from_u64(arg2 - v1.last_updated), v1.interest_rate)) / v1.interest_rate_scale;
        v1.last_updated = arg2;
    }

    public(friend) fun update_interest_rate(arg0: &mut 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::WitTable<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>, arg1: 0x1::type_name::TypeName, arg2: 0x1::fixed_point32::FixedPoint32, arg3: u64) {
        let v0 = BorrowDynamics{dummy_field: false};
        let v1 = 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::borrow_mut<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>(v0, arg0, arg1);
        v1.interest_rate = arg2;
        v1.interest_rate_scale = arg3;
    }

    // decompiled from Move bytecode v6
}

