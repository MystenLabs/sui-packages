module 0xeddb505670e20916e1da4766ebb5a7366761ec82895ac19a48d5d1f2a40ba4c6::suilend_admin_entry {
    public fun init_suilend_obligation<T0, T1, T2>(arg0: &0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::VaultGlobal, arg1: &mut 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_pool::VaultPool<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xeddb505670e20916e1da4766ebb5a7366761ec82895ac19a48d5d1f2a40ba4c6::suilend_entry::authorize(arg0);
        assert!(!0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_pool::has_protocol_cap<T1, T2, 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_pool::SuilendObligationCapKey>(arg1, 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_strategy::PROTOCOL_SUILEND(), 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_pool::suilend_obligation_cap_key()), 1);
        0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_validation::validate_suilend_config<T1, T2>(arg1, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg2), arg3);
        0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_pool::store_protocol_cap<T1, T2, 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_pool::SuilendObligationCapKey, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(arg1, 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_strategy::PROTOCOL_SUILEND(), 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_pool::suilend_obligation_cap_key(), 0xeddb505670e20916e1da4766ebb5a7366761ec82895ac19a48d5d1f2a40ba4c6::suilend_adapter::create_obligation<T0>(arg2, arg4), arg4);
    }

    public fun migrate(arg0: &mut 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::VaultGlobal, arg1: &0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::VaultGlobalAdminCap, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0xeddb505670e20916e1da4766ebb5a7366761ec82895ac19a48d5d1f2a40ba4c6::suilend_entry::migration_witness();
        0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::migrate_ext_version<0xeddb505670e20916e1da4766ebb5a7366761ec82895ac19a48d5d1f2a40ba4c6::suilend_entry::SuilendLegAuth>(arg0, arg1, 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_strategy::PROTOCOL_SUILEND(), 0xeddb505670e20916e1da4766ebb5a7366761ec82895ac19a48d5d1f2a40ba4c6::suilend_entry::package_version(), &v0, arg2);
    }

    public fun register_suilend_leg_auth<T0, T1>(arg0: &0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_admin::VaultGlobal, arg1: &mut 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_pool::VaultPool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0xeddb505670e20916e1da4766ebb5a7366761ec82895ac19a48d5d1f2a40ba4c6::suilend_entry::authorize(arg0);
        0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_pool::register_protocol_leg_auth<T0, T1, 0xeddb505670e20916e1da4766ebb5a7366761ec82895ac19a48d5d1f2a40ba4c6::suilend_entry::SuilendLegAuth>(arg1, 0xa6562b12f932b882b8c73add77ff54881295c053595749ec53694f841dfddcd2::vault_strategy::PROTOCOL_SUILEND(), arg2);
    }

    // decompiled from Move bytecode v7
}

