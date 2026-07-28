module 0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::claim {
    struct ClaimRegistry has key {
        id: 0x2::object::UID,
        minter: 0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::MinterCap,
        roots: 0x2::table::Table<u64, vector<u8>>,
        claimed: 0x2::table::Table<ClaimKey, bool>,
        distributed: 0x2::table::Table<u64, u64>,
        reserved: 0x2::table::Table<u64, u64>,
        closed: 0x2::table::Table<u64, bool>,
        paused: bool,
    }

    struct ClaimKey has copy, drop, store {
        epoch: u64,
        who: address,
    }

    struct RootPublished has copy, drop {
        epoch: u64,
        root: vector<u8>,
        total_base: u64,
        reserved: u64,
    }

    struct Claimed has copy, drop {
        epoch: u64,
        who: address,
        amount: u64,
    }

    struct EpochClosed has copy, drop {
        epoch: u64,
        reserved: u64,
        distributed: u64,
        released: u64,
    }

    struct PausedSet has copy, drop {
        paused: bool,
    }

    public fun claim(arg0: &mut ClaimRegistry, arg1: &mut 0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::MintController, arg2: u64, arg3: u64, arg4: vector<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA> {
        assert!(!arg0.paused, 4);
        assert!(arg3 > 0, 5);
        assert!(0x2::table::contains<u64, vector<u8>>(&arg0.roots, arg2), 1);
        assert!(!0x2::table::contains<u64, bool>(&arg0.closed, arg2), 7);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = ClaimKey{
            epoch : arg2,
            who   : v0,
        };
        assert!(!0x2::table::contains<ClaimKey, bool>(&arg0.claimed, v1), 2);
        assert!(verify_proof(&arg4, *0x2::table::borrow<u64, vector<u8>>(&arg0.roots, arg2), leaf_hash(v0, arg3)), 3);
        let v2 = 0x2::table::borrow_mut<u64, u64>(&mut arg0.distributed, arg2);
        assert!(*v2 + arg3 <= *0x2::table::borrow<u64, u64>(&arg0.reserved, arg2), 8);
        *v2 = *v2 + arg3;
        0x2::table::add<ClaimKey, bool>(&mut arg0.claimed, v1, true);
        let v3 = Claimed{
            epoch  : arg2,
            who    : v0,
            amount : arg3,
        };
        0x2::event::emit<Claimed>(v3);
        0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::mint(arg1, &arg0.minter, arg3, arg5)
    }

    public fun claim_to_sender(arg0: &mut ClaimRegistry, arg1: &mut 0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::MintController, arg2: u64, arg3: u64, arg4: vector<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = claim(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun close_epoch(arg0: &0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::AdminCap, arg1: &mut ClaimRegistry, arg2: &mut 0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::emission::EmissionSchedule, arg3: u64) : u64 {
        assert!(0x2::table::contains<u64, vector<u8>>(&arg1.roots, arg3), 1);
        assert!(!0x2::table::contains<u64, bool>(&arg1.closed, arg3), 7);
        let v0 = *0x2::table::borrow<u64, u64>(&arg1.reserved, arg3);
        let v1 = *0x2::table::borrow<u64, u64>(&arg1.distributed, arg3);
        let v2 = v0 - v1;
        0x2::table::add<u64, bool>(&mut arg1.closed, arg3, true);
        if (v2 > 0) {
            0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::emission::release(arg2, v2);
        };
        let v3 = EpochClosed{
            epoch       : arg3,
            reserved    : v0,
            distributed : v1,
            released    : v2,
        };
        0x2::event::emit<EpochClosed>(v3);
        v2
    }

    public fun create_registry(arg0: &0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimRegistry{
            id          : 0x2::object::new(arg1),
            minter      : 0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::issue_minter(arg0, arg1),
            roots       : 0x2::table::new<u64, vector<u8>>(arg1),
            claimed     : 0x2::table::new<ClaimKey, bool>(arg1),
            distributed : 0x2::table::new<u64, u64>(arg1),
            reserved    : 0x2::table::new<u64, u64>(arg1),
            closed      : 0x2::table::new<u64, bool>(arg1),
            paused      : false,
        };
        0x2::transfer::share_object<ClaimRegistry>(v0);
    }

    public fun distributed_in(arg0: &ClaimRegistry, arg1: u64) : u64 {
        *0x2::table::borrow<u64, u64>(&arg0.distributed, arg1)
    }

    public fun has_claimed(arg0: &ClaimRegistry, arg1: u64, arg2: address) : bool {
        let v0 = ClaimKey{
            epoch : arg1,
            who   : arg2,
        };
        0x2::table::contains<ClaimKey, bool>(&arg0.claimed, v0)
    }

    public fun has_root(arg0: &ClaimRegistry, arg1: u64) : bool {
        0x2::table::contains<u64, vector<u8>>(&arg0.roots, arg1)
    }

    fun hash_pair(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        if (lte(&arg0, &arg1)) {
            0x1::vector::append<u8>(&mut v0, arg0);
            0x1::vector::append<u8>(&mut v0, arg1);
        } else {
            0x1::vector::append<u8>(&mut v0, arg1);
            0x1::vector::append<u8>(&mut v0, arg0);
        };
        0x1::hash::sha2_256(v0)
    }

    public fun is_closed(arg0: &ClaimRegistry, arg1: u64) : bool {
        0x2::table::contains<u64, bool>(&arg0.closed, arg1)
    }

    public fun is_paused(arg0: &ClaimRegistry) : bool {
        arg0.paused
    }

    public fun leaf_hash(arg0: address, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::hash::sha2_256(v0)
    }

    fun lte(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<u8>(arg0, v3);
            let v5 = *0x1::vector::borrow<u8>(arg1, v3);
            if (v4 < v5) {
                return true
            };
            if (v4 > v5) {
                return false
            };
            v3 = v3 + 1;
        };
        v0 <= v1
    }

    public fun publish_root(arg0: &0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::AdminCap, arg1: &mut ClaimRegistry, arg2: &mut 0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::emission::EmissionSchedule, arg3: u64, arg4: vector<u8>, arg5: u64) : u64 {
        assert!(0x1::vector::length<u8>(&arg4) == 32, 6);
        assert!(!0x2::table::contains<u64, vector<u8>>(&arg1.roots, arg3), 0);
        assert!(arg5 > 0, 5);
        let v0 = 0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::emission::reserve(arg2, arg5);
        0x2::table::add<u64, vector<u8>>(&mut arg1.roots, arg3, arg4);
        0x2::table::add<u64, u64>(&mut arg1.distributed, arg3, 0);
        0x2::table::add<u64, u64>(&mut arg1.reserved, arg3, v0);
        let v1 = RootPublished{
            epoch      : arg3,
            root       : arg4,
            total_base : arg5,
            reserved   : v0,
        };
        0x2::event::emit<RootPublished>(v1);
        v0
    }

    public fun reserved_for(arg0: &ClaimRegistry, arg1: u64) : u64 {
        if (!0x2::table::contains<u64, u64>(&arg0.reserved, arg1)) {
            0
        } else {
            *0x2::table::borrow<u64, u64>(&arg0.reserved, arg1)
        }
    }

    public fun root_for(arg0: &ClaimRegistry, arg1: u64) : vector<u8> {
        *0x2::table::borrow<u64, vector<u8>>(&arg0.roots, arg1)
    }

    public fun set_paused(arg0: &0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::AdminCap, arg1: &mut ClaimRegistry, arg2: bool) {
        arg1.paused = arg2;
        let v0 = PausedSet{paused: arg2};
        0x2::event::emit<PausedSet>(v0);
    }

    public fun verify_proof(arg0: &vector<vector<u8>>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        let v0 = arg2;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg0)) {
            v0 = hash_pair(v0, *0x1::vector::borrow<vector<u8>>(arg0, v1));
            v1 = v1 + 1;
        };
        v0 == arg1
    }

    // decompiled from Move bytecode v7
}

