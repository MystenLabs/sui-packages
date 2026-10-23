module 0xcda8001a0e6c3a499f55de906ab48186a614b5bba1e25bf338207da7c2731924::prize_pool {
    struct PrizePool<phantom T0> has key {
        id: 0x2::object::UID,
        season: 0x1::string::String,
        prizes: 0x2::balance::Balance<T0>,
        sponsors: vector<Sponsorship>,
        total_sponsored: u64,
        paid: bool,
    }

    struct Sponsorship has copy, drop, store {
        sponsor: address,
        amount: u64,
        name: 0x1::option::Option<0x1::string::String>,
    }

    struct PoolAdminCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        season: 0x1::string::String,
    }

    struct Sponsored has copy, drop {
        pool_id: 0x2::object::ID,
        sponsor: address,
        amount: u64,
        name: 0x1::option::Option<0x1::string::String>,
        total: u64,
    }

    struct PrizesPaid has copy, drop {
        pool_id: 0x2::object::ID,
        season: 0x1::string::String,
        total: u64,
        winners: vector<address>,
        amounts: vector<u64>,
        paid_at_ms: u64,
    }

    public fun value<T0>(arg0: &PrizePool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.prizes)
    }

    public fun amount(arg0: &Sponsorship) : u64 {
        arg0.amount
    }

    public fun bps_total() : u64 {
        10000
    }

    public fun create<T0>(arg0: &0xcda8001a0e6c3a499f55de906ab48186a614b5bba1e25bf338207da7c2731924::ledger::ResolverCap, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : PoolAdminCap {
        let v0 = PrizePool<T0>{
            id              : 0x2::object::new(arg2),
            season          : arg1,
            prizes          : 0x2::balance::zero<T0>(),
            sponsors        : 0x1::vector::empty<Sponsorship>(),
            total_sponsored : 0,
            paid            : false,
        };
        let v1 = 0x2::object::id<PrizePool<T0>>(&v0);
        let v2 = PoolCreated{
            pool_id : v1,
            season  : v0.season,
        };
        0x2::event::emit<PoolCreated>(v2);
        0x2::transfer::share_object<PrizePool<T0>>(v0);
        PoolAdminCap{
            id      : 0x2::object::new(arg2),
            pool_id : v1,
        }
    }

    public fun name(arg0: &Sponsorship) : 0x1::option::Option<0x1::string::String> {
        arg0.name
    }

    public fun paid<T0>(arg0: &PrizePool<T0>) : bool {
        arg0.paid
    }

    public fun payout<T0>(arg0: &PoolAdminCap, arg1: &mut PrizePool<T0>, arg2: vector<address>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.pool_id == 0x2::object::id<PrizePool<T0>>(arg1), 13906834749868998657);
        assert!(!arg1.paid, 13906834754164097027);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 > 0, 13906834762754162693);
        assert!(v0 <= 20, 13906834767049261063);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = v1 + 1;
            while (v2 < v0) {
                assert!(*0x1::vector::borrow<address>(&arg2, v1) != *0x1::vector::borrow<address>(&arg2, v2), 13906834784229261321);
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
        let v3 = 0x2::balance::value<T0>(&arg1.prizes);
        assert!(v3 > 0, 13906834805704359949);
        let v4 = split_amounts(v3, v0);
        let v5 = 0;
        while (v5 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.prizes, *0x1::vector::borrow<u64>(&v4, v5)), arg4), *0x1::vector::borrow<address>(&arg2, v5));
            v5 = v5 + 1;
        };
        arg1.paid = true;
        let v6 = PrizesPaid{
            pool_id    : 0x2::object::id<PrizePool<T0>>(arg1),
            season     : arg1.season,
            total      : v3,
            winners    : arg2,
            amounts    : v4,
            paid_at_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PrizesPaid>(v6);
    }

    public fun place_bps(arg0: u64) : u64 {
        if (arg0 == 0) {
            2500
        } else if (arg0 == 1) {
            1500
        } else if (arg0 == 2) {
            1000
        } else if (arg0 < 5) {
            600
        } else if (arg0 < 10) {
            360
        } else if (arg0 < 20) {
            200
        } else {
            0
        }
    }

    public fun pool_id(arg0: &PoolAdminCap) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun season<T0>(arg0: &PrizePool<T0>) : 0x1::string::String {
        arg0.season
    }

    public fun split_amounts(arg0: u64, arg1: u64) : vector<u64> {
        let v0 = 0;
        let v1 = 0;
        while (v1 < arg1) {
            v0 = v0 + place_bps(v1);
            v1 = v1 + 1;
        };
        let v2 = vector[];
        let v3 = 0;
        let v4 = 0;
        while (v4 < arg1) {
            let v5 = (((arg0 as u128) * (place_bps(v4) as u128) / (v0 as u128)) as u64);
            v3 = v3 + v5;
            0x1::vector::push_back<u64>(&mut v2, v5);
            v4 = v4 + 1;
        };
        if (arg1 > 0) {
            let v6 = 0x1::vector::borrow_mut<u64>(&mut v2, 0);
            *v6 = *v6 + arg0 - v3;
        };
        v2
    }

    public fun sponsor<T0>(arg0: &mut PrizePool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::option::Option<0x1::string::String>, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.paid, 13906834672559718403);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 13906834681150177291);
        0x2::balance::join<T0>(&mut arg0.prizes, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_sponsored = arg0.total_sponsored + v0;
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = Sponsorship{
            sponsor : v1,
            amount  : v0,
            name    : arg2,
        };
        0x1::vector::push_back<Sponsorship>(&mut arg0.sponsors, v2);
        let v3 = Sponsored{
            pool_id : 0x2::object::id<PrizePool<T0>>(arg0),
            sponsor : v1,
            amount  : v0,
            name    : arg2,
            total   : arg0.total_sponsored,
        };
        0x2::event::emit<Sponsored>(v3);
    }

    public fun sponsor_address(arg0: &Sponsorship) : address {
        arg0.sponsor
    }

    public fun sponsors<T0>(arg0: &PrizePool<T0>) : &vector<Sponsorship> {
        &arg0.sponsors
    }

    public fun total_sponsored<T0>(arg0: &PrizePool<T0>) : u64 {
        arg0.total_sponsored
    }

    // decompiled from Move bytecode v7
}

