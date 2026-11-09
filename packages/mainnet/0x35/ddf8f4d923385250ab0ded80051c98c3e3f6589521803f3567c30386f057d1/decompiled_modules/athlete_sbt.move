module 0x35ddf8f4d923385250ab0ded80051c98c3e3f6589521803f3567c30386f057d1::athlete_sbt {
    struct MigrationSnapshot has key {
        id: 0x2::object::UID,
        root: 0x1::option::Option<vector<u8>>,
        cutoff_checkpoint: u64,
        leaf_count: u64,
        ids_sha3_256: vector<u8>,
        paused: bool,
    }

    struct SnapshotFinalizedEvent has copy, drop {
        snapshot_id: 0x2::object::ID,
        root: vector<u8>,
        cutoff_checkpoint: u64,
        leaf_count: u64,
        ids_sha3_256: vector<u8>,
    }

    struct MigrationPauseChangedEvent has copy, drop {
        snapshot_id: 0x2::object::ID,
        paused: bool,
    }

    struct LegacyMigratedEvent has copy, drop {
        legacy_id: 0x2::object::ID,
        new_id: 0x2::object::ID,
        snapshot_id: 0x2::object::ID,
        recipient: address,
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

    struct ATHLETE_SBT has drop {
        dummy_field: bool,
    }

    struct AthleteSbtMintEvent has copy, drop {
        id: 0x2::object::ID,
        identifier: u64,
        name: 0x1::string::String,
        country: 0x1::string::String,
        image_url: 0x1::string::String,
        recipient: address,
    }

    struct UpdateCapMintEvent has copy, drop {
        id: 0x2::object::ID,
        athlete_identifier: u64,
        image_url: 0x1::string::String,
        recipient: address,
    }

    struct AthleteSbtBurnEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct AthleteSbtUpdateEvent has copy, drop {
        athlete_sbt_id: 0x2::object::ID,
        update_cap_id: 0x2::object::ID,
        identifier: u64,
        image_url: 0x1::string::String,
    }

    struct AthleteSbt has key {
        id: 0x2::object::UID,
        identifier: u64,
        name: 0x1::string::String,
        country: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct UpdateCap has key {
        id: 0x2::object::UID,
        athlete_identifier: u64,
        image_url: 0x1::string::String,
    }

    fun assert_version(arg0: &VersionConfig) {
        assert!(arg0.version == 1, 101);
    }

    public fun burn_athlete_sbt(arg0: &VersionConfig, arg1: AthleteSbt) {
        assert_version(arg0);
        let v0 = AthleteSbtBurnEvent{id: 0x2::object::id<AthleteSbt>(&arg1)};
        0x2::event::emit<AthleteSbtBurnEvent>(v0);
        let AthleteSbt {
            id         : v1,
            identifier : _,
            name       : _,
            country    : _,
            image_url  : _,
        } = arg1;
        0x2::object::delete(v1);
    }

    public fun cutoff_checkpoint(arg0: &MigrationSnapshot) : u64 {
        arg0.cutoff_checkpoint
    }

    public fun finalize_migration_snapshot(arg0: &VersionConfig, arg1: &0x2::package::Publisher, arg2: &mut MigrationSnapshot, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: 0x2::object::ID, arg8: vector<vector<u8>>) {
        assert_version(arg0);
        assert!(0x2::package::from_module<ATHLETE_SBT>(arg1), 100);
        assert!(0x1::option::is_none<vector<u8>>(&arg2.root), 110);
        assert!(0x1::vector::length<u8>(&arg3) == 32 && arg4 > 0, 112);
        assert!(arg5 > 0 && arg5 <= 4294967296, 112);
        assert!(0x1::vector::length<u8>(&arg6) == 32, 112);
        0x589e47c212a22d5d468fc42a7a2e19066276898982dab20d3b369382548366d6::merkle::verify(&arg3, 0x2::object::id<MigrationSnapshot>(arg2), arg4, arg7, arg8);
        0x1::option::fill<vector<u8>>(&mut arg2.root, arg3);
        arg2.cutoff_checkpoint = arg4;
        arg2.leaf_count = arg5;
        arg2.ids_sha3_256 = arg6;
        let v0 = SnapshotFinalizedEvent{
            snapshot_id       : 0x2::object::id<MigrationSnapshot>(arg2),
            root              : arg3,
            cutoff_checkpoint : arg4,
            leaf_count        : arg5,
            ids_sha3_256      : arg6,
        };
        0x2::event::emit<SnapshotFinalizedEvent>(v0);
    }

    public fun get_country(arg0: &AthleteSbt) : 0x1::string::String {
        arg0.country
    }

    public fun get_identifier(arg0: &AthleteSbt) : u64 {
        arg0.identifier
    }

    public fun get_image_url(arg0: &AthleteSbt) : 0x1::string::String {
        arg0.image_url
    }

    public fun get_name(arg0: &AthleteSbt) : 0x1::string::String {
        arg0.name
    }

    public fun ids_sha3_256(arg0: &MigrationSnapshot) : &vector<u8> {
        &arg0.ids_sha3_256
    }

    fun init(arg0: ATHLETE_SBT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ATHLETE_SBT>(arg0, arg1);
        let v0 = VersionConfig{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        0x2::transfer::share_object<VersionConfig>(v0);
        let v1 = MigrationSnapshot{
            id                : 0x2::object::new(arg1),
            root              : 0x1::option::none<vector<u8>>(),
            cutoff_checkpoint : 0,
            leaf_count        : 0,
            ids_sha3_256      : b"",
            paused            : false,
        };
        0x2::transfer::share_object<MigrationSnapshot>(v1);
    }

    public fun leaf_count(arg0: &MigrationSnapshot) : u64 {
        arg0.leaf_count
    }

    public fun migrate_legacy_sbt(arg0: &VersionConfig, arg1: &MigrationSnapshot, arg2: 0x856629aad57fac9490511f229a25e5c6b9f6ae49b76bf45582b165b271f7f514::athlete_sbt::AthleteSbt, arg3: vector<vector<u8>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::object::id<0x856629aad57fac9490511f229a25e5c6b9f6ae49b76bf45582b165b271f7f514::athlete_sbt::AthleteSbt>(&arg2);
        verify_legacy_id(arg1, v0, arg3);
        0x856629aad57fac9490511f229a25e5c6b9f6ae49b76bf45582b165b271f7f514::athlete_sbt::burn_athlete_sbt(arg2);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = mint_inner(v1, 0x856629aad57fac9490511f229a25e5c6b9f6ae49b76bf45582b165b271f7f514::athlete_sbt::get_name(&arg2), 0x856629aad57fac9490511f229a25e5c6b9f6ae49b76bf45582b165b271f7f514::athlete_sbt::get_country(&arg2), 0x856629aad57fac9490511f229a25e5c6b9f6ae49b76bf45582b165b271f7f514::athlete_sbt::get_image_url(&arg2), 0x856629aad57fac9490511f229a25e5c6b9f6ae49b76bf45582b165b271f7f514::athlete_sbt::get_identifier(&arg2), arg4);
        let v3 = LegacyMigratedEvent{
            legacy_id   : v0,
            new_id      : v2,
            snapshot_id : 0x2::object::id<MigrationSnapshot>(arg1),
            recipient   : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<LegacyMigratedEvent>(v3);
    }

    entry fun migrate_version(arg0: &0x2::package::Publisher, arg1: &mut VersionConfig) {
        migrate_version_to(arg0, arg1, 1);
    }

    fun migrate_version_to(arg0: &0x2::package::Publisher, arg1: &mut VersionConfig, arg2: u64) {
        assert!(0x2::package::from_module<ATHLETE_SBT>(arg0), 100);
        assert!(arg1.version < arg2, 102);
        arg1.version = arg2;
        let v0 = VersionUpdatedEvent{
            config_id        : 0x2::object::id<VersionConfig>(arg1),
            previous_version : arg1.version,
            new_version      : arg2,
        };
        0x2::event::emit<VersionUpdatedEvent>(v0);
    }

    public fun migration_paused(arg0: &MigrationSnapshot) : bool {
        arg0.paused
    }

    public fun mint_athlete_sbt(arg0: &VersionConfig, arg1: &0x589e47c212a22d5d468fc42a7a2e19066276898982dab20d3b369382548366d6::admin::AdminCap, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        mint_inner(arg2, 0x1::string::utf8(arg3), 0x1::string::utf8(arg4), 0x1::string::utf8(arg5), arg6, arg7);
    }

    fun mint_inner(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = AthleteSbt{
            id         : 0x2::object::new(arg5),
            identifier : arg4,
            name       : arg1,
            country    : arg2,
            image_url  : arg3,
        };
        let v1 = AthleteSbtMintEvent{
            id         : 0x2::object::id<AthleteSbt>(&v0),
            identifier : v0.identifier,
            name       : v0.name,
            country    : v0.country,
            image_url  : v0.image_url,
            recipient  : arg0,
        };
        0x2::event::emit<AthleteSbtMintEvent>(v1);
        0x2::transfer::transfer<AthleteSbt>(v0, arg0);
        0x2::object::id<AthleteSbt>(&v0)
    }

    public fun mint_update_cap(arg0: &VersionConfig, arg1: &0x589e47c212a22d5d468fc42a7a2e19066276898982dab20d3b369382548366d6::admin::AdminCap, arg2: address, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = UpdateCap{
            id                 : 0x2::object::new(arg5),
            athlete_identifier : arg3,
            image_url          : 0x1::string::utf8(arg4),
        };
        let v1 = UpdateCapMintEvent{
            id                 : 0x2::object::id<UpdateCap>(&v0),
            athlete_identifier : v0.athlete_identifier,
            image_url          : v0.image_url,
            recipient          : arg2,
        };
        0x2::event::emit<UpdateCapMintEvent>(v1);
        0x2::transfer::transfer<UpdateCap>(v0, arg2);
    }

    public fun set_migration_paused(arg0: &VersionConfig, arg1: &0x2::package::Publisher, arg2: &mut MigrationSnapshot, arg3: bool) {
        assert_version(arg0);
        assert!(0x2::package::from_module<ATHLETE_SBT>(arg1), 100);
        if (arg2.paused == arg3) {
            return
        };
        arg2.paused = arg3;
        let v0 = MigrationPauseChangedEvent{
            snapshot_id : 0x2::object::id<MigrationSnapshot>(arg2),
            paused      : arg3,
        };
        0x2::event::emit<MigrationPauseChangedEvent>(v0);
    }

    public fun snapshot_root(arg0: &MigrationSnapshot) : &0x1::option::Option<vector<u8>> {
        &arg0.root
    }

    public fun update_athlete_sbt(arg0: &VersionConfig, arg1: UpdateCap, arg2: &mut AthleteSbt) {
        assert_version(arg0);
        assert!(arg1.athlete_identifier == arg2.identifier, 1);
        arg2.image_url = arg1.image_url;
        let v0 = AthleteSbtUpdateEvent{
            athlete_sbt_id : 0x2::object::id<AthleteSbt>(arg2),
            update_cap_id  : 0x2::object::id<UpdateCap>(&arg1),
            identifier     : arg2.identifier,
            image_url      : arg2.image_url,
        };
        0x2::event::emit<AthleteSbtUpdateEvent>(v0);
        let UpdateCap {
            id                 : v1,
            athlete_identifier : _,
            image_url          : _,
        } = arg1;
        0x2::object::delete(v1);
    }

    fun verify_legacy_id(arg0: &MigrationSnapshot, arg1: 0x2::object::ID, arg2: vector<vector<u8>>) {
        assert!(0x1::option::is_some<vector<u8>>(&arg0.root), 111);
        assert!(!arg0.paused, 113);
        0x589e47c212a22d5d468fc42a7a2e19066276898982dab20d3b369382548366d6::merkle::verify(0x1::option::borrow<vector<u8>>(&arg0.root), 0x2::object::id<MigrationSnapshot>(arg0), arg0.cutoff_checkpoint, arg1, arg2);
    }

    public fun version(arg0: &VersionConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

