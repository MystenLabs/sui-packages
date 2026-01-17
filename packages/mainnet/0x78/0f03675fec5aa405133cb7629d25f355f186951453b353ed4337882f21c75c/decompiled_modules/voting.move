module 0x780f03675fec5aa405133cb7629d25f355f186951453b353ed4337882f21c75c::voting {
    struct Poll has key {
        id: 0x2::object::UID,
        question: 0x1::string::String,
        option_a: 0x1::string::String,
        option_b: 0x1::string::String,
        count_a: u64,
        count_b: u64,
    }

    struct VoteEvent has copy, drop {
        voter: address,
        option: u8,
    }

    public entry fun create_poll(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Poll{
            id       : 0x2::object::new(arg3),
            question : arg0,
            option_a : arg1,
            option_b : arg2,
            count_a  : 0,
            count_b  : 0,
        };
        0x2::transfer::share_object<Poll>(v0);
    }

    public entry fun vote(arg0: &mut Poll, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 1) {
            arg0.count_a = arg0.count_a + 1;
        } else {
            assert!(arg1 == 2, 0);
            arg0.count_b = arg0.count_b + 1;
        };
        let v0 = VoteEvent{
            voter  : 0x2::tx_context::sender(arg2),
            option : arg1,
        };
        0x2::event::emit<VoteEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

