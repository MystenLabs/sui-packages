module 0xbb20ae4f9437321b6b48b4ccd380e57ea123a52a762bc6b72916a9705ba5b087::flipsui {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ChallengeReceipt<phantom T0> has store, key {
        id: 0x2::object::UID,
        n_challenge: u64,
        challenger: address,
        stake: 0x2::balance::Balance<T0>,
        success: bool,
    }

    struct Flip<phantom T0> has store, key {
        id: 0x2::object::UID,
        protocol_stake: 0x2::balance::Balance<T0>,
        n_challenges: u64,
        allowed_amounts: vector<u64>,
    }

    struct ChallengePlaced<phantom T0> has copy, drop {
        n_challenge: u64,
        challenge_id: address,
        challenger: address,
        stake: u64,
        success: bool,
    }

    struct ChallengeResolved<phantom T0> has copy, drop {
        n_challenge: u64,
        challenger: address,
        success: bool,
        stake: u64,
        new_protocol_stake: u64,
    }

    public fun add_to_protocol_stake<T0>(arg0: &mut Flip<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.protocol_stake, 0x2::coin::into_balance<T0>(arg1));
    }

    fun calculate_protocol_stake_amount(arg0: u64) : u64 {
        arg0 * 95 / 100
    }

    public fun challenge<T0>(arg0: &mut Flip<T0>, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(0x1::vector::contains<u64>(&arg0.allowed_amounts, &v0), 9223372423401832447);
        let v1 = 0x2::coin::into_balance<T0>(arg1);
        0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(&mut arg0.protocol_stake, calculate_protocol_stake_amount(v0)));
        let v2 = arg0.n_challenges;
        arg0.n_challenges = arg0.n_challenges + 1;
        let v3 = ChallengeReceipt<T0>{
            id          : 0x2::object::new(arg4),
            n_challenge : v2,
            challenger  : 0x2::tx_context::sender(arg4),
            stake       : v1,
            success     : false,
        };
        let v4 = ChallengePlaced<T0>{
            n_challenge  : v2,
            challenge_id : 0x2::object::uid_to_address(&v3.id),
            challenger   : 0x2::tx_context::sender(arg4),
            stake        : v0,
            success      : false,
        };
        let v5 = 0x2::random::new_generator(arg3, arg4);
        let v6 = 0x2::random::generate_bool(&mut v5) == arg2;
        v3.success = v6;
        v4.success = v6;
        0x2::event::emit<ChallengePlaced<T0>>(v4);
        0x2::transfer::share_object<ChallengeReceipt<T0>>(v3);
    }

    public fun create_flip_instance<T0>(arg0: &AdminCap, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Flip<T0>{
            id              : 0x2::object::new(arg2),
            protocol_stake  : 0x2::balance::zero<T0>(),
            n_challenges    : 0,
            allowed_amounts : arg1,
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

    public fun resolve_challenge<T0>(arg0: &mut Flip<T0>, arg1: ChallengeReceipt<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let ChallengeReceipt {
            id          : v0,
            n_challenge : v1,
            challenger  : v2,
            stake       : v3,
            success     : v4,
        } = arg1;
        let v5 = v3;
        0x2::object::delete(v0);
        if (v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg2), v2);
        } else {
            0x2::balance::join<T0>(&mut arg0.protocol_stake, v5);
        };
        let v6 = ChallengeResolved<T0>{
            n_challenge        : v1,
            challenger         : v2,
            success            : v4,
            stake              : 0x2::balance::value<T0>(&v5),
            new_protocol_stake : 0x2::balance::value<T0>(&arg0.protocol_stake),
        };
        0x2::event::emit<ChallengeResolved<T0>>(v6);
    }

    public fun take_from_protocol_stake<T0>(arg0: &AdminCap, arg1: &mut Flip<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.protocol_stake, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

