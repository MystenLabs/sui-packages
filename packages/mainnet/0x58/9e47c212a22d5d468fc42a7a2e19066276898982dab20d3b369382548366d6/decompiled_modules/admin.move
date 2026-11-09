module 0x589e47c212a22d5d468fc42a7a2e19066276898982dab20d3b369382548366d6::admin {
    struct ADMIN has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct VersionConfig has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct VersionUpdatedEvent has copy, drop {
        config_id: 0x2::object::ID,
        previous_version: u64,
        new_version: u64,
    }

    struct AdminCapMintEvent has copy, drop {
        id: 0x2::object::ID,
        recipient: address,
    }

    fun assert_version(arg0: &VersionConfig) {
        assert!(arg0.version == 1, 2);
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ADMIN>(arg0, arg1);
        let v0 = VersionConfig{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        0x2::transfer::share_object<VersionConfig>(v0);
        let v1 = 0;
        while (v1 < 10) {
            let v2 = 0x2::tx_context::sender(arg1);
            mint_admin_inner(v2, arg1);
            v1 = v1 + 1;
        };
    }

    entry fun migrate_version(arg0: &0x2::package::Publisher, arg1: &mut VersionConfig) {
        migrate_version_to(arg0, arg1, 1);
    }

    fun migrate_version_to(arg0: &0x2::package::Publisher, arg1: &mut VersionConfig, arg2: u64) {
        assert!(0x2::package::from_module<ADMIN>(arg0), 1);
        assert!(arg1.version < arg2, 3);
        arg1.version = arg2;
        let v0 = VersionUpdatedEvent{
            config_id        : 0x2::object::id<VersionConfig>(arg1),
            previous_version : arg1.version,
            new_version      : arg2,
        };
        0x2::event::emit<VersionUpdatedEvent>(v0);
    }

    public fun mint_admin(arg0: &0x2::package::Publisher, arg1: &VersionConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(0x2::package::from_module<ADMIN>(arg0), 1);
        mint_admin_inner(arg2, arg3);
    }

    fun mint_admin_inner(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = AdminCapMintEvent{
            id        : 0x2::object::id<AdminCap>(&v0),
            recipient : arg0,
        };
        0x2::event::emit<AdminCapMintEvent>(v1);
        0x2::transfer::transfer<AdminCap>(v0, arg0);
    }

    public fun version(arg0: &VersionConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

