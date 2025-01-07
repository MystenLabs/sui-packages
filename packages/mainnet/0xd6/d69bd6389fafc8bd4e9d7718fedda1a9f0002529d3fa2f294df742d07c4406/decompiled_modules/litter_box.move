module 0xd6d69bd6389fafc8bd4e9d7718fedda1a9f0002529d3fa2f294df742d07c4406::litter_box {
    struct LitterBox has key {
        id: 0x2::object::UID,
        balances: 0x2::bag::Bag,
    }

    struct Cap has key {
        id: 0x2::object::UID,
    }

    struct DumpEvent<phantom T0> has copy, drop {
        amount: u64,
    }

    fun balance_mut<T0>(arg0: &mut LitterBox) : &mut 0x2::balance::Balance<T0> {
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>())
    }

    public fun dump<T0>(arg0: &mut LitterBox, arg1: 0x2::coin::Coin<T0>) {
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T0>())) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>(), 0x2::balance::zero<T0>());
        };
        let v0 = DumpEvent<T0>{amount: 0x2::coin::value<T0>(&arg1)};
        0x2::event::emit<DumpEvent<T0>>(v0);
        0x2::coin::put<T0>(balance_mut<T0>(arg0), arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LitterBox{
            id       : 0x2::object::new(arg0),
            balances : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<LitterBox>(v0);
        let v1 = Cap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Cap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun take_litter<T0>(arg0: &mut LitterBox, arg1: &Cap) : 0x2::balance::Balance<T0> {
        0x2::balance::withdraw_all<T0>(balance_mut<T0>(arg0))
    }

    // decompiled from Move bytecode v6
}

