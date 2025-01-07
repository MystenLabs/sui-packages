module 0x7a6a0d7178c1cbc70e2c8c6c0c251adc350f08ad129ed566bbb15e1053c77105::proceeds {
    struct Proceeds has store, key {
        id: 0x2::object::UID,
    }

    public fun balance<T0>(arg0: &Proceeds) : &0x2::balance::Balance<T0> {
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, 0x1::type_name::get<T0>())
    }

    public(friend) fun add<T0>(arg0: &mut Proceeds, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0)) {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, arg1);
        } else {
            0x2::balance::join<T0>(balance_mut<T0>(arg0), arg1);
        };
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : Proceeds {
        Proceeds{id: 0x2::object::new(arg0)}
    }

    fun balance_mut<T0>(arg0: &mut Proceeds) : &mut 0x2::balance::Balance<T0> {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>())
    }

    public(friend) fun collect<T0>(arg0: &mut Proceeds, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::balance::withdraw_all<T0>(balance_mut<T0>(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg2), arg1);
        0x2::balance::value<T0>(&v0)
    }

    // decompiled from Move bytecode v6
}

