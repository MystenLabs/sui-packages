module 0x56ba7f681324665d979cd455f665020b869c4bcd9cf50b48bfee31c362ef7c5d::utils {
    public fun count_occurrences<T0: copy + drop + store>(arg0: &vector<T0>, arg1: &T0) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<T0>(arg0)) {
            if (*0x1::vector::borrow<T0>(arg0, v1) == *arg1) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun flip_coin(arg0: &0x2::random::Random, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::random::new_generator(arg0, arg2);
        0x2::random::generate_u64_in_range(&mut v0, 0, 100) <= arg1
    }

    public(friend) fun percentage(arg0: u128, arg1: u128) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 1);
        arg0 * arg1 / 100
    }

    public(friend) fun percentage_calculation(arg0: u128, arg1: u128) : u128 {
        arg0 * arg1 / 10000
    }

    public(friend) fun percentage_increment(arg0: u128, arg1: u128) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 1);
        let v0 = arg0 + arg0 * arg1 / 100;
        assert!(v0 >= arg0, 1);
        v0
    }

    public(friend) fun percentage_value(arg0: u128, arg1: u128) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 1);
        arg0 * arg1 / 10000
    }

    public(friend) fun roll_dice(arg0: u64, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::random::new_generator(arg1, arg2);
        0x2::random::generate_u64_in_range(&mut v0, 1, arg0)
    }

    public fun safe_multiply(arg0: u128, arg1: u128) : u128 {
        assert!(arg0 == 0 || 340282366920938463463374607431768211455 / arg0 >= arg1, 1);
        arg0 * arg1
    }

    public fun safe_subtract_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 1);
        arg0 - arg1
    }

    // decompiled from Move bytecode v6
}

