module 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::publish_message {
    struct WormholeMessage has copy, drop {
        sender: 0x2::object::ID,
        sequence: u64,
        nonce: u32,
        payload: vector<u8>,
        consistency_level: u8,
        timestamp: u64,
    }

    struct MessageTicket {
        sender: 0x2::object::ID,
        sequence: u64,
        nonce: u32,
        payload: vector<u8>,
    }

    public fun publish_message(arg0: &mut 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::State, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: MessageTicket, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::assert_latest_only(arg0);
        0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::deposit_fee(&v0, arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let MessageTicket {
            sender   : v1,
            sequence : v2,
            nonce    : v3,
            payload  : v4,
        } = arg2;
        let v5 = WormholeMessage{
            sender            : v1,
            sequence          : v2,
            nonce             : v3,
            payload           : v4,
            consistency_level : 0,
            timestamp         : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<WormholeMessage>(v5);
        v2
    }

    public fun prepare_message(arg0: &mut 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::emitter::EmitterCap, arg1: u32, arg2: vector<u8>) : MessageTicket {
        MessageTicket{
            sender   : 0x2::object::id<0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::emitter::EmitterCap>(arg0),
            sequence : 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::emitter::use_sequence(arg0),
            nonce    : arg1,
            payload  : arg2,
        }
    }

    // decompiled from Move bytecode v7
}

