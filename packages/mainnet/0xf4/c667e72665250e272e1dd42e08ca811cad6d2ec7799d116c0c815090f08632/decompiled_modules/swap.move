module 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::swap {
    public fun swap_asset_to_stable<T0, T1>(arg0: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::Proposal<T0, T1>, arg1: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken {
        assert!(0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::market_state_id<T0, T1>(arg0) == 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::get_market_state_id<T0, T1>(arg1), 4);
        let v0 = swap_asset_to_stable_internal<T0, T1>(arg0, 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::get_market_state<T0, T1>(arg1), arg2, 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::value(&arg3), arg4, arg5, arg6);
        0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::liquidity_interact::assert_all_reserves_consistency<T0, T1>(arg0, arg1);
        0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::swap_token_asset_to_stable<T0, T1>(arg1, arg3, arg2, v0, arg5, arg6)
    }

    public fun swap_stable_to_asset<T0, T1>(arg0: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::Proposal<T0, T1>, arg1: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken {
        assert!(0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::market_state_id<T0, T1>(arg0) == 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::get_market_state_id<T0, T1>(arg1), 4);
        let v0 = swap_stable_to_asset_internal<T0, T1>(arg0, 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::get_market_state<T0, T1>(arg1), arg2, 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::value(&arg3), arg4, arg5, arg6);
        0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::liquidity_interact::assert_all_reserves_consistency<T0, T1>(arg0, arg1);
        0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::swap_token_stable_to_asset<T0, T1>(arg1, arg3, arg2, v0, arg5, arg6)
    }

    public fun create_and_swap_asset_to_stable<T0, T1>(arg0: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::Proposal<T0, T1>, arg1: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (vector<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>, 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken) {
        assert!(0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::market_state_id<T0, T1>(arg0) == 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::get_market_state_id<T0, T1>(arg1), 4);
        let v0 = 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::mint_complete_set_asset<T0, T1>(arg1, arg4, arg5, arg6);
        assert!(arg2 < 0x1::vector::length<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(&v0), 0);
        (v0, swap_asset_to_stable<T0, T1>(arg0, arg1, arg2, 0x1::vector::remove<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(&mut v0, arg2), arg3, arg5, arg6))
    }

    public entry fun create_and_swap_asset_to_stable_entry<T0, T1>(arg0: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::Proposal<T0, T1>, arg1: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_and_swap_asset_to_stable<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg6);
        while (!0x1::vector::is_empty<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(&v2)) {
            0x2::transfer::public_transfer<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(0x1::vector::pop_back<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(&mut v2), v3);
        };
        0x2::transfer::public_transfer<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(v1, v3);
        0x1::vector::destroy_empty<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(v2);
    }

    public fun create_and_swap_asset_to_stable_with_existing<T0, T1>(arg0: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::Proposal<T0, T1>, arg1: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (vector<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>, 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken) {
        assert!(0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::market_state_id<T0, T1>(arg0) == 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::get_market_state_id<T0, T1>(arg1), 4);
        let v0 = 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::mint_complete_set_asset<T0, T1>(arg1, arg5, arg6, arg7);
        assert!(arg2 < 0x1::vector::length<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(&v0), 0);
        let v1 = 0x1::vector::remove<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(&mut v0, arg2);
        assert!(0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::outcome(&arg3) == (arg2 as u8), 2);
        assert!(0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::asset_type(&arg3) == 0, 1);
        assert!(0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::market_id(&arg3) == 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::market_state::market_id(0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::get_market_state<T0, T1>(arg1)), 4);
        assert!(0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::outcome(&v1) == (arg2 as u8), 2);
        let v2 = 0x1::vector::empty<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>();
        0x1::vector::push_back<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(&mut v2, arg3);
        0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::merge_many(&mut v1, v2, arg6, arg7);
        (v0, swap_asset_to_stable<T0, T1>(arg0, arg1, arg2, v1, arg4, arg6, arg7))
    }

    public entry fun create_and_swap_asset_to_stable_with_existing_entry<T0, T1>(arg0: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::Proposal<T0, T1>, arg1: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_and_swap_asset_to_stable_with_existing<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg7);
        while (!0x1::vector::is_empty<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(&v2)) {
            0x2::transfer::public_transfer<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(0x1::vector::pop_back<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(&mut v2), v3);
        };
        0x2::transfer::public_transfer<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(v1, v3);
        0x1::vector::destroy_empty<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(v2);
    }

    public fun create_and_swap_stable_to_asset<T0, T1>(arg0: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::Proposal<T0, T1>, arg1: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (vector<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>, 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken) {
        assert!(0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::market_state_id<T0, T1>(arg0) == 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::get_market_state_id<T0, T1>(arg1), 4);
        let v0 = 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::mint_complete_set_stable<T0, T1>(arg1, arg4, arg5, arg6);
        assert!(arg2 < 0x1::vector::length<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(&v0), 0);
        (v0, swap_stable_to_asset<T0, T1>(arg0, arg1, arg2, 0x1::vector::remove<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(&mut v0, arg2), arg3, arg5, arg6))
    }

    public entry fun create_and_swap_stable_to_asset_entry<T0, T1>(arg0: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::Proposal<T0, T1>, arg1: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_and_swap_stable_to_asset<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg6);
        while (!0x1::vector::is_empty<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(&v2)) {
            0x2::transfer::public_transfer<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(0x1::vector::pop_back<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(&mut v2), v3);
        };
        0x2::transfer::public_transfer<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(v1, v3);
        0x1::vector::destroy_empty<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(v2);
    }

    public fun create_and_swap_stable_to_asset_with_existing<T0, T1>(arg0: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::Proposal<T0, T1>, arg1: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (vector<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>, 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken) {
        assert!(0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::market_state_id<T0, T1>(arg0) == 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::get_market_state_id<T0, T1>(arg1), 4);
        let v0 = 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::mint_complete_set_stable<T0, T1>(arg1, arg5, arg6, arg7);
        assert!(arg2 < 0x1::vector::length<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(&v0), 0);
        let v1 = 0x1::vector::remove<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(&mut v0, arg2);
        assert!(0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::outcome(&arg3) == (arg2 as u8), 2);
        assert!(0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::asset_type(&arg3) == 1, 1);
        assert!(0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::market_id(&arg3) == 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::market_state::market_id(0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::get_market_state<T0, T1>(arg1)), 4);
        assert!(0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::outcome(&v1) == (arg2 as u8), 2);
        let v2 = 0x1::vector::empty<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>();
        0x1::vector::push_back<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(&mut v2, arg3);
        0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::merge_many(&mut v1, v2, arg6, arg7);
        (v0, swap_stable_to_asset<T0, T1>(arg0, arg1, arg2, v1, arg4, arg6, arg7))
    }

    public entry fun create_and_swap_stable_to_asset_with_existing_entry<T0, T1>(arg0: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::Proposal<T0, T1>, arg1: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_and_swap_stable_to_asset_with_existing<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg7);
        while (!0x1::vector::is_empty<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(&v2)) {
            0x2::transfer::public_transfer<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(0x1::vector::pop_back<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(&mut v2), v3);
        };
        0x2::transfer::public_transfer<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(v1, v3);
        0x1::vector::destroy_empty<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(v2);
    }

    public entry fun swap_asset_to_stable_entry<T0, T1>(arg0: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::Proposal<T0, T1>, arg1: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        0x2::transfer::public_transfer<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(swap_asset_to_stable<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6), v0);
    }

    fun swap_asset_to_stable_internal<T0, T1>(arg0: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::Proposal<T0, T1>, arg1: &0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::market_state::MarketState, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : u64 {
        assert!(0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::proposal_id<T0, T1>(arg0) == 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::market_state::market_id(arg1), 4);
        assert!(arg2 < 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::outcome_count<T0, T1>(arg0), 0);
        assert!(0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::state<T0, T1>(arg0) == 1, 3);
        0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::amm::swap_asset_to_stable(0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::get_pool_mut_by_outcome<T0, T1>(arg0, (arg2 as u8)), arg1, arg3, arg4, arg5, arg6)
    }

    public entry fun swap_stable_to_asset_entry<T0, T1>(arg0: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::Proposal<T0, T1>, arg1: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        0x2::transfer::public_transfer<0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::conditional_token::ConditionalToken>(swap_stable_to_asset<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6), v0);
    }

    fun swap_stable_to_asset_internal<T0, T1>(arg0: &mut 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::Proposal<T0, T1>, arg1: &0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::market_state::MarketState, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : u64 {
        assert!(0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::proposal_id<T0, T1>(arg0) == 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::market_state::market_id(arg1), 4);
        assert!(arg2 < 0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::outcome_count<T0, T1>(arg0), 0);
        assert!(0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::state<T0, T1>(arg0) == 1, 3);
        0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::amm::swap_stable_to_asset(0xf4c667e72665250e272e1dd42e08ca811cad6d2ec7799d116c0c815090f08632::proposal::get_pool_mut_by_outcome<T0, T1>(arg0, (arg2 as u8)), arg1, arg3, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v6
}

