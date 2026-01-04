module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_store {
    struct VaultStore<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        vault_registry_id: 0x2::object::ID,
        vaults: 0x2::object_table::ObjectTable<0x2::object::ID, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::Vault<T0>>,
        active_vaults: u64,
        vault_ids: 0x2::table::Table<u64, 0x2::object::ID>,
        vault_counter: u64,
    }

    public fun assert_vault_registry_id<T0>(arg0: &VaultStore<T0>, arg1: 0x2::object::ID) {
        assert!(arg0.vault_registry_id == arg1, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EVaultRegistryIdMismatch());
    }

    public fun assert_version<T0>(arg0: &VaultStore<T0>) {
        assert!(arg0.version == 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion());
    }

    public(friend) fun create_new_vault<T0>(arg0: 0x2::object::ID, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u256, arg6: u256, arg7: u256, arg8: &mut VaultStore<T0>, arg9: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin) {
        let (v0, v1) = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::create_vault<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg0, arg9);
        let v2 = v0;
        let v3 = 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::Vault<T0>>(&v2);
        0x2::object_table::add<0x2::object::ID, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::Vault<T0>>(&mut arg8.vaults, v3, v2);
        arg8.active_vaults = arg8.active_vaults + 1;
        0x2::table::add<u64, 0x2::object::ID>(&mut arg8.vault_ids, arg8.vault_counter, v3);
        arg8.vault_counter = arg8.vault_counter + 1;
        (v3, v1)
    }

    public(friend) fun create_vault_store<T0>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultStore<T0>{
            id                : 0x2::object::new(arg1),
            version           : 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(),
            vault_registry_id : arg0,
            vaults            : 0x2::object_table::new<0x2::object::ID, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::Vault<T0>>(arg1),
            active_vaults     : 0,
            vault_ids         : 0x2::table::new<u64, 0x2::object::ID>(arg1),
            vault_counter     : 0,
        };
        0x2::transfer::share_object<VaultStore<T0>>(v0);
    }

    public(friend) fun delete_vault<T0>(arg0: 0x2::object::ID, arg1: &mut VaultStore<T0>) : 0x2::balance::Balance<T0> {
        arg1.active_vaults = arg1.active_vaults - 1;
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::delete_vault_and_return_collateral<T0>(0x2::object_table::remove<0x2::object::ID, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::Vault<T0>>(&mut arg1.vaults, arg0))
    }

    public(friend) fun get_vault<T0>(arg0: &mut VaultStore<T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::Vault<T0> {
        if (!0x2::object_table::contains<0x2::object::ID, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::Vault<T0>>(&arg0.vaults, arg1)) {
            abort 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EVaultNotFoundInStore()
        };
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::Vault<T0>>(&mut arg0.vaults, arg1);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault::assert_vault_registry_id<T0>(v0, arg2);
        v0
    }

    public fun get_vault_active_counter<T0>(arg0: &VaultStore<T0>) : u64 {
        arg0.active_vaults
    }

    public fun get_vault_counter<T0>(arg0: &VaultStore<T0>) : u64 {
        arg0.vault_counter
    }

    entry fun migrate<T0>(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut VaultStore<T0>) {
        assert!(arg1.version < 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ENotUpgrade());
        arg1.version = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION();
    }

    // decompiled from Move bytecode v6
}

