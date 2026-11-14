module 0x5c234318e08445515b17fc471416c3eb5c9e31cf69e77cf9f83283785974801::bounty {
    struct Bounty<phantom T0> has key {
        id: 0x2::object::UID,
        poster: address,
        title: 0x1::string::String,
        spec_uri: 0x1::string::String,
        reward: 0x2::balance::Balance<T0>,
        reward_value: u64,
        deadline_ms: u64,
        claimant: 0x1::option::Option<address>,
        work_uri: 0x1::option::Option<0x1::string::String>,
        status: u8,
    }

    struct BountyCreated has copy, drop {
        bounty_id: 0x2::object::ID,
        poster: address,
        reward: u64,
        deadline_ms: u64,
    }

    struct BountyClaimed has copy, drop {
        bounty_id: 0x2::object::ID,
        claimant: address,
    }

    struct WorkSubmitted has copy, drop {
        bounty_id: 0x2::object::ID,
        claimant: address,
        work_uri: 0x1::string::String,
    }

    struct BountyReleased has copy, drop {
        bounty_id: 0x2::object::ID,
        claimant: address,
        amount: u64,
        by_poster: bool,
    }

    struct BountyRefunded has copy, drop {
        bounty_id: 0x2::object::ID,
        poster: address,
        amount: u64,
    }

    public fun approve<T0>(arg0: &mut Bounty<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.poster, 8);
        assert!(arg0.status == 2, 9);
        pay_claimant<T0>(arg0, true, arg1);
    }

    public fun claim<T0>(arg0: &mut Bounty<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 3);
        assert!(0x2::tx_context::sender(arg2) != arg0.poster, 4);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.deadline_ms, 5);
        arg0.claimant = 0x1::option::some<address>(0x2::tx_context::sender(arg2));
        arg0.status = 1;
        let v0 = BountyClaimed{
            bounty_id : 0x2::object::id<Bounty<T0>>(arg0),
            claimant  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<BountyClaimed>(v0);
    }

    public fun claimant<T0>(arg0: &Bounty<T0>) : 0x1::option::Option<address> {
        arg0.claimant
    }

    public fun create<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(*0x1::type_name::as_string(&v0) == 0x1::ascii::string(b"46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE"), 12);
        create_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun create_inner<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = if (0x1::string::length(&arg1) > 0) {
            if (0x1::string::length(&arg1) <= 300) {
                0x1::string::length(&arg2) <= 300
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 11);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg3 >= v2 + 3600000 && arg3 <= v2 + 7776000000, 2);
        let v3 = Bounty<T0>{
            id           : 0x2::object::new(arg5),
            poster       : 0x2::tx_context::sender(arg5),
            title        : arg1,
            spec_uri     : arg2,
            reward       : 0x2::coin::into_balance<T0>(arg0),
            reward_value : v0,
            deadline_ms  : arg3,
            claimant     : 0x1::option::none<address>(),
            work_uri     : 0x1::option::none<0x1::string::String>(),
            status       : 0,
        };
        let v4 = 0x2::object::id<Bounty<T0>>(&v3);
        let v5 = BountyCreated{
            bounty_id   : v4,
            poster      : v3.poster,
            reward      : v0,
            deadline_ms : arg3,
        };
        0x2::event::emit<BountyCreated>(v5);
        0x2::transfer::share_object<Bounty<T0>>(v3);
        v4
    }

    public fun deadline_ms<T0>(arg0: &Bounty<T0>) : u64 {
        arg0.deadline_ms
    }

    fun pay_claimant<T0>(arg0: &mut Bounty<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x1::option::borrow<address>(&arg0.claimant);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.reward), arg2), v0);
        arg0.status = 3;
        let v1 = BountyReleased{
            bounty_id : 0x2::object::id<Bounty<T0>>(arg0),
            claimant  : v0,
            amount    : 0x2::balance::value<T0>(&arg0.reward),
            by_poster : arg1,
        };
        0x2::event::emit<BountyReleased>(v1);
    }

    public fun poster<T0>(arg0: &Bounty<T0>) : address {
        arg0.poster
    }

    public fun refund<T0>(arg0: &mut Bounty<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.poster, 8);
        assert!(arg0.status == 0 || arg0.status == 1, 3);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.deadline_ms, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.reward), arg2), arg0.poster);
        arg0.status = 4;
        let v0 = BountyRefunded{
            bounty_id : 0x2::object::id<Bounty<T0>>(arg0),
            poster    : arg0.poster,
            amount    : 0x2::balance::value<T0>(&arg0.reward),
        };
        0x2::event::emit<BountyRefunded>(v0);
    }

    public fun release_after_review<T0>(arg0: &mut Bounty<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 9);
        assert!(arg0.claimant == 0x1::option::some<address>(0x2::tx_context::sender(arg2)), 6);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.deadline_ms + 604800000, 10);
        pay_claimant<T0>(arg0, false, arg2);
    }

    public fun review_ms() : u64 {
        604800000
    }

    public fun reward_left<T0>(arg0: &Bounty<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reward)
    }

    public fun status<T0>(arg0: &Bounty<T0>) : u8 {
        arg0.status
    }

    public fun submit<T0>(arg0: &mut Bounty<T0>, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 7);
        assert!(arg0.claimant == 0x1::option::some<address>(0x2::tx_context::sender(arg3)), 6);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.deadline_ms, 5);
        assert!(0x1::string::length(&arg1) > 0 && 0x1::string::length(&arg1) <= 300, 11);
        arg0.work_uri = 0x1::option::some<0x1::string::String>(arg1);
        arg0.status = 2;
        let v0 = WorkSubmitted{
            bounty_id : 0x2::object::id<Bounty<T0>>(arg0),
            claimant  : 0x2::tx_context::sender(arg3),
            work_uri  : arg1,
        };
        0x2::event::emit<WorkSubmitted>(v0);
    }

    // decompiled from Move bytecode v7
}

