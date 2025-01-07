module 0x28a208bc3bc2de8c1055900b15866a3190e5ee49e90bcc7635cafb131edfdbe1::whdevlab_swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Bank<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        a: 0x2::balance::Balance<T0>,
        b: 0x2::balance::Balance<T1>,
    }

    public entry fun create<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank<T0, T1>{
            id : 0x2::object::new(arg0),
            a  : 0x2::balance::zero<T0>(),
            b  : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::share_object<Bank<T0, T1>>(v0);
    }

    public entry fun deposit_a<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.a, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun deposit_b<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.b, 0x2::coin::into_balance<T1>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_a_b<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.a, 0x2::coin::into_balance<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.b, 0x2::coin::value<T0>(&arg1)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_b_a<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.b, 0x2::coin::into_balance<T1>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.a, 0x2::coin::value<T1>(&arg1)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_a<T0, T1>(arg0: &AdminCap, arg1: &mut Bank<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.a, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_b<T0, T1>(arg0: &AdminCap, arg1: &mut Bank<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.b, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

