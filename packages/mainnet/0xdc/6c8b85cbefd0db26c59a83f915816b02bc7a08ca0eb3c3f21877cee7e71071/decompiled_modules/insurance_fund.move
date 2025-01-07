module 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund {
    struct AdminReceipt<phantom T0, phantom T1> {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct InsuranceFund has key {
        id: 0x2::object::UID,
        version: u64,
        funds: 0x2::bag::Bag,
    }

    public fun transfer(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun admin_deposit<T0, T1>(arg0: &AdminCap, arg1: &mut InsuranceFund, arg2: AdminReceipt<T0, T1>, arg3: 0x2::coin::Coin<T0>) {
        assert_version(arg1);
        let AdminReceipt {  } = arg2;
        deposit<T0>(arg1, arg3);
    }

    public fun admin_withdraw<T0, T1>(arg0: &AdminCap, arg1: &mut InsuranceFund, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, AdminReceipt<T0, T1>) {
        assert_version(arg1);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg1.funds, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.funds, v0);
        assert!(arg2 <= 0x2::balance::value<T1>(v1), 2);
        let v2 = AdminReceipt<T0, T1>{dummy_field: false};
        (0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v1, arg2), arg3), v2)
    }

    public fun assert_version(arg0: &InsuranceFund) {
        assert!(arg0.version == 1, 0);
    }

    public fun balance_of<T0>(arg0: &mut InsuranceFund) : u64 {
        assert_version(arg0);
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.funds, 0x1::type_name::get<T0>()))
    }

    public fun deposit<T0>(arg0: &mut InsuranceFund, arg1: 0x2::coin::Coin<T0>) {
        assert_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.funds, v0)) {
            0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.funds, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.funds, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InsuranceFund{
            id      : 0x2::object::new(arg0),
            version : 1,
            funds   : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<InsuranceFund>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

