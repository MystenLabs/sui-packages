module 0x7296bcc110aaa6841b6a744641558b1e23308472ea3b645b7d890af377e171bd::events {
    struct EmailSent has copy, drop, store {
        inbox_id: 0x2::object::ID,
        sender: address,
        recipient: address,
        email_index: u64,
    }

    public(friend) fun emit_email_sent(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64) {
        let v0 = EmailSent{
            inbox_id    : arg0,
            sender      : arg1,
            recipient   : arg2,
            email_index : arg3,
        };
        0x2::event::emit<EmailSent>(v0);
    }

    // decompiled from Move bytecode v6
}

