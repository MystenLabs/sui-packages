module 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::wormhole_facet {
    struct WormholeFee has key {
        id: 0x2::object::UID,
        fee: u64,
        beneficiary: address,
    }

    struct Storage has key {
        id: 0x2::object::UID,
        emitter_cap: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap,
        src_wormhole_chain_id: u16,
        actual_reserve: u64,
        estimate_reserve: u64,
        dst_base_gas: 0x2::table::Table<u16, u256>,
        dst_gas_per_bytes: 0x2::table::Table<u16, u256>,
    }

    struct NormalizedWormholeData has copy, drop {
        dst_wormhole_chain_id: u16,
        dst_max_gas_price_in_wei_for_relayer: u256,
        wormhole_fee: u256,
        dst_so_diamond: vector<u8>,
    }

    struct WormholeFacetManager has key {
        id: 0x2::object::UID,
        owner: address,
        relayer: address,
    }

    struct TransferFromWormholeEvent has copy, drop {
        src_wormhole_chain_id: u16,
        dst_wormhole_chain_id: u16,
        sequence: u64,
    }

    struct SoTransferStarted has copy, drop {
        transaction_id: vector<u8>,
    }

    struct SoTransferCompleted has copy, drop {
        transaction_id: vector<u8>,
        actual_receiving_amount: u64,
    }

    struct SrcAmount has copy, drop {
        relayer_fee: u64,
        cross_amount: u64,
    }

    struct DstAmount has copy, drop {
        so_fee: u64,
    }

    public fun check_relayer_fee(arg0: &mut Storage, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::so_fee_wormhole::PriceManager, arg3: 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSoData, arg4: NormalizedWormholeData, arg5: vector<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>) : (bool, u64, u64, u256) {
        let v0 = arg0.actual_reserve;
        let v1 = estimate_complete_soswap_gas(arg0, 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::encode_normalized_so_data(arg3), arg4, 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::encode_normalized_swap_data(arg5));
        let v2 = (100000000 as u256);
        let v3 = if (arg4.dst_wormhole_chain_id == 22) {
            arg4.dst_max_gas_price_in_wei_for_relayer * v1 * (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::so_fee_wormhole::get_price_ratio(arg2, arg4.dst_wormhole_chain_id) as u256) / v2 * (v0 as u256) / v2 * 10
        } else {
            arg4.dst_max_gas_price_in_wei_for_relayer * v1 * (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::so_fee_wormhole::get_price_ratio(arg2, arg4.dst_wormhole_chain_id) as u256) / v2 * (v0 as u256) / v2 / 1000000000
        };
        let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::message_fee(arg1);
        let v5 = v4;
        if (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::swap::right_type<0x2::sui::SUI>(0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_sending_asset_id(arg3))) {
            v5 = v4 + (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_amount(arg3) as u64);
        };
        let v6 = (v3 as u64);
        let v7 = v5 + v6;
        let v8 = false;
        if (v7 <= (arg4.wormhole_fee as u64)) {
            v8 = true;
        };
        (v8, v6, v7, v1)
    }

    public entry fun complete_so_swap_by_admin<T0>(arg0: &mut Storage, arg1: &mut WormholeFacetManager, arg2: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg3: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg4: &mut WormholeFee, arg5: vector<u8>, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg8), 4);
        let (v0, v1) = complete_transfer<T0>(arg0, arg2, arg3, arg5, arg7, arg8);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = get_so_fees(arg4);
        let v6 = (((v4 as u128) * (v5 as u128) / (100000000 as u128)) as u64);
        if (v6 > 0 && v6 <= v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v3, v6, arg8), arg4.beneficiary);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg6);
        let v7 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::payload(&v2);
        let (_, _, v10, _) = decode_wormhole_payload(&v7);
        let v12 = SoTransferCompleted{
            transaction_id          : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_transaction_id(v10),
            actual_receiving_amount : 0x2::coin::value<T0>(&v3),
        };
        0x2::event::emit<SoTransferCompleted>(v12);
        let v13 = DstAmount{so_fee: v6};
        0x2::event::emit<DstAmount>(v13);
    }

    public entry fun complete_so_swap_by_relayer<T0>(arg0: &mut Storage, arg1: &mut WormholeFacetManager, arg2: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg3: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg4: &mut WormholeFee, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg1.relayer, 4);
        let (v0, v1) = complete_transfer<T0>(arg0, arg2, arg3, arg5, arg6, arg7);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = get_so_fees(arg4);
        let v6 = (((v4 as u128) * (v5 as u128) / (100000000 as u128)) as u64);
        if (v6 > 0 && v6 <= v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v3, v6, arg7), arg4.beneficiary);
        };
        let v7 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::payload(&v2);
        let (_, _, v10, _) = decode_wormhole_payload(&v7);
        let v12 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_receiver(v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_address(&v12));
        let v13 = SoTransferCompleted{
            transaction_id          : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_transaction_id(v10),
            actual_receiving_amount : 0x2::coin::value<T0>(&v3),
        };
        0x2::event::emit<SoTransferCompleted>(v13);
        let v14 = DstAmount{so_fee: v6};
        0x2::event::emit<DstAmount>(v14);
    }

    public entry fun complete_so_swap_for_cetus_base_asset<T0, T1>(arg0: &mut Storage, arg1: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg2: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &mut WormholeFee, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = complete_transfer<T1>(arg0, arg1, arg2, arg6, arg7, arg8);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::coin::value<T1>(&v3);
        let v5 = get_so_fees(arg3);
        let v6 = (((v4 as u128) * (v5 as u128) / (100000000 as u128)) as u64);
        if (v6 > 0 && v6 <= v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v3, v6, arg8), arg3.beneficiary);
        };
        let v7 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::payload(&v2);
        let (_, _, v10, v11) = decode_wormhole_payload(&v7);
        let v12 = v11;
        let v13 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_receiver(v10);
        let v14 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_address(&v13);
        let v15 = 0x2::coin::value<T1>(&v3);
        if (0x1::vector::length<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&v12) > 0) {
            assert!(0x1::vector::length<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&v12) == 1, 11);
            let (v16, v17, _) = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::swap::swap_for_base_asset_by_cetus<T0, T1>(arg4, arg5, v3, *0x1::vector::borrow<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&v12, 0), arg7, arg8);
            let v19 = v17;
            v15 = 0x2::coin::value<T1>(&v19);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v19, v14);
            process_left_coin<T0>(v16, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, v14);
        };
        let v20 = SoTransferCompleted{
            transaction_id          : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_transaction_id(v10),
            actual_receiving_amount : v15,
        };
        0x2::event::emit<SoTransferCompleted>(v20);
        let v21 = DstAmount{so_fee: v6};
        0x2::event::emit<DstAmount>(v21);
    }

    public entry fun complete_so_swap_for_cetus_quote_asset<T0, T1>(arg0: &mut Storage, arg1: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg2: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &mut WormholeFee, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = complete_transfer<T0>(arg0, arg1, arg2, arg6, arg7, arg8);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = get_so_fees(arg3);
        let v6 = (((v4 as u128) * (v5 as u128) / (100000000 as u128)) as u64);
        if (v6 > 0 && v6 <= v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v3, v6, arg8), arg3.beneficiary);
        };
        let v7 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::payload(&v2);
        let (_, _, v10, v11) = decode_wormhole_payload(&v7);
        let v12 = v11;
        let v13 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_receiver(v10);
        let v14 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_address(&v13);
        let v15 = 0x2::coin::value<T0>(&v3);
        if (0x1::vector::length<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&v12) > 0) {
            assert!(0x1::vector::length<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&v12) == 1, 11);
            let (v16, v17, _) = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::swap::swap_for_quote_asset_by_cetus<T0, T1>(arg4, arg5, v3, *0x1::vector::borrow<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&v12, 0), arg7, arg8);
            let v19 = v17;
            v15 = 0x2::coin::value<T1>(&v19);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v19, v14);
            process_left_coin<T0>(v16, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v14);
        };
        let v20 = SoTransferCompleted{
            transaction_id          : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_transaction_id(v10),
            actual_receiving_amount : v15,
        };
        0x2::event::emit<SoTransferCompleted>(v20);
        let v21 = DstAmount{so_fee: v6};
        0x2::event::emit<DstAmount>(v21);
    }

    public entry fun complete_so_swap_for_deepbook_base_asset<T0, T1>(arg0: &mut Storage, arg1: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg2: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &mut WormholeFee, arg4: &mut 0xdee9::clob::Pool<T0, T1>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = complete_transfer<T1>(arg0, arg1, arg2, arg5, arg6, arg7);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::coin::value<T1>(&v3);
        let v5 = get_so_fees(arg3);
        let v6 = (((v4 as u128) * (v5 as u128) / (100000000 as u128)) as u64);
        if (v6 > 0 && v6 <= v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v3, v6, arg7), arg3.beneficiary);
        };
        let v7 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::payload(&v2);
        let (_, _, v10, v11) = decode_wormhole_payload(&v7);
        let v12 = v11;
        let v13 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_receiver(v10);
        let v14 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_address(&v13);
        let v15 = 0x2::coin::value<T1>(&v3);
        if (0x1::vector::length<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&v12) > 0) {
            assert!(0x1::vector::length<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&v12) == 1, 11);
            let (v16, v17, _) = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::swap::swap_for_base_asset_by_deepbook<T0, T1>(arg4, v3, *0x1::vector::borrow<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&v12, 0), arg6, arg7);
            let v19 = v17;
            v15 = 0x2::coin::value<T1>(&v19);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v19, v14);
            process_left_coin<T0>(v16, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, v14);
        };
        let v20 = SoTransferCompleted{
            transaction_id          : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_transaction_id(v10),
            actual_receiving_amount : v15,
        };
        0x2::event::emit<SoTransferCompleted>(v20);
        let v21 = DstAmount{so_fee: v6};
        0x2::event::emit<DstAmount>(v21);
    }

    public entry fun complete_so_swap_for_deepbook_quote_asset<T0, T1>(arg0: &mut Storage, arg1: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg2: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &mut WormholeFee, arg4: &mut 0xdee9::clob::Pool<T0, T1>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = complete_transfer<T0>(arg0, arg1, arg2, arg5, arg6, arg7);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = get_so_fees(arg3);
        let v6 = (((v4 as u128) * (v5 as u128) / (100000000 as u128)) as u64);
        if (v6 > 0 && v6 <= v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v3, v6, arg7), arg3.beneficiary);
        };
        let v7 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::payload(&v2);
        let (_, _, v10, v11) = decode_wormhole_payload(&v7);
        let v12 = v11;
        let v13 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_receiver(v10);
        let v14 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_address(&v13);
        let v15 = 0x2::coin::value<T0>(&v3);
        if (0x1::vector::length<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&v12) > 0) {
            assert!(0x1::vector::length<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&v12) == 1, 11);
            let (v16, v17, _) = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::swap::swap_for_quote_asset_by_deepbook<T0, T1>(arg4, v3, *0x1::vector::borrow<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&v12, 0), arg6, arg7);
            let v19 = v17;
            v15 = 0x2::coin::value<T1>(&v19);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v19, v14);
            process_left_coin<T0>(v16, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v14);
        };
        let v20 = SoTransferCompleted{
            transaction_id          : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_transaction_id(v10),
            actual_receiving_amount : v15,
        };
        0x2::event::emit<SoTransferCompleted>(v20);
        let v21 = DstAmount{so_fee: v6};
        0x2::event::emit<DstAmount>(v21);
    }

    public entry fun complete_so_swap_without_swap<T0>(arg0: &mut Storage, arg1: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg2: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &mut WormholeFee, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = complete_transfer<T0>(arg0, arg1, arg2, arg4, arg5, arg6);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = get_so_fees(arg3);
        let v6 = (((v4 as u128) * (v5 as u128) / (100000000 as u128)) as u64);
        if (v6 > 0 && v6 <= v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v3, v6, arg6), arg3.beneficiary);
        };
        let v7 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::payload(&v2);
        let (_, _, v10, v11) = decode_wormhole_payload(&v7);
        let v12 = v11;
        let v13 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_receiver(v10);
        assert!(0x1::vector::length<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&v12) == 0, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_address(&v13));
        let v14 = SoTransferCompleted{
            transaction_id          : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_transaction_id(v10),
            actual_receiving_amount : 0x2::coin::value<T0>(&v3),
        };
        0x2::event::emit<SoTransferCompleted>(v14);
        let v15 = DstAmount{so_fee: v6};
        0x2::event::emit<DstAmount>(v15);
    }

    fun complete_transfer<T0>(arg0: &mut Storage, arg1: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg2: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::TransferWithPayload) {
        let (v0, v1, _) = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer_with_payload::redeem_coin<T0>(&arg0.emitter_cap, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer_with_payload::authorize_transfer<T0>(arg1, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::vaa::verify_only_once(arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg2, arg3, arg4)), arg5));
        (v0, v1)
    }

    public fun decode_normalized_wormhole_data(arg0: &vector<u8>) : NormalizedWormholeData {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > 0, 3);
        let v1 = 0;
        let v2 = 2;
        let v3 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v1, v1 + v2);
        let v4 = v1 + v2;
        let v5 = 32;
        let v6 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v4, v4 + v5);
        let v7 = v4 + v5;
        let v8 = 32;
        let v9 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v7, v7 + v8);
        let v10 = v7 + v8;
        let v11 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v10, v10 + 8);
        let v12 = 8 + 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::get_vector_length(&mut v11);
        let v13 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v10, v10 + v12);
        assert!(v10 + v12 == v0, 3);
        NormalizedWormholeData{
            dst_wormhole_chain_id                : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_u16(&v3),
            dst_max_gas_price_in_wei_for_relayer : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_u256(&v6),
            wormhole_fee                         : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_u256(&v9),
            dst_so_diamond                       : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_vector_with_length(&v13),
        }
    }

    public fun decode_wormhole_payload(arg0: &vector<u8>) : (u256, u256, 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSoData, vector<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > 0, 3);
        let v1 = 0;
        let v2 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v1, v1 + 1);
        let v3 = (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_u8(&mut v2) as u64);
        let v4 = v1 + 1;
        let v5 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v4, v4 + v3);
        let v6 = v4 + v3;
        let v7 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v6, v6 + 1);
        let v8 = (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_u8(&mut v7) as u64);
        let v9 = v6 + 1;
        let v10 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v9, v9 + v8);
        let v11 = v9 + v8;
        let v12 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v11, v11 + 1);
        let v13 = (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_u8(&mut v12) as u64);
        let v14 = v11 + 1;
        let v15 = v14 + v13;
        let v16 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v15, v15 + 1);
        let v17 = (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_u8(&mut v16) as u64);
        let v18 = v15 + 1;
        let v19 = v18 + v17;
        let v20 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v19, v19 + 1);
        let v21 = (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_u8(&mut v20) as u64);
        let v22 = v19 + 1;
        let v23 = v22 + v21;
        let v24 = v23;
        if (v23 < v0) {
            let v25 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v23, v23 + 1);
            v24 = v23 + 1 + (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_u8(&mut v25) as u64);
        };
        let v26 = 0x1::vector::empty<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>();
        while (v24 < v0) {
            let v27 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v24, v24 + 1);
            let v28 = (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_u8(&mut v27) as u64);
            let v29 = v24 + 1;
            let v30 = v29 + v28;
            let v31 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v30, v30 + 1);
            let v32 = (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_u8(&mut v31) as u64);
            let v33 = v30 + 1;
            let v34 = v33 + v32;
            let v35 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v34, v34 + 1);
            let v36 = (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_u8(&mut v35) as u64);
            let v37 = v34 + 1;
            let v38 = v37 + v36;
            let v39 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v38, v38 + 2);
            let v40 = (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_u16(&mut v39) as u64);
            let v41 = v38 + 2;
            v24 = v41 + v40;
            0x1::vector::push_back<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&mut v26, 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::padding_swap_data(0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v29, v29 + v28), 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v33, v33 + v32), 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v37, v37 + v36), 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v41, v41 + v40)));
        };
        (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_u256_with_hex_str(&v5), 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_u256_with_hex_str(&v10), 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::padding_so_data(0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v14, v14 + v13), 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v18, v18 + v17), 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v22, v22 + v21)), v26)
    }

    public fun encode_normalized_wormhole_data(arg0: NormalizedWormholeData) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_u16(&mut v0, arg0.dst_wormhole_chain_id);
        0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_u256(&mut v0, arg0.dst_max_gas_price_in_wei_for_relayer);
        0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_u256(&mut v0, arg0.wormhole_fee);
        0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_vector_with_length(&mut v0, arg0.dst_so_diamond);
        v0
    }

    public fun encode_wormhole_payload(arg0: u256, arg1: u256, arg2: 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSoData, arg3: vector<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::empty<u8>();
        0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_u256_with_hex_str(&mut v1, arg0);
        0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_u8(&mut v0, (0x1::vector::length<u8>(&v1) as u8));
        0x1::vector::append<u8>(&mut v0, v1);
        let v2 = 0x1::vector::empty<u8>();
        0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_u256_with_hex_str(&mut v2, arg1);
        0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_u8(&mut v0, (0x1::vector::length<u8>(&v2) as u8));
        0x1::vector::append<u8>(&mut v0, v2);
        let v3 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_transaction_id(arg2);
        0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_u8(&mut v0, (0x1::vector::length<u8>(&v3) as u8));
        0x1::vector::append<u8>(&mut v0, v3);
        let v4 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_receiver(arg2);
        0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_u8(&mut v0, (0x1::vector::length<u8>(&v4) as u8));
        0x1::vector::append<u8>(&mut v0, v4);
        let v5 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_receiving_asset_id(arg2);
        0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_u8(&mut v0, (0x1::vector::length<u8>(&v5) as u8));
        0x1::vector::append<u8>(&mut v0, v5);
        let v6 = 0x1::vector::length<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&arg3);
        if (v6 > 0) {
            let v7 = 0x1::vector::empty<u8>();
            0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_u256_with_hex_str(&mut v7, (v6 as u256));
            0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_u8(&mut v0, (0x1::vector::length<u8>(&v7) as u8));
            0x1::vector::append<u8>(&mut v0, v7);
        };
        0x1::vector::reverse<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&mut arg3);
        while (!0x1::vector::is_empty<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&arg3)) {
            let v8 = 0x1::vector::pop_back<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&mut arg3);
            let v9 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::swap_call_to(v8);
            0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_u8(&mut v0, (0x1::vector::length<u8>(&v9) as u8));
            0x1::vector::append<u8>(&mut v0, v9);
            let v10 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::swap_sending_asset_id(v8);
            0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_u8(&mut v0, (0x1::vector::length<u8>(&v10) as u8));
            0x1::vector::append<u8>(&mut v0, v10);
            let v11 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::swap_receiving_asset_id(v8);
            0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_u8(&mut v0, (0x1::vector::length<u8>(&v11) as u8));
            0x1::vector::append<u8>(&mut v0, v11);
            let v12 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::swap_call_data(v8);
            0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_u16(&mut v0, (0x1::vector::length<u8>(&v12) as u16));
            0x1::vector::append<u8>(&mut v0, v12);
        };
        v0
    }

    public fun estimate_complete_soswap_gas(arg0: &mut Storage, arg1: vector<u8>, arg2: NormalizedWormholeData, arg3: vector<u8>) : u256 {
        if (0x2::table::contains<u16, u256>(&arg0.dst_base_gas, arg2.dst_wormhole_chain_id)) {
            *0x2::table::borrow<u16, u256>(&arg0.dst_base_gas, arg2.dst_wormhole_chain_id) + *0x2::table::borrow<u16, u256>(&arg0.dst_gas_per_bytes, arg2.dst_wormhole_chain_id) * ((65 + 0x1::vector::length<u8>(&arg1) + 1 + 0x1::vector::length<u8>(&arg3)) as u256)
        } else {
            0
        }
    }

    public fun estimate_relayer_fee(arg0: &mut Storage, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::so_fee_wormhole::PriceManager, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) : (u64, u64, u256) {
        let v0 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::decode_normalized_so_data(&mut arg3);
        let v1 = decode_normalized_wormhole_data(&arg4);
        let v2 = if (0x1::vector::length<u8>(&arg5) > 0) {
            0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::decode_normalized_swap_data(&mut arg5)
        } else {
            0x1::vector::empty<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>()
        };
        let v3 = arg0.estimate_reserve;
        let v4 = estimate_complete_soswap_gas(arg0, 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::encode_normalized_so_data(v0), v1, 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::encode_normalized_swap_data(v2));
        let v5 = (100000000 as u256);
        let v6 = if (v1.dst_wormhole_chain_id == 22) {
            v1.dst_max_gas_price_in_wei_for_relayer * v4 * (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::so_fee_wormhole::get_price_ratio(arg2, v1.dst_wormhole_chain_id) as u256) / v5 * (v3 as u256) / v5 * 10
        } else {
            v1.dst_max_gas_price_in_wei_for_relayer * v4 * (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::so_fee_wormhole::get_price_ratio(arg2, v1.dst_wormhole_chain_id) as u256) / v5 * (v3 as u256) / v5 / 1000000000
        };
        let v7 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::message_fee(arg1);
        let v8 = v7;
        if (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::swap::right_type<0x2::sui::SUI>(0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_sending_asset_id(v0))) {
            v8 = v7 + (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_amount(v0) as u64);
        };
        let v9 = (v6 as u64);
        (v9, v8 + v9, v4)
    }

    public fun get_dst_gas(arg0: &mut Storage, arg1: u16) : (u256, u256) {
        if (0x2::table::contains<u16, u256>(&arg0.dst_base_gas, arg1)) {
            (*0x2::table::borrow<u16, u256>(&arg0.dst_base_gas, arg1), *0x2::table::borrow<u16, u256>(&arg0.dst_gas_per_bytes, arg1))
        } else {
            (0, 0)
        }
    }

    public fun get_so_fees(arg0: &mut WormholeFee) : u64 {
        arg0.fee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WormholeFacetManager{
            id      : 0x2::object::new(arg0),
            owner   : 0x2::tx_context::sender(arg0),
            relayer : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<WormholeFacetManager>(v0);
    }

    public entry fun init_wormhole(arg0: &mut WormholeFacetManager, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        let v0 = Storage{
            id                    : 0x2::object::new(arg3),
            emitter_cap           : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::new(arg1, arg3),
            src_wormhole_chain_id : arg2,
            actual_reserve        : 0,
            estimate_reserve      : 0,
            dst_base_gas          : 0x2::table::new<u16, u256>(arg3),
            dst_gas_per_bytes     : 0x2::table::new<u16, u256>(arg3),
        };
        0x2::transfer::share_object<Storage>(v0);
        let v1 = WormholeFee{
            id          : 0x2::object::new(arg3),
            fee         : 0,
            beneficiary : 0x2::tx_context::sender(arg3),
        };
        0x2::transfer::share_object<WormholeFee>(v1);
    }

    public fun merge_coin<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) > 0) {
            0x1::vector::reverse<0x2::coin::Coin<T0>>(&mut arg0);
            let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
            while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
                0x2::coin::join<T0>(&mut v1, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0));
            };
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            let v2 = 0x2::coin::value<T0>(&v1);
            let v3 = arg1;
            if (arg1 == 18446744073709551615) {
                v3 = v2;
            };
            assert!(v2 >= v3, 7);
            if (0x2::coin::value<T0>(&v1) > v3) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg2));
                0x2::coin::split<T0>(&mut v1, v3, arg2)
            } else {
                v1
            }
        } else {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            assert!(arg1 == 0, 8);
            0x2::coin::zero<T0>(arg2)
        }
    }

    public fun process_left_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public entry fun set_relayer(arg0: &mut WormholeFacetManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        arg0.relayer = arg1;
    }

    public entry fun set_so_fees(arg0: &mut WormholeFee, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.beneficiary == 0x2::tx_context::sender(arg2), 4);
        arg0.fee = arg1;
    }

    public entry fun set_wormhole_gas(arg0: &mut Storage, arg1: &mut WormholeFacetManager, arg2: u16, arg3: u256, arg4: u256, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg5), 4);
        if (0x2::table::contains<u16, u256>(&arg0.dst_base_gas, arg2)) {
            0x2::table::remove<u16, u256>(&mut arg0.dst_base_gas, arg2);
        };
        if (0x2::table::contains<u16, u256>(&arg0.dst_gas_per_bytes, arg2)) {
            0x2::table::remove<u16, u256>(&mut arg0.dst_gas_per_bytes, arg2);
        };
        0x2::table::add<u16, u256>(&mut arg0.dst_base_gas, arg2, arg3);
        0x2::table::add<u16, u256>(&mut arg0.dst_gas_per_bytes, arg2, arg4);
    }

    public entry fun set_wormhole_reserve(arg0: &mut WormholeFacetManager, arg1: &mut Storage, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 4);
        arg1.actual_reserve = arg2;
        arg1.estimate_reserve = arg3;
    }

    public entry fun so_swap_for_cetus_base_asset<T0, T1>(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg2: &mut Storage, arg3: &0x2::clock::Clock, arg4: &mut 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::so_fee_wormhole::PriceManager, arg5: &mut WormholeFee, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<0x2::coin::Coin<T1>>, arg13: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::decode_normalized_so_data(&mut arg8);
        let v1 = decode_normalized_wormhole_data(&arg10);
        let v2 = if (0x1::vector::length<u8>(&arg11) > 0) {
            0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::decode_normalized_swap_data(&mut arg11)
        } else {
            0x1::vector::empty<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>()
        };
        let (v3, v4, v5, v6) = check_relayer_fee(arg2, arg0, arg4, v0, v1, v2);
        assert!(v3, 6);
        let v7 = merge_coin<0x2::sui::SUI>(arg13, v5, arg14);
        let v8 = 0x2::coin::split<0x2::sui::SUI>(&mut v7, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::message_fee(arg0), arg14);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v7, v4, arg14), arg5.beneficiary);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v7) == 0, 9);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v7);
        let v9 = merge_coin<T1>(arg12, (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_amount(v0) as u64), arg14);
        let v10 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::decode_normalized_swap_data(&mut arg9);
        assert!(0x1::vector::length<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&v10) == 1, 11);
        let (v11, v12, _) = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::swap::swap_for_base_asset_by_cetus<T0, T1>(arg6, arg7, v9, *0x1::vector::borrow<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&v10, 0), arg3, arg14);
        let v14 = v11;
        let (v15, v16) = tranfer_token<T0>(arg0, arg1, arg2, arg3, v14, v1, encode_wormhole_payload(v1.dst_max_gas_price_in_wei_for_relayer, v6, v0, v2), v8);
        let v17 = v16;
        process_left_coin<T1>(v12, 0x2::tx_context::sender(arg14));
        process_left_coin<T0>(v17, 0x2::tx_context::sender(arg14));
        let v18 = SoTransferStarted{transaction_id: 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_transaction_id(v0)};
        0x2::event::emit<SoTransferStarted>(v18);
        let v19 = TransferFromWormholeEvent{
            src_wormhole_chain_id : arg2.src_wormhole_chain_id,
            dst_wormhole_chain_id : v1.dst_wormhole_chain_id,
            sequence              : v15,
        };
        0x2::event::emit<TransferFromWormholeEvent>(v19);
        let v20 = SrcAmount{
            relayer_fee  : v4,
            cross_amount : 0x2::coin::value<T0>(&v14) - 0x2::coin::value<T0>(&v17),
        };
        0x2::event::emit<SrcAmount>(v20);
    }

    public entry fun so_swap_for_cetus_quote_asset<T0, T1>(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg2: &mut Storage, arg3: &0x2::clock::Clock, arg4: &mut 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::so_fee_wormhole::PriceManager, arg5: &mut WormholeFee, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<0x2::coin::Coin<T0>>, arg13: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::decode_normalized_so_data(&mut arg8);
        let v1 = decode_normalized_wormhole_data(&arg10);
        let v2 = if (0x1::vector::length<u8>(&arg11) > 0) {
            0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::decode_normalized_swap_data(&mut arg11)
        } else {
            0x1::vector::empty<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>()
        };
        let (v3, v4, v5, v6) = check_relayer_fee(arg2, arg0, arg4, v0, v1, v2);
        assert!(v3, 6);
        let v7 = merge_coin<0x2::sui::SUI>(arg13, v5, arg14);
        let v8 = 0x2::coin::split<0x2::sui::SUI>(&mut v7, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::message_fee(arg0), arg14);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v7, v4, arg14), arg5.beneficiary);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v7) == 0, 9);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v7);
        let v9 = merge_coin<T0>(arg12, (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_amount(v0) as u64), arg14);
        let v10 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::decode_normalized_swap_data(&mut arg9);
        assert!(0x1::vector::length<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&v10) == 1, 11);
        let (v11, v12, _) = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::swap::swap_for_quote_asset_by_cetus<T0, T1>(arg6, arg7, v9, *0x1::vector::borrow<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&v10, 0), arg3, arg14);
        let v14 = v12;
        let (v15, v16) = tranfer_token<T1>(arg0, arg1, arg2, arg3, v14, v1, encode_wormhole_payload(v1.dst_max_gas_price_in_wei_for_relayer, v6, v0, v2), v8);
        let v17 = v16;
        process_left_coin<T0>(v11, 0x2::tx_context::sender(arg14));
        process_left_coin<T1>(v17, 0x2::tx_context::sender(arg14));
        let v18 = SoTransferStarted{transaction_id: 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_transaction_id(v0)};
        0x2::event::emit<SoTransferStarted>(v18);
        let v19 = TransferFromWormholeEvent{
            src_wormhole_chain_id : arg2.src_wormhole_chain_id,
            dst_wormhole_chain_id : v1.dst_wormhole_chain_id,
            sequence              : v15,
        };
        0x2::event::emit<TransferFromWormholeEvent>(v19);
        let v20 = SrcAmount{
            relayer_fee  : v4,
            cross_amount : 0x2::coin::value<T1>(&v14) - 0x2::coin::value<T1>(&v17),
        };
        0x2::event::emit<SrcAmount>(v20);
    }

    public entry fun so_swap_for_deepbook_base_asset<T0, T1>(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg2: &mut Storage, arg3: &0x2::clock::Clock, arg4: &mut 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::so_fee_wormhole::PriceManager, arg5: &mut WormholeFee, arg6: &mut 0xdee9::clob::Pool<T0, T1>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<0x2::coin::Coin<T1>>, arg12: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::decode_normalized_so_data(&mut arg7);
        let v1 = decode_normalized_wormhole_data(&arg9);
        let v2 = if (0x1::vector::length<u8>(&arg10) > 0) {
            0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::decode_normalized_swap_data(&mut arg10)
        } else {
            0x1::vector::empty<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>()
        };
        let (v3, v4, v5, v6) = check_relayer_fee(arg2, arg0, arg4, v0, v1, v2);
        assert!(v3, 6);
        let v7 = merge_coin<0x2::sui::SUI>(arg12, v5, arg13);
        let v8 = 0x2::coin::split<0x2::sui::SUI>(&mut v7, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::message_fee(arg0), arg13);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v7, v4, arg13), arg5.beneficiary);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v7) == 0, 9);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v7);
        let v9 = merge_coin<T1>(arg11, (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_amount(v0) as u64), arg13);
        let v10 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::decode_normalized_swap_data(&mut arg8);
        assert!(0x1::vector::length<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&v10) == 1, 11);
        let (v11, v12, _) = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::swap::swap_for_base_asset_by_deepbook<T0, T1>(arg6, v9, *0x1::vector::borrow<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&v10, 0), arg3, arg13);
        let v14 = v11;
        let (v15, v16) = tranfer_token<T0>(arg0, arg1, arg2, arg3, v14, v1, encode_wormhole_payload(v1.dst_max_gas_price_in_wei_for_relayer, v6, v0, v2), v8);
        let v17 = v16;
        process_left_coin<T1>(v12, 0x2::tx_context::sender(arg13));
        process_left_coin<T0>(v17, 0x2::tx_context::sender(arg13));
        let v18 = SoTransferStarted{transaction_id: 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_transaction_id(v0)};
        0x2::event::emit<SoTransferStarted>(v18);
        let v19 = TransferFromWormholeEvent{
            src_wormhole_chain_id : arg2.src_wormhole_chain_id,
            dst_wormhole_chain_id : v1.dst_wormhole_chain_id,
            sequence              : v15,
        };
        0x2::event::emit<TransferFromWormholeEvent>(v19);
        let v20 = SrcAmount{
            relayer_fee  : v4,
            cross_amount : 0x2::coin::value<T0>(&v14) - 0x2::coin::value<T0>(&v17),
        };
        0x2::event::emit<SrcAmount>(v20);
    }

    public entry fun so_swap_for_deepbook_quote_asset<T0, T1>(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg2: &mut Storage, arg3: &0x2::clock::Clock, arg4: &mut 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::so_fee_wormhole::PriceManager, arg5: &mut WormholeFee, arg6: &mut 0xdee9::clob::Pool<T0, T1>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<0x2::coin::Coin<T0>>, arg12: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::decode_normalized_so_data(&mut arg7);
        let v1 = decode_normalized_wormhole_data(&arg9);
        let v2 = if (0x1::vector::length<u8>(&arg10) > 0) {
            0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::decode_normalized_swap_data(&mut arg10)
        } else {
            0x1::vector::empty<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>()
        };
        let (v3, v4, v5, v6) = check_relayer_fee(arg2, arg0, arg4, v0, v1, v2);
        assert!(v3, 6);
        let v7 = merge_coin<0x2::sui::SUI>(arg12, v5, arg13);
        let v8 = 0x2::coin::split<0x2::sui::SUI>(&mut v7, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::message_fee(arg0), arg13);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v7, v4, arg13), arg5.beneficiary);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v7) == 0, 9);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v7);
        let v9 = merge_coin<T0>(arg11, (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_amount(v0) as u64), arg13);
        let v10 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::decode_normalized_swap_data(&mut arg8);
        assert!(0x1::vector::length<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&v10) == 1, 11);
        let (v11, v12, _) = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::swap::swap_for_quote_asset_by_deepbook<T0, T1>(arg6, v9, *0x1::vector::borrow<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>(&v10, 0), arg3, arg13);
        let v14 = v12;
        let (v15, v16) = tranfer_token<T1>(arg0, arg1, arg2, arg3, v14, v1, encode_wormhole_payload(v1.dst_max_gas_price_in_wei_for_relayer, v6, v0, v2), v8);
        let v17 = v16;
        process_left_coin<T0>(v11, 0x2::tx_context::sender(arg13));
        process_left_coin<T1>(v17, 0x2::tx_context::sender(arg13));
        let v18 = SoTransferStarted{transaction_id: 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_transaction_id(v0)};
        0x2::event::emit<SoTransferStarted>(v18);
        let v19 = TransferFromWormholeEvent{
            src_wormhole_chain_id : arg2.src_wormhole_chain_id,
            dst_wormhole_chain_id : v1.dst_wormhole_chain_id,
            sequence              : v15,
        };
        0x2::event::emit<TransferFromWormholeEvent>(v19);
        let v20 = SrcAmount{
            relayer_fee  : v4,
            cross_amount : 0x2::coin::value<T1>(&v14) - 0x2::coin::value<T1>(&v17),
        };
        0x2::event::emit<SrcAmount>(v20);
    }

    public entry fun so_swap_without_swap<T0>(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg2: &mut Storage, arg3: &0x2::clock::Clock, arg4: &mut 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::so_fee_wormhole::PriceManager, arg5: &mut WormholeFee, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<0x2::coin::Coin<T0>>, arg11: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg7) == 0, 11);
        let v0 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::decode_normalized_so_data(&mut arg6);
        let v1 = decode_normalized_wormhole_data(&arg8);
        let v2 = if (0x1::vector::length<u8>(&arg9) > 0) {
            0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::decode_normalized_swap_data(&mut arg9)
        } else {
            0x1::vector::empty<0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::NormalizedSwapData>()
        };
        let (v3, v4, v5, v6) = check_relayer_fee(arg2, arg0, arg4, v0, v1, v2);
        assert!(v3, 6);
        let v7 = merge_coin<0x2::sui::SUI>(arg11, v5, arg12);
        let v8 = 0x2::coin::split<0x2::sui::SUI>(&mut v7, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::message_fee(arg0), arg12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v7, v4, arg12), arg5.beneficiary);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v7) == 0, 9);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v7);
        let v9 = merge_coin<T0>(arg10, (0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_amount(v0) as u64), arg12);
        let (v10, v11) = tranfer_token<T0>(arg0, arg1, arg2, arg3, v9, v1, encode_wormhole_payload(v1.dst_max_gas_price_in_wei_for_relayer, v6, v0, v2), v8);
        let v12 = v11;
        process_left_coin<T0>(v12, 0x2::tx_context::sender(arg12));
        let v13 = SoTransferStarted{transaction_id: 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross::so_transaction_id(v0)};
        0x2::event::emit<SoTransferStarted>(v13);
        let v14 = TransferFromWormholeEvent{
            src_wormhole_chain_id : arg2.src_wormhole_chain_id,
            dst_wormhole_chain_id : v1.dst_wormhole_chain_id,
            sequence              : v10,
        };
        0x2::event::emit<TransferFromWormholeEvent>(v14);
        let v15 = SrcAmount{
            relayer_fee  : v4,
            cross_amount : 0x2::coin::value<T0>(&v9) - 0x2::coin::value<T0>(&v12),
        };
        0x2::event::emit<SrcAmount>(v15);
    }

    fun tranfer_token<T0>(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg2: &mut Storage, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: NormalizedWormholeData, arg6: vector<u8>, arg7: 0x2::coin::Coin<0x2::sui::SUI>) : (u64, 0x2::coin::Coin<T0>) {
        let (v0, v1) = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_tokens_with_payload::prepare_transfer<T0>(&arg2.emitter_cap, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::verified_asset<T0>(arg1), arg4, arg5.dst_wormhole_chain_id, arg5.dst_so_diamond, arg6, 0);
        (0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::publish_message(arg0, arg7, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_tokens_with_payload::transfer_tokens_with_payload<T0>(arg1, v0), arg3), v1)
    }

    public entry fun transfer_beneficiary(arg0: &mut WormholeFee, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.beneficiary == 0x2::tx_context::sender(arg2), 4);
        arg0.beneficiary = arg1;
    }

    public entry fun transfer_owner(arg0: &mut WormholeFacetManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        arg0.owner = arg1;
    }

    public fun vector_copy(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

