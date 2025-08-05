module 0xdbd297a04b3399d4ded18ac862cacbbc19855de56b0c908476bb508d96a37c1e::treasury {
    struct Treasury has key {
        id: 0x2::object::UID,
        vaults: 0x2::bag::Bag,
    }

    public fun deposit<T0>(arg0: &0xdbd297a04b3399d4ded18ac862cacbbc19855de56b0c908476bb508d96a37c1e::admin_cap::AdminCap, arg1: &mut Treasury, arg2: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.vaults, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.vaults, v0), arg2);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.vaults, v0, arg2);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id     : 0x2::object::new(arg0),
            vaults : 0x2::bag::new(arg0),
        };
        0x2::transfer::transfer<Treasury>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun withdraw<T0>(arg0: &0xdbd297a04b3399d4ded18ac862cacbbc19855de56b0c908476bb508d96a37c1e::admin_cap::AdminCap, arg1: &mut Treasury, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg1.vaults, v0)) {
            abort 20
        };
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.vaults, v0);
        if (0x2::balance::value<T0>(v1) < arg2) {
            abort 20
        };
        0x2::balance::split<T0>(v1, arg2)
    }

    // decompiled from Move bytecode v6
}

