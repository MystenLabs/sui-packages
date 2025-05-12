module 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::operation {
    struct CoinTypeAssetTxExecuted has copy, drop {
        vault_id: address,
        epoch: u64,
        loss: u256,
        epoch_loss: u256,
        coin_type_asset_addr: address,
    }

    struct NaviTxExecuted has copy, drop {
        vault_id: address,
        epoch: u64,
        loss: u256,
        epoch_loss: u256,
        account_cap_addr: address,
    }

    struct CetusTxExecuted has copy, drop {
        vault_id: address,
        epoch: u64,
        loss: u256,
        epoch_loss: u256,
        position_addr: address,
    }

    struct SuilendTxExecuted has copy, drop {
        vault_id: address,
        epoch: u64,
        loss: u256,
        epoch_loss: u256,
        obligation_addr: address,
    }

    struct TxExecuted has copy, drop {
        vault_id: address,
        epoch: u64,
        loss: u256,
        epoch_loss: u256,
        navi_account_cap_addr: address,
        cetus_position_addr: address,
    }

    struct Operation has store, key {
        id: 0x2::object::UID,
        freezed_operator: 0x2::table::Table<address, bool>,
    }

    struct OperationMiddleTxNavi {
        account_cap_id: u8,
        account_cap_addr: address,
        total_usd_value: u256,
        total_shares: u256,
    }

    struct OperationMiddleTxCetus {
        position_id: u8,
        position_addr: address,
        total_usd_value: u256,
        total_shares: u256,
    }

    struct OperationMiddleTxCoinType {
        coin_id: address,
        total_usd_value: u256,
        total_shares: u256,
    }

    struct OperationMiddleTxSuilend {
        obligation_id: u8,
        obligation_addr: address,
        total_usd_value: u256,
        total_shares: u256,
    }

    struct OperationMiddleTx {
        account_cap_id: u8,
        cetus_position_id: u8,
        obligation_id: u8,
        bluefin_position_id: u8,
        momentum_position_id: u8,
        account_cap_addr: address,
        cetus_position_addr: address,
        obligation_addr: address,
        bluefin_position_addr: address,
        momentum_position_addr: address,
        principal_coin_addr: address,
        coin_type_asset_addr: address,
        total_usd_value: u256,
        total_shares: u256,
    }

    public fun add_new_bluefin_position<T0>(arg0: &Operation, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg2: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg3: u8, arg4: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) {
        assert_not_freezed(arg0, arg1);
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::add_new_bluefin_position<T0>(arg2, arg3, arg4);
    }

    public fun add_new_cetus_position<T0>(arg0: &Operation, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg2: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg3: u8, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) {
        assert_not_freezed(arg0, arg1);
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::add_new_cetus_position<T0>(arg2, arg3, arg4);
    }

    public fun add_new_coin_type_asset<T0, T1>(arg0: &Operation, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg2: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>) {
        assert_not_freezed(arg0, arg1);
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::add_new_coin_type_asset<T0, T1>(arg2);
    }

    public fun add_new_momentum_position<T0>(arg0: &Operation, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg2: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg3: u8, arg4: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position) {
        assert_not_freezed(arg0, arg1);
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::add_new_momentum_position<T0>(arg2, arg3, arg4);
    }

    public fun add_new_navi_account_cap<T0>(arg0: &Operation, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg2: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg3: u8, arg4: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) {
        assert_not_freezed(arg0, arg1);
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::add_new_navi_account_cap<T0>(arg2, arg3, arg4);
    }

    public fun add_new_suilend_obligation<T0, T1>(arg0: &Operation, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg2: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg3: u8, arg4: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T1>) {
        assert_not_freezed(arg0, arg1);
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::add_new_suilend_obligation<T0, T1>(arg2, arg3, arg4);
    }

    public fun add_principal<T0>(arg0: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg1: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg2: 0x2::balance::Balance<T0>) {
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::return_free_principal<T0>(arg1, arg2);
    }

    public fun add_reward<T0, T1>(arg0: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg1: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg2: 0x2::balance::Balance<T1>) {
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::add_reward_balance<T0, T1>(arg1, arg2);
    }

    public fun add_reward_with_buffer<T0, T1>(arg0: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg1: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::RewardBuffer, arg4: 0x2::balance::Balance<T1>) {
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::add_reward_with_buffer<T0, T1>(arg1, arg2, arg3, arg4);
    }

    fun assert_not_freezed(arg0: &Operation, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap) {
        assert!(!operator_freezed(arg0, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::operator_id(arg1)), 1021);
    }

    public fun deposit_by_operator<T0>(arg0: &Operation, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg2: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg7: 0x2::coin::Coin<T0>, arg8: bool, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive) {
        assert_not_freezed(arg0, arg1);
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::deposit_by_operator<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun end_op<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: &Operation, arg1: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg2: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg3: &0x2::clock::Clock, arg4: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: OperationMiddleTx, arg7: 0x1::option::Option<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>, arg8: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg9: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T8>>, arg10: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg11: 0x1::option::Option<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>, arg12: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>, arg13: &mut 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T5>>, arg14: &mut 0x1::option::Option<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T6, T7>>, arg15: 0x2::coin::Coin<T0>, arg16: 0x2::coin::Coin<T1>) {
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::set_enabled<T0>(arg1, true);
        assert_not_freezed(arg0, arg2);
        let v0 = if (0x1::option::is_some<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg7)) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(0x1::option::borrow<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg7))
        } else {
            0x2::address::from_u256(0)
        };
        let v1 = if (0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg8)) {
            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg8))
        } else {
            0x2::address::from_u256(0)
        };
        let v2 = if (0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T8>>(&arg9)) {
            0x2::object::id_address<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T8>>(0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T8>>(&arg9))
        } else {
            0x2::address::from_u256(0)
        };
        let v3 = if (0x1::option::is_some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg10)) {
            0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg10))
        } else {
            0x2::address::from_u256(0)
        };
        let v4 = if (0x1::option::is_some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg11)) {
            0x2::object::id_address<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg11))
        } else {
            0x2::address::from_u256(0)
        };
        if (0x1::option::is_some<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg7)) {
            0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::return_navi_account_cap<T0>(arg1, arg6.account_cap_id, 0x1::option::extract<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&mut arg7));
        };
        if (0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg8)) {
            0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::return_cetus_position<T0>(arg1, arg6.cetus_position_id, 0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg8));
        };
        if (0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T8>>(&arg9)) {
            0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::return_suilend_obligation<T0, T8>(arg1, arg6.obligation_id, 0x1::option::extract<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T8>>(&mut arg9));
        };
        if (0x1::option::is_some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg10)) {
            0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::return_bluefin_position<T0>(arg1, arg6.bluefin_position_id, 0x1::option::extract<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg10));
        };
        if (0x1::option::is_some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg11)) {
            0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::return_momentum_position<T0>(arg1, arg6.momentum_position_id, 0x1::option::extract<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg11));
        };
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::return_coin_type_asset<T0, T1>(arg1, 0x2::coin::into_balance<T1>(arg16));
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::return_free_principal<T0>(arg1, 0x2::coin::into_balance<T0>(arg15));
        if (arg6.account_cap_id != 200) {
            0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::update_navi_position_value<T0>(arg1, arg4, arg3, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg6.account_cap_id), arg5);
        };
        if (arg6.cetus_position_id != 200) {
            assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg12), 1022);
            0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::update_cetus_position_value<T0, T2, T3>(arg1, arg4, arg3, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg6.cetus_position_id), 0x1::option::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg12));
        };
        if (arg6.obligation_id != 200) {
            0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::update_suilend_position_value<T0, T8>(arg1, arg3, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T8>>(arg6.obligation_id));
        };
        if (arg6.bluefin_position_id != 200) {
            0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::update_bluefin_position_value<T0, T4, T5>(arg1, arg4, arg3, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg6.bluefin_position_id), 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T5>>(arg13));
        };
        if (arg6.momentum_position_id != 200) {
            0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::update_momentum_position_value<T0, T6, T7>(arg1, arg4, arg3, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg6.momentum_position_id), 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T6, T7>>(arg14));
        };
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::update_coin_type_asset_value<T0, T1>(arg1, arg4, arg3);
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::update_free_principal_value<T0>(arg1, arg4, arg3);
        0x1::option::destroy_none<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg7);
        0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg8);
        0x1::option::destroy_none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T8>>(arg9);
        0x1::option::destroy_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg10);
        0x1::option::destroy_none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg11);
        parse_tx<T0>(arg1, arg4, arg3, arg6, v0, v1, v2, v3, v4);
    }

    public fun end_op_cetus<T0, T1, T2>(arg0: &Operation, arg1: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg2: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg3: &0x2::clock::Clock, arg4: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg5: OperationMiddleTxCetus, arg6: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>) {
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::set_enabled<T0>(arg1, true);
        assert_not_freezed(arg0, arg2);
        let v0 = arg5.position_id;
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::return_cetus_position<T0>(arg1, v0, arg6);
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::update_cetus_position_value<T0, T1, T2>(arg1, arg4, arg3, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0), arg7);
        parse_tx_cetus<T0>(arg1, arg4, arg3, arg5, 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg6));
    }

    public fun end_op_coin_type_asset<T0, T1, T2>(arg0: &Operation, arg1: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg2: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg3: &0x2::clock::Clock, arg4: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg5: 0x2::coin::Coin<T1>, arg6: 0x1::option::Option<0x2::coin::Coin<T2>>, arg7: OperationMiddleTxCoinType) {
        assert_not_freezed(arg0, arg2);
        let OperationMiddleTxCoinType {
            coin_id         : _,
            total_usd_value : v1,
            total_shares    : v2,
        } = arg7;
        assert!(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::total_shares<T0>(arg1) == v2, 1018);
        let v3 = 0x2::coin::into_balance<T1>(arg5);
        if (0x2::balance::value<T1>(&v3) > 0) {
            0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::return_coin_type_asset<T0, T1>(arg1, v3);
        } else {
            0x2::balance::destroy_zero<T1>(v3);
        };
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::update_coin_type_asset_value<T0, T1>(arg1, arg4, arg3);
        if (0x1::option::is_some<0x2::coin::Coin<T2>>(&arg6)) {
            let v4 = 0x2::coin::into_balance<T2>(0x1::option::extract<0x2::coin::Coin<T2>>(&mut arg6));
            if (!0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::contains_asset_type<T0>(arg1, 0x1::type_name::into_string(0x1::type_name::get<T2>()))) {
                0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::add_new_coin_type_asset<T0, T2>(arg1);
            };
            if (0x2::balance::value<T2>(&v4) > 0) {
                0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::return_coin_type_asset<T0, T2>(arg1, v4);
            } else {
                0x2::balance::destroy_zero<T2>(v4);
            };
            0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::update_coin_type_asset_value<T0, T2>(arg1, arg4, arg3);
            0x1::option::destroy_none<0x2::coin::Coin<T2>>(arg6);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T2>>(arg6);
        };
        let v5 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::get_total_usd_value<T0>(arg1, arg4, arg3, false);
        let v6 = 0;
        if (v5 < v1) {
            v6 = v1 - v5;
        };
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::update_tolerance<T0>(arg1, v1, v6);
        let v7 = CoinTypeAssetTxExecuted{
            vault_id             : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::vault_id<T0>(arg1),
            epoch                : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::cur_epoch<T0>(arg1),
            loss                 : v6,
            epoch_loss           : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::cur_epoch_loss<T0>(arg1),
            coin_type_asset_addr : 0x2::object::id_address<0x2::coin::Coin<T1>>(&arg5),
        };
        0x2::event::emit<CoinTypeAssetTxExecuted>(v7);
    }

    public fun end_op_navi<T0>(arg0: &Operation, arg1: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg2: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg3: &0x2::clock::Clock, arg4: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: OperationMiddleTxNavi, arg7: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) {
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::set_enabled<T0>(arg1, true);
        assert_not_freezed(arg0, arg2);
        let v0 = arg6.account_cap_id;
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::return_navi_account_cap<T0>(arg1, v0, arg7);
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::update_navi_position_value<T0>(arg1, arg4, arg3, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::parse_key<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(v0), arg5);
        parse_tx_navi<T0>(arg1, arg4, arg3, arg6, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg7));
    }

    public fun end_op_suilend<T0, T1>(arg0: &Operation, arg1: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg2: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg3: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg4: &0x2::clock::Clock, arg5: OperationMiddleTxSuilend, arg6: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T1>) {
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::set_enabled<T0>(arg1, true);
        assert_not_freezed(arg0, arg2);
        parse_tx_suilend<T0, T1>(arg1, arg3, arg4, arg5, &arg6);
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::return_suilend_obligation<T0, T1>(arg1, arg5.obligation_id, arg6);
    }

    public fun execute_deposit<T0>(arg0: &Operation, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg2: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg7: u64, arg8: address, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) {
        assert_not_freezed(arg0, arg1);
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::execute_deposit<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun execute_withdraw<T0>(arg0: &Operation, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg2: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg3: &0x2::clock::Clock, arg4: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert_not_freezed(arg0, arg1);
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::execute_withdraw<T0>(arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Operation{
            id               : 0x2::object::new(arg0),
            freezed_operator : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<Operation>(v0);
    }

    public(friend) fun operator_freezed(arg0: &Operation, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.freezed_operator, arg1) && *0x2::table::borrow<address, bool>(&arg0.freezed_operator, arg1)
    }

    fun parse_tx<T0>(arg0: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: OperationMiddleTx, arg4: address, arg5: address, arg6: address, arg7: address, arg8: address) {
        let OperationMiddleTx {
            account_cap_id         : v0,
            cetus_position_id      : v1,
            obligation_id          : v2,
            bluefin_position_id    : v3,
            momentum_position_id   : v4,
            account_cap_addr       : v5,
            cetus_position_addr    : v6,
            obligation_addr        : v7,
            bluefin_position_addr  : v8,
            momentum_position_addr : v9,
            principal_coin_addr    : _,
            coin_type_asset_addr   : _,
            total_usd_value        : v12,
            total_shares           : v13,
        } = arg3;
        if (v0 != 200) {
            assert!(v5 == arg4, 1020);
        };
        if (v1 != 200) {
            assert!(v6 == arg5, 1019);
        };
        if (v2 != 200) {
            assert!(v7 == arg6, 1023);
        };
        if (v3 != 200) {
            assert!(v8 == arg7, 1019);
        };
        if (v4 != 200) {
            assert!(v9 == arg8, 1019);
        };
        let v14 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::get_total_usd_value<T0>(arg0, arg1, arg2, false);
        let v15 = 0;
        if (v14 < v12) {
            let v16 = v12 - v14;
            v15 = v16;
            0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::update_tolerance<T0>(arg0, v12, v16);
        };
        assert!(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::total_shares<T0>(arg0) == v13, 1018);
        let v17 = TxExecuted{
            vault_id              : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::vault_id<T0>(arg0),
            epoch                 : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::cur_epoch<T0>(arg0),
            loss                  : v15,
            epoch_loss            : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::cur_epoch_loss<T0>(arg0),
            navi_account_cap_addr : arg4,
            cetus_position_addr   : arg5,
        };
        0x2::event::emit<TxExecuted>(v17);
    }

    fun parse_tx_cetus<T0>(arg0: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: OperationMiddleTxCetus, arg4: address) {
        let OperationMiddleTxCetus {
            position_id     : _,
            position_addr   : v1,
            total_usd_value : v2,
            total_shares    : v3,
        } = arg3;
        let v4 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::get_total_usd_value<T0>(arg0, arg1, arg2, false);
        let v5 = 0;
        if (v4 < v2) {
            let v6 = v2 - v4;
            v5 = v6;
            0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::update_tolerance<T0>(arg0, v2, v6);
        };
        assert!(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::total_shares<T0>(arg0) == v3, 1018);
        assert!(arg4 == v1, 1019);
        let v7 = CetusTxExecuted{
            vault_id      : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::vault_id<T0>(arg0),
            epoch         : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::cur_epoch<T0>(arg0),
            loss          : v5,
            epoch_loss    : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::cur_epoch_loss<T0>(arg0),
            position_addr : v1,
        };
        0x2::event::emit<CetusTxExecuted>(v7);
    }

    fun parse_tx_navi<T0>(arg0: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: OperationMiddleTxNavi, arg4: address) {
        let OperationMiddleTxNavi {
            account_cap_id   : _,
            account_cap_addr : v1,
            total_usd_value  : v2,
            total_shares     : v3,
        } = arg3;
        let v4 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::get_total_usd_value<T0>(arg0, arg1, arg2, false);
        let v5 = 0;
        if (v4 < v2) {
            let v6 = v2 - v4;
            v5 = v6;
            0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::update_tolerance<T0>(arg0, v2, v6);
        };
        assert!(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::total_shares<T0>(arg0) == v3, 1018);
        assert!(v1 == arg4, 1020);
        let v7 = NaviTxExecuted{
            vault_id         : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::vault_id<T0>(arg0),
            epoch            : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::cur_epoch<T0>(arg0),
            loss             : v5,
            epoch_loss       : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::cur_epoch_loss<T0>(arg0),
            account_cap_addr : v1,
        };
        0x2::event::emit<NaviTxExecuted>(v7);
    }

    fun parse_tx_suilend<T0, T1>(arg0: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: OperationMiddleTxSuilend, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T1>) {
        let OperationMiddleTxSuilend {
            obligation_id   : _,
            obligation_addr : v1,
            total_usd_value : v2,
            total_shares    : v3,
        } = arg3;
        let v4 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::get_total_usd_value<T0>(arg0, arg1, arg2, false);
        let v5 = 0;
        if (v4 < v2) {
            let v6 = v2 - v4;
            v5 = v6;
            0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::update_tolerance<T0>(arg0, v2, v6);
        };
        assert!(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::total_shares<T0>(arg0) == v3, 1018);
        assert!(v1 == 0x2::object::id_address<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T1>>(arg4), 1019);
        let v7 = SuilendTxExecuted{
            vault_id        : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::vault_id<T0>(arg0),
            epoch           : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::cur_epoch<T0>(arg0),
            loss            : v5,
            epoch_loss      : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::cur_epoch_loss<T0>(arg0),
            obligation_addr : v1,
        };
        0x2::event::emit<SuilendTxExecuted>(v7);
    }

    public(friend) fun pre_vault_check<T0>(arg0: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg1: &0x2::tx_context::TxContext) {
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::assert_enabled<T0>(arg0);
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::set_enabled<T0>(arg0, false);
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::try_reset_tolerance<T0>(arg0, arg1);
    }

    public fun set_new_asset_type<T0>(arg0: &Operation, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg2: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg3: 0x1::ascii::String) {
        assert_not_freezed(arg0, arg1);
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::set_new_asset_type<T0>(arg2, arg3);
    }

    public(friend) fun set_operator_freezed(arg0: &mut Operation, arg1: address, arg2: bool) {
        if (0x2::table::contains<address, bool>(&arg0.freezed_operator, arg1)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.freezed_operator, arg1) = arg2;
        } else {
            0x2::table::add<address, bool>(&mut arg0.freezed_operator, arg1, arg2);
        };
    }

    public fun set_reward_rate<T0, T1>(arg0: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg1: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::RewardBuffer, arg4: u64) {
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::set_reward_rate<T0, T1>(arg1, arg2, arg3, arg4);
    }

    public fun start_op<T0, T1, T2>(arg0: &Operation, arg1: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg2: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg3: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg4: &0x2::clock::Clock, arg5: u8, arg6: u8, arg7: u8, arg8: u8, arg9: u8, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : (OperationMiddleTx, 0x1::option::Option<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>, 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T2>>, 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, 0x1::option::Option<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_not_freezed(arg0, arg2);
        pre_vault_check<T0>(arg1, arg12);
        let v0 = if (arg5 == 200) {
            0x1::option::none<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>()
        } else {
            0x1::option::some<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::borrow_navi_account_cap<T0>(arg1, arg5))
        };
        let v1 = v0;
        let v2 = if (arg5 == 200) {
            0x2::address::from_u256(0)
        } else {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(0x1::option::borrow<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&v1))
        };
        let v3 = if (arg6 == 200) {
            0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>()
        } else {
            0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::borrow_cetus_position<T0>(arg1, arg6))
        };
        let v4 = v3;
        let v5 = if (arg6 == 200) {
            0x2::address::from_u256(0)
        } else {
            0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v4))
        };
        let v6 = if (arg7 == 200) {
            0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T2>>()
        } else {
            0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T2>>(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::borrow_suilend_obligation<T0, T2>(arg1, arg7))
        };
        let v7 = v6;
        let v8 = if (arg7 == 200) {
            0x2::address::from_u256(0)
        } else {
            0x2::object::id_address<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T2>>(0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T2>>(&v7))
        };
        let v9 = if (arg8 == 200) {
            0x1::option::none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>()
        } else {
            0x1::option::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::borrow_bluefin_position<T0>(arg1, arg8))
        };
        let v10 = v9;
        let v11 = if (arg8 == 200) {
            0x2::address::from_u256(0)
        } else {
            0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v10))
        };
        let v12 = if (arg9 == 200) {
            0x1::option::none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>()
        } else {
            0x1::option::some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::borrow_momentum_position<T0>(arg1, arg9))
        };
        let v13 = v12;
        let v14 = if (arg9 == 200) {
            0x2::address::from_u256(0)
        } else {
            0x2::object::id_address<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&v13))
        };
        let v15 = 0x2::coin::from_balance<T0>(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::borrow_free_principal<T0>(arg1, arg10), arg12);
        let v16 = 0x2::coin::from_balance<T1>(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::borrow_coin_type_asset<T0, T1>(arg1, arg11), arg12);
        let v17 = OperationMiddleTx{
            account_cap_id         : arg5,
            cetus_position_id      : arg6,
            obligation_id          : arg7,
            bluefin_position_id    : arg8,
            momentum_position_id   : arg9,
            account_cap_addr       : v2,
            cetus_position_addr    : v5,
            obligation_addr        : v8,
            bluefin_position_addr  : v11,
            momentum_position_addr : v14,
            principal_coin_addr    : 0x2::object::id_address<0x2::coin::Coin<T0>>(&v15),
            coin_type_asset_addr   : 0x2::object::id_address<0x2::coin::Coin<T1>>(&v16),
            total_usd_value        : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::get_total_usd_value<T0>(arg1, arg3, arg4, true),
            total_shares           : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::total_shares<T0>(arg1),
        };
        (v17, v1, v4, v7, v10, v13, v15, v16)
    }

    public fun start_op_cetus<T0>(arg0: &Operation, arg1: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg2: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg3: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg4: &0x2::clock::Clock, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) : (OperationMiddleTxCetus, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) {
        assert_not_freezed(arg0, arg2);
        pre_vault_check<T0>(arg1, arg6);
        let v0 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::borrow_cetus_position<T0>(arg1, arg5);
        let v1 = OperationMiddleTxCetus{
            position_id     : arg5,
            position_addr   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0),
            total_usd_value : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::get_total_usd_value<T0>(arg1, arg3, arg4, true),
            total_shares    : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::total_shares<T0>(arg1),
        };
        (v1, v0)
    }

    public fun start_op_coin_type_asset<T0, T1>(arg0: &Operation, arg1: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg2: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg3: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (OperationMiddleTxCoinType, 0x2::coin::Coin<T1>) {
        assert_not_freezed(arg0, arg2);
        pre_vault_check<T0>(arg1, arg6);
        let v0 = 0x2::coin::from_balance<T1>(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::borrow_coin_type_asset<T0, T1>(arg1, arg5), arg6);
        let v1 = OperationMiddleTxCoinType{
            coin_id         : 0x2::object::id_address<0x2::coin::Coin<T1>>(&v0),
            total_usd_value : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::get_total_usd_value<T0>(arg1, arg3, arg4, true),
            total_shares    : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::total_shares<T0>(arg1),
        };
        (v1, v0)
    }

    public fun start_op_navi<T0>(arg0: &Operation, arg1: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg2: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg3: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg4: &0x2::clock::Clock, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) : (OperationMiddleTxNavi, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) {
        assert_not_freezed(arg0, arg2);
        pre_vault_check<T0>(arg1, arg6);
        let v0 = OperationMiddleTxNavi{
            account_cap_id   : arg5,
            account_cap_addr : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::get_navi_account_cap<T0>(arg1, arg5)),
            total_usd_value  : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::get_total_usd_value<T0>(arg1, arg3, arg4, true),
            total_shares     : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::total_shares<T0>(arg1),
        };
        (v0, 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::borrow_navi_account_cap<T0>(arg1, arg5))
    }

    public fun start_op_suilend<T0, T1>(arg0: &Operation, arg1: &mut 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::Vault<T0>, arg2: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::OperatorCap, arg3: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg4: &0x2::clock::Clock, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) : (OperationMiddleTxSuilend, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T1>) {
        assert_not_freezed(arg0, arg2);
        pre_vault_check<T0>(arg1, arg6);
        let v0 = 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::borrow_suilend_obligation<T0, T1>(arg1, arg5);
        let v1 = OperationMiddleTxSuilend{
            obligation_id   : arg5,
            obligation_addr : 0x2::object::id_address<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T1>>(&v0),
            total_usd_value : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::get_total_usd_value<T0>(arg1, arg3, arg4, true),
            total_shares    : 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault::total_shares<T0>(arg1),
        };
        (v1, v0)
    }

    // decompiled from Move bytecode v6
}

