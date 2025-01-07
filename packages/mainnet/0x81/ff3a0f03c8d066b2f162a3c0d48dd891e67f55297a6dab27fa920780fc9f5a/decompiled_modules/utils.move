module 0x81ff3a0f03c8d066b2f162a3c0d48dd891e67f55297a6dab27fa920780fc9f5a::utils {
    struct RandomSeed has copy, drop {
        tx_digest: vector<u8>,
        tx_digest_u64: u64,
        current_timestamp: u64,
    }

    public fun generate_random_in_range(arg0: &mut 0x2::tx_context::TxContext, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64) : u64 {
        arg2 + generate_random_number(arg0, arg1) % (arg3 - arg2)
    }

    public fun generate_random_number(arg0: &0x2::tx_context::TxContext, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::tx_context::digest(arg0);
        let v1 = 0x2::bcs::new(*v0);
        let v2 = 0x2::bcs::peel_u64(&mut v1);
        let v3 = 0x2::clock::timestamp_ms(arg1);
        let v4 = RandomSeed{
            tx_digest         : *v0,
            tx_digest_u64     : v2,
            current_timestamp : v3,
        };
        0x2::event::emit<RandomSeed>(v4);
        v3 % v2
    }

    // decompiled from Move bytecode v6
}

