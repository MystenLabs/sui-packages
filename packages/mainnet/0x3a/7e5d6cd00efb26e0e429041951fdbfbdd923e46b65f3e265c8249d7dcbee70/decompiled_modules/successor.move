module 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::successor {
    struct SuccessorKey has copy, drop, store {
        from: address,
    }

    struct Successor has copy, drop, store {
        from: address,
        to: address,
    }

    struct SuccessorRecorded has copy, drop {
        from: address,
        to: address,
    }

    public fun has_successor(arg0: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg1: address) : bool {
        let v0 = SuccessorKey{from: arg1};
        0x2::dynamic_field::exists<SuccessorKey>(0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::uid(arg0), v0)
    }

    public fun record(arg0: &mut 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 != arg1, 79);
        let v1 = SuccessorKey{from: v0};
        assert!(!0x2::dynamic_field::exists<SuccessorKey>(0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::uid(arg0), v1), 78);
        let v2 = Successor{
            from : v0,
            to   : arg1,
        };
        0x2::dynamic_field::add<SuccessorKey, Successor>(0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::uid_mut(arg0), v1, v2);
        let v3 = SuccessorRecorded{
            from : v0,
            to   : arg1,
        };
        0x2::event::emit<SuccessorRecorded>(v3);
    }

    public fun successor_of(arg0: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg1: address) : address {
        let v0 = SuccessorKey{from: arg1};
        if (0x2::dynamic_field::exists<SuccessorKey>(0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::uid(arg0), v0)) {
            0x2::dynamic_field::borrow<SuccessorKey, Successor>(0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::uid(arg0), v0).to
        } else {
            arg1
        }
    }

    // decompiled from Move bytecode v7
}

