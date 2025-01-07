module 0xa18ae7eb56075055362c80c424e88860200ad2ff5dfd0db8e7be273f216eb5c1::admin {
    public fun is_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0xa18ae7eb56075055362c80c424e88860200ad2ff5dfd0db8e7be273f216eb5c1::err::wrong_launchpad_admin());
    }

    // decompiled from Move bytecode v6
}

