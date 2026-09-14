module 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::season {
    struct Pending has copy, drop, store {
        season: u64,
        root: vector<u8>,
        amount: u64,
        ready_ms: u64,
    }

    struct Seasons has key {
        id: 0x2::object::UID,
        pending: 0x1::option::Option<Pending>,
        executed: u64,
    }

    struct Distributor has key {
        id: 0x2::object::UID,
        season: u64,
        root: vector<u8>,
        total: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        claimed: 0x2::table::Table<address, u64>,
        claim_until_ms: u64,
    }

    struct DistributionProposed has copy, drop {
        season: u64,
        root: vector<u8>,
        amount: u64,
        ready_ms: u64,
    }

    struct DistributionCancelled has copy, drop {
        season: u64,
    }

    struct DistributionCreated has copy, drop {
        season: u64,
        distributor_id: 0x2::object::ID,
        root: vector<u8>,
        amount: u64,
        claim_until_ms: u64,
    }

    struct SeasonClaimed has copy, drop {
        season: u64,
        account: address,
        amount: u64,
    }

    struct SeasonSwept has copy, drop {
        season: u64,
        amount: u64,
    }

    public fun cancel(arg0: &0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::AdminCap, arg1: &mut Seasons, arg2: &0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::Config) {
        0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::assert_version(arg2);
        assert!(0x1::option::is_some<Pending>(&arg1.pending), 700);
        let v0 = 0x1::option::extract<Pending>(&mut arg1.pending);
        let v1 = DistributionCancelled{season: v0.season};
        0x2::event::emit<DistributionCancelled>(v1);
    }

    public fun claim(arg0: &mut Distributor, arg1: &0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::Config, arg2: u64, arg3: vector<vector<u8>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::assert_version(arg1);
        assert!(0x2::clock::timestamp_ms(arg4) < arg0.claim_until_ms, 705);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!0x2::table::contains<address, u64>(&arg0.claimed, v0), 704);
        assert!(verify(&arg0.root, leaf(v0, arg2), &arg3), 703);
        0x2::table::add<address, u64>(&mut arg0.claimed, v0, arg2);
        let v1 = SeasonClaimed{
            season  : arg0.season,
            account : v0,
            amount  : arg2,
        };
        0x2::event::emit<SeasonClaimed>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg5)
    }

    public fun claimed_amount(arg0: &Distributor, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.claimed, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.claimed, arg1)
        } else {
            0
        }
    }

    public fun execute(arg0: &mut Seasons, arg1: &0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::Config, arg2: &mut 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::Treasury, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::assert_version(arg1);
        assert!(0x1::option::is_some<Pending>(&arg0.pending), 700);
        let v0 = *0x1::option::borrow<Pending>(&arg0.pending);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= v0.ready_ms, 701);
        arg0.pending = 0x1::option::none<Pending>();
        arg0.executed = arg0.executed + 1;
        let v2 = Distributor{
            id             : 0x2::object::new(arg4),
            season         : v0.season,
            root           : v0.root,
            total          : v0.amount,
            balance        : 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::take_season(arg2, v0.amount),
            claimed        : 0x2::table::new<address, u64>(arg4),
            claim_until_ms : v1 + 86400000,
        };
        let v3 = DistributionCreated{
            season         : v0.season,
            distributor_id : 0x2::object::id<Distributor>(&v2),
            root           : v0.root,
            amount         : v0.amount,
            claim_until_ms : v2.claim_until_ms,
        };
        0x2::event::emit<DistributionCreated>(v3);
        0x2::transfer::share_object<Distributor>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Seasons{
            id       : 0x2::object::new(arg0),
            pending  : 0x1::option::none<Pending>(),
            executed : 0,
        };
        0x2::transfer::share_object<Seasons>(v0);
    }

    public fun leaf(arg0: address, arg1: u64) : vector<u8> {
        let v0 = x"00";
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::hash::sha2_256(v0)
    }

    fun less_or_equal(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != *0x1::vector::borrow<u8>(arg1, v0)) {
                return *0x1::vector::borrow<u8>(arg0, v0) < *0x1::vector::borrow<u8>(arg1, v0)
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun node(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = x"01";
        if (less_or_equal(&arg0, &arg1)) {
            0x1::vector::append<u8>(&mut v0, arg0);
            0x1::vector::append<u8>(&mut v0, arg1);
        } else {
            0x1::vector::append<u8>(&mut v0, arg1);
            0x1::vector::append<u8>(&mut v0, arg0);
        };
        0x1::hash::sha2_256(v0)
    }

    public fun propose(arg0: &0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::AdminCap, arg1: &mut Seasons, arg2: &0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::Config, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock) {
        0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::assert_version(arg2);
        assert!(0x1::option::is_none<Pending>(&arg1.pending), 702);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 708);
        assert!(arg5 > 0, 707);
        let v0 = 0x2::clock::timestamp_ms(arg6) + 600000;
        let v1 = Pending{
            season   : arg3,
            root     : arg4,
            amount   : arg5,
            ready_ms : v0,
        };
        arg1.pending = 0x1::option::some<Pending>(v1);
        let v2 = DistributionProposed{
            season   : arg3,
            root     : arg4,
            amount   : arg5,
            ready_ms : v0,
        };
        0x2::event::emit<DistributionProposed>(v2);
    }

    public fun remaining(arg0: &Distributor) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun sweep(arg0: &mut Distributor, arg1: &0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::Config, arg2: &mut 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::Treasury, arg3: &0x2::clock::Clock) {
        0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::assert_version(arg1);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.claim_until_ms, 706);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v0 > 0, 707);
        0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::donate_season_balance(arg2, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance));
        let v1 = SeasonSwept{
            season : arg0.season,
            amount : v0,
        };
        0x2::event::emit<SeasonSwept>(v1);
    }

    public fun verify(arg0: &vector<u8>, arg1: vector<u8>, arg2: &vector<vector<u8>>) : bool {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg2)) {
            let v2 = v0;
            v0 = node(v2, *0x1::vector::borrow<vector<u8>>(arg2, v1));
            v1 = v1 + 1;
        };
        &v0 == arg0
    }

    // decompiled from Move bytecode v7
}

