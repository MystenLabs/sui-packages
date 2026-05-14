module 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::vault_registry {
    struct VaultEntry has copy, drop, store {
        family_slug: vector<u8>,
        deposit_coin_type: 0x1::ascii::String,
        share_coin_type: 0x1::ascii::String,
        methodology_hash: vector<u8>,
        registered_at_ms: u64,
        paused_at_ms: u64,
    }

    struct VaultRegistry has key {
        id: 0x2::object::UID,
        vaults: 0x2::table::Table<0x2::object::ID, VaultEntry>,
        canonical: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
        total_registered: u64,
    }

    struct VaultRegistered has copy, drop {
        vault_id: 0x2::object::ID,
        family_slug: vector<u8>,
        deposit_coin_type: 0x1::ascii::String,
        share_coin_type: 0x1::ascii::String,
        methodology_hash: vector<u8>,
        registered_at_ms: u64,
    }

    struct VaultUnregistered has copy, drop {
        vault_id: 0x2::object::ID,
        family_slug: vector<u8>,
        unregistered_at_ms: u64,
    }

    struct CanonicalReplaced has copy, drop {
        family_slug: vector<u8>,
        old_vault_id: 0x2::object::ID,
        new_vault_id: 0x2::object::ID,
        replaced_at_ms: u64,
    }

    public fun contains(arg0: &VaultRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, VaultEntry>(&arg0.vaults, arg1)
    }

    public fun canonical(arg0: &VaultRegistry, arg1: vector<u8>) : 0x2::object::ID {
        *0x2::table::borrow<vector<u8>, 0x2::object::ID>(&arg0.canonical, arg1)
    }

    public fun entry_deposit_coin_type(arg0: &VaultEntry) : 0x1::ascii::String {
        arg0.deposit_coin_type
    }

    public fun entry_family_slug(arg0: &VaultEntry) : vector<u8> {
        arg0.family_slug
    }

    public fun entry_methodology_hash(arg0: &VaultEntry) : vector<u8> {
        arg0.methodology_hash
    }

    public fun entry_registered_at_ms(arg0: &VaultEntry) : u64 {
        arg0.registered_at_ms
    }

    public fun entry_share_coin_type(arg0: &VaultEntry) : 0x1::ascii::String {
        arg0.share_coin_type
    }

    public fun get_entry(arg0: &VaultRegistry, arg1: 0x2::object::ID) : &VaultEntry {
        0x2::table::borrow<0x2::object::ID, VaultEntry>(&arg0.vaults, arg1)
    }

    public fun has_canonical(arg0: &VaultRegistry, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.canonical, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultRegistry{
            id               : 0x2::object::new(arg0),
            vaults           : 0x2::table::new<0x2::object::ID, VaultEntry>(arg0),
            canonical        : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg0),
            total_registered : 0,
        };
        0x2::transfer::share_object<VaultRegistry>(v0);
    }

    public fun register(arg0: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin::AdminCap, arg1: &mut VaultRegistry, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: vector<u8>, arg7: &0x2::clock::Clock) {
        assert!(0x1::vector::length<u8>(&arg3) > 0 && 0x1::vector::length<u8>(&arg3) <= 64, 202);
        assert!(0x1::vector::length<u8>(&arg6) == 32, 203);
        assert!(!0x2::table::contains<0x2::object::ID, VaultEntry>(&arg1.vaults, arg2), 200);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = VaultEntry{
            family_slug       : arg3,
            deposit_coin_type : arg4,
            share_coin_type   : arg5,
            methodology_hash  : arg6,
            registered_at_ms  : v0,
            paused_at_ms      : 0,
        };
        0x2::table::add<0x2::object::ID, VaultEntry>(&mut arg1.vaults, arg2, v1);
        if (!0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg1.canonical, arg3)) {
            0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg1.canonical, arg3, arg2);
        };
        arg1.total_registered = arg1.total_registered + 1;
        let v2 = VaultRegistered{
            vault_id          : arg2,
            family_slug       : arg3,
            deposit_coin_type : arg4,
            share_coin_type   : arg5,
            methodology_hash  : arg6,
            registered_at_ms  : v0,
        };
        0x2::event::emit<VaultRegistered>(v2);
    }

    public fun replace_canonical(arg0: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin::AdminCap, arg1: &mut VaultRegistry, arg2: vector<u8>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x2::object::ID, VaultEntry>(&arg1.vaults, arg3), 201);
        assert!(0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg1.canonical, arg2), 201);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg1.canonical, arg2, arg3);
        let v0 = CanonicalReplaced{
            family_slug    : arg2,
            old_vault_id   : 0x2::table::remove<vector<u8>, 0x2::object::ID>(&mut arg1.canonical, arg2),
            new_vault_id   : arg3,
            replaced_at_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CanonicalReplaced>(v0);
    }

    public fun total_registered(arg0: &VaultRegistry) : u64 {
        arg0.total_registered
    }

    public fun unregister(arg0: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin::AdminCap, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin::GuardianCap, arg2: &mut VaultRegistry, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x2::object::ID, VaultEntry>(&arg2.vaults, arg3), 201);
        let v0 = 0x2::table::remove<0x2::object::ID, VaultEntry>(&mut arg2.vaults, arg3);
        let v1 = v0.family_slug;
        if (0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg2.canonical, v1)) {
            if (*0x2::table::borrow<vector<u8>, 0x2::object::ID>(&arg2.canonical, v1) == arg3) {
                0x2::table::remove<vector<u8>, 0x2::object::ID>(&mut arg2.canonical, v1);
            };
        };
        let v2 = VaultUnregistered{
            vault_id           : arg3,
            family_slug        : v1,
            unregistered_at_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<VaultUnregistered>(v2);
    }

    // decompiled from Move bytecode v7
}

