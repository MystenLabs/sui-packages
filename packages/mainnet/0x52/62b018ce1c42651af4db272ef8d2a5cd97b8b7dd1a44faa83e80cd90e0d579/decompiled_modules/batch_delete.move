module 0x5262b018ce1c42651af4db272ef8d2a5cd97b8b7dd1a44faa83e80cd90e0d579::batch_delete {
    struct DeletableWrapper<T0: store + key> has key {
        id: 0x2::object::UID,
        inner: T0,
    }

    public entry fun batch_clean_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            return
        };
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x2::coin::join<T0>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        if (0x2::coin::value<T0>(&v0) == 0) {
            0x2::coin::destroy_zero<T0>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg1));
        };
    }

    public entry fun batch_delete_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x2::coin::zero<T0>(arg2);
        while (v1 < 0x1::vector::length<0x2::coin::Coin<T0>>(&arg0)) {
            let v3 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
            v0 = v0 + 0x2::coin::value<T0>(&v3);
            0x2::coin::join<T0>(&mut v2, v3);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        if (0x2::coin::value<T0>(&v2) == 0) {
            0x2::coin::destroy_zero<T0>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg2));
        };
    }

    public fun calculate_fee(arg0: u64) : u64 {
        arg0 * 1000 / 10000
    }

    public entry fun delete_object<T0: store + key>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(arg0, @0x0);
    }

    public entry fun pay_fee(arg0: &mut 0x5262b018ce1c42651af4db272ef8d2a5cd97b8b7dd1a44faa83e80cd90e0d579::fee_pool::FeePool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x5262b018ce1c42651af4db272ef8d2a5cd97b8b7dd1a44faa83e80cd90e0d579::fee_pool::deposit_fee(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

