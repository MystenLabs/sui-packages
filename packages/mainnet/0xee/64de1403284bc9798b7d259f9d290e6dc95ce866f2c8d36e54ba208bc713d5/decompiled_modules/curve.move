module 0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::curve {
    struct CurveKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Curve has store {
        virtual_quote: u64,
        basis: u64,
    }

    public fun basis(arg0: &0x2::object::UID) : u64 {
        let v0 = CurveKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<CurveKey>(arg0, v0)) {
            let v2 = CurveKey{dummy_field: false};
            0x2::dynamic_field::borrow<CurveKey, Curve>(arg0, v2).basis
        } else {
            0
        }
    }

    public(friend) fun buy(arg0: &mut 0x2::object::UID, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = CurveKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<CurveKey>(arg0, v0)) {
            return 0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::math::output(arg3, arg2, arg1)
        };
        let v1 = CurveKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<CurveKey, Curve>(arg0, v1);
        let v3 = if (v2.basis == 0) {
            arg3
        } else {
            0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::math::mul_div(arg3, v2.basis, arg2)
        };
        assert!(v3 > 0, 1);
        v2.basis = v2.basis + v3;
        0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::math::output(v3, v2.virtual_quote + v2.basis, arg1)
    }

    public fun depth(arg0: &0x2::object::UID, arg1: u64) : u64 {
        let v0 = CurveKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<CurveKey>(arg0, v0)) {
            return arg1
        };
        let v1 = CurveKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<CurveKey, Curve>(arg0, v1);
        if (v2.basis == 0) {
            return v2.virtual_quote
        };
        let v3 = ((v2.virtual_quote as u256) + (v2.basis as u256)) * (arg1 as u256) / (v2.basis as u256);
        assert!(v3 <= 18446744073709551615, 1);
        (v3 as u64)
    }

    public(friend) fun install(arg0: &mut 0x2::object::UID, arg1: u64, arg2: u64) {
        assert!(arg1 <= 1000000000000000, 1);
        if (arg1 == 0) {
            return
        };
        assert!(arg2 > 0, 1);
        let v0 = CurveKey{dummy_field: false};
        let v1 = Curve{
            virtual_quote : arg1,
            basis         : arg2,
        };
        0x2::dynamic_field::add<CurveKey, Curve>(arg0, v0, v1);
    }

    public fun max_virtual() : u64 {
        1000000000000000
    }

    public(friend) fun sell(arg0: &mut 0x2::object::UID, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = CurveKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<CurveKey>(arg0, v0)) {
            return 0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::math::output(arg3, arg1, arg2)
        };
        let v1 = CurveKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<CurveKey, Curve>(arg0, v1);
        let v3 = 0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::math::output(arg3, arg1, v2.virtual_quote + v2.basis);
        assert!(v3 <= v2.basis, 2);
        v2.basis = v2.basis - v3;
        0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::math::mul_div(v3, arg2, v2.basis)
    }

    public fun virtual_quote(arg0: &0x2::object::UID) : u64 {
        let v0 = CurveKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<CurveKey>(arg0, v0)) {
            let v2 = CurveKey{dummy_field: false};
            0x2::dynamic_field::borrow<CurveKey, Curve>(arg0, v2).virtual_quote
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

