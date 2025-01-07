module 0x843edb8652dd013d8d9330537d4775f2977017f75a8e175e513b3c9d28606152::finger_guessing {
    struct Result has copy, drop {
        status: u8,
    }

    struct Reg has key {
        id: 0x2::object::UID,
        round: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Reg{
            id    : 0x2::object::new(arg0),
            round : 0,
        };
        0x2::transfer::share_object<Reg>(v0);
    }

    public entry fun play(arg0: &Reg, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg1 > 2) {
            abort 2
        };
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_bytes(&v0);
        0x2::object::delete(v0);
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg0.round));
        let v2 = 0x1::hash::sha2_256(v1);
        let v3 = (safe_selection(3, &v2) as u8);
        if (arg1 == v3) {
            let v4 = Result{status: 0};
            0x2::event::emit<Result>(v4);
        } else if (arg1 == 0 && v3 == 2 || arg1 == 2 && v3 == 1 || arg1 == 1 && v3 == 0) {
            let v5 = Result{status: 1};
            0x2::event::emit<Result>(v5);
        } else {
            let v6 = Result{status: 2};
            0x2::event::emit<Result>(v6);
        };
    }

    public fun safe_selection(arg0: u64, arg1: &vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(arg1) >= 16, 1);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 16) {
            let v2 = v0 << 8;
            v0 = v2 + (*0x1::vector::borrow<u8>(arg1, v1) as u128);
            v1 = v1 + 1;
        };
        ((v0 % (arg0 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

