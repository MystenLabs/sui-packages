module 0x9272d9d9585d081fe25318c24ca7f80916c6e19c7ec50840063764a751f234de::bridge_locked_fee {
    struct BridgeLockedFeeSubmitted has copy, drop {
        cctp_nonce: u64,
        dest_domain: u32,
        amount_bridged: u64,
        fee_redeem: u64,
        gas_drop: u64,
        coin_metadata_id: address,
        coin_type: 0x1::ascii::String,
        locked_fee_id: address,
        addr_dest: address,
    }

    struct BridgeLockedFeeTicket<phantom T0> {
        input_funds: 0x2::coin::Coin<T0>,
        addr_dest: address,
        domain_dest: u32,
        gas_drop: u64,
        fee_redeem: u64,
    }

    struct CctpBurnRequestBridgeLockedFee<phantom T0> {
        domain_dest: u32,
        mint_recipient: address,
        burn_token: address,
        amount_in: u64,
        caller: address,
        locked_fee_funds: 0x2::coin::Coin<T0>,
        gas_drop: u64,
        token_in: address,
    }

    struct CircleAuth has drop {
        dummy_field: bool,
    }

    public fun bridge_locked_fee<T0: drop>(arg0: &mut 0x9272d9d9585d081fe25318c24ca7f80916c6e19c7ec50840063764a751f234de::state::State, arg1: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg2: &0x2::coin::CoinMetadata<T0>, arg3: BridgeLockedFeeTicket<T0>, arg4: &mut 0x2::tx_context::TxContext) : (CctpBurnRequestBridgeLockedFee<T0>, 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::DepositForBurnWithCallerTicket<T0, CircleAuth>) {
        0x9272d9d9585d081fe25318c24ca7f80916c6e19c7ec50840063764a751f234de::state::assert_valid_version(arg0);
        assert!(!0x9272d9d9585d081fe25318c24ca7f80916c6e19c7ec50840063764a751f234de::state::is_paused(arg0), 0);
        let BridgeLockedFeeTicket {
            input_funds : v0,
            addr_dest   : v1,
            domain_dest : v2,
            gas_drop    : v3,
            fee_redeem  : v4,
        } = arg3;
        let v5 = v0;
        let v6 = 0x2::coin::value<T0>(&v5);
        assert!(v6 >= v4, 2);
        assert!(v2 != 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::local_domain(arg1), 3);
        assert!(v2 != 0x9272d9d9585d081fe25318c24ca7f80916c6e19c7ec50840063764a751f234de::state::solana_cctp_domain(), 4);
        let v7 = 0x9272d9d9585d081fe25318c24ca7f80916c6e19c7ec50840063764a751f234de::state::get_cctp_mayan_caller(arg0, v2);
        let v8 = CircleAuth{dummy_field: false};
        let v9 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg2);
        let v10 = CctpBurnRequestBridgeLockedFee<T0>{
            domain_dest      : v2,
            mint_recipient   : v1,
            burn_token       : 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::token_utils::calculate_token_id<T0>(),
            amount_in        : v6,
            caller           : v7,
            locked_fee_funds : v5,
            gas_drop         : v3,
            token_in         : 0x2::object::id_to_address(&v9),
        };
        (v10, 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::create_deposit_for_burn_with_caller_ticket<T0, CircleAuth>(v8, 0x2::coin::split<T0>(&mut v5, v6 - v4, arg4), v2, v1, v7))
    }

    public fun prepare_bridge_locked_fee<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: u32, arg4: u64, arg5: u64) : BridgeLockedFeeTicket<T0> {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 1);
        BridgeLockedFeeTicket<T0>{
            input_funds : arg0,
            addr_dest   : arg2,
            domain_dest : arg3,
            gas_drop    : arg4,
            fee_redeem  : arg5,
        }
    }

    public fun store_bridge_locked_fee<T0>(arg0: &mut 0x9272d9d9585d081fe25318c24ca7f80916c6e19c7ec50840063764a751f234de::state::State, arg1: &0x2::coin::CoinMetadata<T0>, arg2: CctpBurnRequestBridgeLockedFee<T0>, arg3: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::Message, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x9272d9d9585d081fe25318c24ca7f80916c6e19c7ec50840063764a751f234de::state::is_paused(arg0), 0);
        0x9272d9d9585d081fe25318c24ca7f80916c6e19c7ec50840063764a751f234de::state::assert_valid_version(arg0);
        let CctpBurnRequestBridgeLockedFee {
            domain_dest      : v0,
            mint_recipient   : v1,
            burn_token       : v2,
            amount_in        : v3,
            caller           : v4,
            locked_fee_funds : v5,
            gas_drop         : v6,
            token_in         : v7,
        } = arg2;
        let v8 = v5;
        let v9 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::message_body(arg3);
        let v10 = 0x9272d9d9585d081fe25318c24ca7f80916c6e19c7ec50840063764a751f234de::burn_message::from_bytes(&v9);
        assert!(v0 == 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::destination_domain(arg3), 5);
        assert!(v1 == 0x9272d9d9585d081fe25318c24ca7f80916c6e19c7ec50840063764a751f234de::burn_message::mint_recipient(&v10), 5);
        assert!(v2 == 0x9272d9d9585d081fe25318c24ca7f80916c6e19c7ec50840063764a751f234de::burn_message::burn_token(&v10), 5);
        assert!(v3 == (0x9272d9d9585d081fe25318c24ca7f80916c6e19c7ec50840063764a751f234de::burn_message::amount(&v10) as u64), 5);
        assert!(v4 == 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::destination_caller(arg3), 5);
        let v11 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg1);
        assert!(v7 == 0x2::object::id_to_address(&v11), 5);
        let v12 = BridgeLockedFeeSubmitted{
            cctp_nonce       : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::nonce(arg3),
            dest_domain      : v0,
            amount_bridged   : v3,
            fee_redeem       : 0x2::coin::value<T0>(&v8),
            gas_drop         : v6,
            coin_metadata_id : v7,
            coin_type        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            locked_fee_id    : 0x9272d9d9585d081fe25318c24ca7f80916c6e19c7ec50840063764a751f234de::state::lock_fee_redeem<T0>(arg0, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::nonce(arg3), v1, v6, 0x2::coin::into_balance<T0>(v8), arg4),
            addr_dest        : v1,
        };
        0x2::event::emit<BridgeLockedFeeSubmitted>(v12);
    }

    // decompiled from Move bytecode v6
}

