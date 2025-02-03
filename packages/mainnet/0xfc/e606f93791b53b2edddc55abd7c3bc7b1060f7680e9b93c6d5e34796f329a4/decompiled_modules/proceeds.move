module 0xfce606f93791b53b2edddc55abd7c3bc7b1060f7680e9b93c6d5e34796f329a4::proceeds {
    struct Proceeds has store, key {
        id: 0x2::object::UID,
        qt_sold: QtSold,
    }

    struct QtSold has copy, drop, store {
        collected: u64,
        total: u64,
    }

    public fun empty(arg0: &mut 0x2::tx_context::TxContext) : Proceeds {
        let v0 = QtSold{
            collected : 0,
            total     : 0,
        };
        Proceeds{
            id      : 0x2::object::new(arg0),
            qt_sold : v0,
        }
    }

    public fun balance<T0>(arg0: &Proceeds) : &0x2::balance::Balance<T0> {
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, 0x1::type_name::get<T0>())
    }

    public(friend) fun add<T0>(arg0: &mut Proceeds, arg1: 0x2::balance::Balance<T0>, arg2: u64) {
        arg0.qt_sold.total = arg0.qt_sold.total + arg2;
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0)) {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, arg1);
        } else {
            0x2::balance::join<T0>(balance_mut<T0>(arg0), arg1);
        };
    }

    fun balance_mut<T0>(arg0: &mut Proceeds) : &mut 0x2::balance::Balance<T0> {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>())
    }

    public(friend) fun collect_with_fees<T0>(arg0: &mut Proceeds, arg1: u64, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = balance_mut<T0>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg4), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, 0x2::balance::value<T0>(v0)), arg4), arg3);
    }

    public(friend) fun collect_without_fees<T0>(arg0: &mut Proceeds, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = balance_mut<T0>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, 0x2::balance::value<T0>(v0)), arg2), arg1);
    }

    public fun collected(arg0: &Proceeds) : u64 {
        arg0.qt_sold.collected
    }

    public fun total(arg0: &Proceeds) : u64 {
        arg0.qt_sold.total
    }

    // decompiled from Move bytecode v6
}

