module 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::set {
    struct Set<T0: copy + drop + store> has store {
        values: vector<T0>,
        positions: 0x2::table::Table<T0, u64>,
    }

    public fun length<T0: copy + drop + store>(arg0: &Set<T0>) : u64 {
        0x1::vector::length<T0>(&arg0.values)
    }

    public fun borrow<T0: copy + drop + store>(arg0: &Set<T0>, arg1: u64) : &T0 {
        assert!(arg1 < length<T0>(arg0), 0);
        0x1::vector::borrow<T0>(&arg0.values, arg1)
    }

    public fun add<T0: copy + drop + store>(arg0: &mut Set<T0>, arg1: T0) : bool {
        if (!contains<T0>(arg0, arg1)) {
            0x1::vector::push_back<T0>(&mut arg0.values, arg1);
            0x2::table::add<T0, u64>(&mut arg0.positions, arg1, 0x1::vector::length<T0>(&arg0.values) - 1);
            true
        } else {
            false
        }
    }

    public fun contains<T0: copy + drop + store>(arg0: &Set<T0>, arg1: T0) : bool {
        0x2::table::contains<T0, u64>(&arg0.positions, arg1)
    }

    public fun drop<T0: copy + drop + store>(arg0: Set<T0>) {
        let Set {
            values    : _,
            positions : v1,
        } = arg0;
        0x2::table::drop<T0, u64>(v1);
    }

    public fun new<T0: copy + drop + store>(arg0: &mut 0x2::tx_context::TxContext) : Set<T0> {
        Set<T0>{
            values    : 0x1::vector::empty<T0>(),
            positions : 0x2::table::new<T0, u64>(arg0),
        }
    }

    public fun remove<T0: copy + drop + store>(arg0: &mut Set<T0>, arg1: T0) : bool {
        if (contains<T0>(arg0, arg1)) {
            let v1 = *0x2::table::borrow<T0, u64>(&arg0.positions, arg1);
            let v2 = 0x1::vector::length<T0>(&arg0.values) - 1;
            if (v2 != v1) {
                0x1::vector::swap<T0>(&mut arg0.values, v1, v2);
                *0x2::table::borrow_mut<T0, u64>(&mut arg0.positions, *0x1::vector::borrow<T0>(&arg0.values, v2)) = v1;
            };
            0x1::vector::pop_back<T0>(&mut arg0.values);
            0x2::table::remove<T0, u64>(&mut arg0.positions, arg1);
            true
        } else {
            false
        }
    }

    public fun borrow_values<T0: copy + drop + store>(arg0: &Set<T0>) : &vector<T0> {
        &arg0.values
    }

    // decompiled from Move bytecode v6
}

