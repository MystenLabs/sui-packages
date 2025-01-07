module 0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::redeem {
    struct SwapExecuted has copy, drop {
        recipient: address,
        relayer: address,
        coin: address,
        coin_amount: u64,
        sui_amount: u64,
    }

    public fun calculate_max_swap_amount_in<T0>(arg0: &0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::state::State, arg1: u8) : u64 {
        let v0 = 9;
        let v1 = if (arg1 > v0) {
            (0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::state::max_native_swap_amount<T0>(arg0) as u256) * (0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::state::native_swap_rate<T0>(arg0) as u256) * (0x2::math::pow(10, arg1 - v0) as u256) / (0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::state::swap_rate_precision(arg0) as u256)
        } else {
            (0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::state::max_native_swap_amount<T0>(arg0) as u256) * (0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::state::native_swap_rate<T0>(arg0) as u256) / (0x2::math::pow(10, v0 - arg1) as u256) * (0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::state::swap_rate_precision(arg0) as u256)
        };
        assert!(v1 <= 18446744073709551614, 4);
        (v1 as u64)
    }

    fun calculate_native_amount_for_recipient<T0>(arg0: &0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::state::State, arg1: &mut u64, arg2: u8) : u64 {
        if (*arg1 > 0) {
            let v1 = calculate_max_swap_amount_in<T0>(arg0, arg2);
            if (*arg1 > v1) {
                *arg1 = v1;
            };
            let v2 = calculate_native_swap_amount_out<T0>(arg0, *arg1, arg2);
            if (v2 == 0) {
                *arg1 = 0;
            };
            v2
        } else {
            0
        }
    }

    public fun calculate_native_swap_amount_out<T0>(arg0: &0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::state::State, arg1: u64, arg2: u8) : u64 {
        let v0 = 9;
        let v1 = if (arg2 > v0) {
            (0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::state::swap_rate_precision(arg0) as u256) * (arg1 as u256) / (0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::state::native_swap_rate<T0>(arg0) as u256) * (0x2::math::pow(10, arg2 - v0) as u256)
        } else {
            (0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::state::swap_rate_precision(arg0) as u256) * (arg1 as u256) * (0x2::math::pow(10, v0 - arg2) as u256) / (0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::state::native_swap_rate<T0>(arg0) as u256)
        };
        assert!(v1 <= 18446744073709551614, 5);
        (v1 as u64)
    }

    public fun complete_transfer<T0>(arg0: &0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::state::State, arg1: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer_with_payload::RedeemerReceipt<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer_with_payload::redeem_coin<T0>(0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::state::emitter_cap(arg0), arg1);
        let v3 = v1;
        verify_transfer<T0>(arg0, v2, &v3);
        let v4 = 0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::message::deserialize(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::payload(&v3));
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::message::recipient(&v4)) == 0x2::tx_context::sender(arg2), 2);
        0x2::pay::keep<T0>(v0, arg2);
    }

    public fun complete_transfer_with_relay<T0>(arg0: &0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::state::State, arg1: &0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg2: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer_with_payload::RedeemerReceipt<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer_with_payload::redeem_coin<T0>(0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::state::emitter_cap(arg0), arg2);
        let v3 = v1;
        verify_transfer<T0>(arg0, v2, &v3);
        let v4 = 0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::message::deserialize(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::take_payload(v3));
        let v5 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::message::recipient(&v4));
        assert!(v5 != 0x2::tx_context::sender(arg4), 2);
        let v6 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::verified_asset<T0>(arg1);
        let v7 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::coin_decimals<T0>(&v6);
        let v8 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::to_raw(0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::message::to_native_token_amount(&v4), v7);
        if (!0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::state::is_swap_enabled<T0>(arg0) || v8 == 0) {
            handle_transfer_without_swap<T0>(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::to_raw(0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::message::target_relayer_fee(&v4), v7), v0, arg3, v5, arg4);
        } else {
            handle_transfer_and_swap<T0>(arg0, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::to_raw(0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::message::target_relayer_fee(&v4), v7), v8, v0, v7, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::token_address<T0>(&v6), arg3, v5, arg4);
        };
    }

    fun handle_transfer_and_swap<T0>(arg0: &0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::state::State, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: u8, arg5: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg2;
        let v1 = calculate_native_amount_for_recipient<T0>(arg0, v0, arg4);
        if (v1 > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= v1, 3);
            0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut arg6, v1, arg7, arg8);
            let v2 = SwapExecuted{
                recipient   : arg7,
                relayer     : 0x2::tx_context::sender(arg8),
                coin        : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(arg5),
                coin_amount : arg2,
                sui_amount  : v1,
            };
            0x2::event::emit<SwapExecuted>(v2);
        };
        0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::coin_utils::return_nonzero<0x2::sui::SUI>(arg6, arg8);
        0x2::pay::split_and_transfer<T0>(&mut arg3, 0x2::coin::value<T0>(&arg3) - arg1 - arg2, arg7, arg8);
        0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::coin_utils::return_nonzero<T0>(arg3, arg8);
    }

    fun handle_transfer_without_swap<T0>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg0 > 0) {
            0x2::pay::split<T0>(&mut arg1, arg0, arg4);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg3);
        0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::coin_utils::return_nonzero<0x2::sui::SUI>(arg2, arg4);
    }

    fun verify_transfer<T0>(arg0: &0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::state::State, arg1: u16, arg2: &0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::TransferWithPayload) {
        assert!(0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::state::is_registered_token<T0>(arg0), 1);
        assert!(0x1bf76666c5e087c5b4b68c7a966e60d22fa3211b27c42c50cf67071930677eb4::state::foreign_contract_address(arg0, arg1) == 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::sender(arg2), 0);
    }

    // decompiled from Move bytecode v6
}

