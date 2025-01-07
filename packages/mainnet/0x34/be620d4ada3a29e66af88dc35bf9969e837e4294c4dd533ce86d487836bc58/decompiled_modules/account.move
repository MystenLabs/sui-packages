module 0x34be620d4ada3a29e66af88dc35bf9969e837e4294c4dd533ce86d487836bc58::account {
    struct Account has key {
        id: 0x2::object::UID,
    }

    struct AccountBalance<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public entry fun accept_payment<T0>(arg0: &mut Account, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        let v0 = AccountBalance<T0>{dummy_field: false};
        let v1 = &mut arg0.id;
        if (0x2::dynamic_field::exists_<AccountBalance<T0>>(v1, v0)) {
            0x2::coin::join<T0>(0x2::dynamic_field::borrow_mut<AccountBalance<T0>, 0x2::coin::Coin<T0>>(v1, v0), 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1));
        } else {
            0x2::dynamic_field::add<AccountBalance<T0>, 0x2::coin::Coin<T0>>(v1, v0, 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Account{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Account>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun transfer_account(arg0: Account, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Account>(arg0, arg1);
    }

    public fun withdraw<T0>(arg0: &mut Account, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = AccountBalance<T0>{dummy_field: false};
        let v1 = &mut arg0.id;
        assert!(0x2::dynamic_field::exists_<AccountBalance<T0>>(v1, v0), 1);
        0x2::coin::split<T0>(0x2::dynamic_field::borrow_mut<AccountBalance<T0>, 0x2::coin::Coin<T0>>(v1, v0), arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

