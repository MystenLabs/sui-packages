module 0x59bb8e6152a2fafdabbd0f477c0bb387d10f6ea69a9b8d1386f817663baa20e6::sui_peer_executor {
    struct OriginRecord has copy, drop, store {
        origin_chain: vector<u8>,
        origin_owner: address,
        origin_asset: vector<u8>,
    }

    struct PeerCustodyDeposited has copy, drop {
        origin_chain: vector<u8>,
        origin_owner: address,
        origin_asset: vector<u8>,
        principal_micros: u64,
    }

    struct PeerCustodyExitBound has copy, drop {
        origin_chain: vector<u8>,
        origin_owner: address,
        origin_asset: vector<u8>,
        position_owner: address,
        payout_destination: address,
    }

    fun assert_origin_binding(arg0: &0xe674c1aecbe0c444827b1df7688439803e377eecaf34fcc409c32f9ef8c94a66::suilend_usdc_forwarder::Position, arg1: &OriginRecord) {
        assert!(0xe674c1aecbe0c444827b1df7688439803e377eecaf34fcc409c32f9ef8c94a66::suilend_usdc_forwarder::owner(arg0) == arg1.origin_owner, 5);
        assert!(0xe674c1aecbe0c444827b1df7688439803e377eecaf34fcc409c32f9ef8c94a66::suilend_usdc_forwarder::payout_destination(arg0) == arg1.origin_owner, 6);
    }

    public fun exit_to_origin(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: &mut 0xe674c1aecbe0c444827b1df7688439803e377eecaf34fcc409c32f9ef8c94a66::suilend_usdc_forwarder::Position, arg2: OriginRecord, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.origin_owner != @0x0, 1);
        assert_origin_binding(arg1, &arg2);
        let v0 = PeerCustodyExitBound{
            origin_chain       : arg2.origin_chain,
            origin_owner       : arg2.origin_owner,
            origin_asset       : arg2.origin_asset,
            position_owner     : 0xe674c1aecbe0c444827b1df7688439803e377eecaf34fcc409c32f9ef8c94a66::suilend_usdc_forwarder::owner(arg1),
            payout_destination : 0xe674c1aecbe0c444827b1df7688439803e377eecaf34fcc409c32f9ef8c94a66::suilend_usdc_forwarder::payout_destination(arg1),
        };
        0x2::event::emit<PeerCustodyExitBound>(v0);
        0xe674c1aecbe0c444827b1df7688439803e377eecaf34fcc409c32f9ef8c94a66::suilend_usdc_forwarder::withdraw_all_usdc(arg0, arg1, arg3, arg4);
    }

    public fun new_origin_record(arg0: vector<u8>, arg1: address, arg2: vector<u8>) : OriginRecord {
        assert!(arg1 != @0x0, 1);
        assert!(!0x1::vector::is_empty<u8>(&arg0), 2);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 3);
        OriginRecord{
            origin_chain : arg0,
            origin_owner : arg1,
            origin_asset : arg2,
        }
    }

    public fun origin_asset(arg0: &OriginRecord) : vector<u8> {
        arg0.origin_asset
    }

    public fun origin_chain(arg0: &OriginRecord) : vector<u8> {
        arg0.origin_chain
    }

    public fun origin_owner(arg0: &OriginRecord) : address {
        arg0.origin_owner
    }

    public fun receive_and_deposit_suilend(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: OriginRecord, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5.origin_owner != @0x0, 1);
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg4);
        assert!(v0 > 0, 4);
        let v1 = PeerCustodyDeposited{
            origin_chain     : arg5.origin_chain,
            origin_owner     : arg5.origin_owner,
            origin_asset     : arg5.origin_asset,
            principal_micros : v0,
        };
        0x2::event::emit<PeerCustodyDeposited>(v1);
        0xe674c1aecbe0c444827b1df7688439803e377eecaf34fcc409c32f9ef8c94a66::suilend_usdc_forwarder::deposit_usdc_for_owner(arg0, arg1, arg2, arg3, arg4, arg5.origin_owner, arg6, arg7);
    }

    // decompiled from Move bytecode v7
}

