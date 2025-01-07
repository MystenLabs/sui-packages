module 0x500f69a88f4fe0223dc6d15351d95ffc55578afe1d80426cc2211f78a2f31b6a::div {
    struct Div has store, key {
        id: 0x2::object::UID,
        children: vector<0x2::object::ID>,
    }

    public fun delete(arg0: Div) {
        let Div {
            id       : v0,
            children : v1,
        } = arg0;
        0x1::vector::destroy_empty<0x2::object::ID>(v1);
        0x2::object::delete(v0);
    }

    public fun add_child<T0: store + key>(arg0: &mut Div, arg1: T0, arg2: u64) {
        0x1::vector::insert<0x2::object::ID>(&mut arg0.children, 0x2::object::id<T0>(&arg1), arg2);
        0x2::transfer::public_transfer<T0>(arg1, 0x2::object::uid_to_address(&arg0.id));
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : Div {
        Div{
            id       : 0x2::object::new(arg0),
            children : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    public fun remove_child<T0: store + key>(arg0: &mut Div, arg1: 0x2::transfer::Receiving<T0>) : T0 {
        0x2::transfer::public_receive<T0>(&mut arg0.id, arg1)
    }

    public fun swap_children(arg0: &mut Div, arg1: u64, arg2: u64) {
        0x1::vector::swap<0x2::object::ID>(&mut arg0.children, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

