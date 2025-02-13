module 0x7371f087258937f798262eb810b0d5bb25a2c1af5f567ad6d0a77912aab89567::bag_wrapper {
    struct BagWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun create<T0>(arg0: &mut BagWrapper, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        let v1 = 0;
        while (v1 < arg2) {
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, 0x2::coin::zero<T0>(arg3));
            v1 = v1 + 1;
        };
        0x2::dynamic_field::add<u64, vector<0x2::coin::Coin<T0>>>(&mut arg0.id, arg1, v0);
    }

    public fun destroy<T0>(arg0: &mut BagWrapper, arg1: u64) {
        let v0 = 0x2::dynamic_field::remove<u64, vector<0x2::coin::Coin<T0>>>(&mut arg0.id, arg1);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&v0)) {
            0x2::coin::destroy_zero<T0>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut v0));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BagWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<BagWrapper>(v0);
    }

    // decompiled from Move bytecode v6
}

