module 0xe11651eb8a9255595e003db29098e7a2d10f0a123d60b031c66ed0c9bb5023c7::farm {
    struct Farm<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        reward: 0x2::balance::Balance<T0>,
        root: vector<u8>,
        root_epoch: u64,
        root_at_ms: u64,
        last_activity_ms: u64,
        declared_total: u64,
        paid_total: u64,
        claimed: 0x2::table::Table<address, u64>,
        max_per_claim: u64,
        claims_paused: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Funded has copy, drop {
        farm: address,
        from: address,
        amount: u64,
        pot: u64,
    }

    struct RootSet has copy, drop {
        farm: address,
        root_epoch: u64,
        root: vector<u8>,
        declared_total: u64,
        pot: u64,
        at_ms: u64,
    }

    struct Claimed has copy, drop {
        farm: address,
        who: address,
        amount: u64,
        cumulative_paid: u64,
        root_epoch: u64,
    }

    struct PausedSet has copy, drop {
        farm: address,
        paused: bool,
    }

    struct LeftoverBurned has copy, drop {
        farm: address,
        amount: u64,
        idle_ms: u64,
    }

    public fun burn_leftover<T0>(arg0: &mut Farm<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.last_activity_ms > 0, 5);
        assert!(v0 >= arg0.last_activity_ms + 15552000000, 5);
        let v1 = arg0.declared_total - arg0.paid_total;
        let v2 = 0x2::balance::value<T0>(&arg0.reward);
        assert!(v2 > v1, 8);
        let v3 = v2 - v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward, v3), arg2), @0x0);
        let v4 = LeftoverBurned{
            farm    : 0x2::object::uid_to_address(&arg0.id),
            amount  : v3,
            idle_ms : v0 - arg0.last_activity_ms,
        };
        0x2::event::emit<LeftoverBurned>(v4);
    }

    public fun claim<T0>(arg0: &mut Farm<T0>, arg1: u64, arg2: vector<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 0);
        assert!(!arg0.claims_paused, 1);
        assert!(0x1::vector::length<u8>(&arg0.root) == 32, 7);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::uid_to_address(&arg0.id);
        assert!(verify(&arg0.root, &arg2, v1, v0, arg1), 3);
        let v2 = if (0x2::table::contains<address, u64>(&arg0.claimed, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.claimed, v0)
        } else {
            0
        };
        assert!(arg1 > v2, 2);
        let v3 = arg1 - v2;
        let v4 = if (v3 > arg0.max_per_claim) {
            arg0.max_per_claim
        } else {
            v3
        };
        let v5 = v4;
        let v6 = 0x2::balance::value<T0>(&arg0.reward);
        if (v4 > v6) {
            v5 = v6;
        };
        assert!(v5 > 0, 2);
        if (0x2::table::contains<address, u64>(&arg0.claimed, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.claimed, v0) = v2 + v5;
        } else {
            0x2::table::add<address, u64>(&mut arg0.claimed, v0, v5);
        };
        arg0.paid_total = arg0.paid_total + v5;
        let v7 = Claimed{
            farm            : v1,
            who             : v0,
            amount          : v5,
            cumulative_paid : v2 + v5,
            root_epoch      : arg0.root_epoch,
        };
        0x2::event::emit<Claimed>(v7);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward, v5), arg3)
    }

    public fun claim_and_transfer<T0>(arg0: &mut Farm<T0>, arg1: u64, arg2: vector<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = claim<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun claimed_of<T0>(arg0: &Farm<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.claimed, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.claimed, arg1)
        } else {
            0
        }
    }

    public fun create<T0>(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 8);
        let v0 = Farm<T0>{
            id               : 0x2::object::new(arg2),
            version          : 1,
            reward           : 0x2::balance::zero<T0>(),
            root             : b"",
            root_epoch       : 0,
            root_at_ms       : 0,
            last_activity_ms : 0,
            declared_total   : 0,
            paid_total       : 0,
            claimed          : 0x2::table::new<address, u64>(arg2),
            max_per_claim    : arg1,
            claims_paused    : false,
        };
        0x2::transfer::share_object<Farm<T0>>(v0);
    }

    public fun declared_total<T0>(arg0: &Farm<T0>) : u64 {
        arg0.declared_total
    }

    public fun fund<T0>(arg0: &mut Farm<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 8);
        0x2::balance::join<T0>(&mut arg0.reward, 0x2::coin::into_balance<T0>(arg1));
        arg0.last_activity_ms = 0x2::clock::timestamp_ms(arg2);
        let v1 = Funded{
            farm   : 0x2::object::uid_to_address(&arg0.id),
            from   : 0x2::tx_context::sender(arg3),
            amount : v0,
            pot    : 0x2::balance::value<T0>(&arg0.reward),
        };
        0x2::event::emit<Funded>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused<T0>(arg0: &Farm<T0>) : bool {
        arg0.claims_paused
    }

    public fun last_activity_ms<T0>(arg0: &Farm<T0>) : u64 {
        arg0.last_activity_ms
    }

    public fun leaf_hash(arg0: address, arg1: address, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x2::hash::blake2b256(&v0)
    }

    fun lte(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v1 = *0x1::vector::borrow<u8>(arg0, v0);
            let v2 = *0x1::vector::borrow<u8>(arg1, v0);
            if (v1 < v2) {
                return true
            };
            if (v1 > v2) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun max_per_claim<T0>(arg0: &Farm<T0>) : u64 {
        arg0.max_per_claim
    }

    public fun migrate<T0>(arg0: &AdminCap, arg1: &mut Farm<T0>) {
        assert!(arg1.version < 1, 6);
        arg1.version = 1;
    }

    fun node_hash(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        if (lte(arg0, arg1)) {
            0x1::vector::append<u8>(&mut v0, *arg0);
            0x1::vector::append<u8>(&mut v0, *arg1);
        } else {
            0x1::vector::append<u8>(&mut v0, *arg1);
            0x1::vector::append<u8>(&mut v0, *arg0);
        };
        0x2::hash::blake2b256(&v0)
    }

    public fun outstanding<T0>(arg0: &Farm<T0>) : u64 {
        arg0.declared_total - arg0.paid_total
    }

    public fun paid_total<T0>(arg0: &Farm<T0>) : u64 {
        arg0.paid_total
    }

    public fun pot<T0>(arg0: &Farm<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reward)
    }

    public fun root<T0>(arg0: &Farm<T0>) : vector<u8> {
        arg0.root
    }

    public fun root_at_ms<T0>(arg0: &Farm<T0>) : u64 {
        arg0.root_at_ms
    }

    public fun root_epoch<T0>(arg0: &Farm<T0>) : u64 {
        arg0.root_epoch
    }

    public fun set_max_per_claim<T0>(arg0: &AdminCap, arg1: &mut Farm<T0>, arg2: u64) {
        assert!(arg1.version == 1, 0);
        assert!(arg2 > 0, 8);
        arg1.max_per_claim = arg2;
    }

    public fun set_paused<T0>(arg0: &AdminCap, arg1: &mut Farm<T0>, arg2: bool) {
        assert!(arg1.version == 1, 0);
        arg1.claims_paused = arg2;
        let v0 = PausedSet{
            farm   : 0x2::object::uid_to_address(&arg1.id),
            paused : arg2,
        };
        0x2::event::emit<PausedSet>(v0);
    }

    public fun set_root<T0>(arg0: &AdminCap, arg1: &mut Farm<T0>, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg1.version == 1, 0);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 7);
        assert!(arg3 >= arg1.paid_total, 7);
        assert!(arg3 - arg1.paid_total <= 0x2::balance::value<T0>(&arg1.reward), 4);
        arg1.root = arg2;
        arg1.declared_total = arg3;
        arg1.root_epoch = arg1.root_epoch + 1;
        arg1.root_at_ms = 0x2::clock::timestamp_ms(arg4);
        arg1.last_activity_ms = arg1.root_at_ms;
        let v0 = RootSet{
            farm           : 0x2::object::uid_to_address(&arg1.id),
            root_epoch     : arg1.root_epoch,
            root           : arg2,
            declared_total : arg3,
            pot            : 0x2::balance::value<T0>(&arg1.reward),
            at_ms          : arg1.root_at_ms,
        };
        0x2::event::emit<RootSet>(v0);
    }

    public fun verify(arg0: &vector<u8>, arg1: &vector<vector<u8>>, arg2: address, arg3: address, arg4: u64) : bool {
        let v0 = 0x1::vector::length<vector<u8>>(arg1);
        let v1 = 0;
        while (v1 < v0) {
            if (0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(arg1, v1)) != 32) {
                return false
            };
            v1 = v1 + 1;
        };
        let v2 = leaf_hash(arg2, arg3, arg4);
        v1 = 0;
        while (v1 < v0) {
            let v3 = &v2;
            v2 = node_hash(v3, 0x1::vector::borrow<vector<u8>>(arg1, v1));
            v1 = v1 + 1;
        };
        v2 == *arg0
    }

    // decompiled from Move bytecode v7
}

