module 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::admin {
    public fun is_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::err::wrong_launchpad_admin());
    }

    // decompiled from Move bytecode v6
}

