module 0x35cb07c876fab777bffa1e3f9faa3df82190540bf4dd5e481c02945ea2b9deac::swap {
    struct Bank<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin1: 0x2::balance::Balance<T0>,
        coin2: 0x2::balance::Balance<T1>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun create_bank<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank<T0, T1>{
            id    : 0x2::object::new(arg0),
            coin1 : 0x2::balance::zero<T0>(),
            coin2 : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::share_object<Bank<T0, T1>>(v0);
    }

    fun deposit<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun deposit_coin1<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.coin1;
        deposit<T0>(v0, arg1);
    }

    public entry fun deposit_coin2<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.coin2;
        deposit<T1>(v0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_1_2<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.coin1;
        deposit<T0>(v0, arg1);
        let v1 = &mut arg0.coin2;
        withdraw<T1>(v1, 0x2::coin::value<T0>(&arg1) * 73 / 10, arg2);
    }

    public entry fun swap_2_1<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.coin2;
        deposit<T1>(v0, arg1);
        let v1 = &mut arg0.coin1;
        withdraw<T0>(v1, 0x2::coin::value<T1>(&arg1) * 10 / 73, arg2);
    }

    fun withdraw<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_coin1<T0, T1>(arg0: &AdminCap, arg1: &mut Bank<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.coin1;
        withdraw<T0>(v0, arg2, arg3);
    }

    public entry fun withdraw_coin2<T0, T1>(arg0: &AdminCap, arg1: &mut Bank<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.coin2;
        withdraw<T1>(v0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

