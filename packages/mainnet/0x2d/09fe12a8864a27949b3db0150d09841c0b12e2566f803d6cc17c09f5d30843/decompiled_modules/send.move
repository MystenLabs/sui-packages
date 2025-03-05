module 0x2d09fe12a8864a27949b3db0150d09841c0b12e2566f803d6cc17c09f5d30843::send {
    struct SendStampEvent has copy, drop {
        recipient: address,
        event: 0x1::string::String,
        stamp: 0x2::object::ID,
    }

    public fun batch_send_stamp(arg0: &0x2d09fe12a8864a27949b3db0150d09841c0b12e2566f803d6cc17c09f5d30843::stamp::AdminSet, arg1: &mut 0x2d09fe12a8864a27949b3db0150d09841c0b12e2566f803d6cc17c09f5d30843::stamp::Event, arg2: 0x1::string::String, arg3: vector<address>, arg4: &0x2d09fe12a8864a27949b3db0150d09841c0b12e2566f803d6cc17c09f5d30843::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x2d09fe12a8864a27949b3db0150d09841c0b12e2566f803d6cc17c09f5d30843::stamp::check_admin(arg0, arg5);
        let v0 = 0;
        0x2d09fe12a8864a27949b3db0150d09841c0b12e2566f803d6cc17c09f5d30843::version::check_version(arg4);
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg3);
            let v2 = 0x2d09fe12a8864a27949b3db0150d09841c0b12e2566f803d6cc17c09f5d30843::stamp::new(arg1, arg2, arg5);
            let v3 = SendStampEvent{
                recipient : v1,
                event     : 0x2d09fe12a8864a27949b3db0150d09841c0b12e2566f803d6cc17c09f5d30843::stamp::event_name(arg1),
                stamp     : 0x2::object::id<0x2d09fe12a8864a27949b3db0150d09841c0b12e2566f803d6cc17c09f5d30843::stamp::Stamp>(&v2),
            };
            0x2::event::emit<SendStampEvent>(v3);
            0x2d09fe12a8864a27949b3db0150d09841c0b12e2566f803d6cc17c09f5d30843::stamp::transfer_stamp(v2, v1);
            v0 = v0 + 1;
        };
    }

    public fun send_stamp(arg0: &0x2d09fe12a8864a27949b3db0150d09841c0b12e2566f803d6cc17c09f5d30843::stamp::AdminSet, arg1: &mut 0x2d09fe12a8864a27949b3db0150d09841c0b12e2566f803d6cc17c09f5d30843::stamp::Event, arg2: 0x1::string::String, arg3: address, arg4: &0x2d09fe12a8864a27949b3db0150d09841c0b12e2566f803d6cc17c09f5d30843::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x2d09fe12a8864a27949b3db0150d09841c0b12e2566f803d6cc17c09f5d30843::stamp::check_admin(arg0, arg5);
        let v0 = 0x2d09fe12a8864a27949b3db0150d09841c0b12e2566f803d6cc17c09f5d30843::stamp::new(arg1, arg2, arg5);
        0x2d09fe12a8864a27949b3db0150d09841c0b12e2566f803d6cc17c09f5d30843::version::check_version(arg4);
        let v1 = SendStampEvent{
            recipient : arg3,
            event     : 0x2d09fe12a8864a27949b3db0150d09841c0b12e2566f803d6cc17c09f5d30843::stamp::event_name(arg1),
            stamp     : 0x2::object::id<0x2d09fe12a8864a27949b3db0150d09841c0b12e2566f803d6cc17c09f5d30843::stamp::Stamp>(&v0),
        };
        0x2::event::emit<SendStampEvent>(v1);
        0x2d09fe12a8864a27949b3db0150d09841c0b12e2566f803d6cc17c09f5d30843::stamp::transfer_stamp(v0, arg3);
    }

    // decompiled from Move bytecode v6
}

