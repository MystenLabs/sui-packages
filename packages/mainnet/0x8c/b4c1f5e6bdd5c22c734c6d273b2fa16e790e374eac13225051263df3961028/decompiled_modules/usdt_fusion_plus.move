module 0x8cb4c1f5e6bdd5c22c734c6d273b2fa16e790e374eac13225051263df3961028::usdt_fusion_plus {
    struct USDTFusionOrder<phantom T0> has store, key {
        id: 0x2::object::UID,
        maker: address,
        source_chain_id: 0x1::string::String,
        dest_chain_id: 0x1::string::String,
        source_token: 0x1::string::String,
        dest_token: 0x1::string::String,
        amount_in: u64,
        amount_out_min: u64,
        deadline: u64,
        hash_lock: vector<u8>,
        filled: bool,
        htlc_contract_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct USDTResolver has store, key {
        id: 0x2::object::UID,
        resolver_address: address,
        supported_chains: vector<0x1::string::String>,
        reputation_score: u64,
        active: bool,
    }

    struct USDTOrderCreated<phantom T0> has copy, drop {
        order_id: address,
        maker: address,
        source_chain_id: 0x1::string::String,
        dest_chain_id: 0x1::string::String,
        amount_in: u64,
        amount_out_min: u64,
        deadline: u64,
    }

    struct USDTOrderFilled<phantom T0> has copy, drop {
        order_id: address,
        resolver: address,
        htlc_id: address,
    }

    struct USDTSwapCompleted<phantom T0> has copy, drop {
        order_id: address,
        secret: vector<u8>,
    }

    struct USDTResolverRegistered has copy, drop {
        resolver: address,
        supported_chains: vector<0x1::string::String>,
    }

    public fun complete_usdt_swap<T0>(arg0: &USDTFusionOrder<T0>, arg1: &mut 0x8cb4c1f5e6bdd5c22c734c6d273b2fa16e790e374eac13225051263df3961028::usdt_htlc::USDTHTLCContract<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.filled, 1);
        assert!(0x2::tx_context::sender(arg4) == arg0.maker, 3);
        let v0 = USDTSwapCompleted<T0>{
            order_id : 0x2::object::uid_to_address(&arg0.id),
            secret   : arg2,
        };
        0x2::event::emit<USDTSwapCompleted<T0>>(v0);
        0x8cb4c1f5e6bdd5c22c734c6d273b2fa16e790e374eac13225051263df3961028::usdt_htlc::complete_usdt_htlc<T0>(arg1, arg2, arg3, arg4)
    }

    public fun create_usdt_order<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : USDTFusionOrder<T0> {
        assert!(arg6 > 0x2::clock::timestamp_ms(arg8), 2);
        assert!(arg0 != arg1, 5);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::object::new(arg9);
        let v2 = USDTFusionOrder<T0>{
            id               : v1,
            maker            : v0,
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
        let v3 = USDTOrderCreated<T0>{
            order_id        : 0x2::object::uid_to_address(&v1),
            maker           : v0,
            source_chain_id : arg0,
            dest_chain_id   : arg1,
            amount_in       : arg4,
            amount_out_min  : arg5,
            deadline        : arg6,
        };
        0x2::event::emit<USDTOrderCreated<T0>>(v3);
        v2
    }

    public fun destroy_empty_order<T0>(arg0: USDTFusionOrder<T0>) {
        let USDTFusionOrder {
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
            htlc_contract_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_resolver(arg0: USDTResolver) {
        let USDTResolver {
            id               : v0,
            resolver_address : _,
            supported_chains : _,
            reputation_score : _,
            active           : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun fill_usdt_order<T0>(arg0: &mut USDTFusionOrder<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &USDTResolver, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.filled, 4);
        assert!(arg2.active, 3);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.deadline, 2);
        assert!(0x2::tx_context::sender(arg4) == arg2.resolver_address, 3);
        let v0 = 0x8cb4c1f5e6bdd5c22c734c6d273b2fa16e790e374eac13225051263df3961028::usdt_htlc::create_usdt_htlc<T0>(arg1, arg0.maker, arg0.hash_lock, arg0.deadline, arg3, arg4);
        let v1 = 0x2::object::id<0x8cb4c1f5e6bdd5c22c734c6d273b2fa16e790e374eac13225051263df3961028::usdt_htlc::USDTHTLCContract<T0>>(&v0);
        arg0.htlc_contract_id = 0x1::option::some<0x2::object::ID>(v1);
        arg0.filled = true;
        0x2::transfer::public_share_object<0x8cb4c1f5e6bdd5c22c734c6d273b2fa16e790e374eac13225051263df3961028::usdt_htlc::USDTHTLCContract<T0>>(v0);
        let v2 = USDTOrderFilled<T0>{
            order_id : 0x2::object::uid_to_address(&arg0.id),
            resolver : arg2.resolver_address,
            htlc_id  : 0x2::object::id_to_address(&v1),
        };
        0x2::event::emit<USDTOrderFilled<T0>>(v2);
    }

    public fun get_order_amount_in<T0>(arg0: &USDTFusionOrder<T0>) : u64 {
        arg0.amount_in
    }

    public fun get_order_amount_out_min<T0>(arg0: &USDTFusionOrder<T0>) : u64 {
        arg0.amount_out_min
    }

    public fun get_order_deadline<T0>(arg0: &USDTFusionOrder<T0>) : u64 {
        arg0.deadline
    }

    public fun get_order_dest_chain<T0>(arg0: &USDTFusionOrder<T0>) : 0x1::string::String {
        arg0.dest_chain_id
    }

    public fun get_order_hash_lock<T0>(arg0: &USDTFusionOrder<T0>) : vector<u8> {
        arg0.hash_lock
    }

    public fun get_order_htlc_id<T0>(arg0: &USDTFusionOrder<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.htlc_contract_id
    }

    public fun get_order_maker<T0>(arg0: &USDTFusionOrder<T0>) : address {
        arg0.maker
    }

    public fun get_order_source_chain<T0>(arg0: &USDTFusionOrder<T0>) : 0x1::string::String {
        arg0.source_chain_id
    }

    public fun get_resolver_address(arg0: &USDTResolver) : address {
        arg0.resolver_address
    }

    public fun get_resolver_chains(arg0: &USDTResolver) : vector<0x1::string::String> {
        arg0.supported_chains
    }

    public fun get_resolver_reputation(arg0: &USDTResolver) : u64 {
        arg0.reputation_score
    }

    public fun is_order_filled<T0>(arg0: &USDTFusionOrder<T0>) : bool {
        arg0.filled
    }

    public fun is_resolver_active(arg0: &USDTResolver) : bool {
        arg0.active
    }

    public fun register_usdt_resolver(arg0: vector<0x1::string::String>, arg1: &mut 0x2::tx_context::TxContext) : USDTResolver {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = USDTResolver{
            id               : 0x2::object::new(arg1),
            resolver_address : v0,
            supported_chains : arg0,
            reputation_score : 0,
            active           : true,
        };
        let v2 = USDTResolverRegistered{
            resolver         : v0,
            supported_chains : arg0,
        };
        0x2::event::emit<USDTResolverRegistered>(v2);
        v1
    }

    public fun update_resolver_status(arg0: &mut USDTResolver, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.resolver_address, 3);
        arg0.active = arg1;
    }

    // decompiled from Move bytecode v6
}

