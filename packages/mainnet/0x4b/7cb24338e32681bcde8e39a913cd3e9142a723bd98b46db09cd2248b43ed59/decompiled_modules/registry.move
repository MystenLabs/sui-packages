module 0x4b7cb24338e32681bcde8e39a913cd3e9142a723bd98b46db09cd2248b43ed59::registry {
    struct WhiteListMintRegistry has key {
        id: 0x2::object::UID,
        version: u8,
        addresses: 0x2::table::Table<address, bool>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct REGISTRY has drop {
        dummy_field: bool,
    }

    public fun add_to_whitelist(arg0: &AdminCap, arg1: &mut WhiteListMintRegistry, arg2: address) {
        validate_whitelist_version(arg1);
        assert!(!0x2::table::contains<address, bool>(&arg1.addresses, arg2), 4);
        0x2::table::add<address, bool>(&mut arg1.addresses, arg2, true);
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<REGISTRY>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = WhiteListMintRegistry{
            id        : 0x2::object::new(arg1),
            version   : 1,
            addresses : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<WhiteListMintRegistry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun is_whitelisted(arg0: &WhiteListMintRegistry, arg1: address) : bool {
        validate_whitelist_version(arg0);
        0x2::table::contains<address, bool>(&arg0.addresses, arg1)
    }

    public fun mint_admin_cap(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg1)}
    }

    public fun remove_from_whitelist(arg0: &AdminCap, arg1: &mut WhiteListMintRegistry, arg2: address) {
        validate_whitelist_version(arg1);
        assert!(0x2::table::contains<address, bool>(&arg1.addresses, arg2), 3);
        0x2::table::remove<address, bool>(&mut arg1.addresses, arg2);
    }

    public fun validate_whitelist_version(arg0: &WhiteListMintRegistry) {
        assert!(arg0.version == 1, 1);
    }

    // decompiled from Move bytecode v6
}

