module 0x6178d818452c7fe167b8d3431f33f3522745a6f148702366f3cc8befa0907edc::transfer {
    struct CoinBalance<phantom T0> has key {
        id: 0x2::object::UID,
        token: 0x2::balance::Balance<T0>,
    }

    struct LogBridgeTo has copy, drop {
        _adaptorId: u8,
        _from: address,
        _to: address,
        _token: 0x1::string::String,
        _amount: u64,
        _orderId: u128,
        _toChainId: u32,
    }

    public fun redeem_transfer<T0>(arg0: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer::RelayerReceipt<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::coin_utils::return_nonzero<T0>(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer::redeem_relayer_payout<T0>(arg0), arg1);
    }

    public fun redeem_transfer_with_payload<T0>(arg0: &0x6178d818452c7fe167b8d3431f33f3522745a6f148702366f3cc8befa0907edc::owner::FundCap, arg1: &mut 0x6178d818452c7fe167b8d3431f33f3522745a6f148702366f3cc8befa0907edc::state::State, arg2: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer_with_payload::RedeemerReceipt<T0>, arg3: bool, arg4: vector<u8>, arg5: address, arg6: vector<u8>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, _) = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer_with_payload::redeem_coin<T0>(0x6178d818452c7fe167b8d3431f33f3522745a6f148702366f3cc8befa0907edc::state::emitter_cap(arg1), arg2);
        let v3 = v1;
        let v4 = v0;
        let v5 = 0x6178d818452c7fe167b8d3431f33f3522745a6f148702366f3cc8befa0907edc::message::deserialize(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::payload(&v3));
        let v6 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(0x6178d818452c7fe167b8d3431f33f3522745a6f148702366f3cc8befa0907edc::message::recipient(&v5));
        let v7 = 0x6178d818452c7fe167b8d3431f33f3522745a6f148702366f3cc8befa0907edc::state::get_relayer_fee(arg1, 0x2::coin::value<T0>(&v4));
        if (v7 > 0 && v6 != 0x2::tx_context::sender(arg8)) {
            0x2::pay::split<T0>(&mut v4, v7, arg8);
        };
        if (arg3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v6);
            0x2::coin::split<T0>(&mut v4, 0, arg8)
        } else {
            let (v9, _) = verify(arg1, arg4, arg5, arg6, arg7);
            assert!(v9 == true, 7);
            v4
        }
    }

    public fun send_tokens_with_payload<T0>(arg0: &0x6178d818452c7fe167b8d3431f33f3522745a6f148702366f3cc8befa0907edc::state::State, arg1: 0x2::coin::Coin<T0>, arg2: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::VerifiedAsset<T0>, arg3: u16, arg4: address, arg5: u32, arg6: u128, arg7: u8, arg8: 0x1::string::String, arg9: u32, arg10: &0x2::tx_context::TxContext) : 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_tokens_with_payload::TransferTicket<T0> {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::from_address(arg4);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::is_nonzero(&v0), 0);
        assert!(0x6178d818452c7fe167b8d3431f33f3522745a6f148702366f3cc8befa0907edc::state::contract_registered(arg0, arg3), 1);
        let v1 = LogBridgeTo{
            _adaptorId : arg7,
            _from      : 0x2::tx_context::sender(arg10),
            _to        : arg4,
            _token     : arg8,
            _amount    : 0x2::coin::value<T0>(&arg1),
            _orderId   : arg6,
            _toChainId : arg9,
        };
        0x2::event::emit<LogBridgeTo>(v1);
        let v2 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::coin_decimals<T0>(&arg2);
        assert!(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::to_raw(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::from_raw(0x2::coin::value<T0>(&arg1), v2), v2) > 0, 2);
        let (v3, v4) = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_tokens_with_payload::prepare_transfer<T0>(0x6178d818452c7fe167b8d3431f33f3522745a6f148702366f3cc8befa0907edc::state::emitter_cap(arg0), arg2, arg1, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(0x6178d818452c7fe167b8d3431f33f3522745a6f148702366f3cc8befa0907edc::state::foreign_contract_address(arg0, arg3)), 0x6178d818452c7fe167b8d3431f33f3522745a6f148702366f3cc8befa0907edc::message::serialize(0x6178d818452c7fe167b8d3431f33f3522745a6f148702366f3cc8befa0907edc::message::new(v0)), arg5);
        0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::coin_utils::return_nonzero<T0>(v4, arg10);
        v3
    }

    fun verify(arg0: &mut 0x6178d818452c7fe167b8d3431f33f3522745a6f148702366f3cc8befa0907edc::state::State, arg1: vector<u8>, arg2: address, arg3: vector<u8>, arg4: u64) : (bool, address) {
        let v0 = 0x6178d818452c7fe167b8d3431f33f3522745a6f148702366f3cc8befa0907edc::state::guadian_address(arg0, arg4);
        let v1 = x"19457468657265756d205369676e6564204d6573736167653a0a3332";
        let v2 = 0x2::hash::keccak256(&arg1);
        let v3 = 0;
        while (v3 < 32) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v2, v3));
            v3 = v3 + 1;
        };
        assert!(0x6178d818452c7fe167b8d3431f33f3522745a6f148702366f3cc8befa0907edc::guardian::ecrecover_eth_verify(arg3, v1, v0), 5);
        let v4 = 0x6178d818452c7fe167b8d3431f33f3522745a6f148702366f3cc8befa0907edc::parse::parse(arg1);
        let v5 = 0x6178d818452c7fe167b8d3431f33f3522745a6f148702366f3cc8befa0907edc::parse::txHash(&v4);
        assert!(0x6178d818452c7fe167b8d3431f33f3522745a6f148702366f3cc8befa0907edc::state::is_paid(arg0, arg4, v5) == false, 6);
        assert!(0x6178d818452c7fe167b8d3431f33f3522745a6f148702366f3cc8befa0907edc::parse::to(&v4) == arg2, 3);
        0x6178d818452c7fe167b8d3431f33f3522745a6f148702366f3cc8befa0907edc::state::add_paid_tx(arg0, arg4, v5);
        (true, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v0))
    }

    // decompiled from Move bytecode v6
}

