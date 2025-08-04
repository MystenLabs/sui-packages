module 0x1d287021e4afd4fc561e888fc10620dc05e3c71b32fb1693975654780df9cd64::marble_racing_bank {
    struct MarbleRacingBank<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<T0>,
    }

    struct BankCap has store, key {
        id: 0x2::object::UID,
        original_id_cap: 0x2::object::ID,
    }

    struct BankConfig has store, key {
        id: 0x2::object::UID,
        managers: 0x2::vec_set::VecSet<address>,
    }

    public(friend) fun get_from_bank<T0>(arg0: &mut MarbleRacingBank<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.pool, arg1)
    }

    public(friend) fun new_bank<T0>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = BankCap{
            id              : v0,
            original_id_cap : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::public_transfer<BankCap>(v1, arg0);
        let v2 = BankConfig{
            id       : 0x2::object::new(arg1),
            managers : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<BankConfig>(v2);
        let v3 = MarbleRacingBank<T0>{
            id   : 0x2::object::new(arg1),
            pool : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<MarbleRacingBank<T0>>(v3);
    }

    public(friend) fun put_to_bank<T0>(arg0: &mut MarbleRacingBank<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.pool, 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun withdraw_from_bank<T0>(arg0: address, arg1: &mut MarbleRacingBank<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.pool, 0x2::balance::value<T0>(&arg1.pool)), arg2), arg0);
    }

    // decompiled from Move bytecode v6
}

