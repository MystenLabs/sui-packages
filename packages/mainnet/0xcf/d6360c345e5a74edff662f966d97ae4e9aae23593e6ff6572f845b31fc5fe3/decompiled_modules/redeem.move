module 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::redeem {
    struct BridgeRedeemed has copy, drop {
        cctp_nonce: u256,
        cctp_source_domain: u32,
        payload_type: u8,
        addr_dest: address,
        currency_id: address,
        coin_type: 0x1::ascii::String,
        amount_in: u64,
        amount_dest: u64,
        fee_redeem: u64,
        fee_ref: u64,
        fee_mayan: u64,
        gas_drop: u64,
        relayer: address,
    }

    struct DestCap has store, key {
        id: 0x2::object::UID,
    }

    struct DestCapCreated has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct DestCapDestroyed has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct RedeemReceipt<phantom T0> {
        payload_type: u8,
        addr_dest: address,
        relayer_funds: 0x2::coin::Coin<T0>,
        funds: 0x2::coin::Coin<T0>,
        gas_drop: 0x2::coin::Coin<0x2::sui::SUI>,
        custom_payload_hash: address,
    }

    public fun redeem<T0: drop>(arg0: &mut 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::state::State, arg1: &mut 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::state::FundsReceiver, arg2: &0xb1734cb5a244bdb2729e37402a79e0a2e81d18b96b7bfbfe174482b8d9330639::state::FeeManagerState, arg3: &0x2::coin_registry::Currency<T0>, arg4: u256, arg5: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) : RedeemReceipt<T0> {
        0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::state::assert_valid_version(arg0);
        let (v0, _, v2, v3, v4) = 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::state::remove_pending_bridge(arg0, arg4);
        assert!(v2 == 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::token_utils::calculate_token_id<T0>(), 0);
        let (v5, v6, v7, v8, v9, v10, v11) = 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::bridge_payload::unpack(v4);
        let v12 = 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::state::receive_minted_funds<T0>(arg1, v3, arg5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::amount::denormalize_amount(v7, 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::amount::sui_decimals()), 1);
        let v13 = 0x1::u64::min(v8, v3);
        let v14 = 0x2::coin::value<T0>(&v12);
        let v15 = 0x2::object::id<0x2::coin_registry::Currency<T0>>(arg3);
        let v16 = 0x2::object::id_to_address(&v15);
        let v17 = 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::amount::cap_fee_rate(v10);
        let v18 = if (v9 != @0x0) {
            0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::amount::bps(v14, (v17 as u16))
        } else {
            0
        };
        let v19 = 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::amount::bps(v14, (0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::amount::cap_fee_rate(0xb1734cb5a244bdb2729e37402a79e0a2e81d18b96b7bfbfe174482b8d9330639::calculate_fast_mctp_fee::calculate_protocol_fee_rate(arg2, v5, v0, v16, v14, v16, v9, v17)) as u16));
        if (v18 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v12, v18, arg7), v9);
        };
        if (v19 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v12, v19, arg7), 0xb1734cb5a244bdb2729e37402a79e0a2e81d18b96b7bfbfe174482b8d9330639::state::get_fee_collector(arg2));
        };
        let v20 = BridgeRedeemed{
            cctp_nonce         : arg4,
            cctp_source_domain : v0,
            payload_type       : v5,
            addr_dest          : v6,
            currency_id        : v16,
            coin_type          : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount_in          : v3,
            amount_dest        : 0x2::coin::value<T0>(&v12),
            fee_redeem         : v13,
            fee_ref            : v18,
            fee_mayan          : v19,
            gas_drop           : 0x2::coin::value<0x2::sui::SUI>(&arg6),
            relayer            : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<BridgeRedeemed>(v20);
        RedeemReceipt<T0>{
            payload_type        : v5,
            addr_dest           : v6,
            relayer_funds       : 0x2::coin::split<T0>(&mut v12, v13, arg7),
            funds               : v12,
            gas_drop            : arg6,
            custom_payload_hash : v11,
        }
    }

    public fun complete_redeem_simple<T0>(arg0: &0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::state::State, arg1: RedeemReceipt<T0>) : 0x2::coin::Coin<T0> {
        0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::state::assert_valid_version(arg0);
        let RedeemReceipt {
            payload_type        : v0,
            addr_dest           : v1,
            relayer_funds       : v2,
            funds               : v3,
            gas_drop            : v4,
            custom_payload_hash : _,
        } = arg1;
        assert!(v0 == 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::bridge_payload::payload_type_default(), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v1);
        v2
    }

    public fun complete_redeem_with_payload<T0: drop>(arg0: &0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::state::State, arg1: RedeemReceipt<T0>, arg2: &DestCap) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>, address) {
        0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::state::assert_valid_version(arg0);
        let RedeemReceipt {
            payload_type        : v0,
            addr_dest           : v1,
            relayer_funds       : v2,
            funds               : v3,
            gas_drop            : v4,
            custom_payload_hash : v5,
        } = arg1;
        assert!(v0 == 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::bridge_payload::payload_type_custom(), 2);
        let v6 = 0x2::object::id<DestCap>(arg2);
        assert!(0x2::object::id_to_address(&v6) == v1, 3);
        (v2, v3, v4, v5)
    }

    public fun destroy_dest_cap(arg0: &0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::state::State, arg1: DestCap) {
        0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::state::assert_valid_version(arg0);
        let v0 = DestCapDestroyed{cap_id: 0x2::object::id<DestCap>(&arg1)};
        0x2::event::emit<DestCapDestroyed>(v0);
        let DestCap { id: v1 } = arg1;
        0x2::object::delete(v1);
    }

    public fun get_redeem_receipt_addr_dest<T0>(arg0: &RedeemReceipt<T0>) : address {
        arg0.addr_dest
    }

    public fun get_redeem_receipt_custom_payload_hash<T0>(arg0: &RedeemReceipt<T0>) : address {
        arg0.custom_payload_hash
    }

    public fun get_redeem_receipt_funds_value<T0>(arg0: &RedeemReceipt<T0>) : u64 {
        0x2::coin::value<T0>(&arg0.funds)
    }

    public fun get_redeem_receipt_gas_drop_value<T0>(arg0: &RedeemReceipt<T0>) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.gas_drop)
    }

    public fun get_redeem_receipt_payload_type<T0>(arg0: &RedeemReceipt<T0>) : u8 {
        arg0.payload_type
    }

    public fun get_redeem_receipt_relayer_funds_value<T0>(arg0: &RedeemReceipt<T0>) : u64 {
        0x2::coin::value<T0>(&arg0.relayer_funds)
    }

    public fun new_dest_cap(arg0: &0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::state::State, arg1: &mut 0x2::tx_context::TxContext) : DestCap {
        0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::state::assert_valid_version(arg0);
        let v0 = DestCap{id: 0x2::object::new(arg1)};
        let v1 = DestCapCreated{cap_id: 0x2::object::id<DestCap>(&v0)};
        0x2::event::emit<DestCapCreated>(v1);
        v0
    }

    // decompiled from Move bytecode v7
}

