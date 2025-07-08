module 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::receipt_adaptor {
    public fun get_receipt_value<T0>(arg0: &0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::Vault<T0>, arg1: &0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_oracle::OracleConfig, arg2: &0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::receipt::Receipt, arg3: &0x2::clock::Clock) : u256 {
        0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::assert_vault_receipt_matched<T0>(arg0, arg2);
        let v0 = 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::vault_receipt_info<T0>(arg0, 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::receipt::receipt_id(arg2));
        let v1 = 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_receipt_info::shares(v0);
        let v2 = v1;
        if (0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_receipt_info::status(v0) == 3) {
            v2 = v1 - 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_receipt_info::pending_withdraw_shares(v0);
        };
        let v3 = 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_oracle::get_normalized_asset_price(arg1, arg3, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_utils::mul_d(v2, 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::get_share_ratio<T0>(arg0, arg3)) + 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_utils::mul_with_oracle_price((0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_receipt_info::pending_deposit_balance(v0) as u256), v3) + 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_utils::mul_with_oracle_price((0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_receipt_info::claimable_principal(v0) as u256), v3)
    }

    public fun update_receipt_value<T0, T1>(arg0: &mut 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::Vault<T0>, arg1: &0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::Vault<T1>, arg2: &0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_oracle::OracleConfig, arg3: &0x2::clock::Clock, arg4: 0x1::ascii::String) {
        0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::assert_normal<T1>(arg1);
        0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::finish_update_asset_value<T0>(arg0, arg4, get_receipt_value<T1>(arg1, arg2, 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault::get_defi_asset<T0, 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::receipt::Receipt>(arg0, arg4), arg3), 0x2::clock::timestamp_ms(arg3));
    }

    // decompiled from Move bytecode v6
}

