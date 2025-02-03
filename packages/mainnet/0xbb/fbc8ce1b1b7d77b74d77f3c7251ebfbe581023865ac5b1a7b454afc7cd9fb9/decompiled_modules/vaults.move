module 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::vaults {
    struct VaultStore has key {
        id: 0x2::object::UID,
        admin: address,
        vaults_bank_manger: address,
        vaults_bank_accounts: 0x2::vec_set::VecSet<address>,
        version: u64,
    }

    public fun set_vault_sub_account(arg0: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::SubAccountsV2, arg1: &mut VaultStore, arg2: address, arg3: address, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        assert!(arg1.admin == 0x2::tx_context::sender(arg5), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::unauthorized());
        assert!(0x2::vec_set::contains<address>(&arg1.vaults_bank_accounts, &arg2), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::vault_does_not_belong_to_safe());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::set_vault_sub_account(arg0, arg2, arg3, arg4);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::events::emit_vault_sub_account_event(0x2::object::uid_to_inner(&arg1.id), arg2, arg3, arg4);
    }

    public fun create_vault_bank_account<T0>(arg0: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::BankV2<T0>, arg1: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::SubAccountsV2, arg2: &mut VaultStore, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : address {
        assert!(arg2.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        assert!(arg2.admin == 0x2::tx_context::sender(arg4), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::unauthorized());
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x2::object::uid_to_address(&v0);
        0x2::vec_set::insert<address>(&mut arg2.vaults_bank_accounts, v1);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::initialize_account(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::mut_accounts_v2<T0>(arg0), v1);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::set_vault_sub_account(arg1, v1, arg3, true);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::events::emit_vault_bank_account_created_event(0x2::object::uid_to_inner(&v0), v1);
        0x2::object::delete(v0);
        v1
    }

    public fun create_vault_store(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultStore{
            id                   : 0x2::object::new(arg2),
            admin                : arg1,
            vaults_bank_manger   : arg1,
            vaults_bank_accounts : 0x2::vec_set::empty<address>(),
            version              : 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(),
        };
        0x2::transfer::share_object<VaultStore>(v0);
    }

    public fun set_admin(arg0: &mut VaultStore, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::unauthorized());
        arg0.admin = arg1;
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::events::emit_vault_store_admin_udpdate_event(*0x2::object::uid_as_inner(&arg0.id), arg1);
    }

    public fun set_vaults_bank_manger(arg0: &mut VaultStore, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::unauthorized());
        arg0.vaults_bank_manger = arg1;
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::events::emit_vault_bank_manager_udpdate_event(*0x2::object::uid_as_inner(&arg0.id), arg1);
    }

    entry fun update_vault_store_version(arg0: &mut VaultStore, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::unauthorized());
        arg0.version = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version();
    }

    public fun withdraw_coins_from_vault<T0>(arg0: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::BankV2<T0>, arg1: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::Sequencer, arg2: &VaultStore, arg3: vector<u8>, arg4: address, arg5: u128, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        assert!(0x2::vec_set::contains<address>(&arg2.vaults_bank_accounts, &arg4), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::vault_does_not_belong_to_safe());
        assert!(arg2.vaults_bank_manger == 0x2::tx_context::sender(arg6), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::unauthorized());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::withdraw_coins_from_bank_for_vault<T0>(arg0, arg1, arg3, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v6
}

