module 0xa3beb1846ba59db2ff68e82d8bb0d2e40e00bfade6c17e301e3d1c4f6e022bdc::utility {
    public fun decrease_u64_vector_value(arg0: &mut vector<u64>, arg1: u64, arg2: u64) {
        pad_u64_vector(arg0, arg1);
        *0x1::vector::borrow_mut<u64>(arg0, arg1) = *0x1::vector::borrow<u64>(arg0, arg1) - arg2;
    }

    public fun get_u64_vector_value(arg0: &vector<u64>, arg1: u64) : u64 {
        if (0x1::vector::length<u64>(arg0) > arg1) {
            return *0x1::vector::borrow<u64>(arg0, arg1)
        };
        0
    }

    public fun increase_u64_vector_value(arg0: &mut vector<u64>, arg1: u64, arg2: u64) {
        pad_u64_vector(arg0, arg1);
        *0x1::vector::borrow_mut<u64>(arg0, arg1) = *0x1::vector::borrow<u64>(arg0, arg1) + arg2;
    }

    fun pad_u64_vector(arg0: &mut vector<u64>, arg1: u64) {
        while (0x1::vector::length<u64>(arg0) < arg1 + 1) {
            0x1::vector::push_back<u64>(arg0, 0);
        };
    }

    public fun set_u64_vector_value(arg0: &mut vector<u64>, arg1: u64, arg2: u64) {
        pad_u64_vector(arg0, arg1);
        *0x1::vector::borrow_mut<u64>(arg0, arg1) = arg2;
    }

    public fun transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun transfer_balance_opt<T0>(arg0: 0x1::option::Option<0x2::balance::Balance<T0>>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::balance::Balance<T0>>(&arg0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x1::option::destroy_some<0x2::balance::Balance<T0>>(arg0), arg2), arg1);
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<T0>>(arg0);
        };
    }

    public fun transfer_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: address) {
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0), arg1);
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
    }

    // decompiled from Move bytecode v6
}

