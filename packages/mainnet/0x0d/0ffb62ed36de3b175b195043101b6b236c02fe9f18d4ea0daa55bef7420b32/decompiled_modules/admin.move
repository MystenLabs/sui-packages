module 0xd0ffb62ed36de3b175b195043101b6b236c02fe9f18d4ea0daa55bef7420b32::admin {
    public fun is_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0xd0ffb62ed36de3b175b195043101b6b236c02fe9f18d4ea0daa55bef7420b32::err::wrong_launchpad_admin());
    }

    // decompiled from Move bytecode v6
}

