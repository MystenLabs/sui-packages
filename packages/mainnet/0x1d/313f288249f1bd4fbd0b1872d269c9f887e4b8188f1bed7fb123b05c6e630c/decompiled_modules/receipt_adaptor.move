module 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::receipt_adaptor {
    public fun get_receipt_value<T0>(arg0: &0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::Vault<T0>, arg1: &0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_oracle::OracleConfig, arg2: &0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::receipt::Receipt, arg3: &0x2::clock::Clock) : u256 {
        0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::assert_vault_receipt_matched<T0>(arg0, arg2);
        let v0 = 0x1::ascii::string(b"get_receipt_value");
        0x1::debug::print<0x1::ascii::String>(&v0);
        let v1 = 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::vault_receipt_info<T0>(arg0, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::receipt::receipt_id(arg2));
        let v2 = 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::shares(v1);
        let v3 = v2;
        if (0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::status(v1) == 3) {
            v3 = v2 - 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::pending_withdraw_shares(v1);
        };
        let v4 = 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_oracle::get_normalized_asset_price(arg1, arg3, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_utils::mul_d(v3, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::get_share_ratio<T0>(arg0, arg3)) + 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_utils::mul_with_oracle_price((0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::pending_deposit_balance(v1) as u256), v4) + 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_utils::mul_with_oracle_price((0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_receipt_info::claimable_principal(v1) as u256), v4)
    }

    public fun update_receipt_value<T0, T1>(arg0: &mut 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::Vault<T0>, arg1: &0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::Vault<T1>, arg2: &0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault_oracle::OracleConfig, arg3: &0x2::clock::Clock, arg4: 0x1::ascii::String) {
        0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::assert_normal<T1>(arg1);
        0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::finish_update_asset_value<T0>(arg0, arg4, get_receipt_value<T1>(arg1, arg2, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::vault::get_defi_asset<T0, 0x491b8fd79bf92ca4a4c2f5836dcf2c1b2140bc070a1e988c4e7316e3444569cd::receipt::Receipt>(arg0, arg4), arg3), 0x2::clock::timestamp_ms(arg3));
    }

    // decompiled from Move bytecode v6
}

