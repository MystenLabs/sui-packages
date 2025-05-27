module 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::receipt_adaptor {
    public fun get_receipt_value<T0>(arg0: &0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::Vault<T0>, arg1: &0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::receipt::Receipt, arg2: &0x2::clock::Clock) : u256 {
        0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::assert_vault_receipt_matched<T0>(arg0, arg1);
        let v0 = 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::vault_receipt_info<T0>(arg0, 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::receipt::receipt_id(arg1));
        0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault_utils::mul_d(0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault_receipt_info::shares(v0), 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::get_share_ratio<T0>(arg0, arg2)) + (0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault_receipt_info::pending_deposit_balance(v0) as u256) + (0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault_receipt_info::claimable_principal(v0) as u256)
    }

    public fun update_receipt_value<T0, T1>(arg0: &mut 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::Vault<T0>, arg1: &0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::Vault<T1>, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String) {
        0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::finish_update_asset_value<T0>(arg0, arg3, get_receipt_value<T1>(arg1, 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::get_defi_asset<T0, 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::receipt::Receipt>(arg0, arg3), arg2), 0x2::clock::timestamp_ms(arg2));
    }

    // decompiled from Move bytecode v6
}

