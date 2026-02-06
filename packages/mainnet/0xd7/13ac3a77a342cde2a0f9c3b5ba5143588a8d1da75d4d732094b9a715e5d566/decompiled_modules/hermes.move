module 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::hermes {
    public fun calculate_daily_stream_rate(arg0: u64) : u64 {
        arg0 / 86400
    }

    public fun calculate_monthly_stream_rate(arg0: u64) : u64 {
        arg0 / 2592000
    }

    public fun calculate_weekly_stream_rate(arg0: u64) : u64 {
        arg0 / 604800
    }

    public fun create_and_pay_invoice<T0>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::invoice::create_directed_invoice<T0>(arg0, 0x2::tx_context::sender(arg3), 0x2::coin::value<T0>(&arg1), 0x2::tx_context::epoch_timestamp_ms(arg3) + 3600000, arg2, arg3);
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::invoice::pay_invoice<T0>(&mut v0, arg1, arg3);
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::invoice::destroy<T0>(v0);
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::invoice::release<T0>(&mut v0, arg3)
    }

    public fun create_equal_split(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::revenue_split::RevenueSplit, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::revenue_split::RevenueSplitCap) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = &mut v0;
        0x1::vector::push_back<address>(v1, arg0);
        0x1::vector::push_back<address>(v1, arg1);
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::revenue_split::create_split(v0, vector[5000, 5000], arg2)
    }

    public fun create_oracle_invoice<T0>(arg0: address, arg1: u64, arg2: u64, arg3: address, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::invoice::Invoice<T0> {
        let v0 = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::invoice::create_invoice<T0>(arg0, arg1, arg2, arg4, arg5);
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::invoice::add_release_condition<T0>(&mut v0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::new_oracle_condition(arg3), arg5);
        v0
    }

    public fun create_royalty_split(arg0: address, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::revenue_split::RevenueSplit, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::revenue_split::RevenueSplitCap) {
        assert!(arg2 < 10000, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_shares());
        let v0 = 0x1::vector::empty<address>();
        let v1 = &mut v0;
        0x1::vector::push_back<address>(v1, arg0);
        0x1::vector::push_back<address>(v1, arg1);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 10000 - arg2);
        0x1::vector::push_back<u64>(v3, arg2);
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::revenue_split::create_split(v0, v2, arg3)
    }

    public fun create_timelocked_invoice<T0>(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::invoice::Invoice<T0> {
        let v0 = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::invoice::create_invoice<T0>(arg0, arg1, arg2, arg4, arg5);
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::invoice::add_release_condition<T0>(&mut v0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::new_time_condition(arg3), arg5);
        v0
    }

    entry fun instant_payment<T0>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(create_and_pay_invoice<T0>(arg0, arg1, arg2, arg3), arg0);
    }

    public fun open_unidirectional_channel<T0>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::payment_channel::PaymentChannel<T0>, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::payment_channel::ChannelCap, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::payment_channel::ChannelCap) {
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::payment_channel::open_channel<T0>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun quick_channel<T0>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::payment_channel::PaymentChannel<T0>, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::payment_channel::ChannelCap, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::payment_channel::ChannelCap) {
        let (v0, v1, v2) = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::payment_channel::open_channel<T0>(arg0, arg1, arg2, arg4, arg5);
        let v3 = v2;
        let v4 = v0;
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::payment_channel::deposit<T0>(&mut v4, &v3, arg3, arg5);
        (v4, v1, v3)
    }

    public fun quick_stream<T0>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::stream::PaymentStream<T0>, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::stream::StreamCap, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::stream::StreamCap) {
        assert!(arg3 > 0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_duration());
        let v0 = 0x2::coin::value<T0>(&arg2) / arg3;
        assert!(v0 > 0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_rate());
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::stream::create_stream<T0>(arg0, arg1, arg2, v0, arg4)
    }

    public fun register_and_configure_service(arg0: &mut 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::service_registry::ServiceRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::PricingTier>, arg4: vector<u8>, arg5: 0x1::option::Option<vector<address>>, arg6: 0x1::option::Option<vector<u64>>, arg7: &mut 0x2::tx_context::TxContext) : (0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::service_registry::Service, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::service_registry::ServiceCap, 0x1::option::Option<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::revenue_split::RevenueSplit>, 0x1::option::Option<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::revenue_split::RevenueSplitCap>) {
        let (v0, v1) = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::service_registry::register_service(arg0, arg1, arg2, arg3, arg4, arg7);
        let v2 = v1;
        let v3 = v0;
        if (0x1::option::is_some<vector<address>>(&arg5) && 0x1::option::is_some<vector<u64>>(&arg6)) {
            let (v6, v7) = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::revenue_split::create_split(0x1::option::destroy_some<vector<address>>(arg5), 0x1::option::destroy_some<vector<u64>>(arg6), arg7);
            let v8 = v6;
            0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::service_registry::set_revenue_split(&mut v3, &v2, 0x2::object::id<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::revenue_split::RevenueSplit>(&v8), arg7);
            (v3, v2, 0x1::option::some<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::revenue_split::RevenueSplit>(v8), 0x1::option::some<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::revenue_split::RevenueSplitCap>(v7))
        } else {
            0x1::option::destroy_none<vector<address>>(arg5);
            0x1::option::destroy_none<vector<u64>>(arg6);
            (v3, v2, 0x1::option::none<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::revenue_split::RevenueSplit>(), 0x1::option::none<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::revenue_split::RevenueSplitCap>())
        }
    }

    entry fun register_service<T0>(arg0: &mut 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::service_registry::ServiceRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = register_simple_service(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = v1;
        let v3 = v0;
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::service_registry::add_accepted_token<T0>(&mut v3, &v2);
        0x2::transfer::public_share_object<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::service_registry::Service>(v3);
        0x2::transfer::public_transfer<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::service_registry::ServiceCap>(v2, 0x2::tx_context::sender(arg5));
    }

    public fun register_simple_service(arg0: &mut 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::service_registry::ServiceRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : (0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::service_registry::Service, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::service_registry::ServiceCap) {
        let v0 = 0x1::vector::empty<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::PricingTier>();
        0x1::vector::push_back<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::PricingTier>(&mut v0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::new_pricing_tier(b"default", arg3, b"Standard service call", 0));
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::service_registry::register_service(arg0, arg1, arg2, v0, arg4, arg5)
    }

    entry fun setup_channel<T0>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = quick_channel<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_share_object<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::payment_channel::PaymentChannel<T0>>(v0);
        0x2::transfer::public_transfer<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::payment_channel::ChannelCap>(v1, arg0);
        0x2::transfer::public_transfer<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::payment_channel::ChannelCap>(v2, arg1);
    }

    entry fun setup_revenue_split(arg0: vector<address>, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::revenue_split::create_split(arg0, arg1, arg2);
        0x2::transfer::public_share_object<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::revenue_split::RevenueSplit>(v0);
        0x2::transfer::public_transfer<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::revenue_split::RevenueSplitCap>(v1, 0x2::tx_context::sender(arg2));
    }

    entry fun setup_stream<T0>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = quick_stream<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_share_object<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::stream::PaymentStream<T0>>(v0);
        0x2::transfer::public_transfer<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::stream::StreamCap>(v1, arg0);
        0x2::transfer::public_transfer<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::stream::StreamCap>(v2, arg1);
    }

    public fun stream_at_rate<T0>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::stream::PaymentStream<T0>, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::stream::StreamCap, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::stream::StreamCap) {
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::stream::create_stream<T0>(arg0, arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

