module 0xd7276e22f792b34f26e790f364b544760f34414ea8dc8899c816173397d5e561::moonbags_router {
    struct BuyEvent<phantom T0> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct SellEvent<phantom T0> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct OrderCompletedEvent has copy, drop {
        order_id: 0x1::string::String,
    }

    public entry fun buy_exact_in<T0>(arg0: &mut 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags::Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags::buy_exact_in_returns<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10);
        let v2 = v1;
        0xd7276e22f792b34f26e790f364b544760f34414ea8dc8899c816173397d5e561::utils::send_coin<T0>(v2, 0x2::tx_context::sender(arg10));
        0xd7276e22f792b34f26e790f364b544760f34414ea8dc8899c816173397d5e561::utils::send_coin<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg10));
        let v3 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg10),
            amount_in  : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            amount_out : 0x2::coin::value<T0>(&v2),
        };
        0x2::event::emit<BuyEvent<T0>>(v3);
        let v4 = OrderCompletedEvent{order_id: arg9};
        0x2::event::emit<OrderCompletedEvent>(v4);
    }

    public entry fun buy_exact_out<T0>(arg0: &mut 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags::Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags::buy_exact_out_returns<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9);
        let v2 = v1;
        let v3 = v0;
        0xd7276e22f792b34f26e790f364b544760f34414ea8dc8899c816173397d5e561::utils::send_coin<T0>(v2, 0x2::tx_context::sender(arg9));
        0xd7276e22f792b34f26e790f364b544760f34414ea8dc8899c816173397d5e561::utils::send_coin<0x2::sui::SUI>(v3, 0x2::tx_context::sender(arg9));
        let v4 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg9),
            amount_in  : 0x2::coin::value<0x2::sui::SUI>(&arg1) - 0x2::coin::value<0x2::sui::SUI>(&v3),
            amount_out : 0x2::coin::value<T0>(&v2),
        };
        0x2::event::emit<BuyEvent<T0>>(v4);
        let v5 = OrderCompletedEvent{order_id: arg8};
        0x2::event::emit<OrderCompletedEvent>(v5);
    }

    public entry fun sell_exact_in<T0>(arg0: &mut 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags::Configuration, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags::sell_returns<T0>(arg0, arg1, arg2, arg3, arg5);
        let v2 = v0;
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        assert!(v3 >= arg2, 1);
        0xd7276e22f792b34f26e790f364b544760f34414ea8dc8899c816173397d5e561::utils::send_coin<T0>(v1, 0x2::tx_context::sender(arg5));
        0xd7276e22f792b34f26e790f364b544760f34414ea8dc8899c816173397d5e561::utils::send_coin<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg5));
        let v4 = SellEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg5),
            amount_in  : 0x2::coin::value<T0>(&arg1),
            amount_out : v3,
        };
        0x2::event::emit<SellEvent<T0>>(v4);
        let v5 = OrderCompletedEvent{order_id: arg4};
        0x2::event::emit<OrderCompletedEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

