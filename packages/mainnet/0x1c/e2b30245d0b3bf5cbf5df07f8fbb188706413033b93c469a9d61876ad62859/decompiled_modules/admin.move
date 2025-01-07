module 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::admin {
    public fun is_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0x1ce2b30245d0b3bf5cbf5df07f8fbb188706413033b93c469a9d61876ad62859::err::wrong_launchpad_admin());
    }

    // decompiled from Move bytecode v6
}

