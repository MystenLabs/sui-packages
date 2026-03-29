module 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::cursor {
    struct Cursor<T0> {
        data: vector<T0>,
    }

    public fun destroy_empty<T0>(arg0: Cursor<T0>) {
        let Cursor { data: v0 } = arg0;
        0x1::vector::destroy_empty<T0>(v0);
    }

    public fun is_empty<T0>(arg0: &Cursor<T0>) : bool {
        0x1::vector::is_empty<T0>(&arg0.data)
    }

    public fun data<T0>(arg0: &Cursor<T0>) : &vector<T0> {
        &arg0.data
    }

    public fun new<T0>(arg0: vector<T0>) : Cursor<T0> {
        0x1::vector::reverse<T0>(&mut arg0);
        Cursor<T0>{data: arg0}
    }

    public fun poke<T0>(arg0: &mut Cursor<T0>) : T0 {
        0x1::vector::pop_back<T0>(&mut arg0.data)
    }

    public fun take_rest<T0>(arg0: Cursor<T0>) : vector<T0> {
        let Cursor { data: v0 } = arg0;
        0x1::vector::reverse<T0>(&mut v0);
        v0
    }

    // decompiled from Move bytecode v6
}

