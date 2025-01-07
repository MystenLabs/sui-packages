module 0xdd88af7469132717e9f8bc88429bf41025da5ae7bc5efb3b2038651c08aa7b6a::flipsui {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Challenge<phantom T0> has store {
        challenger: address,
        epoch: u64,
        stake: 0x2::balance::Balance<T0>,
    }

    struct Flip<phantom T0> has store, key {
        id: 0x2::object::UID,
        protocol_stake: 0x2::balance::Balance<T0>,
        n_challenges: u64,
        challenges: 0x2::table::Table<u64, Challenge<T0>>,
        allowed_amounts: vector<u64>,
        vrf_pubkey: vector<u8>,
    }

    struct ChallengePlaced<phantom T0> has copy, drop {
        challenge_id: u64,
        user: address,
        staked: u64,
        expiry_epoch: u64,
    }

    struct ChallengeResolved<phantom T0> has copy, drop {
        challenge_id: u64,
        user: address,
        accepted: bool,
        amount_returned: u64,
        new_protocol_stake: u64,
    }

    public fun add_to_protocol_stake<T0>(arg0: &mut Flip<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.protocol_stake, 0x2::coin::into_balance<T0>(arg1));
    }

    fun calculate_protocol_stake_amount(arg0: u64) : u64 {
        arg0 * 95 / 100
    }

    public fun challenge<T0>(arg0: &mut Flip<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(0x1::vector::contains<u64>(&arg0.allowed_amounts, &v0), 9223372431991767039);
        let v1 = 0x2::coin::into_balance<T0>(arg1);
        0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(&mut arg0.protocol_stake, calculate_protocol_stake_amount(v0)));
        let v2 = arg0.n_challenges;
        arg0.n_challenges = arg0.n_challenges + 1;
        let v3 = Challenge<T0>{
            challenger : 0x2::tx_context::sender(arg2),
            epoch      : 0x2::tx_context::epoch(arg2),
            stake      : v1,
        };
        0x2::table::add<u64, Challenge<T0>>(&mut arg0.challenges, v2, v3);
        let v4 = ChallengePlaced<T0>{
            challenge_id : v2,
            user         : 0x2::tx_context::sender(arg2),
            staked       : v0,
            expiry_epoch : 0x2::tx_context::epoch(arg2) + 7,
        };
        0x2::event::emit<ChallengePlaced<T0>>(v4);
        v2
    }

    public fun create_flip_instance<T0>(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Flip<T0>{
            id              : 0x2::object::new(arg3),
            protocol_stake  : 0x2::balance::zero<T0>(),
            n_challenges    : 0,
            challenges      : 0x2::table::new<u64, Challenge<T0>>(arg3),
            allowed_amounts : arg2,
            vrf_pubkey      : arg1,
        };
        0x2::transfer::share_object<Flip<T0>>(v0);
    }

    public fun duplicate_admin_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg1)}
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun resolve_challenge_expired<T0>(arg0: &mut Flip<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, Challenge<T0>>(&arg0.challenges, arg1), 9223372543660916735);
        let Challenge {
            challenger : v0,
            epoch      : v1,
            stake      : v2,
        } = 0x2::table::remove<u64, Challenge<T0>>(&mut arg0.challenges, arg1);
        assert!(v1 + 7 <= 0x2::tx_context::epoch(arg2), 9223372573725687807);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg2), v0);
    }

    public fun resolve_challenge_vrf<T0>(arg0: &mut Flip<T0>, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, Challenge<T0>>(&arg0.challenges, arg1), 9223372599495491583);
        let Challenge {
            challenger : v0,
            epoch      : _,
            stake      : v2,
        } = 0x2::table::remove<u64, Challenge<T0>>(&mut arg0.challenges, arg1);
        let v3 = v2;
        let v4 = 0x1::bcs::to_bytes<u64>(&arg1);
        assert!(0x2::ecvrf::ecvrf_verify(&arg2, &v4, &arg0.vrf_pubkey, &arg3), 9223372638150197247);
        if (*0x1::vector::borrow<u8>(&arg2, 0) % 2 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg4), v0);
            let v5 = ChallengeResolved<T0>{
                challenge_id       : arg1,
                user               : v0,
                accepted           : true,
                amount_returned    : 0x2::balance::value<T0>(&v3),
                new_protocol_stake : 0x2::balance::value<T0>(&arg0.protocol_stake),
            };
            0x2::event::emit<ChallengeResolved<T0>>(v5);
        } else {
            0x2::balance::join<T0>(&mut arg0.protocol_stake, v3);
            let v6 = ChallengeResolved<T0>{
                challenge_id       : arg1,
                user               : v0,
                accepted           : false,
                amount_returned    : 0x2::balance::value<T0>(&v3),
                new_protocol_stake : 0x2::balance::value<T0>(&arg0.protocol_stake),
            };
            0x2::event::emit<ChallengeResolved<T0>>(v6);
        };
    }

    public fun take_from_protocol_stake<T0>(arg0: &AdminCap, arg1: &mut Flip<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.protocol_stake, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

