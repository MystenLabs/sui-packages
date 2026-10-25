module 0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::community {
    struct CommunityPool<phantom T0> has key {
        id: 0x2::object::UID,
        treasury: address,
        started_ms: u64,
        remaining: 0x2::balance::Balance<T0>,
    }

    struct CommunityClaimed<phantom T0> has copy, drop {
        pool: 0x2::object::ID,
        amount: u64,
    }

    public fun claim<T0>(arg0: &mut CommunityPool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.treasury, 0);
        let v0 = claimable<T0>(arg0, arg1);
        assert!(v0 > 0, 1);
        let v1 = CommunityClaimed<T0>{
            pool   : 0x2::object::id<CommunityPool<T0>>(arg0),
            amount : v0,
        };
        0x2::event::emit<CommunityClaimed<T0>>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.remaining, v0), arg2)
    }

    public fun claimable<T0>(arg0: &CommunityPool<T0>, arg1: &0x2::clock::Clock) : u64 {
        (((0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::amounts::community_tokens() as u128) * (0x1::u64::min(0x2::clock::timestamp_ms(arg1) - arg0.started_ms, 0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::amounts::duration_ms()) as u128) / (0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::amounts::duration_ms() as u128)) as u64) - 0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::amounts::community_tokens() - 0x2::balance::value<T0>(&arg0.remaining)
    }

    public(friend) fun create<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : CommunityPool<T0> {
        assert!(0x2::balance::value<T0>(&arg0) == 0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::amounts::community_tokens(), 2);
        CommunityPool<T0>{
            id         : 0x2::object::new(arg3),
            treasury   : arg1,
            started_ms : 0x2::clock::timestamp_ms(arg2),
            remaining  : arg0,
        }
    }

    public fun remaining<T0>(arg0: &CommunityPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.remaining)
    }

    public(friend) fun share<T0>(arg0: CommunityPool<T0>) {
        0x2::transfer::share_object<CommunityPool<T0>>(arg0);
    }

    // decompiled from Move bytecode v7
}

