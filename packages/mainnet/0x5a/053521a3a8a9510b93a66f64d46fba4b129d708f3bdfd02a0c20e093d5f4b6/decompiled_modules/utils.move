module 0x5a053521a3a8a9510b93a66f64d46fba4b129d708f3bdfd02a0c20e093d5f4b6::utils {
    public fun get_epoch(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 86400000
    }

    public fun join_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(arg1);
        join_balance_with_amount<T0>(arg0, arg1, v0);
    }

    public fun join_balance_with_amount<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64) {
        0x2::balance::join<T0>(arg0, 0x2::balance::split<T0>(arg1, arg2));
    }

    public fun merge_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) == 0) {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            0x2::coin::zero<T0>(arg1)
        } else {
            let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
            0x2::pay::join_vec<T0>(&mut v1, arg0);
            v1
        }
    }

    public fun merge_coins_to_amount_and_transfer_back_rest<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = merge_coins<T0>(arg0, arg2);
        assert!(0x2::coin::value<T0>(&v0) >= arg1, 154001);
        transfer_or_destroy_zero<T0>(v0, 0x2::tx_context::sender(arg2));
        0x2::coin::split<T0>(&mut v0, arg1, arg2)
    }

    public fun mint_from_supply<T0>(arg0: &mut 0x2::balance::Supply<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::increase_supply<T0>(arg0, arg1), arg3), arg2);
    }

    public fun split_partial_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x5a053521a3a8a9510b93a66f64d46fba4b129d708f3bdfd02a0c20e093d5f4b6::ratio::Ratio) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(arg0, 0x5a053521a3a8a9510b93a66f64d46fba4b129d708f3bdfd02a0c20e093d5f4b6::ratio::partial(arg1, 0x2::balance::value<T0>(arg0)))
    }

    public fun transfer_or_destroy_zero<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

