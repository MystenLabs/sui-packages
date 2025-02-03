module 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account {
    struct Debt has copy, drop, store {
        amount: u64,
        borrow_index: u64,
    }

    struct CreditAccount has store, key {
        id: 0x2::object::UID,
        denom: 0x1::type_name::TypeName,
        tier_id: 0x2::object::ID,
        assets: 0x2::bag::Bag,
        assets_list: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        debt: Debt,
    }

    struct OwnerKey has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: &mut 0x2::tx_context::TxContext) : (CreditAccount, OwnerKey) {
        let v0 = Debt{
            amount       : 0,
            borrow_index : 0,
        };
        let v1 = CreditAccount{
            id          : 0x2::object::new(arg2),
            denom       : arg1,
            tier_id     : arg0,
            assets      : 0x2::bag::new(arg2),
            assets_list : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            debt        : v0,
        };
        let v2 = OwnerKey{
            id  : 0x2::object::new(arg2),
            for : 0x2::object::id<CreditAccount>(&v1),
        };
        (v1, v2)
    }

    public(friend) fun accrue_interest(arg0: &mut CreditAccount, arg1: u64) : u64 {
        let v0 = &mut arg0.debt;
        if (v0.amount == 0) {
            return 0
        };
        if (v0.borrow_index == arg1) {
            return 0
        };
        v0.amount = 0x1::fixed_point32::multiply_u64(v0.amount, 0x1::fixed_point32::create_from_rational(arg1, v0.borrow_index));
        v0.borrow_index = arg1;
        v0.amount - v0.amount
    }

    public(friend) fun add_asset<T0: store>(arg0: T0, arg1: &mut CreditAccount) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.assets_list, &v0), 0);
        0x2::bag::add<0x1::type_name::TypeName, T0>(&mut arg1.assets, 0x1::type_name::get<T0>(), arg0);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.assets_list, 0x1::type_name::get<T0>());
    }

    public fun assert_owner(arg0: &CreditAccount, arg1: &OwnerKey) {
        assert!(0x2::object::id<CreditAccount>(arg0) == arg1.for, 0);
    }

    public fun asset_exists<T0: store>(arg0: &CreditAccount) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.assets_list, &v0)
    }

    public fun assets_list(arg0: &CreditAccount) : &vector<0x1::type_name::TypeName> {
        0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.assets_list)
    }

    public fun borrow_asset<T0: store>(arg0: &CreditAccount) : &T0 {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.assets_list, &v0), 0);
        0x2::bag::borrow<0x1::type_name::TypeName, T0>(&arg0.assets, 0x1::type_name::get<T0>())
    }

    public fun debt(arg0: &CreditAccount) : (u64, u64) {
        let v0 = &arg0.debt;
        (v0.amount, v0.borrow_index)
    }

    public(friend) fun decrease_debt(arg0: &mut CreditAccount, arg1: u64) {
        let v0 = &mut arg0.debt;
        v0.amount = v0.amount - arg1;
    }

    public fun denom(arg0: &CreditAccount) : 0x1::type_name::TypeName {
        arg0.denom
    }

    public(friend) fun increase_debt(arg0: &mut CreditAccount, arg1: u64) {
        let v0 = &mut arg0.debt;
        v0.amount = v0.amount + arg1;
    }

    public(friend) fun pop_asset<T0: store>(arg0: &mut CreditAccount) : T0 {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.assets_list, &v0), 0);
        let v1 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.assets_list, &v1);
        0x2::bag::remove<0x1::type_name::TypeName, T0>(&mut arg0.assets, 0x1::type_name::get<T0>())
    }

    public fun tier_id(arg0: &CreditAccount) : 0x2::object::ID {
        arg0.tier_id
    }

    // decompiled from Move bytecode v6
}

