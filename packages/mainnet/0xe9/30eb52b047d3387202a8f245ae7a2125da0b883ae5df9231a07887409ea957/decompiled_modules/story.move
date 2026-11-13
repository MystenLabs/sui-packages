module 0xe930eb52b047d3387202a8f245ae7a2125da0b883ae5df9231a07887409ea957::story {
    struct Story has key {
        id: 0x2::object::UID,
        teller: address,
        origin: 0x1::string::String,
        promise_id: 0x1::string::String,
        terms_hash: 0x1::string::String,
        beats: u64,
        told_at: u64,
        settled_at: u64,
        told: u64,
    }

    struct Minted has copy, drop {
        story: address,
        origin: 0x1::string::String,
        terms_hash: 0x1::string::String,
    }

    struct Told has copy, drop {
        story: address,
        origin: 0x1::string::String,
        beat: u8,
        hash: 0x1::string::String,
    }

    public fun beats(arg0: &Story) : u64 {
        arg0.beats
    }

    public fun create_story(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Story{
            id         : 0x2::object::new(arg6),
            teller     : arg0,
            origin     : arg1,
            promise_id : arg2,
            terms_hash : arg3,
            beats      : arg4,
            told_at    : 0x2::clock::timestamp_ms(arg5),
            settled_at : 0,
            told       : 0,
        };
        let v1 = Minted{
            story      : 0x2::object::uid_to_address(&v0.id),
            origin     : v0.origin,
            terms_hash : v0.terms_hash,
        };
        0x2::event::emit<Minted>(v1);
        0x2::transfer::share_object<Story>(v0);
    }

    public fun origin(arg0: &Story) : &0x1::string::String {
        &arg0.origin
    }

    public fun promise_id(arg0: &Story) : &0x1::string::String {
        &arg0.promise_id
    }

    public fun settled_at(arg0: &Story) : u64 {
        arg0.settled_at
    }

    public fun tell_beat(arg0: &mut Story, arg1: u8, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.teller, 11);
        assert!((arg1 as u64) < 7, 13);
        assert!(arg0.told >> arg1 & 1 == 0, 12);
        arg0.told = arg0.told | 1 << arg1;
        let v0 = Told{
            story  : 0x2::object::uid_to_address(&arg0.id),
            origin : arg0.origin,
            beat   : arg1,
            hash   : arg2,
        };
        0x2::event::emit<Told>(v0);
    }

    public fun teller(arg0: &Story) : address {
        arg0.teller
    }

    public fun terms_hash(arg0: &Story) : &0x1::string::String {
        &arg0.terms_hash
    }

    public fun told(arg0: &Story) : u64 {
        arg0.told
    }

    public fun told_at(arg0: &Story) : u64 {
        arg0.told_at
    }

    // decompiled from Move bytecode v7
}

