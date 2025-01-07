module 0x37816d28c34cc0df82655ca97b3f066112a5f3c202cbb4aaa76c8af54e779750::utils {
    public fun extract_balance<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::zero<T0>();
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            if (arg1 > 0) {
                let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
                if (0x2::coin::value<T0>(&v1) >= arg1) {
                    0x2::balance::join<T0>(&mut v0, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut v1), arg1));
                    0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut arg0, v1);
                    arg1 = 0;
                    break
                };
                arg1 = arg1 - 0x2::coin::value<T0>(&v1);
                0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(v1));
            } else {
                break
            };
        };
        assert!(arg1 == 0, 0);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0), 0x2::tx_context::sender(arg2));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        v0
    }

    public fun get_u64_padding_value(arg0: &vector<u64>, arg1: u64) : u64 {
        if (0x1::vector::length<u64>(arg0) > arg1) {
            return *0x1::vector::borrow<u64>(arg0, arg1)
        };
        0
    }

    public fun multiplier(arg0: u64) : u64 {
        let v0 = 0;
        let v1 = 1;
        while (v0 < arg0) {
            v1 = v1 * 10;
            v0 = v0 + 1;
        };
        v1
    }

    public fun set_u64_padding_value(arg0: &mut vector<u64>, arg1: u64, arg2: u64) {
        while (0x1::vector::length<u64>(arg0) < arg1 + 1) {
            0x1::vector::push_back<u64>(arg0, 0);
        };
        *0x1::vector::borrow_mut<u64>(arg0, arg1) = arg2;
    }

    // decompiled from Move bytecode v6
}

