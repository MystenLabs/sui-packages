module 0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::queue {
    struct Queue<phantom T0: store> has store {
        front: u64,
        back: u64,
        items: 0x2::table::Table<u64, T0>,
    }

    public fun length<T0: store>(arg0: &Queue<T0>) : u64 {
        0x2::table::length<u64, T0>(&arg0.items)
    }

    public fun destroy_empty<T0: store>(arg0: Queue<T0>) {
        assert!(length<T0>(&arg0) == 0, 1);
        let Queue {
            front : _,
            back  : _,
            items : v2,
        } = arg0;
        0x2::table::destroy_empty<u64, T0>(v2);
    }

    public fun drop<T0: drop + store>(arg0: Queue<T0>) {
        let Queue {
            front : _,
            back  : _,
            items : v2,
        } = arg0;
        0x2::table::drop<u64, T0>(v2);
    }

    public fun is_empty<T0: store>(arg0: &Queue<T0>) : bool {
        0x2::table::is_empty<u64, T0>(&arg0.items)
    }

    public fun new<T0: store>(arg0: &mut 0x2::tx_context::TxContext) : Queue<T0> {
        Queue<T0>{
            front : 0,
            back  : 0,
            items : 0x2::table::new<u64, T0>(arg0),
        }
    }

    public fun borrow_at<T0: store>(arg0: &Queue<T0>, arg1: u64) : &T0 {
        assert!(0x2::table::contains<u64, T0>(&arg0.items, arg1), 2);
        0x2::table::borrow<u64, T0>(&arg0.items, arg1)
    }

    public fun borrow_front<T0: store>(arg0: &Queue<T0>) : &T0 {
        assert!(length<T0>(arg0) != 0, 0);
        0x2::table::borrow<u64, T0>(&arg0.items, arg0.front)
    }

    public fun borrow_mut_front<T0: store>(arg0: &mut Queue<T0>) : &mut T0 {
        assert!(length<T0>(arg0) != 0, 0);
        0x2::table::borrow_mut<u64, T0>(&mut arg0.items, arg0.front)
    }

    public fun next_index<T0: store>(arg0: &Queue<T0>) : u64 {
        arg0.back
    }

    public fun pop_front<T0: store>(arg0: &mut Queue<T0>) : T0 {
        assert!(length<T0>(arg0) != 0, 0);
        arg0.front = arg0.front + 1;
        0x2::table::remove<u64, T0>(&mut arg0.items, arg0.front)
    }

    public fun push<T0: store>(arg0: &mut Queue<T0>, arg1: T0) {
        0x2::table::add<u64, T0>(&mut arg0.items, arg0.back, arg1);
        arg0.back = arg0.back + 1;
    }

    // decompiled from Move bytecode v6
}

