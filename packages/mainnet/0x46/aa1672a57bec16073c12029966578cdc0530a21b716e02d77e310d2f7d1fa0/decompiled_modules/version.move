module 0x46aa1672a57bec16073c12029966578cdc0530a21b716e02d77e310d2f7d1fa0::version {
    public fun next_version() : u64 {
        0x46aa1672a57bec16073c12029966578cdc0530a21b716e02d77e310d2f7d1fa0::constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x46aa1672a57bec16073c12029966578cdc0530a21b716e02d77e310d2f7d1fa0::constants::version(), 0x46aa1672a57bec16073c12029966578cdc0530a21b716e02d77e310d2f7d1fa0::error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x46aa1672a57bec16073c12029966578cdc0530a21b716e02d77e310d2f7d1fa0::constants::version()
    }

    // decompiled from Move bytecode v6
}

