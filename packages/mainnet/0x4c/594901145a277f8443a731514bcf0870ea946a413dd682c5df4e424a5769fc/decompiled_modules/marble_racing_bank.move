module 0x4c594901145a277f8443a731514bcf0870ea946a413dd682c5df4e424a5769fc::marble_racing_bank {
    struct MarbleRacingBank<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<T0>,
    }

    public(friend) fun get_from_bank<T0>(arg0: &mut MarbleRacingBank<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.pool, arg1)
    }

    public(friend) fun new_bank<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarbleRacingBank<T0>{
            id   : 0x2::object::new(arg0),
            pool : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<MarbleRacingBank<T0>>(v0);
    }

    public(friend) fun put_to_bank<T0>(arg0: &mut MarbleRacingBank<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.pool, 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun withdraw_from_bank<T0>(arg0: address, arg1: &mut MarbleRacingBank<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.pool, 0x2::balance::value<T0>(&arg1.pool)), arg2), arg0);
    }

    // decompiled from Move bytecode v6
}

