module 0x12721c5f36085ac7329e13cff4ab13ec5ae74eee77cc5d2457830cc1f42b0946::raffle {
    struct Raffle has key {
        id: 0x2::object::UID,
        label: vector<u8>,
        ballots_sha256: vector<u8>,
        total_weight: u64,
        draw_after_ms: u64,
        draws_remaining: u64,
        rolls: vector<u64>,
        admin: address,
    }

    struct Committed has copy, drop {
        raffle: 0x2::object::ID,
        label: vector<u8>,
        ballots_sha256: vector<u8>,
        total_weight: u64,
        draw_after_ms: u64,
        draws: u64,
    }

    struct Drawn has copy, drop {
        raffle: 0x2::object::ID,
        index: u64,
        roll: u64,
    }

    public fun ballots_sha256(arg0: &Raffle) : &vector<u8> {
        &arg0.ballots_sha256
    }

    public fun commit(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 4);
        assert!(arg4 > 0, 4);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        let v0 = Raffle{
            id              : 0x2::object::new(arg5),
            label           : arg0,
            ballots_sha256  : arg1,
            total_weight    : arg2,
            draw_after_ms   : arg3,
            draws_remaining : arg4,
            rolls           : vector[],
            admin           : 0x2::tx_context::sender(arg5),
        };
        let v1 = Committed{
            raffle         : 0x2::object::id<Raffle>(&v0),
            label          : v0.label,
            ballots_sha256 : v0.ballots_sha256,
            total_weight   : arg2,
            draw_after_ms  : arg3,
            draws          : arg4,
        };
        0x2::event::emit<Committed>(v1);
        0x2::transfer::share_object<Raffle>(v0);
    }

    entry fun draw(arg0: &mut Raffle, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 3);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.draw_after_ms, 1);
        assert!(arg0.draws_remaining > 0, 2);
        let v0 = 0x2::random::new_generator(arg1, arg3);
        let v1 = 0x2::random::generate_u64_in_range(&mut v0, 0, arg0.total_weight - 1);
        arg0.draws_remaining = arg0.draws_remaining - 1;
        0x1::vector::push_back<u64>(&mut arg0.rolls, v1);
        let v2 = Drawn{
            raffle : 0x2::object::id<Raffle>(arg0),
            index  : 0x1::vector::length<u64>(&arg0.rolls),
            roll   : v1,
        };
        0x2::event::emit<Drawn>(v2);
    }

    public fun draws_remaining(arg0: &Raffle) : u64 {
        arg0.draws_remaining
    }

    public fun rolls(arg0: &Raffle) : &vector<u64> {
        &arg0.rolls
    }

    public fun total_weight(arg0: &Raffle) : u64 {
        arg0.total_weight
    }

    // decompiled from Move bytecode v7
}

