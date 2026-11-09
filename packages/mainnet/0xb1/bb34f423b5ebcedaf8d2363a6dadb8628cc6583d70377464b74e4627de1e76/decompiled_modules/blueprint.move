module 0xb1bb34f423b5ebcedaf8d2363a6dadb8628cc6583d70377464b74e4627de1e76::blueprint {
    struct VersionConfig has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct VersionUpdatedEvent has copy, drop {
        config_id: 0x2::object::ID,
        previous_version: u64,
        new_version: u64,
    }

    struct BlueprintMintEvent has copy, drop {
        id: 0x2::object::ID,
        recipient: address,
    }

    struct BlueprintBurnEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct Blueprint has store, key {
        id: 0x2::object::UID,
    }

    struct BLUEPRINT has drop {
        dummy_field: bool,
    }

    fun assert_version(arg0: &VersionConfig) {
        assert!(arg0.version == 1, 101);
    }

    public fun burn(arg0: &VersionConfig, arg1: Blueprint) {
        assert_version(arg0);
        let v0 = BlueprintBurnEvent{id: 0x2::object::id<Blueprint>(&arg1)};
        0x2::event::emit<BlueprintBurnEvent>(v0);
        let Blueprint { id: v1 } = arg1;
        0x2::object::delete(v1);
    }

    fun init(arg0: BLUEPRINT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<BLUEPRINT>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = VersionConfig{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        0x2::transfer::share_object<VersionConfig>(v0);
    }

    entry fun migrate_version(arg0: &0x2::package::Publisher, arg1: &mut VersionConfig) {
        migrate_version_to(arg0, arg1, 1);
    }

    fun migrate_version_to(arg0: &0x2::package::Publisher, arg1: &mut VersionConfig, arg2: u64) {
        assert!(0x2::package::from_module<BLUEPRINT>(arg0), 100);
        assert!(arg1.version < arg2, 102);
        arg1.version = arg2;
        let v0 = VersionUpdatedEvent{
            config_id        : 0x2::object::id<VersionConfig>(arg1),
            previous_version : arg1.version,
            new_version      : arg2,
        };
        0x2::event::emit<VersionUpdatedEvent>(v0);
    }

    public fun mint(arg0: &VersionConfig, arg1: &0x589e47c212a22d5d468fc42a7a2e19066276898982dab20d3b369382548366d6::admin::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = Blueprint{id: 0x2::object::new(arg3)};
        let v1 = BlueprintMintEvent{
            id        : 0x2::object::id<Blueprint>(&v0),
            recipient : arg2,
        };
        0x2::event::emit<BlueprintMintEvent>(v1);
        0x2::transfer::transfer<Blueprint>(v0, arg2);
    }

    public fun version(arg0: &VersionConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

