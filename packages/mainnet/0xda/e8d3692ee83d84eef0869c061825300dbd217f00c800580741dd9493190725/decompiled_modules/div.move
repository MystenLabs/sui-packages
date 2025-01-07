module 0xdae8d3692ee83d84eef0869c061825300dbd217f00c800580741dd9493190725::div {
    struct Div has store, key {
        id: 0x2::object::UID,
        children: 0x2::object_bag::ObjectBag,
        count: u64,
        order: vector<0x2::object::ID>,
    }

    public fun delete(arg0: Div) {
        let Div {
            id       : v0,
            children : v1,
            count    : _,
            order    : v3,
        } = arg0;
        0x2::object_bag::destroy_empty(v1);
        0x1::vector::destroy_empty<0x2::object::ID>(v3);
        0x2::object::delete(v0);
    }

    public fun add_child<T0: store + key>(arg0: T0, arg1: &mut Div) {
        let v0 = 0x2::object::id<T0>(&arg0);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg1.order, &v0), 9223372268783009791);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.order, 0x2::object::id<T0>(&arg0));
        0x2::object_bag::add<0x2::object::ID, T0>(&mut arg1.children, 0x2::object::id<T0>(&arg0), arg0);
        arg1.count = arg1.count + 1;
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : Div {
        Div{
            id       : 0x2::object::new(arg0),
            children : 0x2::object_bag::new(arg0),
            count    : 0,
            order    : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    public fun remove_child<T0: store + key>(arg0: 0x2::object::ID, arg1: &mut Div) : T0 {
        arg1.count = arg1.count - 1;
        0x2::object_bag::remove<0x2::object::ID, T0>(&mut arg1.children, arg0)
    }

    public fun swap_children(arg0: u64, arg1: u64, arg2: &mut Div) {
        0x1::vector::swap<0x2::object::ID>(&mut arg2.order, arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

