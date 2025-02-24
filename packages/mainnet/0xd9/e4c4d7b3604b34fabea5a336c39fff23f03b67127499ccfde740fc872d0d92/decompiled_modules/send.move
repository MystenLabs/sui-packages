module 0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::send {
    struct SendStampEvent has copy, drop {
        recipient: address,
        event: 0x1::string::String,
        stamp: 0x2::object::ID,
    }

    public fun batch_send_stamp(arg0: &0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp::AdminCap, arg1: &mut 0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp::Event, arg2: 0x1::string::String, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg3);
            let v2 = 0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp::new(arg1, arg2, arg4);
            let v3 = SendStampEvent{
                recipient : v1,
                event     : 0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp::event_name(arg1),
                stamp     : 0x2::object::id<0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp::Stamp>(&v2),
            };
            0x2::event::emit<SendStampEvent>(v3);
            0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp::transfer_stamp(v2, v1);
            v0 = v0 + 1;
        };
    }

    public fun send_stamp(arg0: &0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp::AdminCap, arg1: &mut 0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp::Event, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp::new(arg1, arg2, arg4);
        let v1 = SendStampEvent{
            recipient : arg3,
            event     : 0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp::event_name(arg1),
            stamp     : 0x2::object::id<0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp::Stamp>(&v0),
        };
        0x2::event::emit<SendStampEvent>(v1);
        0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp::transfer_stamp(v0, arg3);
    }

    // decompiled from Move bytecode v6
}

