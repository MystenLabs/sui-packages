module 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::escrow_src_builder {
    struct EscrowSrcBuilder<phantom T0> has key {
        id: 0x2::object::UID,
        maker: address,
        taker: address,
        balance: 0x2::balance::Balance<T0>,
        hash_lock: vector<u8>,
        created_at: u64,
        timeout: u64,
    }

    struct BuilderCreated has copy, drop {
        builder_id: 0x2::object::ID,
        maker: address,
        taker: address,
        amount: u64,
        hash_lock: vector<u8>,
        timeout: u64,
    }

    struct BuilderRefunded has copy, drop {
        builder_id: 0x2::object::ID,
        maker: address,
        amount: u64,
    }

    struct BuilderUsed has copy, drop {
        builder_id: 0x2::object::ID,
        taker: address,
        escrow_id: 0x2::object::ID,
    }

    public fun can_complete<T0>(arg0: &EscrowSrcBuilder<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) <= arg0.timeout
    }

    public entry fun complete_escrow<T0>(arg0: EscrowSrcBuilder<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::capabilities::ResolverCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.taker, 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors::only_taker());
        assert!(0x2::clock::timestamp_ms(arg3) <= arg0.timeout, 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors::builder_expired());
        let EscrowSrcBuilder {
            id         : v0,
            maker      : v1,
            taker      : v2,
            balance    : v3,
            hash_lock  : v4,
            created_at : _,
            timeout    : _,
        } = arg0;
        let v7 = v0;
        let v8 = 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::escrow_src::new_escrow_src<T0>(v3, 0x2::coin::into_balance<0x2::sui::SUI>(arg1), v1, v2, v4, arg2, arg3, arg4);
        let v9 = BuilderUsed{
            builder_id : 0x2::object::uid_to_inner(&v7),
            taker      : v2,
            escrow_id  : 0x2::object::uid_to_inner(0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::escrow_src::get_escrow_id<T0>(&v8)),
        };
        0x2::event::emit<BuilderUsed>(v9);
        0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::escrow_src::share_escrow_src<T0>(v8);
        0x2::object::delete(v7);
    }

    public entry fun create_src_builder<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = EscrowSrcBuilder<T0>{
            id         : 0x2::object::new(arg4),
            maker      : v0,
            taker      : arg1,
            balance    : 0x2::coin::into_balance<T0>(arg0),
            hash_lock  : arg2,
            created_at : v1,
            timeout    : v1 + 3600000,
        };
        let v3 = BuilderCreated{
            builder_id : 0x2::object::uid_to_inner(&v2.id),
            maker      : v0,
            taker      : arg1,
            amount     : 0x2::balance::value<T0>(&v2.balance),
            hash_lock  : arg2,
            timeout    : v2.timeout,
        };
        0x2::event::emit<BuilderCreated>(v3);
        0x2::transfer::share_object<EscrowSrcBuilder<T0>>(v2);
    }

    public fun get_builder_info<T0>(arg0: &EscrowSrcBuilder<T0>) : (address, address, u64, vector<u8>, u64, u64) {
        (arg0.maker, arg0.taker, 0x2::balance::value<T0>(&arg0.balance), arg0.hash_lock, arg0.created_at, arg0.timeout)
    }

    public fun is_expired<T0>(arg0: &EscrowSrcBuilder<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > arg0.timeout
    }

    public entry fun refund_expired<T0>(arg0: EscrowSrcBuilder<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.timeout, 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors::builder_not_expired());
        assert!(0x2::tx_context::sender(arg2) == arg0.maker, 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors::only_maker());
        let EscrowSrcBuilder {
            id         : v0,
            maker      : v1,
            taker      : _,
            balance    : v3,
            hash_lock  : _,
            created_at : _,
            timeout    : _,
        } = arg0;
        let v7 = v3;
        let v8 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg2), v1);
        let v9 = BuilderRefunded{
            builder_id : 0x2::object::uid_to_inner(&v8),
            maker      : v1,
            amount     : 0x2::balance::value<T0>(&v7),
        };
        0x2::event::emit<BuilderRefunded>(v9);
        0x2::object::delete(v8);
    }

    // decompiled from Move bytecode v6
}

