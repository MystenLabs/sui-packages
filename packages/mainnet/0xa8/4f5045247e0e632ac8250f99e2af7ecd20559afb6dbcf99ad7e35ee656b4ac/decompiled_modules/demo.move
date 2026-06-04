module 0x97a3b4ea8faab464361b47e3c17d5fb00a781f7262d9ebe7c62e81237bd0baa7::demo {
    struct A has store {
        a: u64,
    }

    struct List1 has store, key {
        id: 0x2::object::UID,
        obs: vector<A>,
    }

    struct D has copy, drop, store {
        v: u64,
    }

    struct D1 has store, key {
        id: 0x2::object::UID,
        age: u64,
    }

    struct D1_V has copy, drop, store {
        dummy_field: bool,
    }

    public fun length(arg0: &List1) : u64 {
        0x1::vector::length<A>(&arg0.obs)
    }

    public entry fun add(arg0: &mut List1, arg1: u64) {
        let v0 = A{a: arg1};
        0x1::vector::push_back<A>(&mut arg0.obs, v0);
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : List1 {
        List1{
            id  : 0x2::object::new(arg0),
            obs : 0x1::vector::empty<A>(),
        }
    }

    public entry fun add_dynamic(arg0: &mut D, arg1: u64) {
        arg0.v = arg1;
    }

    public entry fun add_dynamic1(arg0: &mut D1, arg1: D1_V, arg2: u64) {
        0x2::dynamic_field::add<D1_V, u64>(&mut arg0.id, arg1, arg2);
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new(arg0);
        0x2::transfer::public_transfer<List1>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun create_D(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = D1{
            id  : 0x2::object::new(arg1),
            age : arg0,
        };
        0x2::transfer::public_transfer<D1>(v0, 0x2::tx_context::sender(arg1));
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

