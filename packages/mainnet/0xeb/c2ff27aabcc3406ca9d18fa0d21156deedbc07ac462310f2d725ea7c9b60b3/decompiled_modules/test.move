module 0xebc2ff27aabcc3406ca9d18fa0d21156deedbc07ac462310f2d725ea7c9b60b3::test {
    struct Storage has store, key {
        id: 0x2::object::UID,
        investment: 0x2::bag::Bag,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Storage{
            id         : 0x2::object::new(arg0),
            investment : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Storage>(v0);
    }

    public fun hihi<T0>(arg0: &mut Storage, arg1: 0x2::coin::Coin<T0>) {
        0x2::bag::add<u64, 0x2::balance::Balance<T0>>(&mut arg0.investment, 0, 0x2::coin::into_balance<T0>(arg1));
    }

    // decompiled from Move bytecode v6
}

