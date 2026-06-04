module 0x97a3b4ea8faab464361b47e3c17d5fb00a781f7262d9ebe7c62e81237bd0baa7::demo {
    struct A has store {
        a: u64,
    }

    struct List1 has store, key {
        id: 0x2::object::UID,
        obs: vector<A>,
    }

    public fun length(arg0: &List1) : u64 {
        0x1::vector::length<A>(&arg0.obs)
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : List1 {
        List1{
            id  : 0x2::object::new(arg0),
            obs : 0x1::vector::empty<A>(),
        }
    }

    public entry fun add(arg0: &mut List1, arg1: u64) {
        let v0 = A{a: arg1};
        0x1::vector::push_back<A>(&mut arg0.obs, v0);
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new(arg0);
        0x2::transfer::public_transfer<List1>(v0, 0x2::tx_context::sender(arg0));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new(arg0);
        0x2::transfer::public_transfer<List1>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun value_at(arg0: &List1, arg1: u64) : u64 {
        0x1::vector::borrow<A>(&arg0.obs, arg1).a
    }

    // decompiled from Move bytecode v7
}

