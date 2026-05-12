module 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::tier10_distributor {
    struct Tier10Distributor<phantom T0> has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        current_root: vector<u8>,
        total_distributed: u64,
        last_draw_id: u64,
        user_claimed_cumulative: 0x2::table::Table<address, u64>,
    }

    struct MerkleRootCommittedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        draw_id: u64,
        root: vector<u8>,
        total_distributed: u64,
        timestamp_ms: u64,
    }

    struct Tier10ClaimedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        cumulative_now: u64,
        paid: u64,
        timestamp_ms: u64,
    }

    public fun claim_with_proof_stub<T0>(arg0: &mut Tier10Distributor<T0>, arg1: vector<vector<u8>>, arg2: u64, arg3: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (0x2::table::contains<address, u64>(&arg0.user_claimed_cumulative, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.user_claimed_cumulative, v0)
        } else {
            0
        };
        assert!(arg2 > v1, 2);
        if (0x2::table::contains<address, u64>(&arg0.user_claimed_cumulative, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.user_claimed_cumulative, v0) = arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.user_claimed_cumulative, v0, arg2);
        };
        arg2 - v1
    }

    public fun commit_merkle_root<T0>(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::AdminCap, arg1: &mut Tier10Distributor<T0>, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: u64) {
        assert!(arg4 >= arg1.total_distributed, 4);
        arg1.current_root = arg3;
        arg1.total_distributed = arg4;
        arg1.last_draw_id = arg2;
        let v0 = MerkleRootCommittedEvent{
            pool_id           : arg1.pool_id,
            draw_id           : arg2,
            root              : arg3,
            total_distributed : arg4,
            timestamp_ms      : arg5,
        };
        0x2::event::emit<MerkleRootCommittedEvent>(v0);
    }

    public fun create_distributor<T0>(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::AdminCap, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Tier10Distributor<T0>{
            id                      : 0x2::object::new(arg2),
            pool_id                 : arg1,
            current_root            : 0x1::vector::empty<u8>(),
            total_distributed       : 0,
            last_draw_id            : 0,
            user_claimed_cumulative : 0x2::table::new<address, u64>(arg2),
        };
        0x2::transfer::share_object<Tier10Distributor<T0>>(v0);
    }

    public fun current_root<T0>(arg0: &Tier10Distributor<T0>) : vector<u8> {
        arg0.current_root
    }

    public fun pool_id<T0>(arg0: &Tier10Distributor<T0>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun total_distributed<T0>(arg0: &Tier10Distributor<T0>) : u64 {
        arg0.total_distributed
    }

    public fun user_claimed<T0>(arg0: &Tier10Distributor<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.user_claimed_cumulative, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_claimed_cumulative, arg1)
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

