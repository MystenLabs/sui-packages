module 0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::transfer {
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

    public fun create_coinbalance<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinBalance<T0>{
            id    : 0x2::object::new(arg1),
            token : 0x2::coin::into_balance<T0>(arg0),
        };
        0x2::transfer::share_object<CoinBalance<T0>>(v0);
    }

    public fun redeem_transfer<T0>(arg0: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer::RelayerReceipt<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::coin_utils::return_nonzero<T0>(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer::redeem_relayer_payout<T0>(arg0), arg1);
    }

    public fun redeem_transfer_with_payload<T0>(arg0: &0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::state::State, arg1: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer_with_payload::RedeemerReceipt<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _) = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer_with_payload::redeem_coin<T0>(0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::state::emitter_cap(arg0), arg1);
        let v3 = v1;
        let v4 = v0;
        let v5 = 0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::message::deserialize(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::payload(&v3));
        let v6 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::message::recipient(&v5));
        let v7 = 0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::state::get_relayer_fee(arg0, 0x2::coin::value<T0>(&v4));
        if (v7 > 0 && v6 != 0x2::tx_context::sender(arg2)) {
            0x2::pay::split<T0>(&mut v4, v7, arg2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v6);
    }

    public fun send_tokens_with_payload<T0>(arg0: &0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::state::State, arg1: 0x2::coin::Coin<T0>, arg2: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::VerifiedAsset<T0>, arg3: u16, arg4: address, arg5: u32, arg6: u128, arg7: u8, arg8: 0x1::string::String, arg9: u32, arg10: &0x2::tx_context::TxContext) : 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_tokens_with_payload::TransferTicket<T0> {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::from_address(arg4);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::is_nonzero(&v0), 0);
        assert!(0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::state::contract_registered(arg0, arg3), 1);
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
        let (v3, v4) = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_tokens_with_payload::prepare_transfer<T0>(0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::state::emitter_cap(arg0), arg2, arg1, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::state::foreign_contract_address(arg0, arg3)), 0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::message::serialize(0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::message::new(v0)), arg5);
        0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::coin_utils::return_nonzero<T0>(v4, arg10);
        v3
    }

    public fun toswap_refund<T0>(arg0: &0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::owner::FundCap, arg1: &mut 0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::state::State, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: address, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::parse::parse(arg3);
        let v1 = 0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::parse::srcChainId(&v0);
        let v2 = x"19457468657265756d205369676e6564204d6573736167653a0a3332";
        let v3 = 0x2::hash::keccak256(&arg3);
        let v4 = 0;
        while (v4 < 32) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v3, v4));
            v4 = v4 + 1;
        };
        assert!(0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::guardian::ecrecover_eth_verify(arg5, v2, 0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::state::guadian_address(arg1, v1)), 5);
        let v5 = 0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::parse::txHash(&v0);
        assert!(0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::state::is_paid(arg1, v1, v5) == false, 6);
        assert!(0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::parse::to(&v0) == arg4, 3);
        0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::state::add_paid_tx(arg1, v1, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg4);
    }

    public fun verify<T0>(arg0: &0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::owner::FundCap, arg1: &mut CoinBalance<T0>, arg2: &mut 0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::state::State, arg3: u64, arg4: vector<u8>, arg5: address, arg6: vector<u8>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::state::guadian_address(arg2, arg7);
        let v1 = x"19457468657265756d205369676e6564204d6573736167653a0a3332";
        let v2 = 0x2::hash::keccak256(&arg4);
        let v3 = 0;
        while (v3 < 32) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v2, v3));
            v3 = v3 + 1;
        };
        assert!(0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::guardian::ecrecover_eth_verify(arg6, v1, v0), 5);
        let v4 = 0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::parse::parse(arg4);
        let v5 = 0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::parse::txHash(&v4);
        assert!(0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::state::is_paid(arg2, arg7, v5) == false, 6);
        assert!(0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::parse::to(&v4) == arg5, 3);
        0x3280d87e94161b32ae28bcc3a31223f2dc10905c73605881d02400427de1981b::state::add_paid_tx(arg2, arg7, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.token, arg3, arg8), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v0));
    }

    // decompiled from Move bytecode v6
}

