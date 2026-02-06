module 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::service_registry {
    struct ServiceRegistry has key {
        id: 0x2::object::UID,
        name_to_service: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
        total_services: u64,
    }

    struct Service has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: vector<u8>,
        endpoint: vector<u8>,
        pricing: vector<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::PricingTier>,
        accepted_tokens: vector<0x1::type_name::TypeName>,
        revenue_split_id: 0x1::option::Option<0x2::object::ID>,
        total_calls: u64,
        total_revenue: u64,
        metadata: vector<u8>,
    }

    struct ServiceCap has store, key {
        id: 0x2::object::UID,
        service_id: 0x2::object::ID,
    }

    struct ServiceRevenue<phantom T0> has store, key {
        id: 0x2::object::UID,
        service_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun add_accepted_token<T0>(arg0: &mut Service, arg1: &ServiceCap) {
        assert!(arg1.service_id == 0x2::object::id<Service>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_service_cap());
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.accepted_tokens)) {
            assert!(*0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.accepted_tokens, v1) != v0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::token_not_accepted());
            v1 = v1 + 1;
        };
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.accepted_tokens, v0);
    }

    public fun call_service<T0>(arg0: &mut Service, arg1: &mut ServiceRevenue<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg1.service_id == 0x2::object::id<Service>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_service_cap());
        let v0 = 0x1::type_name::get<T0>();
        assert!(is_token_accepted(arg0, &v0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::token_not_accepted());
        let v1 = find_tier_for_payment(arg0, 0x2::coin::value<T0>(&arg2));
        assert!(0x1::option::is_some<u64>(&v1), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::no_pricing_tier());
        let v2 = *0x1::option::borrow<u64>(&v1);
        let v3 = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::tier_price(0x1::vector::borrow<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::PricingTier>(&arg0.pricing, v2));
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v3, arg3)));
        if (0x2::coin::value<T0>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<T0>(arg2);
        };
        arg0.total_calls = arg0.total_calls + 1;
        arg0.total_revenue = arg0.total_revenue + v3;
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_service_called(0x2::object::id<Service>(arg0), 0x2::tx_context::sender(arg3), v3, v2, 0x2::tx_context::epoch_timestamp_ms(arg3));
        v2
    }

    public fun cap_service_id(arg0: &ServiceCap) : 0x2::object::ID {
        arg0.service_id
    }

    public fun clear_revenue_split(arg0: &mut Service, arg1: &ServiceCap) {
        assert!(arg1.service_id == 0x2::object::id<Service>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_service_cap());
        arg0.revenue_split_id = 0x1::option::none<0x2::object::ID>();
    }

    public fun create_registry(arg0: &mut 0x2::tx_context::TxContext) : ServiceRegistry {
        ServiceRegistry{
            id              : 0x2::object::new(arg0),
            name_to_service : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg0),
            total_services  : 0,
        }
    }

    public fun create_revenue<T0>(arg0: &Service, arg1: &ServiceCap, arg2: &mut 0x2::tx_context::TxContext) : ServiceRevenue<T0> {
        assert!(arg1.service_id == 0x2::object::id<Service>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_service_cap());
        ServiceRevenue<T0>{
            id         : 0x2::object::new(arg2),
            service_id : 0x2::object::id<Service>(arg0),
            balance    : 0x2::balance::zero<T0>(),
        }
    }

    fun find_tier_for_payment(arg0: &Service, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0x1::option::none<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::PricingTier>(&arg0.pricing)) {
            let v2 = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::tier_price(0x1::vector::borrow<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::PricingTier>(&arg0.pricing, v1));
            if (arg1 >= v2 && v2 >= 0) {
                v0 = 0x1::option::some<u64>(v1);
            };
            v1 = v1 + 1;
        };
        v0
    }

    entry fun init_registry(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<ServiceRegistry>(create_registry(arg0));
    }

    fun is_token_accepted(arg0: &Service, arg1: &0x1::type_name::TypeName) : bool {
        if (0x1::vector::length<0x1::type_name::TypeName>(&arg0.accepted_tokens) == 0) {
            return true
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.accepted_tokens)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.accepted_tokens, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun lookup_service(arg0: &ServiceRegistry, arg1: vector<u8>) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.name_to_service, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<vector<u8>, 0x2::object::ID>(&arg0.name_to_service, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    entry fun register_and_share<T0>(arg0: &mut ServiceRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: vector<u64>, arg5: vector<vector<u8>>, arg6: vector<u64>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<vector<u8>>(&arg3);
        let v1 = if (0x1::vector::length<u64>(&arg4) == v0) {
            if (0x1::vector::length<vector<u8>>(&arg5) == v0) {
                0x1::vector::length<u64>(&arg6) == v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::length_mismatch());
        let v2 = 0x1::vector::empty<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::PricingTier>();
        let v3 = 0;
        while (v3 < v0) {
            0x1::vector::push_back<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::PricingTier>(&mut v2, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::new_pricing_tier(*0x1::vector::borrow<vector<u8>>(&arg3, v3), *0x1::vector::borrow<u64>(&arg4, v3), *0x1::vector::borrow<vector<u8>>(&arg5, v3), *0x1::vector::borrow<u64>(&arg6, v3)));
            v3 = v3 + 1;
        };
        let (v4, v5) = register_service(arg0, arg1, arg2, v2, arg7, arg8);
        let v6 = v5;
        let v7 = v4;
        let v8 = &mut v7;
        add_accepted_token<T0>(v8, &v6);
        0x2::transfer::share_object<Service>(v7);
        0x2::transfer::transfer<ServiceCap>(v6, 0x2::tx_context::sender(arg8));
    }

    public fun register_service(arg0: &mut ServiceRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::PricingTier>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : (Service, ServiceCap) {
        assert!(0x1::vector::length<u8>(&arg1) > 0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::empty_service_name());
        assert!(0x1::vector::length<u8>(&arg2) > 0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::empty_endpoint());
        assert!(!0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.name_to_service, arg1), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::service_name_taken());
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = Service{
            id               : 0x2::object::new(arg5),
            owner            : v0,
            name             : arg1,
            endpoint         : arg2,
            pricing          : arg3,
            accepted_tokens  : 0x1::vector::empty<0x1::type_name::TypeName>(),
            revenue_split_id : 0x1::option::none<0x2::object::ID>(),
            total_calls      : 0,
            total_revenue    : 0,
            metadata         : arg4,
        };
        let v2 = 0x2::object::id<Service>(&v1);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg0.name_to_service, v1.name, v2);
        arg0.total_services = arg0.total_services + 1;
        let v3 = ServiceCap{
            id         : 0x2::object::new(arg5),
            service_id : v2,
        };
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_service_registered(v2, v0, v1.name, v1.endpoint, 0x2::tx_context::epoch_timestamp_ms(arg5));
        (v1, v3)
    }

    public fun registry_total_services(arg0: &ServiceRegistry) : u64 {
        arg0.total_services
    }

    public fun revenue_balance<T0>(arg0: &ServiceRevenue<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun service_accepted_tokens(arg0: &Service) : &vector<0x1::type_name::TypeName> {
        &arg0.accepted_tokens
    }

    public fun service_endpoint(arg0: &Service) : vector<u8> {
        arg0.endpoint
    }

    public fun service_metadata(arg0: &Service) : vector<u8> {
        arg0.metadata
    }

    public fun service_name(arg0: &Service) : vector<u8> {
        arg0.name
    }

    public fun service_owner(arg0: &Service) : address {
        arg0.owner
    }

    public fun service_pricing(arg0: &Service) : &vector<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::PricingTier> {
        &arg0.pricing
    }

    public fun service_revenue_split_id(arg0: &Service) : 0x1::option::Option<0x2::object::ID> {
        arg0.revenue_split_id
    }

    public fun service_total_calls(arg0: &Service) : u64 {
        arg0.total_calls
    }

    public fun service_total_revenue(arg0: &Service) : u64 {
        arg0.total_revenue
    }

    public fun set_revenue_split(arg0: &mut Service, arg1: &ServiceCap, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.service_id == 0x2::object::id<Service>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_service_cap());
        arg0.revenue_split_id = 0x1::option::some<0x2::object::ID>(arg2);
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_service_revenue_split_set(0x2::object::id<Service>(arg0), arg2, 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    public fun transfer_ownership(arg0: &mut Service, arg1: &ServiceCap, arg2: address) {
        assert!(arg1.service_id == 0x2::object::id<Service>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_service_cap());
        arg0.owner = arg2;
    }

    public fun update_endpoint(arg0: &mut Service, arg1: &ServiceCap, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.service_id == 0x2::object::id<Service>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_service_cap());
        assert!(0x1::vector::length<u8>(&arg2) > 0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::empty_endpoint());
        arg0.endpoint = arg2;
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_service_endpoint_updated(0x2::object::id<Service>(arg0), arg0.endpoint, arg2, 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    public fun update_pricing(arg0: &mut Service, arg1: &ServiceCap, arg2: vector<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::PricingTier>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.service_id == 0x2::object::id<Service>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_service_cap());
        arg0.pricing = arg2;
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_service_pricing_updated(0x2::object::id<Service>(arg0), 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    public fun withdraw_revenue<T0>(arg0: &Service, arg1: &ServiceCap, arg2: &mut ServiceRevenue<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.service_id == 0x2::object::id<Service>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_service_cap());
        assert!(arg2.service_id == 0x2::object::id<Service>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_service_cap());
        assert!(0x2::balance::value<T0>(&arg2.balance) > 0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::no_revenue());
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg2.balance), arg3)
    }

    entry fun withdraw_to_owner<T0>(arg0: &Service, arg1: &ServiceCap, arg2: &mut ServiceRevenue<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw_revenue<T0>(arg0, arg1, arg2, arg3), arg0.owner);
    }

    // decompiled from Move bytecode v6
}

