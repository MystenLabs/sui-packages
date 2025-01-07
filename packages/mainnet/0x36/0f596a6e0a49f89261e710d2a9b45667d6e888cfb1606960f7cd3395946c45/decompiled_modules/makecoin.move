module 0x360f596a6e0a49f89261e710d2a9b45667d6e888cfb1606960f7cd3395946c45::makecoin {
    struct Admin has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun join_vec<T0>(arg0: &mut vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(arg0);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(arg0)) {
            0x2::coin::join<T0>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(arg0));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun join_vec_bag<T0>(arg0: &mut 0x2::bag::Bag, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bag::remove<0x1::string::String, vector<0x2::coin::Coin<T0>>>(arg0, arg1);
        let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut v0);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&v0)) {
            0x2::coin::join<T0>(&mut v1, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut v0));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg2));
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

