module 0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::prvc {
    struct PRVC has drop {
        dummy_field: bool,
    }

    struct EventPaused has copy, drop {
        dummy_field: bool,
    }

    struct EventUnpaused has copy, drop {
        dummy_field: bool,
    }

    struct EventTransfersFrozen has copy, drop {
        address: address,
    }

    struct EventTransfersUnfrozen has copy, drop {
        address: address,
    }

    struct EventMint has copy, drop {
        address: address,
        amount: u64,
    }

    struct EventBurn has copy, drop {
        amount: u64,
    }

    struct EventTransfer has copy, drop {
        sender: address,
        recipient: address,
        amount: u64,
    }

    struct EventAllocation has copy, drop {
        sender: address,
        recipient: address,
        amount: u64,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 2, b"$PRVC", b"Pravica Coin", b"Pravica Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s3m-contracts-prod.s3.eu-central-1.amazonaws.com/icons/0xfe4392fee789b241175ba4bb9ec257e51b2500891f29d16600b5d3d2bad1123f/a1019967379a3c13b3f234bc08b100a338eef5fea64b7f501a866036a48c3da5..png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    public fun burn<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: &0x2::token::TokenPolicy<T0>, arg2: 0x2::token::Token<T0>) {
        assert!(!0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::pauser_rule::paused<T0>(arg1), 200);
        0x2::token::burn<T0>(arg0, arg2);
        let v0 = EventBurn{amount: 0x2::token::value<T0>(&arg2)};
        0x2::event::emit<EventBurn>(v0);
    }

    public fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: &0x2::token::TokenPolicy<T0>, arg2: &0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::token_supply::TokenSupply<T0>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::pauser_rule::paused<T0>(arg1), 200);
        let v0 = 0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::token_supply::max_supply<T0>(arg2);
        if (v0 > 0) {
            assert!(v0 >= 0x2::coin::total_supply<T0>(arg0) + arg3, 201);
        };
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(arg0, 0x2::token::transfer<T0>(0x2::token::mint<T0>(arg0, arg3, arg5), arg4, arg5), arg5);
        let v5 = EventMint{
            address : arg4,
            amount  : arg3,
        };
        0x2::event::emit<EventMint>(v5);
    }

    public fun transfer<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: 0x2::token::Token<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::token::transfer<T0>(arg1, arg2, arg3);
        0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::denylist_rule::verify<T0>(arg0, &mut v0, arg3);
        0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::pauser_rule::verify<T0>(arg0, &mut v0, arg3);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg0, v0, arg3);
        let v5 = EventTransfer{
            sender    : 0x2::tx_context::sender(arg3),
            recipient : arg2,
            amount    : 0x2::token::value<T0>(&arg1),
        };
        0x2::event::emit<EventTransfer>(v5);
    }

    public fun allocate<T0>(arg0: &0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::cash_::CashInCap<T0>, arg1: &0x2::token::TokenPolicy<T0>, arg2: 0x2::token::Token<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::cash_::get_address<T0>(arg0) == 0x2::tx_context::sender(arg4), 202);
        let v0 = 0x2::token::transfer<T0>(arg2, arg3, arg4);
        0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::denylist_rule::verify<T0>(arg1, &mut v0, arg4);
        0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::pauser_rule::verify<T0>(arg1, &mut v0, arg4);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg1, v0, arg4);
        let v5 = EventAllocation{
            sender    : 0x2::tx_context::sender(arg4),
            recipient : arg3,
            amount    : 0x2::token::value<T0>(&arg2),
        };
        0x2::event::emit<EventAllocation>(v5);
    }

    public fun freeze_address<T0>(arg0: &0x2::token::TokenPolicyCap<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::pauser_rule::paused<T0>(arg1), 200);
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, arg2);
        0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::denylist_rule::add_records<T0>(arg1, arg0, v0, arg3);
        let v1 = EventTransfersFrozen{address: arg2};
        0x2::event::emit<EventTransfersFrozen>(v1);
    }

    fun init(arg0: PRVC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<PRVC>(arg0, arg1);
        let (v1, v2) = 0x2::token::new_policy<PRVC>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        let (v5, v6) = 0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::token_supply::new_token_supply<PRVC>(&v0, 0, false, arg1);
        let v7 = v5;
        let v8 = 0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::cash_::new_cashin<PRVC>(&v0, @0xfe4392fee789b241175ba4bb9ec257e51b2500891f29d16600b5d3d2bad1123f, arg1);
        let v9 = &mut v4;
        set_rules<PRVC>(v9, &v3, arg1);
        let v10 = &mut v0;
        maybe_mint_initial_supply<PRVC>(v10, &v4, &v7, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRVC>>(v0, @0xfe4392fee789b241175ba4bb9ec257e51b2500891f29d16600b5d3d2bad1123f);
        0x2::transfer::public_transfer<0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::token_supply::TokenSupplyCap<PRVC>>(v6, @0xfe4392fee789b241175ba4bb9ec257e51b2500891f29d16600b5d3d2bad1123f);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<PRVC>>(v3, @0xfe4392fee789b241175ba4bb9ec257e51b2500891f29d16600b5d3d2bad1123f);
        0x2::transfer::public_transfer<0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::cash_::CashInCap<PRVC>>(v8, @0xfe4392fee789b241175ba4bb9ec257e51b2500891f29d16600b5d3d2bad1123f);
        0x2::token::share_policy<PRVC>(v4);
        0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::token_supply::share_supply<PRVC>(v7);
    }

    public fun is_frozen<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: address) : bool {
        0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::denylist_rule::verifyp<T0>(arg0, arg1)
    }

    public fun is_paused<T0>(arg0: &0x2::token::TokenPolicy<T0>) : bool {
        0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::pauser_rule::paused<T0>(arg0)
    }

    fun maybe_mint_initial_supply<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: &0x2::token::TokenPolicy<T0>, arg2: &0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::token_supply::TokenSupply<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        if (100 > 0) {
            mint<T0>(arg0, arg1, arg2, 100, @0xfe4392fee789b241175ba4bb9ec257e51b2500891f29d16600b5d3d2bad1123f, arg3);
            let v0 = EventTransfer{
                sender    : @0x0,
                recipient : @0xfe4392fee789b241175ba4bb9ec257e51b2500891f29d16600b5d3d2bad1123f,
                amount    : 100,
            };
            0x2::event::emit<EventTransfer>(v0);
        };
    }

    public fun pause<T0>(arg0: &0x2::token::TokenPolicyCap<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::pauser_rule::paused<T0>(arg1)) {
            0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::pauser_rule::set_config<T0>(arg1, arg0, true, arg2);
            let v0 = EventPaused{dummy_field: false};
            0x2::event::emit<EventPaused>(v0);
        };
    }

    public(friend) fun set_rules<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::pauser_rule::set_config<T0>(arg0, arg1, false, arg2);
        0x2::token::add_rule_for_action<T0, 0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::pauser_rule::Pauser>(arg0, arg1, 0x2::token::transfer_action(), arg2);
        0x2::token::add_rule_for_action<T0, 0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::denylist_rule::Denylist>(arg0, arg1, 0x2::token::transfer_action(), arg2);
        0x2::token::add_rule_for_action<T0, 0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::pauser_rule::Pauser>(arg0, arg1, 0x2::token::spend_action(), arg2);
        0x2::token::add_rule_for_action<T0, 0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::denylist_rule::Denylist>(arg0, arg1, 0x2::token::spend_action(), arg2);
        0x2::token::add_rule_for_action<T0, 0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::pauser_rule::Pauser>(arg0, arg1, 0x2::token::to_coin_action(), arg2);
        0x2::token::add_rule_for_action<T0, 0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::denylist_rule::Denylist>(arg0, arg1, 0x2::token::to_coin_action(), arg2);
        0x2::token::add_rule_for_action<T0, 0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::pauser_rule::Pauser>(arg0, arg1, 0x2::token::from_coin_action(), arg2);
        0x2::token::add_rule_for_action<T0, 0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::denylist_rule::Denylist>(arg0, arg1, 0x2::token::from_coin_action(), arg2);
    }

    public fun unfreeze_address<T0>(arg0: &0x2::token::TokenPolicyCap<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::pauser_rule::paused<T0>(arg1), 200);
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, arg2);
        0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::denylist_rule::remove_records<T0>(arg1, arg0, v0, arg3);
        let v1 = EventTransfersUnfrozen{address: arg2};
        0x2::event::emit<EventTransfersUnfrozen>(v1);
    }

    public fun unpause<T0>(arg0: &0x2::token::TokenPolicyCap<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::pauser_rule::paused<T0>(arg1)) {
            0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::pauser_rule::set_config<T0>(arg1, arg0, false, arg2);
            let v0 = EventUnpaused{dummy_field: false};
            0x2::event::emit<EventUnpaused>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

