module 0xe63347f118be12fff29d3dc80f1d553cb3a16d8bcf1c03872d5030cf684e373f::moon_base {
    struct ServiceRecord has copy, drop, store {
        generation: u8,
        name: vector<u8>,
        endpoint: address,
        registered_at: u64,
        active: bool,
    }

    struct TransitHubRecord has copy, drop, store {
        name: vector<u8>,
        chain_id: u64,
        relay_endpoint: address,
        routing_protocol: vector<u8>,
        registered_at: u64,
        active: bool,
    }

    struct MoonBaseState has store, key {
        id: 0x2::object::UID,
        architect: address,
        services: vector<ServiceRecord>,
        hubs: vector<TransitHubRecord>,
        gas_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        total_fees_collected: u64,
        shared_secret_hash: vector<u8>,
        total_operations: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ServiceRegistered has copy, drop {
        generation: u8,
        service_name: vector<u8>,
        endpoint: address,
    }

    struct TransitHubRegistered has copy, drop {
        hub_name: vector<u8>,
        chain_id: u64,
        relay: address,
    }

    struct FeeCollected has copy, drop {
        amount: u64,
        total_fees: u64,
    }

    fun bcs_u64(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
            arg0 = arg0 >> 8;
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun collect_fee(arg0: &mut MoonBaseState, arg1: u64) {
        let v0 = arg1 * 333 / 10000;
        arg0.total_fees_collected = arg0.total_fees_collected + v0;
        arg0.total_operations = arg0.total_operations + 1;
        let v1 = FeeCollected{
            amount     : v0,
            total_fees : arg0.total_fees_collected,
        };
        0x2::event::emit<FeeCollected>(v1);
    }

    public entry fun deposit_gas_pool(arg0: &mut MoonBaseState, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.gas_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun get_architect(arg0: &MoonBaseState) : address {
        arg0.architect
    }

    public fun get_gas_pool_balance(arg0: &MoonBaseState) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.gas_pool)
    }

    public fun get_hub_count(arg0: &MoonBaseState) : u64 {
        0x1::vector::length<TransitHubRecord>(&arg0.hubs)
    }

    public fun get_service_count(arg0: &MoonBaseState) : u64 {
        0x1::vector::length<ServiceRecord>(&arg0.services)
    }

    public fun get_total_operations(arg0: &MoonBaseState) : u64 {
        arg0.total_operations
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = bcs_u64(90112);
        let v2 = MoonBaseState{
            id                   : 0x2::object::new(arg0),
            architect            : v0,
            services             : 0x1::vector::empty<ServiceRecord>(),
            hubs                 : 0x1::vector::empty<TransitHubRecord>(),
            gas_pool             : 0x2::balance::zero<0x2::sui::SUI>(),
            total_fees_collected : 0,
            shared_secret_hash   : 0x2::hash::keccak256(&v1),
            total_operations     : 0,
        };
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<MoonBaseState>(v2);
        0x2::transfer::transfer<AdminCap>(v3, v0);
    }

    public entry fun register_primary_service(arg0: &AdminCap, arg1: &mut MoonBaseState, arg2: u8, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1.architect, 0);
        assert!(0x1::vector::length<ServiceRecord>(&arg1.services) < 255, 1);
        let v0 = ServiceRecord{
            generation    : arg2,
            name          : arg3,
            endpoint      : arg4,
            registered_at : 0x2::tx_context::epoch(arg5),
            active        : true,
        };
        0x1::vector::push_back<ServiceRecord>(&mut arg1.services, v0);
        arg1.total_operations = arg1.total_operations + 1;
        let v1 = ServiceRegistered{
            generation   : arg2,
            service_name : arg3,
            endpoint     : arg4,
        };
        0x2::event::emit<ServiceRegistered>(v1);
    }

    public entry fun register_transit_hub(arg0: &AdminCap, arg1: &mut MoonBaseState, arg2: vector<u8>, arg3: u64, arg4: address, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg1.architect, 0);
        assert!(0x1::vector::length<TransitHubRecord>(&arg1.hubs) < 255, 1);
        let v0 = TransitHubRecord{
            name             : arg2,
            chain_id         : arg3,
            relay_endpoint   : arg4,
            routing_protocol : arg5,
            registered_at    : 0x2::tx_context::epoch(arg6),
            active           : true,
        };
        0x1::vector::push_back<TransitHubRecord>(&mut arg1.hubs, v0);
        arg1.total_operations = arg1.total_operations + 1;
        let v1 = TransitHubRegistered{
            hub_name : arg2,
            chain_id : arg3,
            relay    : arg4,
        };
        0x2::event::emit<TransitHubRegistered>(v1);
    }

    public fun verify_shared_secret(arg0: &MoonBaseState, arg1: u64) : bool {
        let v0 = bcs_u64(arg1);
        0x2::hash::keccak256(&v0) == arg0.shared_secret_hash
    }

    public entry fun withdraw_fees(arg0: &AdminCap, arg1: &mut MoonBaseState, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.architect, 0);
        arg1.total_fees_collected = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.gas_pool, arg1.total_fees_collected), arg2), arg1.architect);
    }

    // decompiled from Move bytecode v6
}

