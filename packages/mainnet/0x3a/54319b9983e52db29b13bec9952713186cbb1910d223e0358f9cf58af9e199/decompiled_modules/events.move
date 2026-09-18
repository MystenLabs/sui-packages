module 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::events {
    struct LogUpdateAuthority has copy, drop {
        old_authority: address,
        new_authority: address,
    }

    struct LogUpdateAuth has copy, drop {
        addr: address,
        granted: bool,
    }

    public(friend) fun emit_log_update_auth(arg0: address, arg1: bool) {
        let v0 = LogUpdateAuth{
            addr    : arg0,
            granted : arg1,
        };
        0x2::event::emit<LogUpdateAuth>(v0);
    }

    public(friend) fun emit_log_update_authority(arg0: address, arg1: address) {
        let v0 = LogUpdateAuthority{
            old_authority : arg0,
            new_authority : arg1,
        };
        0x2::event::emit<LogUpdateAuthority>(v0);
    }

    // decompiled from Move bytecode v7
}

