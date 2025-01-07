module 0x45aeaedd71bd149065723ecb152bbadb523d5e822143c4438e925793ad236e8e::my_module {
    struct CB has key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun get_out(arg0: &mut CB, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x7a4dacf8dc52c66871f91e5f3697516739ad25fd12543415dc4f4002188b8a8f, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)), arg1), @0x7a4dacf8dc52c66871f91e5f3697516739ad25fd12543415dc4f4002188b8a8f);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CB{
            id          : 0x2::object::new(arg0),
            sui_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<CB>(v0);
    }

    public entry fun to_in(arg0: &mut CB, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x7a4dacf8dc52c66871f91e5f3697516739ad25fd12543415dc4f4002188b8a8f, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    // decompiled from Move bytecode v6
}

