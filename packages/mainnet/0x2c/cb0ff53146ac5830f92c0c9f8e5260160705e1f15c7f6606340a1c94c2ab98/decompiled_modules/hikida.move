module 0x2ccb0ff53146ac5830f92c0c9f8e5260160705e1f15c7f6606340a1c94c2ab98::hikida {
    fun receive_balance_impl<T0>(arg0: &mut 0x2::object::UID, arg1: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&arg1)) {
            0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(arg0, 0x1::vector::pop_back<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&mut arg1))));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(arg1);
        v0
    }

    public fun receive_coins_and_send_funds<T0>(arg0: &mut 0x2::object::UID, arg1: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg2: address) : u64 {
        let v0 = receive_balance_impl<T0>(arg0, arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return 0
        };
        0x2::balance::send_funds<T0>(v0, arg2);
        v1
    }

    public fun receive_coins_as_balance<T0>(arg0: &mut 0x2::object::UID, arg1: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>) : 0x2::balance::Balance<T0> {
        receive_balance_impl<T0>(arg0, arg1)
    }

    public fun redeem_balance<T0>(arg0: &mut 0x2::object::UID, arg1: u64) : 0x2::balance::Balance<T0> {
        redeem_balance_impl<T0>(arg0, arg1)
    }

    public fun redeem_balance_and_send_funds<T0>(arg0: &mut 0x2::object::UID, arg1: u64, arg2: address) : u64 {
        if (arg1 == 0) {
            return 0
        };
        0x2::balance::send_funds<T0>(redeem_balance_impl<T0>(arg0, arg1), arg2);
        arg1
    }

    fun redeem_balance_impl<T0>(arg0: &mut 0x2::object::UID, arg1: u64) : 0x2::balance::Balance<T0> {
        if (arg1 == 0) {
            return 0x2::balance::zero<T0>()
        };
        0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(arg0, arg1))
    }

    public fun redeem_settled_balance<T0>(arg0: &mut 0x2::object::UID, arg1: &0x2::accumulator::AccumulatorRoot) : 0x2::balance::Balance<T0> {
        let v0 = settled_balance_value<T0>(arg0, arg1);
        redeem_balance_impl<T0>(arg0, v0)
    }

    public fun redeem_settled_balance_and_send_funds<T0>(arg0: &mut 0x2::object::UID, arg1: &0x2::accumulator::AccumulatorRoot, arg2: address) : u64 {
        let v0 = settled_balance_value<T0>(arg0, arg1);
        redeem_balance_and_send_funds<T0>(arg0, v0, arg2)
    }

    public fun settled_balance_value<T0>(arg0: &0x2::object::UID, arg1: &0x2::accumulator::AccumulatorRoot) : u64 {
        0x2::balance::settled_funds_value<T0>(arg1, 0x2::object::uid_to_address(arg0))
    }

    // decompiled from Move bytecode v7
}

