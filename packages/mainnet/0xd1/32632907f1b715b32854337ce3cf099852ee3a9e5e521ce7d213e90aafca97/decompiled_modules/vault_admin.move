module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin {
    struct VaultAdmin has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        created_timestamp: u64,
    }

    public(friend) fun create_vault_admin(arg0: 0x2::object::ID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : VaultAdmin {
        let v0 = VaultAdmin{
            id                : 0x2::object::new(arg2),
            vault_id          : arg0,
            created_timestamp : arg1,
        };
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_create_vault_admin_event(arg0, 0x2::object::id<VaultAdmin>(&v0));
        v0
    }

    public(friend) fun delete_vault_admin(arg0: VaultAdmin) {
        let VaultAdmin {
            id                : v0,
            vault_id          : _,
            created_timestamp : _,
        } = arg0;
        let v3 = v0;
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_delete_vault_admin_event(0x2::object::uid_to_inner(&v3));
        0x2::object::delete(v3);
    }

    public fun get_vault_id_from_admin(arg0: &VaultAdmin) : 0x2::object::ID {
        arg0.vault_id
    }

    public(friend) fun init_vault_admin_display(arg0: 0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : (0x2::package::Publisher, 0x2::display::Display<VaultAdmin>) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

