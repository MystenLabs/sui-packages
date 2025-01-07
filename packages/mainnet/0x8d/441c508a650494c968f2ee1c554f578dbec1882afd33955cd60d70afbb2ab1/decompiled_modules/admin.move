module 0x8d441c508a650494c968f2ee1c554f578dbec1882afd33955cd60d70afbb2ab1::admin {
    public fun is_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0x8d441c508a650494c968f2ee1c554f578dbec1882afd33955cd60d70afbb2ab1::err::wrong_launchpad_admin());
    }

    // decompiled from Move bytecode v6
}

