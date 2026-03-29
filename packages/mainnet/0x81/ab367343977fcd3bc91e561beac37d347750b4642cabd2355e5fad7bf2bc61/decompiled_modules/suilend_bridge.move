module 0x81ab367343977fcd3bc91e561beac37d347750b4642cabd2355e5fad7bf2bc61::suilend_bridge {
    struct BridgeState<phantom T0> has key {
        id: 0x2::object::UID,
        obligation_cap: 0x3a770cc27297e151c6ff79579be22ce8f4a5423a518d43672c1831dee77c5313::lending_market::ObligationOwnerCap<T0>,
    }

    public fun create_bridge_state<T0>(arg0: 0x3a770cc27297e151c6ff79579be22ce8f4a5423a518d43672c1831dee77c5313::lending_market::ObligationOwnerCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeState<T0>{
            id             : 0x2::object::new(arg1),
            obligation_cap : arg0,
        };
        0x2::transfer::share_object<BridgeState<T0>>(v0);
    }

    public fun deposit_to_suilend<T0, T1>(arg0: &mut BridgeState<T1>, arg1: &mut 0x3a770cc27297e151c6ff79579be22ce8f4a5423a518d43672c1831dee77c5313::lending_market::LendingMarket<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0x3a770cc27297e151c6ff79579be22ce8f4a5423a518d43672c1831dee77c5313::lending_market::deposit_ctokens_into_obligation<T1, T0>(arg1, arg2, &arg0.obligation_cap, arg3, 0x3a770cc27297e151c6ff79579be22ce8f4a5423a518d43672c1831dee77c5313::lending_market::deposit_liquidity_and_mint_ctokens<T1, T0>(arg1, arg2, arg3, arg4, arg5), arg5);
    }

    public fun harvest_rewards_suilend<T0, T1>(arg0: &mut BridgeState<T1>, arg1: &mut 0x3a770cc27297e151c6ff79579be22ce8f4a5423a518d43672c1831dee77c5313::lending_market::LendingMarket<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x3a770cc27297e151c6ff79579be22ce8f4a5423a518d43672c1831dee77c5313::lending_market::claim_rewards<T1, T0>(arg1, &arg0.obligation_cap, arg3, arg2, 0, false, arg4)
    }

    public fun withdraw_from_suilend<T0, T1>(arg0: &mut BridgeState<T1>, arg1: &mut 0x3a770cc27297e151c6ff79579be22ce8f4a5423a518d43672c1831dee77c5313::lending_market::LendingMarket<T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x3a770cc27297e151c6ff79579be22ce8f4a5423a518d43672c1831dee77c5313::lending_market::redeem_ctokens_and_withdraw_liquidity<T1, T0>(arg1, arg2, arg4, 0x3a770cc27297e151c6ff79579be22ce8f4a5423a518d43672c1831dee77c5313::lending_market::withdraw_ctokens<T1, T0>(arg1, arg2, &arg0.obligation_cap, arg4, arg3, arg5), 0x1::option::none<u64>(), arg5)
    }

    // decompiled from Move bytecode v6
}

