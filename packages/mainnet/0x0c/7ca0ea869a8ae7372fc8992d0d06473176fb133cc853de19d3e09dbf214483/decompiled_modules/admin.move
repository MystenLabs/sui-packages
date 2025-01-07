module 0xc7ca0ea869a8ae7372fc8992d0d06473176fb133cc853de19d3e09dbf214483::admin {
    public fun is_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0xc7ca0ea869a8ae7372fc8992d0d06473176fb133cc853de19d3e09dbf214483::err::wrong_launchpad_admin());
    }

    // decompiled from Move bytecode v6
}

