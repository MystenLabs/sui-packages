module 0x1c34b5fedff05b46cb8f49fd6313a55ee1fbeb4029ee5a3ce9c6405b90601c4b::router {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PauseConfig has key {
        id: 0x2::object::UID,
        paused: bool,
    }

    struct OrderRecord has copy, drop {
        order_id: u64,
        decimal: u8,
        out_amount: u64,
    }

    struct CommissionRecord has copy, drop {
        commission_amount: u64,
        referal_address: address,
    }

    struct HopRecord has copy, drop {
        out_amount: u64,
    }

    struct ChangeAdminEvent has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct ValidSigner has key {
        id: 0x2::object::UID,
        addresses: vector<vector<u8>>,
    }

    struct SignerChangeEvent has copy, drop {
        addr: vector<u8>,
        action: u8,
    }

    public entry fun add_signer(arg0: &PauseConfig, arg1: &AdminCap, arg2: &mut ValidSigner, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        check_pause(arg0);
        assert!(0x1::vector::length<u8>(&arg3) == 20, 11);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg2.addresses)) {
            assert!(0x1::vector::borrow<vector<u8>>(&arg2.addresses, v0) != &arg3, 12);
            v0 = v0 + 1;
        };
        0x1::vector::push_back<vector<u8>>(&mut arg2.addresses, arg3);
        let v1 = SignerChangeEvent{
            addr   : arg3,
            action : 0,
        };
        0x2::event::emit<SignerChangeEvent>(v1);
    }

    public fun afsui_swap_a2b_with_return(arg0: &PauseConfig, arg1: &mut 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg2: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: address, arg7: &ValidSigner, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, u64) {
        check_pause(arg0);
        let v0 = &mut arg9;
        assert!(verify(arg7, 0x2::tx_context::sender(arg11), arg8, v0, arg10), 13);
        let v1 = 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::request_stake(arg1, arg2, arg3, arg4, arg5, arg6, arg11);
        let v2 = 0x2::coin::value<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(&v1);
        let v3 = HopRecord{out_amount: v2};
        0x2::event::emit<HopRecord>(v3);
        (v1, v2)
    }

    public fun afsui_swap_b2a_with_return(arg0: &PauseConfig, arg1: &mut 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg2: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg3: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: &mut 0xceb3b6f35b71dbd0296cd96f8c00959c230854c7797294148b413094b9621b0e::treasury::Treasury, arg5: 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, arg6: &ValidSigner, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, u64) {
        check_pause(arg0);
        let v0 = &mut arg8;
        assert!(verify(arg6, 0x2::tx_context::sender(arg10), arg7, v0, arg9), 13);
        let v1 = 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::request_unstake_atomic(arg1, arg2, arg3, arg4, arg5, arg10);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        let v3 = HopRecord{out_amount: v2};
        0x2::event::emit<HopRecord>(v3);
        (v1, v2)
    }

    public fun aftermath_swap_exact_in_with_return<T0, T1, T2>(arg0: &PauseConfig, arg1: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u8, arg13: &ValidSigner, arg14: u64, arg15: vector<u8>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, u64) {
        check_pause(arg0);
        let v0 = &mut arg15;
        assert!(verify(arg13, 0x2::tx_context::sender(arg17), arg14, v0, arg16), 13);
        assert!(0x2::coin::value<T1>(&arg7) == arg8, 6);
        let v1 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10, arg17);
        let v2 = 0x2::coin::value<T2>(&v1);
        let v3 = HopRecord{out_amount: v2};
        0x2::event::emit<HopRecord>(v3);
        (v1, v2)
    }

    public fun bluefin_spot_swap_a2b_with_return<T0, T1>(arg0: &PauseConfig, arg1: &0x2::clock::Clock, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: u64, arg10: u8, arg11: &ValidSigner, arg12: u64, arg13: vector<u8>, arg14: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_pause(arg0);
        let v0 = &mut arg13;
        assert!(verify(arg11, 0x2::tx_context::sender(arg14), arg12, v0, arg1), 13);
        let (v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::balance::zero<T1>(), true, arg5, arg6, arg7, arg8);
        let v3 = 0x2::coin::from_balance<T1>(v2, arg14);
        destroy_or_transfer<T0>(0x2::coin::from_balance<T0>(v1, arg14), arg14);
        let v4 = 0x2::coin::value<T1>(&v3);
        let v5 = HopRecord{out_amount: v4};
        0x2::event::emit<HopRecord>(v5);
        (v3, v4)
    }

    public fun bluefin_spot_swap_b2a_with_return<T0, T1>(arg0: &PauseConfig, arg1: &0x2::clock::Clock, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: u64, arg10: u8, arg11: &ValidSigner, arg12: u64, arg13: vector<u8>, arg14: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        check_pause(arg0);
        let v0 = &mut arg13;
        assert!(verify(arg11, 0x2::tx_context::sender(arg14), arg12, v0, arg1), 13);
        let (v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg1, arg2, arg3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg4), false, arg5, arg6, arg7, arg8);
        let v3 = 0x2::coin::from_balance<T0>(v1, arg14);
        destroy_or_transfer<T1>(0x2::coin::from_balance<T1>(v2, arg14), arg14);
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = HopRecord{out_amount: v4};
        0x2::event::emit<HopRecord>(v5);
        (v3, v4)
    }

    public fun bluemove_stable_swap_exact_input_with_return<T0, T1>(arg0: &PauseConfig, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::Dex_Stable_Info, arg5: &0x2::clock::Clock, arg6: u64, arg7: u8, arg8: &ValidSigner, arg9: u64, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_pause(arg0);
        let v0 = &mut arg10;
        assert!(verify(arg8, 0x2::tx_context::sender(arg11), arg9, v0, arg5), 13);
        let v1 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_router::swap_exact_input_<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg11);
        let v2 = 0x2::coin::value<T1>(&v1);
        let v3 = HopRecord{out_amount: v2};
        0x2::event::emit<HopRecord>(v3);
        (v1, v2)
    }

    public fun bluemove_swap_exact_input_with_return<T0, T1>(arg0: &PauseConfig, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg5: u64, arg6: u8, arg7: &ValidSigner, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_pause(arg0);
        let v0 = &mut arg9;
        assert!(verify(arg7, 0x2::tx_context::sender(arg11), arg8, v0, arg10), 13);
        let v1 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(arg1, arg2, arg3, arg4, arg11);
        let v2 = 0x2::coin::value<T1>(&v1);
        let v3 = HopRecord{out_amount: v2};
        0x2::event::emit<HopRecord>(v3);
        (v1, v2)
    }

    public fun cetus_swap_a2b_with_return<T0, T1>(arg0: &PauseConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: vector<0x2::coin::Coin<T0>>, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: u64, arg10: u8, arg11: &ValidSigner, arg12: u64, arg13: vector<u8>, arg14: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_pause(arg0);
        let v0 = &mut arg13;
        assert!(verify(arg11, 0x2::tx_context::sender(arg14), arg12, v0, arg8), 13);
        let (v1, v2) = 0x1c34b5fedff05b46cb8f49fd6313a55ee1fbeb4029ee5a3ce9c6405b90601c4b::cetus_adapter::swapWithReturn<T0, T1>(arg1, arg2, arg3, 0x1::vector::empty<0x2::coin::Coin<T1>>(), true, arg4, arg5, arg6, arg7, arg8, arg14);
        let v3 = v2;
        destroy_or_transfer<T0>(v1, arg14);
        let v4 = 0x2::coin::value<T1>(&v3);
        let v5 = HopRecord{out_amount: v4};
        0x2::event::emit<HopRecord>(v5);
        (v3, v4)
    }

    public fun cetus_swap_b2a_with_return<T0, T1>(arg0: &PauseConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: vector<0x2::coin::Coin<T1>>, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: u64, arg10: u8, arg11: &ValidSigner, arg12: u64, arg13: vector<u8>, arg14: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        check_pause(arg0);
        let v0 = &mut arg13;
        assert!(verify(arg11, 0x2::tx_context::sender(arg14), arg12, v0, arg8), 13);
        let (v1, v2) = 0x1c34b5fedff05b46cb8f49fd6313a55ee1fbeb4029ee5a3ce9c6405b90601c4b::cetus_adapter::swapWithReturn<T0, T1>(arg1, arg2, 0x1::vector::empty<0x2::coin::Coin<T0>>(), arg3, false, arg4, arg5, arg6, arg7, arg8, arg14);
        let v3 = v1;
        destroy_or_transfer<T1>(v2, arg14);
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = HopRecord{out_amount: v4};
        0x2::event::emit<HopRecord>(v5);
        (v3, v4)
    }

    public entry fun change_admin(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 9);
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        let v0 = ChangeAdminEvent{
            old_admin : 0x2::tx_context::sender(arg2),
            new_admin : arg1,
        };
        0x2::event::emit<ChangeAdminEvent>(v0);
    }

    fun check_pause(arg0: &PauseConfig) {
        assert!(!arg0.paused, 8);
    }

    public fun deepbook_swap_base_to_quote_with_return<T0, T1>(arg0: &PauseConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &ValidSigner, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_pause(arg0);
        let v0 = &mut arg7;
        assert!(verify(arg5, 0x2::tx_context::sender(arg8), arg6, v0, arg4), 13);
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, arg2, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg8), arg3, arg4, arg8);
        let v4 = v2;
        destroy_or_transfer<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v3, arg8);
        destroy_or_transfer<T0>(v1, arg8);
        let v5 = 0x2::coin::value<T1>(&v4);
        let v6 = HopRecord{out_amount: v5};
        0x2::event::emit<HopRecord>(v6);
        (v4, v5)
    }

    public fun deepbook_swap_quote_to_base_with_return<T0, T1>(arg0: &PauseConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &ValidSigner, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        check_pause(arg0);
        let v0 = &mut arg7;
        assert!(verify(arg5, 0x2::tx_context::sender(arg8), arg6, v0, arg4), 13);
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, arg2, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg8), arg3, arg4, arg8);
        let v4 = v1;
        destroy_or_transfer<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v3, arg8);
        destroy_or_transfer<T1>(v2, arg8);
        let v5 = 0x2::coin::value<T0>(&v4);
        let v6 = HopRecord{out_amount: v5};
        0x2::event::emit<HopRecord>(v6);
        (v4, v5)
    }

    fun destroy_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun finalize<T0>(arg0: &PauseConfig, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: u8, arg7: &ValidSigner, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        check_pause(arg0);
        let v0 = &mut arg9;
        assert!(verify(arg7, 0x2::tx_context::sender(arg11), arg8, v0, arg10), 13);
        assert!(arg3 == 0 || arg3 > 0 && arg4 != @0x0, 5);
        let v1 = 0x2::coin::value<T0>(&arg1);
        if (v1 < arg2) {
            abort 1
        };
        let v2 = OrderRecord{
            order_id   : arg5,
            decimal    : arg6,
            out_amount : v1,
        };
        0x2::event::emit<OrderRecord>(v2);
        if (arg3 > 0) {
            let v3 = &mut arg1;
            let (v4, _) = split_with_percentage_for_commission<T0>(arg0, v3, arg3, arg4, arg11);
            destroy_or_transfer<T0>(v4, arg11);
            destroy_or_transfer<T0>(arg1, arg11);
        } else {
            destroy_or_transfer<T0>(arg1, arg11);
        };
    }

    public fun flowx_swap_exact_input_direct_with_return<T0, T1>(arg0: &PauseConfig, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: &ValidSigner, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_pause(arg0);
        let v0 = &mut arg5;
        assert!(verify(arg3, 0x2::tx_context::sender(arg7), arg4, v0, arg6), 13);
        let v1 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg1, arg2, arg7);
        let v2 = 0x2::coin::value<T1>(&v1);
        let v3 = HopRecord{out_amount: v2};
        0x2::event::emit<HopRecord>(v3);
        (v1, v2)
    }

    public fun flowxv3_swap_a2b_with_return<T0, T1>(arg0: &PauseConfig, arg1: &0x2::clock::Clock, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: bool, arg7: u128, arg8: u64, arg9: u8, arg10: &ValidSigner, arg11: u64, arg12: vector<u8>, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_pause(arg0);
        let v0 = &mut arg12;
        assert!(verify(arg10, 0x2::tx_context::sender(arg13), arg11, v0, arg1), 13);
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg3, arg4);
        let (v2, v3, v4) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v1, true, arg6, 0x2::coin::value<T0>(&arg5), arg7, arg2, arg1, arg13);
        let v5 = v4;
        let v6 = v3;
        0x2::balance::destroy_zero<T0>(v2);
        let (v7, _) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v5);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(v1, v5, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut arg5), v7), 0x2::balance::zero<T1>(), arg2, arg13);
        let v9 = 0x2::balance::value<T1>(&v6);
        destroy_or_transfer<T0>(arg5, arg13);
        let v10 = HopRecord{out_amount: v9};
        0x2::event::emit<HopRecord>(v10);
        (0x2::coin::from_balance<T1>(v6, arg13), v9)
    }

    public fun flowxv3_swap_b2a_with_return<T0, T1>(arg0: &PauseConfig, arg1: &0x2::clock::Clock, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: bool, arg7: u128, arg8: u64, arg9: u8, arg10: &ValidSigner, arg11: u64, arg12: vector<u8>, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        check_pause(arg0);
        let v0 = &mut arg12;
        assert!(verify(arg10, 0x2::tx_context::sender(arg13), arg11, v0, arg1), 13);
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg3, arg4);
        let (v2, v3, v4) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v1, false, arg6, 0x2::coin::value<T1>(&arg5), arg7, arg2, arg1, arg13);
        let v5 = v4;
        let v6 = v2;
        0x2::balance::destroy_zero<T1>(v3);
        let (_, v8) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v5);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(v1, v5, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(&mut arg5), v8), arg2, arg13);
        let v9 = 0x2::balance::value<T0>(&v6);
        destroy_or_transfer<T1>(arg5, arg13);
        let v10 = HopRecord{out_amount: v9};
        0x2::event::emit<HopRecord>(v10);
        (0x2::coin::from_balance<T0>(v6, arg13), v9)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = PauseConfig{
            id     : 0x2::object::new(arg0),
            paused : false,
        };
        0x2::transfer::share_object<PauseConfig>(v1);
        let v2 = ValidSigner{
            id        : 0x2::object::new(arg0),
            addresses : 0x1::vector::empty<vector<u8>>(),
        };
        0x2::transfer::share_object<ValidSigner>(v2);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun kriya_amm_swap_token_x_with_return<T0, T1>(arg0: &PauseConfig, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: &ValidSigner, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_pause(arg0);
        let v0 = &mut arg9;
        assert!(verify(arg7, 0x2::tx_context::sender(arg11), arg8, v0, arg10), 13);
        let v1 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg1, arg2, arg3, arg4, arg11);
        let v2 = 0x2::coin::value<T1>(&v1);
        let v3 = HopRecord{out_amount: v2};
        0x2::event::emit<HopRecord>(v3);
        (v1, v2)
    }

    public fun kriya_amm_swap_token_y_with_return<T0, T1>(arg0: &PauseConfig, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: &ValidSigner, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        check_pause(arg0);
        let v0 = &mut arg9;
        assert!(verify(arg7, 0x2::tx_context::sender(arg11), arg8, v0, arg10), 13);
        let v1 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg1, arg2, arg3, arg4, arg11);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = HopRecord{out_amount: v2};
        0x2::event::emit<HopRecord>(v3);
        (v1, v2)
    }

    public fun kriya_clmm_swap_token_x_with_return<T0, T1>(arg0: &PauseConfig, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg7: u64, arg8: u8, arg9: &ValidSigner, arg10: u64, arg11: vector<u8>, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_pause(arg0);
        let v0 = &mut arg11;
        assert!(verify(arg9, 0x2::tx_context::sender(arg12), arg10, v0, arg5), 13);
        let (v1, v2, v3) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, true, true, arg3, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::min_sqrt_price(), arg5, arg6, arg12);
        let v4 = v2;
        let v5 = 0x2::balance::value<T1>(&v4);
        assert!(v5 >= arg4, 7);
        0x2::balance::destroy_zero<T0>(v1);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::coin::into_balance<T0>(arg2), 0x2::balance::zero<T1>(), arg6, arg12);
        let v6 = HopRecord{out_amount: v5};
        0x2::event::emit<HopRecord>(v6);
        (0x2::coin::from_balance<T1>(v4, arg12), v5)
    }

    public fun kriya_clmm_swap_token_y_with_return<T0, T1>(arg0: &PauseConfig, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg7: u64, arg8: u8, arg9: &ValidSigner, arg10: u64, arg11: vector<u8>, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        check_pause(arg0);
        let v0 = &mut arg11;
        assert!(verify(arg9, 0x2::tx_context::sender(arg12), arg10, v0, arg5), 13);
        let (v1, v2, v3) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, false, true, arg3, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::max_sqrt_price(), arg5, arg6, arg12);
        let v4 = v1;
        let v5 = 0x2::balance::value<T0>(&v4);
        assert!(v5 >= arg4, 7);
        0x2::balance::destroy_zero<T1>(v2);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg2), arg6, arg12);
        let v6 = HopRecord{out_amount: v5};
        0x2::event::emit<HopRecord>(v6);
        (0x2::coin::from_balance<T0>(v4, arg12), v5)
    }

    public fun movepump_buy_returns<T0>(arg0: &PauseConfig, arg1: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: u64, arg5: &0x2::clock::Clock, arg6: u64, arg7: u8, arg8: &ValidSigner, arg9: u64, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        check_pause(arg0);
        let v0 = &mut arg10;
        assert!(verify(arg8, 0x2::tx_context::sender(arg11), arg9, v0, arg5), 13);
        let (v1, v2) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::buy_returns<T0>(arg1, arg2, arg3, arg4, arg5, arg11);
        let v3 = v2;
        destroy_or_transfer<0x2::sui::SUI>(v1, arg11);
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = HopRecord{out_amount: v4};
        0x2::event::emit<HopRecord>(v5);
        (v3, v4)
    }

    public fun movepump_sell_returns<T0>(arg0: &PauseConfig, arg1: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: u8, arg7: &ValidSigner, arg8: u64, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, u64) {
        check_pause(arg0);
        let v0 = &mut arg9;
        assert!(verify(arg7, 0x2::tx_context::sender(arg10), arg8, v0, arg4), 13);
        let (v1, v2) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::sell_returns<T0>(arg1, arg2, arg3, arg4, arg10);
        let v3 = v1;
        destroy_or_transfer<T0>(v2, arg10);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        let v5 = HopRecord{out_amount: v4};
        0x2::event::emit<HopRecord>(v5);
        (v3, v4)
    }

    public entry fun remove_signer(arg0: &PauseConfig, arg1: &AdminCap, arg2: &mut ValidSigner, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        check_pause(arg0);
        assert!(0x1::vector::length<u8>(&arg3) == 20, 11);
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg2.addresses)) {
            if (!v1 && 0x1::vector::borrow<vector<u8>>(&arg2.addresses, v0) == &arg3) {
                0x1::vector::remove<vector<u8>>(&mut arg2.addresses, v0);
                let v2 = SignerChangeEvent{
                    addr   : arg3,
                    action : 1,
                };
                0x2::event::emit<SignerChangeEvent>(v2);
                v1 = true;
                continue
            };
            v0 = v0 + 1;
        };
    }

    fun reverse_bytes(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::length<u8>(&arg0);
        while (v1 > 0) {
            v1 = v1 - 1;
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, v1));
        };
        v0
    }

    fun split_with_percentage<T0>(arg0: &PauseConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64, 0x2::coin::Coin<T0>, u64) {
        check_pause(arg0);
        assert!(arg2 <= 10000, 2);
        let v0 = 0x2::coin::value<T0>(arg1);
        let v1 = (((v0 as u128) * (arg2 as u128) / (10000 as u128)) as u64);
        (0x2::coin::split<T0>(arg1, v1, arg3), v1, 0x2::coin::split<T0>(arg1, v0 - v1, arg3), v0 - v1)
    }

    fun split_with_percentage_for_commission<T0>(arg0: &PauseConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        check_pause(arg0);
        assert!(arg2 <= 300, 3);
        assert!(arg2 == 0 || arg2 > 0 && arg3 != @0x0, 5);
        let (v0, v1, v2, v3) = split_with_percentage<T0>(arg0, arg1, arg2, arg4);
        if (v1 == 0) {
            0x2::coin::destroy_zero<T0>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg3);
            let v4 = CommissionRecord{
                commission_amount : v1,
                referal_address   : arg3,
            };
            0x2::event::emit<CommissionRecord>(v4);
        };
        (v2, v3)
    }

    fun sub_range(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public fun suiswap_x_2_y_with_return<T0, T1>(arg0: &PauseConfig, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: u64, arg7: u8, arg8: &ValidSigner, arg9: u64, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_pause(arg0);
        let v0 = &mut arg10;
        assert!(verify(arg8, 0x2::tx_context::sender(arg11), arg9, v0, arg5), 13);
        let (v1, v2) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg1, arg2, arg3, arg5, arg11);
        let v3 = v2;
        assert!(0x2::coin::value<T1>(&v3) >= arg4, 4);
        destroy_or_transfer<T0>(v1, arg11);
        let v4 = 0x2::coin::value<T1>(&v3);
        let v5 = HopRecord{out_amount: v4};
        0x2::event::emit<HopRecord>(v5);
        (v3, v4)
    }

    public fun suiswap_y_2_x_with_return<T0, T1>(arg0: &PauseConfig, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: u64, arg7: u8, arg8: &ValidSigner, arg9: u64, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        check_pause(arg0);
        let v0 = &mut arg10;
        assert!(verify(arg8, 0x2::tx_context::sender(arg11), arg9, v0, arg5), 13);
        let (v1, v2) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, T1>(arg1, arg2, arg3, arg5, arg11);
        let v3 = v2;
        assert!(0x2::coin::value<T0>(&v3) >= arg4, 4);
        destroy_or_transfer<T1>(v1, arg11);
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = HopRecord{out_amount: v4};
        0x2::event::emit<HopRecord>(v5);
        (v3, v4)
    }

    public entry fun toggle_pause(arg0: &mut PauseConfig, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.paused = arg2;
    }

    public fun turbos_swap_a_b_with_return<T0, T1, T2>(arg0: &PauseConfig, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u128, arg6: bool, arg7: address, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: u64, arg12: u8, arg13: &ValidSigner, arg14: u64, arg15: vector<u8>, arg16: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        check_pause(arg0);
        let v0 = &mut arg15;
        assert!(verify(arg13, 0x2::tx_context::sender(arg16), arg14, v0, arg9), 13);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg10);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg16);
        let v3 = v1;
        destroy_or_transfer<T0>(v2, arg16);
        let v4 = 0x2::coin::value<T1>(&v3);
        let v5 = HopRecord{out_amount: v4};
        0x2::event::emit<HopRecord>(v5);
        (v3, v4)
    }

    public fun turbos_swap_b_a_with_return<T0, T1, T2>(arg0: &PauseConfig, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: u64, arg5: u128, arg6: bool, arg7: address, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: u64, arg12: u8, arg13: &ValidSigner, arg14: u64, arg15: vector<u8>, arg16: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        check_pause(arg0);
        let v0 = &mut arg15;
        assert!(verify(arg13, 0x2::tx_context::sender(arg16), arg14, v0, arg9), 13);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg10);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg16);
        let v3 = v1;
        destroy_or_transfer<T1>(v2, arg16);
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = HopRecord{out_amount: v4};
        0x2::event::emit<HopRecord>(v5);
        (v3, v4)
    }

    fun u64_to_be_bytes(arg0: u64) : vector<u8> {
        reverse_bytes(0x1::bcs::to_bytes<u64>(&arg0))
    }

    fun verify(arg0: &ValidSigner, arg1: address, arg2: u64, arg3: &mut vector<u8>, arg4: &0x2::clock::Clock) : bool {
        assert!(0x2::clock::timestamp_ms(arg4) < arg2, 10);
        assert!(0x1::vector::length<u8>(arg3) == 65, 14);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, x"c0badfdeb4a0dfe2dc31d578b5df74f7e294f9617bc9d459ca2f9af5c4844251");
        0x1::vector::append<u8>(&mut v0, u64_to_be_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, u64_to_be_bytes(784));
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, x"19457468657265756d205369676e6564204d6573736167653a0a3332");
        0x1::vector::append<u8>(&mut v1, 0x2::hash::keccak256(&v0));
        let v2 = 0x1::vector::borrow_mut<u8>(arg3, 64);
        if (*v2 == 27) {
            *v2 = 0;
        } else {
            assert!(*v2 == 28, 15);
            *v2 = 1;
        };
        let v3 = 0x2::ecdsa_k1::secp256k1_ecrecover(arg3, &v1, 0);
        let v4 = 0x2::ecdsa_k1::decompress_pubkey(&v3);
        let v5 = sub_range(&v4, 1, 65);
        let v6 = 0x2::hash::keccak256(&v5);
        let v7 = sub_range(&v6, 12, 32);
        let v8 = 0;
        while (v8 < 0x1::vector::length<vector<u8>>(&arg0.addresses)) {
            if (&v7 == 0x1::vector::borrow<vector<u8>>(&arg0.addresses, v8)) {
                return true
            };
            v8 = v8 + 1;
        };
        false
    }

    // decompiled from Move bytecode v6
}

