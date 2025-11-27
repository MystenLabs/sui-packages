module 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::borrow_dynamics {
    struct BorrowDynamics has drop {
        dummy_field: bool,
    }

    struct BorrowDynamic has copy, store {
        interest_rate: 0x1::fixed_point32::FixedPoint32,
        interest_rate_scale: u64,
        borrow_index: u64,
        last_updated: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : 0x1caf0caf6860c2ed8335d7434134902896fa55f374f96323cb92272316238f91::wit_table::WitTable<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic> {
        let v0 = BorrowDynamics{dummy_field: false};
        0x1caf0caf6860c2ed8335d7434134902896fa55f374f96323cb92272316238f91::wit_table::new<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>(v0, true, arg0)
    }

    public fun borrow_index(arg0: &BorrowDynamic) : u64 {
        arg0.borrow_index
    }

    public fun borrow_index_by_type(arg0: &0x1caf0caf6860c2ed8335d7434134902896fa55f374f96323cb92272316238f91::wit_table::WitTable<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>, arg1: 0x1::type_name::TypeName) : u64 {
        0x1caf0caf6860c2ed8335d7434134902896fa55f374f96323cb92272316238f91::wit_table::borrow<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>(arg0, arg1).borrow_index
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

    public fun last_updated_by_type(arg0: &0x1caf0caf6860c2ed8335d7434134902896fa55f374f96323cb92272316238f91::wit_table::WitTable<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>, arg1: 0x1::type_name::TypeName) : u64 {
        0x1caf0caf6860c2ed8335d7434134902896fa55f374f96323cb92272316238f91::wit_table::borrow<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>(arg0, arg1).last_updated
    }

    public(friend) fun register_coin<T0>(arg0: &mut 0x1caf0caf6860c2ed8335d7434134902896fa55f374f96323cb92272316238f91::wit_table::WitTable<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>, arg1: 0x1::fixed_point32::FixedPoint32, arg2: u64, arg3: u64) {
        let v0 = BorrowDynamic{
            interest_rate       : arg1,
            interest_rate_scale : arg2,
            borrow_index        : 0x2::math::pow(10, 9),
            last_updated        : arg3,
        };
        let v1 = BorrowDynamics{dummy_field: false};
        0x1caf0caf6860c2ed8335d7434134902896fa55f374f96323cb92272316238f91::wit_table::add<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>(v1, arg0, 0x1::type_name::get<T0>(), v0);
    }

    public(friend) fun update_borrow_index(arg0: &mut 0x1caf0caf6860c2ed8335d7434134902896fa55f374f96323cb92272316238f91::wit_table::WitTable<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = BorrowDynamics{dummy_field: false};
        let v1 = 0x1caf0caf6860c2ed8335d7434134902896fa55f374f96323cb92272316238f91::wit_table::borrow_mut<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>(v0, arg0, arg1);
        if (v1.last_updated == arg2) {
            return
        };
        v1.borrow_index = v1.borrow_index + 0x1::fixed_point32::multiply_u64(v1.borrow_index, 0xa49e119af5217a0c160aa89e9b36194541e2bc9e0b00fb7be6ca4fb1062ea3dd::fixed_point32_empower::mul(0xa49e119af5217a0c160aa89e9b36194541e2bc9e0b00fb7be6ca4fb1062ea3dd::fixed_point32_empower::from_u64(arg2 - v1.last_updated), v1.interest_rate)) / v1.interest_rate_scale;
        v1.last_updated = arg2;
    }

    public(friend) fun update_interest_rate(arg0: &mut 0x1caf0caf6860c2ed8335d7434134902896fa55f374f96323cb92272316238f91::wit_table::WitTable<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>, arg1: 0x1::type_name::TypeName, arg2: 0x1::fixed_point32::FixedPoint32, arg3: u64) {
        let v0 = BorrowDynamics{dummy_field: false};
        let v1 = 0x1caf0caf6860c2ed8335d7434134902896fa55f374f96323cb92272316238f91::wit_table::borrow_mut<BorrowDynamics, 0x1::type_name::TypeName, BorrowDynamic>(v0, arg0, arg1);
        v1.interest_rate = arg2;
        v1.interest_rate_scale = arg3;
    }

    // decompiled from Move bytecode v6
}

