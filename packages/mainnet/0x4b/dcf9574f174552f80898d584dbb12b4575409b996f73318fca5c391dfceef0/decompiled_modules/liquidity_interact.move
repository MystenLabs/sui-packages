module 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::liquidity_interact {
    struct ProtocolFeesCollected has copy, drop {
        proposal_id: 0x2::object::ID,
        winning_outcome: u64,
        fee_amount: u64,
        timestamp_ms: u64,
    }

    public entry fun empty_all_amm_liquidity<T0, T1>(arg0: &mut 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::Proposal<T0, T1>, arg1: &mut 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::outcome_count<T0, T1>(arg0), 0);
        assert!(0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::is_finalized<T0, T1>(arg0), 3);
        assert!(0x2::tx_context::sender(arg3) == 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::proposer<T0, T1>(arg0), 1);
        assert!(arg2 == 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::get_winning_outcome<T0, T1>(arg0), 2);
        assert!(0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::market_state_id<T0, T1>(arg0) == 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::get_market_state_id<T0, T1>(arg1), 4);
        0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::market_state::assert_market_finalized(0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::get_market_state<T0, T1>(arg1));
        let (v0, v1) = 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::empty_all_amm_liquidity(0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::get_pool_mut_by_outcome<T0, T1>(arg0, (arg2 as u8)), arg3);
        let (v2, v3) = 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::remove_liquidity<T0, T1>(arg1, v0, v1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0x2::tx_context::sender(arg3));
        assert_winning_reserves_consistency<T0, T1>(arg0, arg1);
    }

    public fun mint_complete_set_asset<T0, T1>(arg0: &0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::Proposal<T0, T1>, arg1: &mut 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::TokenEscrow<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : vector<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::conditional_token::ConditionalToken> {
        assert!(!0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::is_finalized<T0, T1>(arg0), 3);
        assert_all_reserves_consistency<T0, T1>(arg0, arg1);
        0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::mint_complete_set_asset<T0, T1>(arg1, arg2, arg3, arg4)
    }

    public fun mint_complete_set_stable<T0, T1>(arg0: &0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::Proposal<T0, T1>, arg1: &mut 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::TokenEscrow<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : vector<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::conditional_token::ConditionalToken> {
        assert!(!0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::is_finalized<T0, T1>(arg0), 3);
        assert_all_reserves_consistency<T0, T1>(arg0, arg1);
        0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::mint_complete_set_stable<T0, T1>(arg1, arg2, arg3, arg4)
    }

    public fun redeem_complete_set_asset<T0, T1>(arg0: &0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::Proposal<T0, T1>, arg1: &mut 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::TokenEscrow<T0, T1>, arg2: vector<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::conditional_token::ConditionalToken>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(!0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::is_finalized<T0, T1>(arg0), 3);
        assert_all_reserves_consistency<T0, T1>(arg0, arg1);
        0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::redeem_complete_set_asset<T0, T1>(arg1, arg2, arg3, arg4)
    }

    public fun redeem_complete_set_stable<T0, T1>(arg0: &0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::Proposal<T0, T1>, arg1: &mut 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::TokenEscrow<T0, T1>, arg2: vector<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::conditional_token::ConditionalToken>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(!0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::is_finalized<T0, T1>(arg0), 3);
        assert_all_reserves_consistency<T0, T1>(arg0, arg1);
        0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::redeem_complete_set_stable<T0, T1>(arg1, arg2, arg3, arg4)
    }

    public fun redeem_winning_tokens_asset<T0, T1>(arg0: &0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::Proposal<T0, T1>, arg1: &mut 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::TokenEscrow<T0, T1>, arg2: 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::conditional_token::ConditionalToken, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::is_finalized<T0, T1>(arg0), 3);
        assert!(0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::conditional_token::outcome(&arg2) == (0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::get_winning_outcome<T0, T1>(arg0) as u8), 2);
        assert_winning_reserves_consistency<T0, T1>(arg0, arg1);
        0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::redeem_winning_tokens_asset<T0, T1>(arg1, arg2, arg3, arg4)
    }

    public fun redeem_winning_tokens_stable<T0, T1>(arg0: &0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::Proposal<T0, T1>, arg1: &mut 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::TokenEscrow<T0, T1>, arg2: 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::conditional_token::ConditionalToken, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::is_finalized<T0, T1>(arg0), 3);
        assert!(0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::conditional_token::outcome(&arg2) == (0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::get_winning_outcome<T0, T1>(arg0) as u8), 2);
        assert_winning_reserves_consistency<T0, T1>(arg0, arg1);
        0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::redeem_winning_tokens_stable<T0, T1>(arg1, arg2, arg3, arg4)
    }

    public fun assert_all_reserves_consistency<T0, T1>(arg0: &0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::Proposal<T0, T1>, arg1: &0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::TokenEscrow<T0, T1>) {
        let (v0, v1) = 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::get_balances<T0, T1>(arg1);
        let v2 = 0;
        while (v2 < 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::outcome_count<T0, T1>(arg0)) {
            let v3 = 0x1::vector::borrow<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::LiquidityPool>(0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::get_amm_pools<T0, T1>(arg0), v2);
            let (v4, v5) = 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::get_reserves(v3);
            let (_, _, v8, v9) = 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::get_escrow_balances_and_supply<T0, T1>(arg1, v2);
            assert!(v4 + v8 == v0, 5);
            assert!(v5 + 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::get_protocol_fees(v3) + v9 == v1, 6);
            v2 = v2 + 1;
        };
    }

    public fun assert_winning_reserves_consistency<T0, T1>(arg0: &0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::Proposal<T0, T1>, arg1: &0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::TokenEscrow<T0, T1>) {
        let v0 = 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::get_winning_outcome<T0, T1>(arg0);
        let (v1, v2) = 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::get_balances<T0, T1>(arg1);
        let v3 = 0x1::vector::borrow<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::LiquidityPool>(0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::get_amm_pools<T0, T1>(arg0), v0);
        let (v4, v5) = 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::get_reserves(v3);
        let (_, _, v8, v9) = 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::get_escrow_balances_and_supply<T0, T1>(arg1, v0);
        assert!(v4 + v8 == v1, 5);
        assert!(v5 + 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::get_protocol_fees(v3) + v9 == v2, 6);
    }

    public entry fun burn_unused_tokens_entry<T0, T1>(arg0: &0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::Proposal<T0, T1>, arg1: &mut 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::TokenEscrow<T0, T1>, arg2: vector<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::conditional_token::ConditionalToken>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::is_finalized<T0, T1>(arg0), 3);
        0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::burn_unused_tokens<T0, T1>(arg1, arg2, arg3, arg4);
        assert_winning_reserves_consistency<T0, T1>(arg0, arg1);
    }

    public(friend) fun collect_protocol_fees<T0, T1>(arg0: &mut 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::Proposal<T0, T1>, arg1: &mut 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::TokenEscrow<T0, T1>, arg2: &mut 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::fee::FeeManager, arg3: &0x2::clock::Clock) {
        assert!(0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::is_finalized<T0, T1>(arg0), 3);
        assert!(0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::is_winning_outcome_set<T0, T1>(arg0), 3);
        assert!(0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::get_market_state_id<T0, T1>(arg1) == 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::market_state_id<T0, T1>(arg0), 3);
        let v0 = 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::get_winning_outcome<T0, T1>(arg0);
        let v1 = 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::get_pool_mut_by_outcome<T0, T1>(arg0, (v0 as u8));
        let v2 = 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::get_protocol_fees(v1);
        if (v2 > 0) {
            0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::amm::reset_protocol_fees(v1);
            0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::fee::deposit_stable_fees<T1>(arg2, 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::extract_stable_fees<T0, T1>(arg1, v2), 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::get_id<T0, T1>(arg0), arg3);
            assert_winning_reserves_consistency<T0, T1>(arg0, arg1);
            let v3 = ProtocolFeesCollected{
                proposal_id     : 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::get_id<T0, T1>(arg0),
                winning_outcome : v0,
                fee_amount      : v2,
                timestamp_ms    : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<ProtocolFeesCollected>(v3);
        };
    }

    public entry fun mint_complete_set_asset_entry<T0, T1>(arg0: &0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::Proposal<T0, T1>, arg1: &mut 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::TokenEscrow<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::mint_complete_set_asset<T0, T1>(arg1, arg2, arg3, arg4);
        assert_all_reserves_consistency<T0, T1>(arg0, arg1);
        while (!0x1::vector::is_empty<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::conditional_token::ConditionalToken>(&v0)) {
            0x2::transfer::public_transfer<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::conditional_token::ConditionalToken>(0x1::vector::pop_back<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::conditional_token::ConditionalToken>(&mut v0), 0x2::tx_context::sender(arg4));
        };
        0x1::vector::destroy_empty<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::conditional_token::ConditionalToken>(v0);
    }

    public entry fun mint_complete_set_stable_entry<T0, T1>(arg0: &0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::Proposal<T0, T1>, arg1: &mut 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::TokenEscrow<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::mint_complete_set_stable<T0, T1>(arg1, arg2, arg3, arg4);
        assert_all_reserves_consistency<T0, T1>(arg0, arg1);
        while (!0x1::vector::is_empty<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::conditional_token::ConditionalToken>(&v0)) {
            0x2::transfer::public_transfer<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::conditional_token::ConditionalToken>(0x1::vector::pop_back<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::conditional_token::ConditionalToken>(&mut v0), 0x2::tx_context::sender(arg4));
        };
        0x1::vector::destroy_empty<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::conditional_token::ConditionalToken>(v0);
    }

    public entry fun redeem_complete_set_asset_entry<T0, T1>(arg0: &0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::Proposal<T0, T1>, arg1: &mut 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::TokenEscrow<T0, T1>, arg2: vector<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::conditional_token::ConditionalToken>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_all_reserves_consistency<T0, T1>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::redeem_complete_set_asset<T0, T1>(arg1, arg2, arg3, arg4), arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun redeem_complete_set_stable_entry<T0, T1>(arg0: &0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::Proposal<T0, T1>, arg1: &mut 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::TokenEscrow<T0, T1>, arg2: vector<0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::conditional_token::ConditionalToken>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_all_reserves_consistency<T0, T1>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::redeem_complete_set_stable<T0, T1>(arg1, arg2, arg3, arg4), arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun redeem_winning_tokens_asset_entry<T0, T1>(arg0: &0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::Proposal<T0, T1>, arg1: &mut 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::TokenEscrow<T0, T1>, arg2: 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::conditional_token::ConditionalToken, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_winning_reserves_consistency<T0, T1>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::redeem_winning_tokens_asset<T0, T1>(arg1, arg2, arg3, arg4), arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun redeem_winning_tokens_stable_entry<T0, T1>(arg0: &0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::proposal::Proposal<T0, T1>, arg1: &mut 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::TokenEscrow<T0, T1>, arg2: 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::conditional_token::ConditionalToken, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_winning_reserves_consistency<T0, T1>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::coin_escrow::redeem_winning_tokens_stable<T0, T1>(arg1, arg2, arg3, arg4), arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

