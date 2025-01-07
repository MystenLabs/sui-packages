module 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::cursor {
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

