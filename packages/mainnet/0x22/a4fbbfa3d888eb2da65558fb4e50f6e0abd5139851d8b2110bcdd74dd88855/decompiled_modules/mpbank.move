module 0x22a4fbbfa3d888eb2da65558fb4e50f6e0abd5139851d8b2110bcdd74dd88855::mpbank {
    struct MPBANK has drop {
        dummy_field: bool,
    }

    struct Bank<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    entry fun add_to_bank<T0>(arg0: &mut Bank<T0>, arg1: 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    entry fun create_bank<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<MPBANK>(arg0), 1);
        let v0 = Bank<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::public_share_object<Bank<T0>>(v0);
    }

    fun init(arg0: MPBANK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<MPBANK>(arg0, arg1);
    }

    entry fun remove_from_bank<T0>(arg0: &0x2::package::Publisher, arg1: &mut Bank<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<MPBANK>(arg0), 1);
        let v0 = 0x2::balance::value<T0>(&arg1.balance);
        assert!(v0 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, v0, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

