module 0xf5f7029970718c094119acdfc9cbc3b8c981a6cd2aa077ae30b68e85e1e870f::vault {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        bal: 0x2::balance::Balance<T0>,
    }

    public(friend) fun borrow_mut<T0>(arg0: &mut Vault<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.bal
    }

    public fun value<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.bal)
    }

    public fun create<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id  : 0x2::object::new(arg0),
            bal : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::transfer<Vault<T0>>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.bal, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bal, arg1), arg2)
    }

    // decompiled from Move bytecode v7
}

