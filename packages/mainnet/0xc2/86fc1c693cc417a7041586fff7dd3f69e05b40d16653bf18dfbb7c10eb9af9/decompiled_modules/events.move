module 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::events {
    struct VaultStoreAdminUpdateEvent has copy, drop {
        vault_store: 0x2::object::ID,
        admin: address,
    }

    struct VaultBankManagerUpdateEvent has copy, drop {
        vault_store: 0x2::object::ID,
        bank_manager: address,
    }

    struct VaultBankAccountCreationEvent has copy, drop {
        vault_store: 0x2::object::ID,
        bank_account: address,
    }

    struct VaultSubAccountEvent has copy, drop {
        vault_store: 0x2::object::ID,
        vault_bank_account: address,
        sub_account: address,
        status: bool,
    }

    public(friend) fun emit_vault_bank_account_created_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = VaultBankAccountCreationEvent{
            vault_store  : arg0,
            bank_account : arg1,
        };
        0x2::event::emit<VaultBankAccountCreationEvent>(v0);
    }

    public(friend) fun emit_vault_bank_manager_udpdate_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = VaultBankManagerUpdateEvent{
            vault_store  : arg0,
            bank_manager : arg1,
        };
        0x2::event::emit<VaultBankManagerUpdateEvent>(v0);
    }

    public(friend) fun emit_vault_store_admin_udpdate_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = VaultStoreAdminUpdateEvent{
            vault_store : arg0,
            admin       : arg1,
        };
        0x2::event::emit<VaultStoreAdminUpdateEvent>(v0);
    }

    public(friend) fun emit_vault_sub_account_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: bool) {
        let v0 = VaultSubAccountEvent{
            vault_store        : arg0,
            vault_bank_account : arg1,
            sub_account        : arg2,
            status             : arg3,
        };
        0x2::event::emit<VaultSubAccountEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

