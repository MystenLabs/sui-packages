module 0x7f058e6f93bfbd5166ff6b36aa81532ed3bc616e157719d0bfcde4ac83b648d3::OrbiterRouter {
    struct MessageTakenEvent has copy, drop {
        msg: 0x1::string::String,
    }

    public fun memo(arg0: 0x1::string::String) {
        let v0 = MessageTakenEvent{msg: arg0};
        0x2::event::emit<MessageTakenEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

