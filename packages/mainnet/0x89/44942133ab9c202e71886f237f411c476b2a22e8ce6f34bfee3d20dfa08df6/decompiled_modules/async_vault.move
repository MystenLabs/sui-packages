module 0x8944942133ab9c202e71886f237f411c476b2a22e8ce6f34bfee3d20dfa08df6::async_vault {
    struct AsyncVault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        deposits_open: bool,
    }

    public(friend) fun create_vault<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AsyncVault<T0, T1>{
            id            : 0x2::object::new(arg0),
            deposits_open : true,
        };
        0x2::transfer::share_object<AsyncVault<T0, T1>>(v0);
    }

    public fun deposits_open<T0, T1>(arg0: &AsyncVault<T0, T1>) : bool {
        arg0.deposits_open
    }

    public(friend) fun toggle_deposits<T0, T1>(arg0: &mut AsyncVault<T0, T1>, arg1: bool) {
        arg0.deposits_open = arg1;
    }

    public(friend) fun uid<T0, T1>(arg0: &mut AsyncVault<T0, T1>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

