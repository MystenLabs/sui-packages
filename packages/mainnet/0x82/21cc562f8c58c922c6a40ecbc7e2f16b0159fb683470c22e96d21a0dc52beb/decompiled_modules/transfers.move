module 0x8221cc562f8c58c922c6a40ecbc7e2f16b0159fb683470c22e96d21a0dc52beb::transfers {
    public fun refund_all<T0>(arg0: &mut 0x2::vec_map::VecMap<address, 0x2::coin::Coin<T0>>) {
        let v0 = 0x2::vec_map::size<address, 0x2::coin::Coin<T0>>(arg0);
        while (v0 > 0) {
            v0 = v0 - 1;
            let (v1, v2) = 0x2::vec_map::remove_entry_by_idx<address, 0x2::coin::Coin<T0>>(arg0, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v1);
        };
    }

    public fun send_all<T0: copy + drop, T1>(arg0: &mut 0x2::vec_map::VecMap<T0, 0x2::coin::Coin<T1>>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::zero<T1>();
        let v1 = 0x2::vec_map::size<T0, 0x2::coin::Coin<T1>>(arg0);
        while (v1 > 0) {
            v1 = v1 - 1;
            let (_, v3) = 0x2::vec_map::remove_entry_by_idx<T0, 0x2::coin::Coin<T1>>(arg0, v1);
            0x2::balance::join<T1>(&mut v0, 0x2::coin::into_balance<T1>(v3));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v0, arg2), arg1);
    }

    // decompiled from Move bytecode v6
}

