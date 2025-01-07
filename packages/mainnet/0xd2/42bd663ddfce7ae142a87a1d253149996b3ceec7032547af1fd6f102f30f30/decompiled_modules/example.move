module 0xd242bd663ddfce7ae142a87a1d253149996b3ceec7032547af1fd6f102f30f30::example {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct Inc has copy, drop {
        sender: address,
        value: u64,
    }

    public entry fun increment(arg0: &OwnerCap, arg1: &mut Counter) {
        arg1.value = arg1.value + 1;
    }

    public entry fun increment_v2(arg0: &OwnerCap, arg1: &mut Counter, arg2: &mut 0x2::tx_context::TxContext) {
        increment(arg0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::share_object<Counter>(v1);
    }

    // decompiled from Move bytecode v6
}

