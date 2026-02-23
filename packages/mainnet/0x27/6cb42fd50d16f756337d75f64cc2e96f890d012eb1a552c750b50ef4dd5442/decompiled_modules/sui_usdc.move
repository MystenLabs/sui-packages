module 0x276cb42fd50d16f756337d75f64cc2e96f890d012eb1a552c750b50ef4dd5442::sui_usdc {
    struct SuiUSDC has key {
        id: 0x2::object::UID,
    }

    public fun create_stable<T0>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::StableRegistry, arg2: &0xc68f74e99d732949aa3edd6b9910f5a8ecfbd3a55c5058bb895ea0f791e605a4::reward_distributor::AdminCap, arg3: u64, arg4: vector<address>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<SuiUSDC>(arg0, decimals(), 0x1::string::utf8(b"suiUSDC"), 0x1::string::utf8(b"suiUSDC"), 0x1::string::utf8(b"Mint suiUSD with USDC and earn SUI"), 0x1::string::utf8(b"https://circle.com/usdc-icon"), arg5);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SuiUSDC>>(0x2::coin_registry::finalize<SuiUSDC>(v0, arg5), 0x2::tx_context::sender(arg5));
        let v2 = 0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::new<SuiUSDC, T0>(arg1, v1, arg3, arg5);
        0x1::vector::reverse<address>(&mut arg4);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg4)) {
            0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::add_manager<SuiUSDC, T0>(arg1, &v2, 0x1::vector::pop_back<address>(&mut arg4));
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<address>(arg4);
        0x1::vector::reverse<address>(&mut arg4);
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&arg4)) {
            0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::add_manager<SuiUSDC, T0>(arg1, &v2, 0x1::vector::pop_back<address>(&mut arg4));
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<address>(arg4);
        0x2::transfer::public_share_object<0xc68f74e99d732949aa3edd6b9910f5a8ecfbd3a55c5058bb895ea0f791e605a4::reward_distributor::RewardDistributor<SuiUSDC, 0x2::sui::SUI>>(0xc68f74e99d732949aa3edd6b9910f5a8ecfbd3a55c5058bb895ea0f791e605a4::reward_distributor::new<SuiUSDC, 0x2::sui::SUI, T0>(arg2, arg3, 86400000, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::one(), arg5));
        0x2::transfer::public_transfer<0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::FactoryCap<SuiUSDC, T0>>(v2, 0x2::tx_context::sender(arg5));
    }

    public fun decimals() : u8 {
        6
    }

    // decompiled from Move bytecode v6
}

