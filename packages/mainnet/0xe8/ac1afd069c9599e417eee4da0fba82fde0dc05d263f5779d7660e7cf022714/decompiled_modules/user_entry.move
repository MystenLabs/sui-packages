module 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::user_entry {
    public fun cancel_deposit<T0>(arg0: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::cancel_deposit<T0>(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    public fun cancel_withdraw<T0>(arg0: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::cancel_withdraw<T0>(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    public fun deposit<T0>(arg0: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u256, arg4: 0x1::option::Option<0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 1001);
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg6));
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::request_deposit<T0>(arg0, arg4, arg5, 0x2::coin::split<T0>(&mut arg1, arg2, arg6), arg3, arg6)
    }

    public fun withdraw<T0>(arg0: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg1: u256, arg2: u64, arg3: 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::receipt::Receipt, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::request_withdraw<T0>(arg0, arg3, arg4, arg1, arg2, 0x2::tx_context::sender(arg5))
    }

    // decompiled from Move bytecode v6
}

