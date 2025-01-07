module 0x671e87284f63651435486ba80f062222900ba1e890aeb5a076afd4b4608b3b27::assets {
    struct Account has key {
        id: 0x2::object::UID,
    }

    struct AccountBalance<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun accept_payment<T0>(arg0: &mut Account, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        let v0 = AccountBalance<T0>{dummy_field: false};
        let v1 = &mut arg0.id;
        if (0x2::dynamic_field::exists_<AccountBalance<T0>>(v1, v0)) {
            0x2::coin::join<T0>(0x2::dynamic_field::borrow_mut<AccountBalance<T0>, 0x2::coin::Coin<T0>>(v1, v0), 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1));
        } else {
            0x2::dynamic_field::add<AccountBalance<T0>, 0x2::coin::Coin<T0>>(v1, v0, 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1));
        };
    }

    public fun withdraw<T0>(arg0: &mut Account, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = AccountBalance<T0>{dummy_field: false};
        let v1 = &mut arg0.id;
        assert!(0x2::dynamic_field::exists_<AccountBalance<T0>>(v1, v0), 1);
        0x2::coin::split<T0>(0x2::dynamic_field::borrow_mut<AccountBalance<T0>, 0x2::coin::Coin<T0>>(v1, v0), arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

