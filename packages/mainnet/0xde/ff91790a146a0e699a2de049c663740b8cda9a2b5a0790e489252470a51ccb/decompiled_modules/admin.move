module 0xdeff91790a146a0e699a2de049c663740b8cda9a2b5a0790e489252470a51ccb::admin {
    public fun is_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0xdeff91790a146a0e699a2de049c663740b8cda9a2b5a0790e489252470a51ccb::err::wrong_launchpad_admin());
    }

    // decompiled from Move bytecode v6
}

