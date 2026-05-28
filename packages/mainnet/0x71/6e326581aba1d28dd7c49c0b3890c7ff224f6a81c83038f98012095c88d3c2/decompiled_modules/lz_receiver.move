module 0x716e326581aba1d28dd7c49c0b3890c7ff224f6a81c83038f98012095c88d3c2::lz_receiver {
    struct LZ_RECEIVER has drop {
        dummy_field: bool,
    }

    struct LzReceiverConfig has key {
        id: 0x2::object::UID,
        oapp_cap: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap,
        received_intents: 0x2::table::Table<vector<u8>, IntentRecord>,
        relayer: address,
    }

    struct IntentRecord has store {
        payload: vector<u8>,
        src_eid: u32,
        nonce: u64,
    }

    struct IntentReceived has copy, drop {
        intent_id: vector<u8>,
        payload: vector<u8>,
        src_eid: u32,
        nonce: u64,
        guid: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
    }

    struct ProofSent has copy, drop {
        intent_id: vector<u8>,
        blob_id: vector<u8>,
        end_epoch: u64,
        dst_eid: u32,
        nonce: u64,
        guid: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
    }

    entry fun register_oapp(arg0: &LzReceiverConfig, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::register_oapp(arg2, &arg0.oapp_cap, arg3, arg4);
    }

    public fun lz_receive(arg0: &mut LzReceiverConfig, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, _, v2, v3, v4, _, _, v7) = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::destroy(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::lz_receive(arg1, &arg0.oapp_cap, arg2));
        let v8 = v7;
        let v9 = v4;
        assert!(0x1::vector::length<u8>(&v9) >= 32, 1);
        let v10 = slice(&v9, 0, 32);
        assert!(!0x2::table::contains<vector<u8>, IntentRecord>(&arg0.received_intents, v10), 0);
        let v11 = IntentRecord{
            payload : v9,
            src_eid : v0,
            nonce   : v2,
        };
        0x2::table::add<vector<u8>, IntentRecord>(&mut arg0.received_intents, v10, v11);
        let v12 = IntentReceived{
            intent_id : v10,
            payload   : v9,
            src_eid   : v0,
            nonce     : v2,
            guid      : v3,
        };
        0x2::event::emit<IntentReceived>(v12);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v8)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v8), 0x2::tx_context::sender(arg3));
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v8);
        };
    }

    public(friend) fun build_proof_message(arg0: vector<u8>, arg1: vector<u8>, arg2: u64) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 3);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, v1));
            v1 = v1 + 1;
        };
        v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg1, v1));
            v1 = v1 + 1;
        };
        v1 = 0;
        while (v1 < 24) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 56 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 48 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 40 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 32 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 & 255) as u8));
        v0
    }

    public fun confirm_lz_send_proof(arg0: &LzReceiverConfig, arg1: &mut 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::confirm_lz_send(arg1, &arg0.oapp_cap, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = *0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::message(&v3);
        let (v5, v6) = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::destroy(v3);
        let v7 = v6;
        let v8 = v5;
        if (0x2::coin::value<0x2::sui::SUI>(&v8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v8, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v8);
        };
        if (0x1::option::is_some<0x2::coin::Coin<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>>(&v7)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>>(0x1::option::destroy_some<0x2::coin::Coin<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>>(v7), 0x2::tx_context::sender(arg3));
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>>(v7);
        };
        let v9 = ProofSent{
            intent_id : slice(&v4, 1, 32),
            blob_id   : slice(&v4, 33, 32),
            end_epoch : decode_u64_from_u256(&v4, 65),
            dst_eid   : 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::dst_eid(&v3),
            nonce     : 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::nonce(&v2),
            guid      : 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::guid(&v2),
        };
        0x2::event::emit<ProofSent>(v9);
    }

    public fun confirm_quote_proof(arg0: &LzReceiverConfig, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee>) : 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee {
        let (_, v1) = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::confirm_quote(arg1, &arg0.oapp_cap, arg2);
        v1
    }

    fun decode_u64_from_u256(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = arg1 + 24;
        (*0x1::vector::borrow<u8>(arg0, v0) as u64) << 56 | (*0x1::vector::borrow<u8>(arg0, v0 + 1) as u64) << 48 | (*0x1::vector::borrow<u8>(arg0, v0 + 2) as u64) << 40 | (*0x1::vector::borrow<u8>(arg0, v0 + 3) as u64) << 32 | (*0x1::vector::borrow<u8>(arg0, v0 + 4) as u64) << 24 | (*0x1::vector::borrow<u8>(arg0, v0 + 5) as u64) << 16 | (*0x1::vector::borrow<u8>(arg0, v0 + 6) as u64) << 8 | (*0x1::vector::borrow<u8>(arg0, v0 + 7) as u64)
    }

    fun init(arg0: LZ_RECEIVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _) = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::new<LZ_RECEIVER>(&arg0, arg1);
        let v3 = LzReceiverConfig{
            id               : 0x2::object::new(arg1),
            oapp_cap         : v0,
            received_intents : 0x2::table::new<vector<u8>, IntentRecord>(arg1),
            relayer          : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<LzReceiverConfig>(v3);
        0x2::transfer::public_transfer<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_received(arg0: &LzReceiverConfig, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, IntentRecord>(&arg0.received_intents, arg1)
    }

    public fun lz_send_proof(arg0: &LzReceiverConfig, arg1: &mut 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u32, arg6: vector<u8>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt> {
        assert!(0x2::tx_context::sender(arg8) == arg0.relayer, 2);
        assert!(0x2::table::contains<vector<u8>, IntentRecord>(&arg0.received_intents, arg2), 6);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::lz_send(arg1, &arg0.oapp_cap, arg5, build_proof_message(arg2, arg3, arg4), arg6, arg7, 0x1::option::none<0x2::coin::Coin<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>>(), 0x1::option::some<address>(0x2::tx_context::sender(arg8)), arg8)
    }

    public fun oapp_cap_id(arg0: &LzReceiverConfig) : address {
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(&arg0.oapp_cap)
    }

    public fun quote_proof(arg0: &LzReceiverConfig, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u32, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee> {
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::quote(arg1, &arg0.oapp_cap, arg5, build_proof_message(arg2, arg3, arg4), arg6, false, arg7)
    }

    entry fun set_relayer(arg0: &mut LzReceiverConfig, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap, arg2: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg3: address) {
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::assert_admin(arg2, arg1);
        assert!(arg3 != @0x0, 5);
        arg0.relayer = arg3;
    }

    fun slice(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v1));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

