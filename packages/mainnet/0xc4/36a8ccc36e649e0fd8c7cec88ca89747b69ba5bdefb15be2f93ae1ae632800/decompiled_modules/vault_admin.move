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
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Vault Admin"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://weiss.finance/vault_admin/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://weissfi.s3.eu-west-3.amazonaws.com/sui-vault-512x512.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://weissfi.s3.eu-west-3.amazonaws.com/sui-vault-256x256.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"With Vault Admin, you can update settings, send your vault to another address, or post it to marketplaces directly."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://weiss.finance"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Weiss Finance"));
        let v4 = 0x2::display::new_with_fields<VaultAdmin>(&arg0, v0, v2, arg1);
        0x2::display::update_version<VaultAdmin>(&mut v4);
        (arg0, v4)
    }

    // decompiled from Move bytecode v6
}

