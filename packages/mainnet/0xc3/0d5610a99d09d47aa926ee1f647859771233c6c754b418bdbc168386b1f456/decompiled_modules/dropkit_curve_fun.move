module 0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::dropkit_curve_fun {
    struct BuyEvent has copy, drop {
        curve_id: address,
        buyer: address,
        token_amount: u64,
        sui_paid: u64,
        fees: u64,
        timestamp: u64,
    }

    struct SellEvent has copy, drop {
        curve_id: address,
        seller: address,
        token_amount: u64,
        sui_received: u64,
        fees: u64,
        timestamp: u64,
    }

    struct CurveCreatedEvent has copy, drop {
        curve_id: address,
        creator: address,
        max_supply: u64,
        buy_multiplier: u64,
        sell_multiplier: u64,
        timestamp: u64,
    }

    struct Curve<phantom T0> has key {
        id: 0x2::object::UID,
        virtual_sui_reserves: u64,
        sui_treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        token_treasury: 0x2::balance::Balance<T0>,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        max_supply: u64,
        tokens_in_circulation: u64,
        buy_multiplier: u64,
        sell_multiplier: u64,
        creator_address: address,
        fee_collector_id: address,
        signature_config: 0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::signature_verifier::SignatureConfig,
    }

    public entry fun buy<T0>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &mut 0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::fee_collector::FeeCollector, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        if (0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::signature_verifier::requires_signature(&arg0.signature_config)) {
            0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::signature_verifier::verify_signature(&mut arg0.signature_config, 0x2::tx_context::sender(arg8), arg3, arg4, arg2, arg5, arg7, 0x2::object::uid_to_address(&arg0.id));
        };
        buy_internal<T0>(arg0, arg1, arg2, arg6, arg8);
    }

    fun buy_internal<T0>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::fee_collector::FeeCollector, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg2 <= 100000, 12);
        let v1 = calculate_buy_cost<T0>(arg0, arg2);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v2 >= v1, 4);
        let v3 = v2 - v1;
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v3, arg4), v0);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == v1, 5);
        let v4 = v1 * 1000 / arg0.buy_multiplier;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_treasury, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v4, arg4)));
        arg0.virtual_sui_reserves = arg0.virtual_sui_reserves + v4;
        assert!(arg0.virtual_sui_reserves > 0, 11);
        assert!(arg0.tokens_in_circulation <= arg0.max_supply, 10);
        0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::fee_collector::collect_and_distribute_fees(arg3, arg1, arg0.creator_address, arg4);
        arg0.tokens_in_circulation = arg0.tokens_in_circulation + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::coin::mint_balance<T0>(&mut arg0.treasury_cap, arg2 * 1000000000), arg4), v0);
        let v5 = BuyEvent{
            curve_id     : 0x2::object::uid_to_address(&arg0.id),
            buyer        : 0x2::tx_context::sender(arg4),
            token_amount : arg2,
            sui_paid     : v2,
            fees         : v1 - v4,
            timestamp    : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<BuyEvent>(v5);
    }

    public entry fun buy_with_sui_amount<T0>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &mut 0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::fee_collector::FeeCollector, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 4);
        let v1 = calculate_tokens_for_payment<T0>(arg0, v0);
        assert!(v1 > 0, 4);
        if (0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::signature_verifier::requires_signature(&arg0.signature_config)) {
            0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::signature_verifier::verify_signature(&mut arg0.signature_config, 0x2::tx_context::sender(arg7), arg2, arg3, v0, arg4, arg6, 0x2::object::uid_to_address(&arg0.id));
        };
        buy_internal<T0>(arg0, arg1, v1, arg5, arg7);
    }

    public fun calculate_buy_cost<T0>(arg0: &Curve<T0>, arg1: u64) : u64 {
        calculate_sui_delta_for_token_delta<T0>(arg0, arg1) * arg0.buy_multiplier / 1000
    }

    public fun calculate_sell_payout<T0>(arg0: &Curve<T0>, arg1: u64) : u64 {
        if (arg1 == 0 || arg1 > arg0.tokens_in_circulation) {
            return 0
        };
        arg0.virtual_sui_reserves * arg1 / (arg0.max_supply - arg0.tokens_in_circulation + arg1) * arg0.sell_multiplier / 1000
    }

    fun calculate_sell_payout_raw<T0>(arg0: &Curve<T0>, arg1: u64) : u64 {
        if (arg1 == 0 || arg1 > arg0.tokens_in_circulation) {
            return 0
        };
        arg0.virtual_sui_reserves * arg1 / (arg0.max_supply - arg0.tokens_in_circulation + arg1)
    }

    fun calculate_sui_delta_for_token_delta<T0>(arg0: &Curve<T0>, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = arg0.max_supply - arg0.tokens_in_circulation;
        assert!(arg1 < v0, 10);
        let v1 = (arg1 as u128);
        let v2 = (arg0.virtual_sui_reserves as u128) * v1 / ((v0 as u128) - v1);
        assert!(v2 <= 18446744073709551615, 11);
        (v2 as u64)
    }

    public fun calculate_tokens_for_payment<T0>(arg0: &Curve<T0>, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = arg1 * 1000 / arg0.buy_multiplier;
        let v1 = arg0.max_supply - arg0.tokens_in_circulation;
        if (v0 == 0) {
            return 0
        };
        if (v1 == 0) {
            return 0
        };
        let v2 = (v0 as u128);
        let v3 = (v1 as u128) * v2 / ((arg0.virtual_sui_reserves as u128) + v2);
        assert!(v3 <= 18446744073709551615, 11);
        (v3 as u64)
    }

    public fun get_backend_public_key<T0>(arg0: &Curve<T0>) : vector<u8> {
        0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::signature_verifier::get_backend_public_key(&arg0.signature_config)
    }

    public fun get_creator_address<T0>(arg0: &Curve<T0>) : address {
        arg0.creator_address
    }

    public fun get_current_price<T0>(arg0: &Curve<T0>) : u64 {
        let v0 = arg0.max_supply - arg0.tokens_in_circulation;
        if (v0 == 0) {
            return 0
        };
        arg0.virtual_sui_reserves / v0 * arg0.buy_multiplier / 1000
    }

    public fun get_curve_info<T0>(arg0: &Curve<T0>) : (u64, u64, u64, u64, u64, u64) {
        (arg0.virtual_sui_reserves, arg0.max_supply, arg0.tokens_in_circulation, arg0.max_supply - arg0.tokens_in_circulation, arg0.buy_multiplier, arg0.sell_multiplier)
    }

    public fun get_curve_stats<T0>(arg0: &Curve<T0>) : (u64, u64, u64, u64) {
        (arg0.virtual_sui_reserves, arg0.max_supply, arg0.tokens_in_circulation, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury))
    }

    public fun get_detailed_curve_state<T0>(arg0: &Curve<T0>) : (u64, u64, u64, u64, u64, u64, u64) {
        (arg0.virtual_sui_reserves, arg0.max_supply - arg0.tokens_in_circulation, arg0.tokens_in_circulation, arg0.max_supply, get_current_price<T0>(arg0), 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury), arg0.buy_multiplier)
    }

    public fun get_effective_price_for_amount<T0>(arg0: &Curve<T0>, arg1: u64) : u64 {
        if (arg1 == 0) {
            return get_current_price<T0>(arg0)
        };
        calculate_buy_cost<T0>(arg0, arg1) / arg1
    }

    public fun get_fee_collector_id<T0>(arg0: &Curve<T0>) : address {
        arg0.fee_collector_id
    }

    public fun get_treasury_balance<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury)
    }

    public fun get_used_nonces_count<T0>(arg0: &Curve<T0>) : u64 {
        0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::signature_verifier::get_used_nonces_count(&arg0.signature_config)
    }

    public fun is_nonce_used<T0>(arg0: &Curve<T0>, arg1: u64) : bool {
        0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::signature_verifier::is_nonce_used(&arg0.signature_config, arg1)
    }

    public entry fun new_curve<T0>(arg0: u64, arg1: u64, arg2: 0x2::coin::TreasuryCap<T0>, arg3: address, arg4: address, arg5: bool, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 1000000;
        let v1 = Curve<T0>{
            id                    : 0x2::object::new(arg7),
            virtual_sui_reserves  : 398000000000,
            sui_treasury          : 0x2::balance::zero<0x2::sui::SUI>(),
            token_treasury        : 0x2::balance::zero<T0>(),
            treasury_cap          : arg2,
            max_supply            : v0,
            tokens_in_circulation : 0,
            buy_multiplier        : 1025,
            sell_multiplier       : 975,
            creator_address       : arg3,
            fee_collector_id      : arg4,
            signature_config      : 0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::signature_verifier::new_signature_config(arg5, arg6, arg7),
        };
        let v2 = CurveCreatedEvent{
            curve_id        : 0x2::object::uid_to_address(&v1.id),
            creator         : arg3,
            max_supply      : v0,
            buy_multiplier  : 1025,
            sell_multiplier : 975,
            timestamp       : 0x2::tx_context::epoch(arg7),
        };
        0x2::event::emit<CurveCreatedEvent>(v2);
        0x2::transfer::share_object<Curve<T0>>(v1);
    }

    public fun requires_signature<T0>(arg0: &Curve<T0>) : bool {
        0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::signature_verifier::requires_signature(&arg0.signature_config)
    }

    public entry fun sell<T0>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &mut 0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::fee_collector::FeeCollector, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        if (0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::signature_verifier::requires_signature(&arg0.signature_config)) {
            0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::signature_verifier::verify_signature(&mut arg0.signature_config, 0x2::tx_context::sender(arg7), arg2, arg3, 0x2::coin::value<T0>(&arg1) / 1000000000, arg4, arg6, 0x2::object::uid_to_address(&arg0.id));
        };
        sell_internal<T0>(arg0, arg1, arg5, arg7);
    }

    fun sell_internal<T0>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::fee_collector::FeeCollector, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = v1 / 1000000000;
        assert!(v1 == v2 * 1000000000, 2);
        assert!(v2 > 0, 2);
        assert!(v2 <= arg0.tokens_in_circulation, 2);
        let v3 = calculate_sell_payout_raw<T0>(arg0, v2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury) >= v3, 3);
        let v4 = v3 * arg0.sell_multiplier / 1000;
        let v5 = v3 - v4;
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(&mut arg0.treasury_cap), 0x2::coin::into_balance<T0>(arg1));
        let v6 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_treasury, v3);
        arg0.virtual_sui_reserves = arg0.virtual_sui_reserves - v3 * 1000 / arg0.sell_multiplier;
        assert!(arg0.virtual_sui_reserves > 0, 11);
        assert!(arg0.max_supply - arg0.tokens_in_circulation <= arg0.max_supply, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v6, v4), arg3), v0);
        if (v5 > 0) {
            0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::fee_collector::collect_and_distribute_fees(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v6, arg3), arg0.creator_address, arg3);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v6);
        };
        arg0.tokens_in_circulation = arg0.tokens_in_circulation - v2;
        let v7 = SellEvent{
            curve_id     : 0x2::object::uid_to_address(&arg0.id),
            seller       : v0,
            token_amount : v2,
            sui_received : v4,
            fees         : v5,
            timestamp    : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<SellEvent>(v7);
    }

    public entry fun set_signature_requirement<T0>(arg0: &mut Curve<T0>, arg1: bool, arg2: vector<u8>, arg3: &0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::admin::DropkitAdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::signature_verifier::set_signature_requirement(&mut arg0.signature_config, arg1, arg2);
    }

    public fun test_math_consistency<T0>(arg0: &Curve<T0>, arg1: u64) : (u64, u64, u64, u64, u64, u64, u64) {
        let v0 = calculate_buy_cost<T0>(arg0, arg1);
        let v1 = calculate_tokens_for_payment<T0>(arg0, v0);
        (arg1, v0, v1, calculate_buy_cost<T0>(arg0, v1), arg0.virtual_sui_reserves, arg0.max_supply - arg0.tokens_in_circulation, calculate_sell_payout<T0>(arg0, arg1))
    }

    public entry fun update_backend_public_key<T0>(arg0: &mut Curve<T0>, arg1: vector<u8>, arg2: &0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::admin::DropkitAdminCap) {
        0xc30d5610a99d09d47aa926ee1f647859771233c6c754b418bdbc168386b1f456::signature_verifier::update_backend_public_key(&mut arg0.signature_config, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

