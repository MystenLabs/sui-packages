module 0xde37a18084a93604696a906318038194fac9e0836cfc74b7c22907afa966ea72::treasury {
    struct TREASURY has drop {
        dummy_field: bool,
    }

    struct Treasury has store, key {
        id: 0x2::object::UID,
        version: u64,
        funds: 0x2::bag::Bag,
    }

    public fun assert_interacting_with_most_up_to_date_package(arg0: &Treasury) {
        assert!(arg0.version == 1, 0);
    }

    public(friend) fun create_treasury(arg0: &TREASURY, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<TREASURY>(arg0), 1);
        let v0 = Treasury{
            id      : 0x2::object::new(arg1),
            version : 1,
            funds   : 0x2::bag::new(arg1),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public fun deposit<T0>(arg0: &mut Treasury, arg1: 0x2::coin::Coin<T0>) {
        assert_interacting_with_most_up_to_date_package(arg0);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.funds, v0)) {
            0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.funds, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.funds, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    fun init(arg0: TREASURY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        create_treasury(&arg0, arg1);
        0x2::transfer::public_transfer<0xde37a18084a93604696a906318038194fac9e0836cfc74b7c22907afa966ea72::admin::AdminCap>(0xde37a18084a93604696a906318038194fac9e0836cfc74b7c22907afa966ea72::admin::create_admin_cap<TREASURY>(&arg0, arg1), v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<TREASURY>(arg0, arg1), v0);
    }

    public fun move_to_bag<T0>(arg0: &mut Treasury, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1);
        deposit<T0>(arg0, v0);
    }

    public fun move_to_bag_unsafe<T0>(arg0: &mut Treasury, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        assert_interacting_with_most_up_to_date_package(arg0);
        0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.funds, 0x1::type_name::get<T0>()), 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1));
    }

    public fun receive<T0>(arg0: &Treasury, arg1: 0x2::coin::Coin<T0>) {
        assert_interacting_with_most_up_to_date_package(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::object::uid_to_address(&arg0.id));
    }

    public fun withdrawable_balance_of<T0>(arg0: &Treasury) : u64 {
        assert_interacting_with_most_up_to_date_package(arg0);
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.funds, 0x1::type_name::get<T0>()))
    }

    // decompiled from Move bytecode v6
}

