module 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::plan {
    struct SalePlan<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        plans: vector<Plan>,
        beneficiary: 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::financial::Beneficiary,
    }

    struct Plan has store {
        plan_name: 0x1::string::String,
        price: u64,
        start_at: u64,
        end_at: u64,
        does_whitelist: bool,
        whitelist: 0x1::option::Option<0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::whitelist::Whitelist>,
        record: 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::record::SaleRecord,
        unlimited_max_amount_this_plan: bool,
        max_amount_this_plan: u64,
        unlimited_max_mint_amount_per_address: bool,
        max_mint_amount_per_address: u64,
        already_mint_amount_this_plan: u64,
    }

    public entry fun add_plan<T0, T1>(arg0: &0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::administrate::AdminCap<T0>, arg1: &mut SalePlan<T0, T1>, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u8, arg8: bool, arg9: u64, arg10: bool, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::whitelist::Whitelist>();
        if (arg6) {
            0x1::option::fill<0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::whitelist::Whitelist>(&mut v0, 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::whitelist::create_whitelist(arg7));
        };
        let v1 = Plan{
            plan_name                             : arg2,
            price                                 : arg3,
            start_at                              : arg4,
            end_at                                : arg5,
            does_whitelist                        : arg6,
            whitelist                             : v0,
            record                                : 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::record::create_sale_record(arg12),
            unlimited_max_amount_this_plan        : arg8,
            max_amount_this_plan                  : arg9,
            unlimited_max_mint_amount_per_address : arg10,
            max_mint_amount_per_address           : arg11,
            already_mint_amount_this_plan         : 0,
        };
        0x1::vector::push_back<Plan>(&mut arg1.plans, v1);
    }

    public entry fun add_pubkey_into_whitelist<T0, T1>(arg0: &0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::administrate::AdminCap<T0>, arg1: &mut SalePlan<T0, T1>, arg2: u64, arg3: vector<u8>) {
        let v0 = 0x1::vector::borrow_mut<Plan>(&mut arg1.plans, arg2);
        if (!v0.does_whitelist) {
            abort 0
        };
        0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::whitelist::add_pubkey_into_offchain_whitelist(0x1::option::borrow_mut<0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::whitelist::Whitelist>(&mut v0.whitelist), arg3);
    }

    public entry fun add_pubkey_into_whitelist_by_admin<T0, T1>(arg0: &0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::permission::Permission, arg1: &mut SalePlan<T0, T1>, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::permission::check_permission(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x1::vector::borrow_mut<Plan>(&mut arg1.plans, arg2);
        if (!v0.does_whitelist) {
            abort 0
        };
        assert!(0x1::option::is_some<0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::whitelist::Whitelist>(&v0.whitelist), 1);
        0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::whitelist::add_pubkey_into_offchain_whitelist(0x1::option::borrow_mut<0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::whitelist::Whitelist>(&mut v0.whitelist), arg3);
    }

    public(friend) fun borrow_beneficiary_mut<T0, T1>(arg0: &mut SalePlan<T0, T1>) : &mut 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::financial::Beneficiary {
        &mut arg0.beneficiary
    }

    public fun check_whitelist<T0, T1>(arg0: address, arg1: &SalePlan<T0, T1>, arg2: u64, arg3: &vector<u8>) {
        let v0 = 0x1::vector::borrow<Plan>(&arg1.plans, arg2);
        if (v0.does_whitelist) {
            let v1 = 0x1::option::borrow<0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::whitelist::Whitelist>(&v0.whitelist);
            let v2 = 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::whitelist::get_whitelist_type(v1);
            if (v2 == 2) {
                let v3 = 0x2::object::id_bytes<SalePlan<T0, T1>>(arg1);
                0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<address>(&arg0));
                0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg2));
                0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::whitelist::check_offchain(v1, &v3, arg3);
            } else if (v2 == 1) {
                0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::whitelist::check_onchain(v1, arg0);
            };
        };
    }

    public fun check_with_plan<T0, T1>(arg0: &SalePlan<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow<Plan>(&arg0.plans, arg1);
        if (!v0.unlimited_max_amount_this_plan) {
            assert!(v0.max_amount_this_plan >= v0.already_mint_amount_this_plan + arg2, 4);
        };
        if (!v0.unlimited_max_mint_amount_per_address) {
            0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::record::check(&v0.record, arg2, v0.max_mint_amount_per_address, 0x2::tx_context::sender(arg4));
        };
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(v0.start_at <= v1, 2);
        assert!(v0.end_at > v1, 3);
    }

    public entry fun create_sale_plan<T0, T1>(arg0: &0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::administrate::AdminCap<T0>, arg1: u8, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SalePlan<T0, T1>{
            id          : 0x2::object::new(arg4),
            plans       : 0x1::vector::empty<Plan>(),
            beneficiary : 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::financial::create_beneficiary_shared(arg1, arg2, arg3),
        };
        0x2::transfer::share_object<SalePlan<T0, T1>>(v0);
    }

    public fun does_whitelist<T0, T1>(arg0: &SalePlan<T0, T1>, arg1: u64) : bool {
        0x1::vector::borrow<Plan>(&arg0.plans, arg1).does_whitelist
    }

    public fun get_plan_price<T0, T1>(arg0: &SalePlan<T0, T1>, arg1: u64) : u64 {
        0x1::vector::borrow<Plan>(&arg0.plans, arg1).price
    }

    public(friend) fun increase_sale_plan_counter<T0, T1>(arg0: &mut SalePlan<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<Plan>(&mut arg0.plans, arg1);
        v0.already_mint_amount_this_plan = v0.already_mint_amount_this_plan + arg2;
        0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::record::increase_record(&mut v0.record, arg2, 0x2::tx_context::sender(arg3));
    }

    public fun update_plan_max_amount<T0, T1>(arg0: &0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::administrate::AdminCap<T0>, arg1: &mut SalePlan<T0, T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x1::vector::borrow_mut<Plan>(&mut arg1.plans, arg2).max_amount_this_plan = arg3;
    }

    public fun update_plan_max_amount_by_admin<T0, T1>(arg0: &0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::permission::Permission, arg1: &mut SalePlan<T0, T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::permission::check_permission(arg0, 0x2::tx_context::sender(arg4));
        0x1::vector::borrow_mut<Plan>(&mut arg1.plans, arg2).max_amount_this_plan = arg3;
    }

    public fun update_plan_max_amount_per_address<T0, T1>(arg0: &0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::administrate::AdminCap<T0>, arg1: &mut SalePlan<T0, T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x1::vector::borrow_mut<Plan>(&mut arg1.plans, arg2).max_mint_amount_per_address = arg3;
    }

    public fun update_plan_max_amount_per_address_by_amdin<T0, T1>(arg0: &0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::permission::Permission, arg1: &mut SalePlan<T0, T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::permission::check_permission(arg0, 0x2::tx_context::sender(arg4));
        0x1::vector::borrow_mut<Plan>(&mut arg1.plans, arg2).max_mint_amount_per_address = arg3;
    }

    public fun update_plan_name<T0, T1>(arg0: &0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::administrate::AdminCap<T0>, arg1: &mut SalePlan<T0, T1>, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x1::vector::borrow_mut<Plan>(&mut arg1.plans, arg2).plan_name = arg3;
    }

    public fun update_plan_name_by_admin<T0, T1>(arg0: &0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::permission::Permission, arg1: &mut SalePlan<T0, T1>, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::permission::check_permission(arg0, 0x2::tx_context::sender(arg4));
        0x1::vector::borrow_mut<Plan>(&mut arg1.plans, arg2).plan_name = arg3;
    }

    public fun update_plan_price<T0, T1>(arg0: &0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::administrate::AdminCap<T0>, arg1: &mut SalePlan<T0, T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x1::vector::borrow_mut<Plan>(&mut arg1.plans, arg2).price = arg3;
    }

    public fun update_plan_price_by_admin<T0, T1>(arg0: &0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::permission::Permission, arg1: &mut SalePlan<T0, T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::permission::check_permission(arg0, 0x2::tx_context::sender(arg4));
        0x1::vector::borrow_mut<Plan>(&mut arg1.plans, arg2).price = arg3;
    }

    public fun update_plan_sale_time<T0, T1>(arg0: &0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::administrate::AdminCap<T0>, arg1: &mut SalePlan<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<Plan>(&mut arg1.plans, arg2);
        v0.start_at = arg3;
        v0.end_at = arg4;
    }

    public fun update_plan_sale_time_by_amin<T0, T1>(arg0: &0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::permission::Permission, arg1: &mut SalePlan<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::permission::check_permission(arg0, 0x2::tx_context::sender(arg5));
        let v0 = 0x1::vector::borrow_mut<Plan>(&mut arg1.plans, arg2);
        v0.start_at = arg3;
        v0.end_at = arg4;
    }

    // decompiled from Move bytecode v6
}

