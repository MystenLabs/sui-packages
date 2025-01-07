module 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::shard {
    struct Shard has key {
        id: 0x2::object::UID,
        amount: u64,
        last_rewarded_at: u64,
    }

    struct ShardEarned has copy, drop {
        shard_id: 0x2::object::ID,
        amount: u64,
    }

    struct ShardSpent has copy, drop {
        shard_id: 0x2::object::ID,
        amount: u64,
    }

    public fun new(arg0: &mut 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::verification::Verifier, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = b"";
        let v1 = 0x1::string::utf8(b"shard");
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&v1));
        let v2 = 0x1::string::utf8(b"new");
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::tx_context::sender(arg3)));
        0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::verification::verify_signature(arg0, 0x2::tx_context::sender(arg3), arg2, arg1, &mut v0);
        let v3 = Shard{
            id               : 0x2::object::new(arg3),
            amount           : 1,
            last_rewarded_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::transfer::transfer<Shard>(v3, 0x2::tx_context::sender(arg3));
    }

    public fun amount(arg0: &Shard) : u64 {
        arg0.amount
    }

    public fun daily_reward(arg0: &mut Shard, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) - arg0.last_rewarded_at > 86400000, 0);
        arg0.amount = arg0.amount + 1;
        arg0.last_rewarded_at = 0x2::clock::timestamp_ms(arg1);
        let v0 = ShardEarned{
            shard_id : 0x2::object::id<Shard>(arg0),
            amount   : 1,
        };
        0x2::event::emit<ShardEarned>(v0);
    }

    public fun last_rewarded_at(arg0: &Shard) : u64 {
        arg0.last_rewarded_at
    }

    public fun spend(arg0: &mut Shard, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.amount >= arg1, 1);
        arg0.amount = arg0.amount - arg1;
        let v0 = ShardSpent{
            shard_id : 0x2::object::uid_to_inner(&arg0.id),
            amount   : arg1,
        };
        0x2::event::emit<ShardSpent>(v0);
    }

    // decompiled from Move bytecode v6
}

