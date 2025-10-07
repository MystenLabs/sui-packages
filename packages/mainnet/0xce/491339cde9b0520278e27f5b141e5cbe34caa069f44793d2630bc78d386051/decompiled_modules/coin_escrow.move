module 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::coin_escrow {
    struct TokenEscrow<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        market_state: 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::MarketState,
        escrowed_asset: 0x2::balance::Balance<T0>,
        escrowed_stable: 0x2::balance::Balance<T1>,
        outcome_asset_supplies: vector<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>,
        outcome_stable_supplies: vector<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>,
    }

    struct LiquidityWithdrawal has copy, drop {
        escrowed_asset: u64,
        escrowed_stable: u64,
        asset_amount: u64,
        stable_amount: u64,
    }

    struct LiquidityDeposit has copy, drop {
        escrowed_asset: u64,
        escrowed_stable: u64,
        asset_amount: u64,
        stable_amount: u64,
    }

    struct TokenRedemption has copy, drop {
        outcome: u64,
        token_type: u8,
        amount: u64,
    }

    struct AdminEscrowSweep has copy, drop {
        market_id: 0x2::object::ID,
        dao_id: 0x2::object::ID,
        asset_amount: u64,
        stable_amount: u64,
        admin: address,
        timestamp: u64,
    }

    struct COIN_ESCROW has drop {
        dummy_field: bool,
    }

    struct EscrowAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new<T0, T1>(arg0: 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::MarketState, arg1: &mut 0x2::tx_context::TxContext) : TokenEscrow<T0, T1> {
        TokenEscrow<T0, T1>{
            id                      : 0x2::object::new(arg1),
            market_state            : arg0,
            escrowed_asset          : 0x2::balance::zero<T0>(),
            escrowed_stable         : 0x2::balance::zero<T1>(),
            outcome_asset_supplies  : 0x1::vector::empty<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(),
            outcome_stable_supplies : 0x1::vector::empty<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(),
        }
    }

    public entry fun admin_sweep_escrow<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: &EscrowAdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::market_id(&arg0.market_state);
        let v1 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::dao_id(&arg0.market_state);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = 0x2::tx_context::sender(arg3);
        assert!(v2 >= 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::get_creation_time(&arg0.market_state) + 2592000000, 11);
        let (v4, v5) = get_balances<T0, T1>(arg0);
        if (v4 > 0 || v5 > 0) {
            let (v6, v7) = remove_liquidity<T0, T1>(arg0, v4, v5, arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v7, v3);
            let v8 = AdminEscrowSweep{
                market_id     : v0,
                dao_id        : v1,
                asset_amount  : v4,
                stable_amount : v5,
                admin         : v3,
                timestamp     : v2,
            };
            0x2::event::emit<AdminEscrowSweep>(v8);
        };
    }

    fun assert_supplies_initialized<T0, T1>(arg0: &TokenEscrow<T0, T1>) {
        let v0 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::outcome_count(&arg0.market_state);
        assert!(0x1::vector::length<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&arg0.outcome_asset_supplies) == v0 && 0x1::vector::length<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&arg0.outcome_stable_supplies) == v0, 4);
    }

    public entry fun burn_admin_sweep_cap(arg0: EscrowAdminCap) {
        let EscrowAdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun burn_unused_tokens<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: vector<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = &arg0.market_state;
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::assert_market_finalized(v0);
        assert_supplies_initialized<T0, T1>(arg0);
        while (!0x1::vector::is_empty<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken>(&arg1)) {
            let v1 = 0x1::vector::pop_back<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken>(&mut arg1);
            let v2 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::outcome(&v1);
            let v3 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::asset_type(&v1);
            let v4 = (v2 as u64);
            assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::market_id(&v1) == 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::market_id(v0), 2);
            assert!(v2 != (0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::get_winning_outcome(v0) as u8), 6);
            assert!(v4 < 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::outcome_count(v0), 5);
            if (v3 == 0) {
                0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::burn(0x1::vector::borrow_mut<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&mut arg0.outcome_asset_supplies, v4), v1, arg2, arg3);
                continue
            };
            assert!(v3 == 1, 3);
            0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::burn(0x1::vector::borrow_mut<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&mut arg0.outcome_stable_supplies, v4), v1, arg2, arg3);
        };
        0x1::vector::destroy_empty<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken>(arg1);
    }

    public(friend) fun deposit_initial_liquidity<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: &vector<u64>, arg3: &vector<u64>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg4);
        let v1 = 0x2::balance::value<T1>(&arg5);
        let v2 = 0x2::tx_context::sender(arg7);
        0x2::balance::join<T0>(&mut arg0.escrowed_asset, arg4);
        0x2::balance::join<T1>(&mut arg0.escrowed_stable, arg5);
        let v3 = 0;
        let v4 = v3;
        let v5 = 0;
        let v6 = v5;
        let v7 = 0;
        while (v7 < arg1) {
            let v8 = *0x1::vector::borrow<u64>(arg2, v7);
            let v9 = *0x1::vector::borrow<u64>(arg3, v7);
            if (v8 > v3) {
                v4 = v8;
            };
            if (v9 > v5) {
                v6 = v9;
            };
            v7 = v7 + 1;
        };
        assert!(v0 == v4, 9);
        assert!(v1 == v6, 10);
        v7 = 0;
        while (v7 < arg1) {
            let v10 = *0x1::vector::borrow<u64>(arg2, v7);
            let v11 = *0x1::vector::borrow<u64>(arg3, v7);
            if (v10 < v4) {
                0x2::transfer::public_transfer<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken>(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::mint(&arg0.market_state, 0x1::vector::borrow_mut<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&mut arg0.outcome_asset_supplies, v7), v4 - v10, v2, arg6, arg7), v2);
            };
            if (v11 < v6) {
                0x2::transfer::public_transfer<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken>(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::mint(&arg0.market_state, 0x1::vector::borrow_mut<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&mut arg0.outcome_stable_supplies, v7), v6 - v11, v2, arg6, arg7), v2);
            };
            v7 = v7 + 1;
        };
        let v12 = LiquidityDeposit{
            escrowed_asset  : v0,
            escrowed_stable : v1,
            asset_amount    : v0,
            stable_amount   : v1,
        };
        0x2::event::emit<LiquidityDeposit>(v12);
    }

    public(friend) fun extract_stable_fees<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64) : 0x2::balance::Balance<T1> {
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::assert_market_finalized(&arg0.market_state);
        assert!(0x2::balance::value<T1>(&arg0.escrowed_stable) >= arg1, 7);
        0x2::balance::split<T1>(&mut arg0.escrowed_stable, arg1)
    }

    public(friend) fun get_asset_supply<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64) : &mut 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply {
        0x1::vector::borrow_mut<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&mut arg0.outcome_asset_supplies, arg1)
    }

    public(friend) fun get_balances<T0, T1>(arg0: &TokenEscrow<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.escrowed_asset), 0x2::balance::value<T1>(&arg0.escrowed_stable))
    }

    public entry fun get_escrow_balances_and_supply<T0, T1>(arg0: &TokenEscrow<T0, T1>, arg1: u64) : (u64, u64, u64, u64) {
        let (v0, v1) = get_balances<T0, T1>(arg0);
        assert!(arg1 < 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::outcome_count(&arg0.market_state), 5);
        assert_supplies_initialized<T0, T1>(arg0);
        (v0, v1, 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::total_supply(0x1::vector::borrow<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&arg0.outcome_asset_supplies, arg1)), 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::total_supply(0x1::vector::borrow<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&arg0.outcome_stable_supplies, arg1)))
    }

    public(friend) fun get_market_state<T0, T1>(arg0: &TokenEscrow<T0, T1>) : &0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::MarketState {
        &arg0.market_state
    }

    public(friend) fun get_market_state_id<T0, T1>(arg0: &TokenEscrow<T0, T1>) : 0x2::object::ID {
        0x2::object::id<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::MarketState>(&arg0.market_state)
    }

    public(friend) fun get_market_state_mut<T0, T1>(arg0: &mut TokenEscrow<T0, T1>) : &mut 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::MarketState {
        &mut arg0.market_state
    }

    public(friend) fun get_stable_supply<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64) : &mut 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply {
        0x1::vector::borrow_mut<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&mut arg0.outcome_stable_supplies, arg1)
    }

    fun init(arg0: COIN_ESCROW, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<COIN_ESCROW>(&arg0), 12);
        let v0 = EscrowAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<EscrowAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint_complete_set_asset<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : vector<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken> {
        assert_supplies_initialized<T0, T1>(arg0);
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::assert_not_finalized(&arg0.market_state);
        0x2::balance::join<T0>(&mut arg0.escrowed_asset, 0x2::coin::into_balance<T0>(arg1));
        let v0 = 0x1::vector::empty<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken>();
        let v1 = 0;
        while (v1 < 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::outcome_count(&arg0.market_state)) {
            0x1::vector::push_back<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken>(&mut v0, 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::mint(&arg0.market_state, 0x1::vector::borrow_mut<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&mut arg0.outcome_asset_supplies, v1), 0x2::coin::value<T0>(&arg1), 0x2::tx_context::sender(arg3), arg2, arg3));
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun mint_complete_set_stable<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : vector<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken> {
        assert_supplies_initialized<T0, T1>(arg0);
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::assert_not_finalized(&arg0.market_state);
        0x2::balance::join<T1>(&mut arg0.escrowed_stable, 0x2::coin::into_balance<T1>(arg1));
        let v0 = 0x1::vector::empty<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken>();
        let v1 = 0;
        while (v1 < 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::outcome_count(&arg0.market_state)) {
            0x1::vector::push_back<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken>(&mut v0, 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::mint(&arg0.market_state, 0x1::vector::borrow_mut<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&mut arg0.outcome_stable_supplies, v1), 0x2::coin::value<T1>(&arg1), 0x2::tx_context::sender(arg3), arg2, arg3));
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun redeem_complete_set_asset<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: vector<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::assert_not_finalized(&arg0.market_state);
        assert_supplies_initialized<T0, T1>(arg0);
        let v0 = verify_token_set<T0, T1>(arg0, &arg1, 0);
        let v1 = 0;
        while (v1 < 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::outcome_count(&arg0.market_state)) {
            let v2 = 0x1::vector::pop_back<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken>(&mut arg1);
            0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::burn(0x1::vector::borrow_mut<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&mut arg0.outcome_asset_supplies, (0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::outcome(&v2) as u64)), v2, arg2, arg3);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken>(arg1);
        assert!(0x2::balance::value<T0>(&arg0.escrowed_asset) >= v0, 0);
        0x2::balance::split<T0>(&mut arg0.escrowed_asset, v0)
    }

    public(friend) fun redeem_complete_set_stable<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: vector<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::assert_not_finalized(&arg0.market_state);
        assert_supplies_initialized<T0, T1>(arg0);
        let v0 = verify_token_set<T0, T1>(arg0, &arg1, 1);
        let v1 = 0;
        while (v1 < 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::outcome_count(&arg0.market_state)) {
            let v2 = 0x1::vector::pop_back<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken>(&mut arg1);
            0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::burn(0x1::vector::borrow_mut<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&mut arg0.outcome_stable_supplies, (0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::outcome(&v2) as u64)), v2, arg2, arg3);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken>(arg1);
        assert!(0x2::balance::value<T1>(&arg0.escrowed_stable) >= v0, 0);
        0x2::balance::split<T1>(&mut arg0.escrowed_stable, v0)
    }

    public(friend) fun redeem_winning_tokens_asset<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::assert_market_finalized(&arg0.market_state);
        let v0 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::get_winning_outcome(&arg0.market_state);
        assert_supplies_initialized<T0, T1>(arg0);
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::outcome(&arg1) == (v0 as u8), 6);
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::market_id(&arg1) == 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::market_id(&arg0.market_state), 2);
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::asset_type(&arg1) == 0, 3);
        let v1 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::value(&arg1);
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::burn(0x1::vector::borrow_mut<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&mut arg0.outcome_asset_supplies, v0), arg1, arg2, arg3);
        assert!(0x2::balance::value<T0>(&arg0.escrowed_asset) >= v1, 0);
        let v2 = TokenRedemption{
            outcome    : v0,
            token_type : 0,
            amount     : v1,
        };
        0x2::event::emit<TokenRedemption>(v2);
        0x2::balance::split<T0>(&mut arg0.escrowed_asset, v1)
    }

    public(friend) fun redeem_winning_tokens_stable<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::assert_market_finalized(&arg0.market_state);
        let v0 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::get_winning_outcome(&arg0.market_state);
        assert_supplies_initialized<T0, T1>(arg0);
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::outcome(&arg1) == (v0 as u8), 6);
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::market_id(&arg1) == 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::market_id(&arg0.market_state), 2);
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::asset_type(&arg1) == 1, 3);
        let v1 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::value(&arg1);
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::burn(0x1::vector::borrow_mut<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&mut arg0.outcome_stable_supplies, v0), arg1, arg2, arg3);
        assert!(0x2::balance::value<T1>(&arg0.escrowed_stable) >= v1, 0);
        let v2 = TokenRedemption{
            outcome    : v0,
            token_type : 1,
            amount     : v1,
        };
        0x2::event::emit<TokenRedemption>(v2);
        0x2::balance::split<T1>(&mut arg0.escrowed_stable, v1)
    }

    public(friend) fun register_supplies<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply, arg3: 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply) {
        assert!(arg1 < 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::outcome_count(&arg0.market_state), 5);
        assert!(0x1::vector::length<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&arg0.outcome_asset_supplies) == arg1, 1);
        0x1::vector::push_back<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&mut arg0.outcome_asset_supplies, arg2);
        0x1::vector::push_back<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&mut arg0.outcome_stable_supplies, arg3);
    }

    public(friend) fun remove_liquidity<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::balance::value<T0>(&arg0.escrowed_asset) >= arg1, 8);
        assert!(0x2::balance::value<T1>(&arg0.escrowed_stable) >= arg2, 8);
        let v0 = LiquidityWithdrawal{
            escrowed_asset  : 0x2::balance::value<T0>(&arg0.escrowed_asset),
            escrowed_stable : 0x2::balance::value<T1>(&arg0.escrowed_stable),
            asset_amount    : arg1,
            stable_amount   : arg2,
        };
        0x2::event::emit<LiquidityWithdrawal>(v0);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.escrowed_asset, arg1), arg3), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.escrowed_stable, arg2), arg3))
    }

    public(friend) fun swap_token_asset_to_stable<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken {
        let v0 = &arg0.market_state;
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::assert_trading_active(v0);
        assert!(arg2 < 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::outcome_count(v0), 5);
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::market_id(&arg1) == 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::market_id(v0), 2);
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::outcome(&arg1) == (arg2 as u8), 6);
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::asset_type(&arg1) == 0, 3);
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::burn(0x1::vector::borrow_mut<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&mut arg0.outcome_asset_supplies, arg2), arg1, arg4, arg5);
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::mint(v0, 0x1::vector::borrow_mut<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&mut arg0.outcome_stable_supplies, arg2), arg3, 0x2::tx_context::sender(arg5), arg4, arg5)
    }

    public(friend) fun swap_token_stable_to_asset<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken {
        let v0 = &arg0.market_state;
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::assert_trading_active(v0);
        assert!(arg2 < 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::outcome_count(v0), 5);
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::market_id(&arg1) == 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::market_id(v0), 2);
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::outcome(&arg1) == (arg2 as u8), 6);
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::asset_type(&arg1) == 1, 3);
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::burn(0x1::vector::borrow_mut<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&mut arg0.outcome_stable_supplies, arg2), arg1, arg4, arg5);
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::mint(v0, 0x1::vector::borrow_mut<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&mut arg0.outcome_asset_supplies, arg2), arg3, 0x2::tx_context::sender(arg5), arg4, arg5)
    }

    fun verify_token_set<T0, T1>(arg0: &TokenEscrow<T0, T1>, arg1: &vector<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken>, arg2: u8) : u64 {
        let v0 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::outcome_count(&arg0.market_state);
        assert!(0x1::vector::length<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken>(arg1) == v0, 1);
        let v1 = 0x1::vector::empty<bool>();
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<bool>(&mut v1, false);
            v2 = v2 + 1;
        };
        let v3 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::value(0x1::vector::borrow<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken>(arg1, 0));
        v2 = 0;
        while (v2 < v0) {
            let v4 = 0x1::vector::borrow<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::ConditionalToken>(arg1, v2);
            assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::market_id(v4) == 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::market_id(&arg0.market_state), 2);
            assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::asset_type(v4) == arg2, 3);
            assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::value(v4) == v3, 0);
            let v5 = (0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::outcome(v4) as u64);
            assert!(v5 < v0, 6);
            assert!(!*0x1::vector::borrow<bool>(&v1, v5), 6);
            *0x1::vector::borrow_mut<bool>(&mut v1, v5) = true;
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < v0) {
            assert!(*0x1::vector::borrow<bool>(&v1, v2), 6);
            v2 = v2 + 1;
        };
        v3
    }

    // decompiled from Move bytecode v6
}

