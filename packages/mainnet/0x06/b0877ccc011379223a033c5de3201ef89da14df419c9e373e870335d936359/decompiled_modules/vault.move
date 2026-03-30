module 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        tag: vector<u8>,
        balance: 0x2::balance::Balance<T0>,
        suspended: bool,
    }

    public fun assert_status<T0>(arg0: &Vault<T0>) {
        assert!(arg0.suspended == false, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::Is_suspended());
    }

    public fun balance_value<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public(friend) fun borrow_balance_mut<T0>(arg0: &mut Vault<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.balance
    }

    public(friend) fun create<T0>(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : Vault<T0> {
        Vault<T0>{
            id        : 0x2::object::new(arg1),
            tag       : arg0,
            balance   : 0x2::balance::zero<T0>(),
            suspended : false,
        }
    }

    fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>) : u64 {
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun deposit_balance<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>) : u64 {
        deposit<T0>(arg0, arg1)
    }

    public fun deposit_coin<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) : u64 {
        deposit<T0>(arg0, 0x2::coin::into_balance<T0>(arg1))
    }

    public(friend) fun share_vault<T0>(arg0: Vault<T0>) {
        0x2::transfer::share_object<Vault<T0>>(arg0);
    }

    fun take_balance<T0>(arg0: &mut Vault<T0>, arg1: 0x1::option::Option<u64>) : 0x2::balance::Balance<T0> {
        let v0 = if (0x1::option::is_some<u64>(&arg1)) {
            0x1::option::destroy_some<u64>(arg1)
        } else {
            0x2::balance::value<T0>(&arg0.balance)
        };
        if (v0 > 0) {
            assert!(0x2::balance::value<T0>(&arg0.balance) >= v0, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::insufficient_vault_balance());
            0x2::balance::split<T0>(&mut arg0.balance, v0)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    public(friend) fun transfer_to_address<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = take_balance<T0>(arg0, arg2);
        if (0x2::balance::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg3), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
    }

    public(friend) fun transfer_to_vault<T0>(arg0: &mut Vault<T0>, arg1: &mut Vault<T0>, arg2: 0x1::option::Option<u64>) {
        0x2::balance::join<T0>(&mut arg1.balance, take_balance<T0>(arg0, arg2));
    }

    public(friend) fun update_status<T0>(arg0: &mut Vault<T0>, arg1: bool) {
        arg0.suspended = arg1;
    }

    public(friend) fun update_tag<T0>(arg0: &mut Vault<T0>, arg1: vector<u8>) {
        arg0.tag = arg1;
    }

    public(friend) fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(take_balance<T0>(arg0, 0x1::option::some<u64>(arg1)), arg2)
    }

    // decompiled from Move bytecode v6
}

