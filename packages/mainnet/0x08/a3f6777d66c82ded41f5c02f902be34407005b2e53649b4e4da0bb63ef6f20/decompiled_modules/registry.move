module 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::registry {
    struct VaultRegistry has key {
        id: 0x2::object::UID,
        next_vault_id: u64,
        version: u64,
    }

    public fun version(arg0: &VaultRegistry) : u64 {
        arg0.version
    }

    public(friend) fun allocate_vault_id(arg0: &mut VaultRegistry) : u64 {
        let v0 = arg0.next_vault_id;
        arg0.next_vault_id = v0 + 1;
        v0
    }

    public fun assert_version(arg0: &VaultRegistry) {
        assert!(arg0.version == 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::constants::version(), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::errors::vault_wrong_version());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultRegistry{
            id            : 0x2::object::new(arg0),
            next_vault_id : 1,
            version       : 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::constants::version(),
        };
        0x2::transfer::share_object<VaultRegistry>(v0);
    }

    public(friend) fun migrate(arg0: &mut VaultRegistry) {
        assert!(arg0.version < 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::constants::version(), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::errors::vault_already_migrated());
        arg0.version = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::constants::version();
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::events::emit_log_migrate(arg0.version, arg0.version);
    }

    public fun next_vault_id(arg0: &VaultRegistry) : u64 {
        arg0.next_vault_id
    }

    public fun total_vaults(arg0: &VaultRegistry) : u64 {
        arg0.next_vault_id - 1
    }

    public(friend) fun uid_mut(arg0: &mut VaultRegistry) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun vault_address(arg0: &VaultRegistry, arg1: u64) : address {
        0x2::derived_object::derive_address<0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::keys::VaultKey>(0x2::object::uid_to_inner(&arg0.id), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::keys::vault_key(arg1))
    }

    public fun vault_exists(arg0: &VaultRegistry, arg1: u64) : bool {
        0x2::derived_object::exists<0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::keys::VaultKey>(&arg0.id, 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::keys::vault_key(arg1))
    }

    // decompiled from Move bytecode v7
}

