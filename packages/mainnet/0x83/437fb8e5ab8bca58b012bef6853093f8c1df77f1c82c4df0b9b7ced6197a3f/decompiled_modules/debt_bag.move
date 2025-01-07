module 0x83437fb8e5ab8bca58b012bef6853093f8c1df77f1c82c4df0b9b7ced6197a3f::debt_bag {
    struct Info has store {
        asset_type: 0x1::type_name::TypeName,
        share_type: 0x1::type_name::TypeName,
        amount: u128,
    }

    struct DebtBag has store {
        infos: vector<Info>,
        bag: 0x2::bag::Bag,
    }

    public fun empty(arg0: &mut 0x2::tx_context::TxContext) : DebtBag {
        DebtBag{
            infos : 0x1::vector::empty<Info>(),
            bag   : 0x2::bag::new(arg0),
        }
    }

    public fun add<T0, T1>(arg0: &mut DebtBag, arg1: 0x83437fb8e5ab8bca58b012bef6853093f8c1df77f1c82c4df0b9b7ced6197a3f::debt::DebtShareBalance<T1>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x83437fb8e5ab8bca58b012bef6853093f8c1df77f1c82c4df0b9b7ced6197a3f::debt::value_x64<T1>(&arg1) == 0) {
            0x83437fb8e5ab8bca58b012bef6853093f8c1df77f1c82c4df0b9b7ced6197a3f::debt::destroy_zero<T1>(arg1);
            return
        };
        let v1 = get_asset_idx_opt(arg0, &v0);
        if (0x1::option::is_some<u64>(&v1)) {
            let v2 = 0x1::option::destroy_some<u64>(v1);
            let v3 = 0x1::vector::borrow_mut<Info>(&mut arg0.infos, v2);
            assert!(v3.share_type == 0x1::type_name::get<T1>(), 0);
            v3.amount = v3.amount + 0x83437fb8e5ab8bca58b012bef6853093f8c1df77f1c82c4df0b9b7ced6197a3f::debt::value_x64<T1>(&arg1);
            0x83437fb8e5ab8bca58b012bef6853093f8c1df77f1c82c4df0b9b7ced6197a3f::debt::join<T1>(0x2::bag::borrow_mut<u64, 0x83437fb8e5ab8bca58b012bef6853093f8c1df77f1c82c4df0b9b7ced6197a3f::debt::DebtShareBalance<T1>>(&mut arg0.bag, v2), arg1);
        } else {
            assert!(!has_share(arg0, &v0), 0);
            let v4 = Info{
                asset_type : v0,
                share_type : 0x1::type_name::get<T1>(),
                amount     : 0x83437fb8e5ab8bca58b012bef6853093f8c1df77f1c82c4df0b9b7ced6197a3f::debt::value_x64<T1>(&arg1),
            };
            0x1::vector::push_back<Info>(&mut arg0.infos, v4);
            0x2::bag::add<u64, 0x83437fb8e5ab8bca58b012bef6853093f8c1df77f1c82c4df0b9b7ced6197a3f::debt::DebtShareBalance<T1>>(&mut arg0.bag, 0x1::vector::length<Info>(&arg0.infos) - 1, arg1);
        };
    }

    fun get_asset_idx_opt(arg0: &DebtBag, arg1: &0x1::type_name::TypeName) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Info>(&arg0.infos)) {
            if (&0x1::vector::borrow<Info>(&arg0.infos, v0).asset_type == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun get_share_amount_by_asset_type<T0>(arg0: &DebtBag) : u128 {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = get_asset_idx_opt(arg0, &v0);
        if (0x1::option::is_none<u64>(&v1)) {
            return 0
        };
        0x1::vector::borrow<Info>(&arg0.infos, 0x1::option::destroy_some<u64>(v1)).amount
    }

    public fun get_share_amount_by_share_type<T0>(arg0: &DebtBag) : u128 {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = get_share_idx_opt(arg0, &v0);
        if (0x1::option::is_none<u64>(&v1)) {
            return 0
        };
        0x1::vector::borrow<Info>(&arg0.infos, 0x1::option::destroy_some<u64>(v1)).amount
    }

    fun get_share_idx(arg0: &DebtBag, arg1: &0x1::type_name::TypeName) : u64 {
        let v0 = get_share_idx_opt(arg0, arg1);
        assert!(0x1::option::is_some<u64>(&v0), 1);
        0x1::option::destroy_some<u64>(v0)
    }

    fun get_share_idx_opt(arg0: &DebtBag, arg1: &0x1::type_name::TypeName) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Info>(&arg0.infos)) {
            if (&0x1::vector::borrow<Info>(&arg0.infos, v0).share_type == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun get_share_type_for_asset<T0>(arg0: &DebtBag) : 0x1::type_name::TypeName {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = get_asset_idx_opt(arg0, &v0);
        assert!(0x1::option::is_some<u64>(&v1), 1);
        0x1::vector::borrow<Info>(&arg0.infos, 0x1::option::destroy_some<u64>(v1)).share_type
    }

    fun has_share(arg0: &DebtBag, arg1: &0x1::type_name::TypeName) : bool {
        let v0 = get_share_idx_opt(arg0, arg1);
        0x1::option::is_some<u64>(&v0)
    }

    public fun take_all<T0>(arg0: &mut DebtBag) : 0x83437fb8e5ab8bca58b012bef6853093f8c1df77f1c82c4df0b9b7ced6197a3f::debt::DebtShareBalance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = get_share_idx(arg0, &v0);
        let Info {
            asset_type : _,
            share_type : _,
            amount     : _,
        } = 0x1::vector::remove<Info>(&mut arg0.infos, v1);
        0x2::bag::remove<u64, 0x83437fb8e5ab8bca58b012bef6853093f8c1df77f1c82c4df0b9b7ced6197a3f::debt::DebtShareBalance<T0>>(&mut arg0.bag, v1)
    }

    public fun take_amt<T0>(arg0: &mut DebtBag, arg1: u128) : 0x83437fb8e5ab8bca58b012bef6853093f8c1df77f1c82c4df0b9b7ced6197a3f::debt::DebtShareBalance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = get_share_idx(arg0, &v0);
        let v2 = 0x1::vector::borrow_mut<Info>(&mut arg0.infos, v1);
        assert!(arg1 <= v2.amount, 2);
        v2.amount = v2.amount - arg1;
        if (v2.amount == 0) {
            let Info {
                asset_type : _,
                share_type : _,
                amount     : _,
            } = 0x1::vector::remove<Info>(&mut arg0.infos, v1);
            0x83437fb8e5ab8bca58b012bef6853093f8c1df77f1c82c4df0b9b7ced6197a3f::debt::destroy_zero<T0>(0x2::bag::remove<u64, 0x83437fb8e5ab8bca58b012bef6853093f8c1df77f1c82c4df0b9b7ced6197a3f::debt::DebtShareBalance<T0>>(&mut arg0.bag, v1));
        };
        0x83437fb8e5ab8bca58b012bef6853093f8c1df77f1c82c4df0b9b7ced6197a3f::debt::split_x64<T0>(0x2::bag::borrow_mut<u64, 0x83437fb8e5ab8bca58b012bef6853093f8c1df77f1c82c4df0b9b7ced6197a3f::debt::DebtShareBalance<T0>>(&mut arg0.bag, v1), arg1)
    }

    // decompiled from Move bytecode v6
}

