module 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata {
    struct AssetBinding has copy, drop, store {
        asset_name: 0x1::string::String,
        version_index: u64,
        download_policy: u8,
    }

    struct SoulMetadata has key {
        id: 0x2::object::UID,
        soul_id: 0x2::object::ID,
        active_sprite: 0x1::option::Option<AssetBinding>,
        active_voice: 0x1::option::Option<AssetBinding>,
        ext: 0x2::table::Table<0x1::string::String, vector<u8>>,
    }

    struct SoulMetadataCreated has copy, drop {
        metadata_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
    }

    struct SoulMetadataSpriteUpdated has copy, drop {
        metadata_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        updater: address,
        active_sprite: 0x1::option::Option<AssetBinding>,
    }

    struct SoulMetadataVoiceUpdated has copy, drop {
        metadata_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        updater: address,
        active_voice: 0x1::option::Option<AssetBinding>,
    }

    struct SoulMetadataBlobUpserted has copy, drop {
        metadata_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        updater: address,
        key: 0x1::string::String,
    }

    struct SoulMetadataBlobDeleted has copy, drop {
        metadata_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        updater: address,
        key: 0x1::string::String,
    }

    public fun active_sprite(arg0: &SoulMetadata) : &0x1::option::Option<AssetBinding> {
        &arg0.active_sprite
    }

    public fun active_voice(arg0: &SoulMetadata) : &0x1::option::Option<AssetBinding> {
        &arg0.active_voice
    }

    public fun assert_asset_version_not_active(arg0: &SoulMetadata, arg1: 0x1::string::String, arg2: u64) {
        assert!(!is_asset_version_active(arg0, arg1, arg2), 3);
    }

    public(friend) fun assert_matches_state(arg0: &SoulMetadata, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState) {
        assert!(arg0.soul_id == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg1), 0);
        let v0 = 0x2::object::id<SoulMetadata>(arg0);
        assert!(0x1::option::contains<0x2::object::ID>(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::metadata_id(arg1), &v0), 0);
    }

    fun assert_valid_download_policy(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 4);
    }

    public fun asset_name(arg0: &AssetBinding) : &0x1::string::String {
        &arg0.asset_name
    }

    public fun clear_active_sprite(arg0: &mut SoulMetadata, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: &0x2::tx_context::TxContext) {
        set_active_sprite(arg0, arg1, 0x1::option::none<AssetBinding>(), arg2);
    }

    public fun clear_active_voice(arg0: &mut SoulMetadata, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: &0x2::tx_context::TxContext) {
        set_active_voice(arg0, arg1, 0x1::option::none<AssetBinding>(), arg2);
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : SoulMetadata {
        let v0 = SoulMetadata{
            id            : 0x2::object::new(arg1),
            soul_id       : arg0,
            active_sprite : 0x1::option::none<AssetBinding>(),
            active_voice  : 0x1::option::none<AssetBinding>(),
            ext           : 0x2::table::new<0x1::string::String, vector<u8>>(arg1),
        };
        let v1 = SoulMetadataCreated{
            metadata_id : 0x2::object::id<SoulMetadata>(&v0),
            soul_id     : arg0,
        };
        0x2::event::emit<SoulMetadataCreated>(v1);
        v0
    }

    public fun delete_metadata_blob(arg0: &mut SoulMetadata, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::assert_owner(arg1, 0x2::tx_context::sender(arg3));
        assert_matches_state(arg0, arg1);
        assert!(!0x1::string::is_empty(&arg2), 2);
        assert!(0x2::table::contains<0x1::string::String, vector<u8>>(&arg0.ext, arg2), 1);
        0x2::table::remove<0x1::string::String, vector<u8>>(&mut arg0.ext, arg2);
        let v0 = SoulMetadataBlobDeleted{
            metadata_id : 0x2::object::id<SoulMetadata>(arg0),
            soul_id     : arg0.soul_id,
            updater     : 0x2::tx_context::sender(arg3),
            key         : arg2,
        };
        0x2::event::emit<SoulMetadataBlobDeleted>(v0);
    }

    public fun download_policy(arg0: &AssetBinding) : u8 {
        arg0.download_policy
    }

    public fun download_policy_allowlist() : u8 {
        2
    }

    public fun download_policy_owner_only() : u8 {
        1
    }

    public fun download_policy_public() : u8 {
        0
    }

    public fun is_asset_version_active(arg0: &SoulMetadata, arg1: 0x1::string::String, arg2: u64) : bool {
        is_binding_active(&arg0.active_sprite, arg1, arg2) || is_binding_active(&arg0.active_voice, arg1, arg2)
    }

    fun is_binding_active(arg0: &0x1::option::Option<AssetBinding>, arg1: 0x1::string::String, arg2: u64) : bool {
        if (!0x1::option::is_some<AssetBinding>(arg0)) {
            return false
        };
        let v0 = 0x1::option::borrow<AssetBinding>(arg0);
        v0.asset_name == arg1 && v0.version_index == arg2
    }

    public(friend) fun new_asset_binding(arg0: 0x1::string::String, arg1: u64, arg2: u8) : AssetBinding {
        assert_valid_download_policy(arg2);
        AssetBinding{
            asset_name      : arg0,
            version_index   : arg1,
            download_policy : arg2,
        }
    }

    public fun set_active_sprite(arg0: &mut SoulMetadata, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: 0x1::option::Option<AssetBinding>, arg3: &0x2::tx_context::TxContext) {
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::assert_owner(arg1, 0x2::tx_context::sender(arg3));
        assert_matches_state(arg0, arg1);
        if (0x1::option::is_some<AssetBinding>(&arg2)) {
            assert_valid_download_policy(0x1::option::borrow<AssetBinding>(&arg2).download_policy);
        };
        arg0.active_sprite = arg2;
        let v0 = SoulMetadataSpriteUpdated{
            metadata_id   : 0x2::object::id<SoulMetadata>(arg0),
            soul_id       : arg0.soul_id,
            updater       : 0x2::tx_context::sender(arg3),
            active_sprite : arg0.active_sprite,
        };
        0x2::event::emit<SoulMetadataSpriteUpdated>(v0);
    }

    public fun set_active_voice(arg0: &mut SoulMetadata, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: 0x1::option::Option<AssetBinding>, arg3: &0x2::tx_context::TxContext) {
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::assert_owner(arg1, 0x2::tx_context::sender(arg3));
        assert_matches_state(arg0, arg1);
        if (0x1::option::is_some<AssetBinding>(&arg2)) {
            assert_valid_download_policy(0x1::option::borrow<AssetBinding>(&arg2).download_policy);
        };
        arg0.active_voice = arg2;
        let v0 = SoulMetadataVoiceUpdated{
            metadata_id  : 0x2::object::id<SoulMetadata>(arg0),
            soul_id      : arg0.soul_id,
            updater      : 0x2::tx_context::sender(arg3),
            active_voice : arg0.active_voice,
        };
        0x2::event::emit<SoulMetadataVoiceUpdated>(v0);
    }

    public(friend) fun share_metadata(arg0: SoulMetadata) {
        0x2::transfer::share_object<SoulMetadata>(arg0);
    }

    public fun soul_id(arg0: &SoulMetadata) : 0x2::object::ID {
        arg0.soul_id
    }

    public fun upsert_metadata_blob(arg0: &mut SoulMetadata, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::assert_owner(arg1, 0x2::tx_context::sender(arg4));
        assert_matches_state(arg0, arg1);
        assert!(!0x1::string::is_empty(&arg2), 2);
        if (0x2::table::contains<0x1::string::String, vector<u8>>(&arg0.ext, arg2)) {
            *0x2::table::borrow_mut<0x1::string::String, vector<u8>>(&mut arg0.ext, arg2) = arg3;
        } else {
            0x2::table::add<0x1::string::String, vector<u8>>(&mut arg0.ext, arg2, arg3);
        };
        let v0 = SoulMetadataBlobUpserted{
            metadata_id : 0x2::object::id<SoulMetadata>(arg0),
            soul_id     : arg0.soul_id,
            updater     : 0x2::tx_context::sender(arg4),
            key         : arg2,
        };
        0x2::event::emit<SoulMetadataBlobUpserted>(v0);
    }

    public fun version_index(arg0: &AssetBinding) : u64 {
        arg0.version_index
    }

    // decompiled from Move bytecode v7
}

