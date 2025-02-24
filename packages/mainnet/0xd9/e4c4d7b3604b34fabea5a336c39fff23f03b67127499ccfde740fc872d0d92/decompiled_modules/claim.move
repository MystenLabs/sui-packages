module 0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::claim {
    struct ClaimStampEvent has copy, drop {
        recipient: address,
        event: 0x1::string::String,
        stamp: 0x2::object::ID,
    }

    struct ClaimStampInfo has drop {
        passport: 0x2::object::ID,
        last_time: u64,
    }

    public fun claim_stamp(arg0: &mut 0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp::Event, arg1: &mut 0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::sui_passport::SuiPassport, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp::new(arg0, arg2, arg5);
        let v2 = ClaimStampInfo{
            passport  : 0x2::object::id<0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::sui_passport::SuiPassport>(arg1),
            last_time : 0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::sui_passport::last_time(arg1),
        };
        let v3 = 0x2::bcs::to_bytes<ClaimStampInfo>(&v2);
        let v4 = 0x2::hash::keccak256(&v3);
        let v5 = x"5d3312bd147038cbb5eac03f683eb63c81d028002132e9884644dc8d83e26a26";
        assert!(0x2::ed25519::ed25519_verify(&arg3, &v5, &v4) == true, 1);
        let v6 = ClaimStampEvent{
            recipient : v0,
            event     : 0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp::event_name(arg0),
            stamp     : 0x2::object::id<0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp::Stamp>(&v1),
        };
        0x2::event::emit<ClaimStampEvent>(v6);
        0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::sui_passport::show_stamp(arg1, &v1, arg4);
        0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp::transfer_stamp(v1, v0);
    }

    // decompiled from Move bytecode v6
}

