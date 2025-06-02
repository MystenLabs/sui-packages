module 0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::receipt_adaptor {
    public fun get_receipt_value<T0>(arg0: &0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::vault::Vault<T0>, arg1: &0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::receipt::Receipt, arg2: &0x2::clock::Clock) : u256 {
        0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::vault::assert_vault_receipt_matched<T0>(arg0, arg1);
        let v0 = 0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::vault::vault_receipt_info<T0>(arg0, 0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::receipt::receipt_id(arg1));
        0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::vault_utils::mul_d(0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::vault_receipt_info::shares(v0), 0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::vault::get_share_ratio<T0>(arg0, arg2)) + (0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::vault_receipt_info::pending_deposit_balance(v0) as u256) + (0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::vault_receipt_info::claimable_principal(v0) as u256)
    }

    public fun update_receipt_value<T0, T1>(arg0: &mut 0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::vault::Vault<T0>, arg1: &0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::vault::Vault<T1>, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String) {
        0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::vault::finish_update_asset_value<T0>(arg0, arg3, get_receipt_value<T1>(arg1, 0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::vault::get_defi_asset<T0, 0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::receipt::Receipt>(arg0, arg3), arg2), 0x2::clock::timestamp_ms(arg2));
    }

    // decompiled from Move bytecode v6
}

