module 0x8cb4c1f5e6bdd5c22c734c6d273b2fa16e790e374eac13225051263df3961028::fusion_plus {
    struct FusionOrder<phantom T0> has store, key {
        id: 0x2::object::UID,
        maker: address,
        source_chain_id: u64,
        dest_chain_id: u64,
        source_token: vector<u8>,
        dest_token: vector<u8>,
        amount_in: u64,
        amount_out_min: u64,
        deadline: u64,
        hash_lock: vector<u8>,
        filled: bool,
        htlc_contract_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct Resolver has store, key {
        id: 0x2::object::UID,
        resolver_address: address,
        supported_chains: vector<u64>,
        reputation_score: u64,
        active: bool,
    }

    struct SwapState<phantom T0> has store, key {
        id: 0x2::object::UID,
        order_id: 0x2::object::ID,
        source_htlc_id: 0x1::option::Option<0x2::object::ID>,
        dest_htlc_id: 0x1::option::Option<0x2::object::ID>,
        secret: 0x1::option::Option<vector<u8>>,
        status: u8,
    }

    struct OrderCreated has copy, drop {
        order_id: 0x2::object::ID,
        maker: address,
        source_chain_id: u64,
        dest_chain_id: u64,
        amount_in: u64,
        amount_out_min: u64,
        deadline: u64,
    }

    struct OrderFilled has copy, drop {
        order_id: 0x2::object::ID,
        resolver: address,
        htlc_id: 0x2::object::ID,
    }

    struct SwapCompleted has copy, drop {
        order_id: 0x2::object::ID,
        secret: vector<u8>,
    }

    public fun complete_swap<T0>(arg0: &FusionOrder<T0>, arg1: &mut 0x8cb4c1f5e6bdd5c22c734c6d273b2fa16e790e374eac13225051263df3961028::htlc::HTLCContract<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.filled, 1);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.htlc_contract_id), 1);
        assert!(0x2::object::id<0x8cb4c1f5e6bdd5c22c734c6d273b2fa16e790e374eac13225051263df3961028::htlc::HTLCContract<T0>>(arg1) == *0x1::option::borrow<0x2::object::ID>(&arg0.htlc_contract_id), 1);
        let v0 = SwapCompleted{
            order_id : 0x2::object::uid_to_inner(&arg0.id),
            secret   : arg2,
        };
        0x2::event::emit<SwapCompleted>(v0);
        0x8cb4c1f5e6bdd5c22c734c6d273b2fa16e790e374eac13225051263df3961028::htlc::complete_htlc<T0>(arg1, arg2, arg3, arg4)
    }

    public fun create_order<T0>(arg0: u64, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) : FusionOrder<T0> {
        let v0 = 0x2::object::new(arg8);
        let v1 = FusionOrder<T0>{
            id               : v0,
            maker            : 0x2::tx_context::sender(arg8),
            source_chain_id  : arg0,
            dest_chain_id    : arg1,
            source_token     : arg2,
            dest_token       : arg3,
            amount_in        : arg4,
            amount_out_min   : arg5,
            deadline         : arg6,
            hash_lock        : arg7,
            filled           : false,
            htlc_contract_id : 0x1::option::none<0x2::object::ID>(),
        };
        let v2 = OrderCreated{
            order_id        : 0x2::object::uid_to_inner(&v0),
            maker           : 0x2::tx_context::sender(arg8),
            source_chain_id : arg0,
            dest_chain_id   : arg1,
            amount_in       : arg4,
            amount_out_min  : arg5,
            deadline        : arg6,
        };
        0x2::event::emit<OrderCreated>(v2);
        v1
    }

    public fun destroy_order<T0>(arg0: FusionOrder<T0>) {
        let FusionOrder {
            id               : v0,
            maker            : _,
            source_chain_id  : _,
            dest_chain_id    : _,
            source_token     : _,
            dest_token       : _,
            amount_in        : _,
            amount_out_min   : _,
            deadline         : _,
            hash_lock        : _,
            filled           : _,
            htlc_contract_id : v11,
        } = arg0;
        0x1::option::destroy_with_default<0x2::object::ID>(v11, 0x2::object::id_from_address(@0x0));
        0x2::object::delete(v0);
    }

    public fun fill_order<T0>(arg0: &mut FusionOrder<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &Resolver, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.filled, 5);
        assert!(arg2.active, 3);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.deadline, 2);
        let v0 = 0x8cb4c1f5e6bdd5c22c734c6d273b2fa16e790e374eac13225051263df3961028::htlc::create_htlc<T0>(arg1, arg0.maker, arg0.hash_lock, arg0.deadline, arg3, arg4);
        let v1 = 0x2::object::id<0x8cb4c1f5e6bdd5c22c734c6d273b2fa16e790e374eac13225051263df3961028::htlc::HTLCContract<T0>>(&v0);
        arg0.htlc_contract_id = 0x1::option::some<0x2::object::ID>(v1);
        arg0.filled = true;
        0x2::transfer::public_share_object<0x8cb4c1f5e6bdd5c22c734c6d273b2fa16e790e374eac13225051263df3961028::htlc::HTLCContract<T0>>(v0);
        let v2 = OrderFilled{
            order_id : 0x2::object::uid_to_inner(&arg0.id),
            resolver : 0x2::tx_context::sender(arg4),
            htlc_id  : v1,
        };
        0x2::event::emit<OrderFilled>(v2);
    }

    public fun get_hash_lock<T0>(arg0: &FusionOrder<T0>) : vector<u8> {
        arg0.hash_lock
    }

    public fun get_order_amount_in<T0>(arg0: &FusionOrder<T0>) : u64 {
        arg0.amount_in
    }

    public fun get_order_amount_out_min<T0>(arg0: &FusionOrder<T0>) : u64 {
        arg0.amount_out_min
    }

    public fun get_order_deadline<T0>(arg0: &FusionOrder<T0>) : u64 {
        arg0.deadline
    }

    public fun get_order_maker<T0>(arg0: &FusionOrder<T0>) : address {
        arg0.maker
    }

    public fun is_order_filled<T0>(arg0: &FusionOrder<T0>) : bool {
        arg0.filled
    }

    public fun register_resolver(arg0: vector<u64>, arg1: &mut 0x2::tx_context::TxContext) : Resolver {
        Resolver{
            id               : 0x2::object::new(arg1),
            resolver_address : 0x2::tx_context::sender(arg1),
            supported_chains : arg0,
            reputation_score : 0,
            active           : true,
        }
    }

    public fun update_resolver_status(arg0: &mut Resolver, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.resolver_address == 0x2::tx_context::sender(arg2), 3);
        arg0.active = arg1;
    }

    // decompiled from Move bytecode v6
}

