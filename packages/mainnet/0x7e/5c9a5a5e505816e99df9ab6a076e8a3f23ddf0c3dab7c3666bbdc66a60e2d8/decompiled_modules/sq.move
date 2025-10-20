module 0x7e5c9a5a5e505816e99df9ab6a076e8a3f23ddf0c3dab7c3666bbdc66a60e2d8::sq {
    struct SQR has store, key {
        id: 0x2::object::UID,
        ci: u64,
        aw: 0x2::vec_set::VecSet<address>,
        an: address,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : address {
        let v0 = SQR{
            id : 0x2::object::new(arg0),
            ci : 0,
            aw : 0x2::vec_set::empty<address>(),
            an : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<SQR>(v0);
        0x2::object::uid_to_address(&v0.id)
    }

    public fun css(arg0: &mut SQR, arg1: u64, arg2: bool, arg3: bool, arg4: &0x2::tx_context::TxContext) : u64 {
        vaw(arg0, arg4);
        let v0 = ics(arg0, arg1, arg2, arg3);
        if (v0 != 0) {
            return v0
        };
        arg0.ci = arg1;
        0
    }

    public fun csst(arg0: &mut SQR, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: &0x2::tx_context::TxContext) : u64 {
        vaw(arg0, arg6);
        let v0 = ct(arg1, arg3, arg4);
        if (v0 != 0) {
            return v0
        };
        let v1 = css(arg0, arg2, arg4, arg5, arg6);
        if (v1 != 0) {
            return v1
        };
        0
    }

    public fun cst(arg0: &mut SQR, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: &0x2::tx_context::TxContext) : u64 {
        vaw(arg0, arg6);
        let v0 = ics(arg0, arg2, arg4, arg5);
        if (v0 != 0) {
            return v0
        };
        let v1 = ct(arg1, arg3, arg4);
        if (v1 != 0) {
            return v1
        };
        0
    }

    public fun ct(arg0: &0x2::clock::Clock, arg1: u64, arg2: bool) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg0) > arg1;
        let v1 = if (v0) {
            201
        } else {
            0
        };
        if (v1 != 0 && !arg2) {
            abort v1
        };
        v1
    }

    public fun da(arg0: &mut SQR, arg1: address, arg2: &0x2::tx_context::TxContext) {
        van(arg0, arg2);
        0x2::vec_set::remove<address>(&mut arg0.aw, &arg1);
    }

    public fun ia(arg0: &mut SQR, arg1: address, arg2: &0x2::tx_context::TxContext) {
        van(arg0, arg2);
        0x2::vec_set::insert<address>(&mut arg0.aw, arg1);
    }

    fun ics(arg0: &SQR, arg1: u64, arg2: bool, arg3: bool) : u64 {
        let v0 = arg0.ci > arg1;
        let v1 = if (v0) {
            200
        } else {
            let v2 = arg0.ci == arg1;
            if (v2) {
                if (arg3) {
                    0
                } else {
                    200
                }
            } else {
                0
            }
        };
        if (v1 != 0 && !arg2) {
            abort v1
        };
        v1
    }

    public fun rci(arg0: &mut SQR, arg1: &0x2::tx_context::TxContext) {
        vaw(arg0, arg1);
        arg0.ci = 0;
    }

    public fun ta(arg0: &mut SQR, arg1: address, arg2: &0x2::tx_context::TxContext) {
        van(arg0, arg2);
        arg0.an = arg1;
    }

    fun van(arg0: &SQR, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.an == 0x2::tx_context::sender(arg1), 202);
    }

    fun vaw(arg0: &SQR, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.aw, &v0), 202);
    }

    // decompiled from Move bytecode v6
}

