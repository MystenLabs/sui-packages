module 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::appearance_v6 {
    struct GenesisAppearanceV6 has key {
        id: 0x2::object::UID,
        version: u64,
        soul_id: 0x2::object::ID,
        soul_state_id: 0x2::object::ID,
        maker_root_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        profile_mode: u8,
        loadout_mutable: bool,
        ownership_epoch: u64,
        authorizer: address,
        client_nonce: vector<u8>,
        loadout_hash: vector<u8>,
        slot_schema_commitment: vector<u8>,
        extensions_hash: vector<u8>,
        transfer_safe: bool,
    }

    struct SoulAppearanceStateV6 has key {
        id: 0x2::object::UID,
        version: u64,
        soul_id: 0x2::object::ID,
        soul_state_id: 0x2::object::ID,
        genesis_appearance_id: 0x2::object::ID,
        maker_root_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        profile_mode: u8,
        loadout_mutable: bool,
        revision: u64,
        ownership_epoch_snapshot: u64,
        current_authorizer: address,
        current_client_nonce: vector<u8>,
        current_loadout_hash: vector<u8>,
        slot_schema_commitment: vector<u8>,
        extensions_hash: vector<u8>,
        transfer_safe: bool,
    }

    struct AppearanceCommitmentV6 has drop {
        maker_root_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        authorizer: address,
        client_nonce: vector<u8>,
        loadout_hash: vector<u8>,
        slot_schema_commitment: vector<u8>,
        extensions_hash: vector<u8>,
        transfer_safe: bool,
    }

    struct GenesisAppearanceV6Created has copy, drop {
        genesis_appearance_id: 0x2::object::ID,
        appearance_state_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        soul_state_id: 0x2::object::ID,
        maker_root_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        profile_mode: u8,
        loadout_mutable: bool,
        ownership_epoch: u64,
        loadout_hash: vector<u8>,
        extensions_hash: vector<u8>,
        transfer_safe: bool,
    }

    struct SoulAppearanceV6Updated has copy, drop {
        appearance_state_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        previous_revision: u64,
        revision: u64,
        ownership_epoch: u64,
        authorizer: address,
        client_nonce: vector<u8>,
        loadout_hash: vector<u8>,
        transfer_safe: bool,
    }

    struct SoulAppearanceV6OwnershipSynced has copy, drop {
        appearance_state_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        revision: u64,
        previous_ownership_epoch: u64,
        ownership_epoch: u64,
    }

    public fun appearance_state_id(arg0: &SoulAppearanceStateV6) : 0x2::object::ID {
        0x2::object::id<SoulAppearanceStateV6>(arg0)
    }

    public(friend) fun apply_authorized_loadout(arg0: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg1: &mut SoulAppearanceStateV6, arg2: u64, arg3: AppearanceCommitmentV6) {
        assert_can_authorize_update(arg0, arg1, arg2);
        let AppearanceCommitmentV6 {
            maker_root_id          : v0,
            profile_id             : v1,
            authorizer             : v2,
            client_nonce           : v3,
            loadout_hash           : v4,
            slot_schema_commitment : v5,
            extensions_hash        : v6,
            transfer_safe          : v7,
        } = arg3;
        assert!(arg1.maker_root_id == v0, 2);
        assert!(arg1.profile_id == v1, 1);
        assert!(arg1.extensions_hash == v6, 1);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_owner(arg0) == v2, 3);
        let v8 = arg1.revision;
        arg1.revision = v8 + 1;
        arg1.current_authorizer = v2;
        arg1.current_client_nonce = v3;
        arg1.current_loadout_hash = v4;
        arg1.slot_schema_commitment = v5;
        arg1.transfer_safe = v7;
        let v9 = SoulAppearanceV6Updated{
            appearance_state_id : 0x2::object::id<SoulAppearanceStateV6>(arg1),
            soul_id             : arg1.soul_id,
            previous_revision   : v8,
            revision            : arg1.revision,
            ownership_epoch     : arg1.ownership_epoch_snapshot,
            authorizer          : v2,
            client_nonce        : *current_client_nonce(arg1),
            loadout_hash        : *current_loadout_hash(arg1),
            transfer_safe       : v7,
        };
        0x2::event::emit<SoulAppearanceV6Updated>(v9);
    }

    public fun assert_active_listing_snapshot(arg0: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg1: &SoulAppearanceStateV6, arg2: u64, arg3: u64, arg4: &vector<u8>) {
        assert_matches_soul(arg1, arg0);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::is_listed(arg0), 12);
        assert!(arg1.transfer_safe, 11);
        assert!(arg1.revision == arg2, 9);
        assert!(arg1.ownership_epoch_snapshot == arg3 && 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::ownership_epoch(arg0) == arg3, 4);
        assert!(arg1.current_loadout_hash == *arg4, 0);
    }

    public(friend) fun assert_can_authorize_update(arg0: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg1: &SoulAppearanceStateV6, arg2: u64) {
        assert_matches_soul(arg1, arg0);
        assert!(!0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::is_listed(arg0), 8);
        assert!(arg1.profile_mode != 0, 6);
        assert!(arg1.loadout_mutable, 7);
        assert!(arg1.revision == arg2, 9);
        assert!(arg1.ownership_epoch_snapshot == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::ownership_epoch(arg0), 4);
    }

    fun assert_commitment_shape(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 10);
        assert!(0x1::vector::length<u8>(arg1) == 32, 10);
        assert!(0x1::vector::length<u8>(arg2) == 32, 10);
        assert!(0x1::vector::length<u8>(arg3) == 32, 10);
    }

    public fun assert_matches_soul(arg0: &SoulAppearanceStateV6, arg1: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState) {
        assert!(arg0.soul_id == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg1), 0);
        assert!(arg0.soul_state_id == 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState>(arg1), 0);
        assert!(0x2::object::id<SoulAppearanceStateV6>(arg0) == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::animacraft_appearance_v6_id(arg1), 0);
    }

    public fun assert_transfer_safe_for_listing(arg0: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg1: &SoulAppearanceStateV6) {
        assert_matches_soul(arg1, arg0);
        assert!(!0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::is_listed(arg0), 8);
        assert!(arg1.transfer_safe, 11);
        assert!(arg1.ownership_epoch_snapshot == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::ownership_epoch(arg0), 4);
    }

    public fun current_authorizer(arg0: &SoulAppearanceStateV6) : address {
        arg0.current_authorizer
    }

    public fun current_client_nonce(arg0: &SoulAppearanceStateV6) : &vector<u8> {
        &arg0.current_client_nonce
    }

    public fun current_loadout_hash(arg0: &SoulAppearanceStateV6) : &vector<u8> {
        &arg0.current_loadout_hash
    }

    public fun extensions_hash(arg0: &SoulAppearanceStateV6) : &vector<u8> {
        &arg0.extensions_hash
    }

    public fun genesis_appearance_id(arg0: &SoulAppearanceStateV6) : 0x2::object::ID {
        arg0.genesis_appearance_id
    }

    public fun genesis_authorizer(arg0: &GenesisAppearanceV6) : address {
        arg0.authorizer
    }

    public fun genesis_client_nonce(arg0: &GenesisAppearanceV6) : &vector<u8> {
        &arg0.client_nonce
    }

    public fun genesis_extensions_hash(arg0: &GenesisAppearanceV6) : &vector<u8> {
        &arg0.extensions_hash
    }

    public fun genesis_loadout_mutable(arg0: &GenesisAppearanceV6) : bool {
        arg0.loadout_mutable
    }

    public fun genesis_maker_root_id(arg0: &GenesisAppearanceV6) : 0x2::object::ID {
        arg0.maker_root_id
    }

    public fun genesis_ownership_epoch(arg0: &GenesisAppearanceV6) : u64 {
        arg0.ownership_epoch
    }

    public fun genesis_profile_id(arg0: &GenesisAppearanceV6) : 0x2::object::ID {
        arg0.profile_id
    }

    public fun genesis_profile_mode(arg0: &GenesisAppearanceV6) : u8 {
        arg0.profile_mode
    }

    public fun genesis_slot_schema_commitment(arg0: &GenesisAppearanceV6) : &vector<u8> {
        &arg0.slot_schema_commitment
    }

    public fun genesis_soul_id(arg0: &GenesisAppearanceV6) : 0x2::object::ID {
        arg0.soul_id
    }

    public fun genesis_state_id(arg0: &GenesisAppearanceV6) : 0x2::object::ID {
        arg0.soul_state_id
    }

    public fun genesis_transfer_safe(arg0: &GenesisAppearanceV6) : bool {
        arg0.transfer_safe
    }

    public fun genesis_version(arg0: &GenesisAppearanceV6) : u64 {
        arg0.version
    }

    public fun loadout_hash(arg0: &GenesisAppearanceV6) : &vector<u8> {
        &arg0.loadout_hash
    }

    public fun loadout_mutable(arg0: &SoulAppearanceStateV6) : bool {
        arg0.loadout_mutable
    }

    public fun maker_root_id(arg0: &SoulAppearanceStateV6) : 0x2::object::ID {
        arg0.maker_root_id
    }

    public(friend) fun new_bind_and_publish(arg0: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg1: u8, arg2: bool, arg3: AppearanceCommitmentV6, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::is_listed(arg0), 8);
        assert!(arg1 == 0 || arg1 == 1, 5);
        assert!(arg1 != 0 || !arg2, 5);
        let AppearanceCommitmentV6 {
            maker_root_id          : v0,
            profile_id             : v1,
            authorizer             : v2,
            client_nonce           : v3,
            loadout_hash           : v4,
            slot_schema_commitment : v5,
            extensions_hash        : v6,
            transfer_safe          : v7,
        } = arg3;
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_owner(arg0) == v2, 3);
        let v8 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg0);
        let v9 = 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState>(arg0);
        let v10 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::ownership_epoch(arg0);
        let v11 = GenesisAppearanceV6{
            id                     : 0x2::object::new(arg4),
            version                : 1,
            soul_id                : v8,
            soul_state_id          : v9,
            maker_root_id          : v0,
            profile_id             : v1,
            profile_mode           : arg1,
            loadout_mutable        : arg2,
            ownership_epoch        : v10,
            authorizer             : v2,
            client_nonce           : v3,
            loadout_hash           : v4,
            slot_schema_commitment : v5,
            extensions_hash        : v6,
            transfer_safe          : v7,
        };
        let v12 = 0x2::object::id<GenesisAppearanceV6>(&v11);
        let v13 = SoulAppearanceStateV6{
            id                       : 0x2::object::new(arg4),
            version                  : 1,
            soul_id                  : v8,
            soul_state_id            : v9,
            genesis_appearance_id    : v12,
            maker_root_id            : v0,
            profile_id               : v1,
            profile_mode             : arg1,
            loadout_mutable          : arg2,
            revision                 : 0,
            ownership_epoch_snapshot : v10,
            current_authorizer       : v2,
            current_client_nonce     : v3,
            current_loadout_hash     : v4,
            slot_schema_commitment   : v5,
            extensions_hash          : v6,
            transfer_safe            : v7,
        };
        let v14 = 0x2::object::id<SoulAppearanceStateV6>(&v13);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::bind_animacraft_appearance_v6(arg0, v14);
        let v15 = GenesisAppearanceV6Created{
            genesis_appearance_id : v12,
            appearance_state_id   : v14,
            soul_id               : v8,
            soul_state_id         : v9,
            maker_root_id         : v0,
            profile_id            : v1,
            profile_mode          : arg1,
            loadout_mutable       : arg2,
            ownership_epoch       : v10,
            loadout_hash          : *loadout_hash(&v11),
            extensions_hash       : *genesis_extensions_hash(&v11),
            transfer_safe         : v7,
        };
        0x2::event::emit<GenesisAppearanceV6Created>(v15);
        0x2::transfer::freeze_object<GenesisAppearanceV6>(v11);
        0x2::transfer::share_object<SoulAppearanceStateV6>(v13);
    }

    public(friend) fun new_commitment(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: bool) : AppearanceCommitmentV6 {
        assert_commitment_shape(&arg3, &arg4, &arg5, &arg6);
        AppearanceCommitmentV6{
            maker_root_id          : arg0,
            profile_id             : arg1,
            authorizer             : arg2,
            client_nonce           : arg3,
            loadout_hash           : arg4,
            slot_schema_commitment : arg5,
            extensions_hash        : arg6,
            transfer_safe          : arg7,
        }
    }

    public fun ownership_epoch_snapshot(arg0: &SoulAppearanceStateV6) : u64 {
        arg0.ownership_epoch_snapshot
    }

    public fun profile_id(arg0: &SoulAppearanceStateV6) : 0x2::object::ID {
        arg0.profile_id
    }

    public fun profile_mode(arg0: &SoulAppearanceStateV6) : u8 {
        arg0.profile_mode
    }

    public fun profile_mode_composable() : u8 {
        1
    }

    public fun profile_mode_fixed() : u8 {
        0
    }

    public fun revision(arg0: &SoulAppearanceStateV6) : u64 {
        arg0.revision
    }

    public fun slot_schema_commitment(arg0: &SoulAppearanceStateV6) : &vector<u8> {
        &arg0.slot_schema_commitment
    }

    public fun soul_id(arg0: &SoulAppearanceStateV6) : 0x2::object::ID {
        arg0.soul_id
    }

    public fun soul_state_id(arg0: &SoulAppearanceStateV6) : 0x2::object::ID {
        arg0.soul_state_id
    }

    public(friend) fun sync_ownership_after_transfer(arg0: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg1: &mut SoulAppearanceStateV6, arg2: u64) {
        assert_matches_soul(arg1, arg0);
        assert!(!0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::is_listed(arg0), 8);
        assert!(arg1.transfer_safe, 11);
        assert!(arg1.revision == arg2, 9);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::ownership_epoch(arg0) == arg1.ownership_epoch_snapshot + 1, 4);
        arg1.ownership_epoch_snapshot = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::ownership_epoch(arg0);
        arg1.current_authorizer = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_owner(arg0);
        let v0 = SoulAppearanceV6OwnershipSynced{
            appearance_state_id      : 0x2::object::id<SoulAppearanceStateV6>(arg1),
            soul_id                  : arg1.soul_id,
            revision                 : arg1.revision,
            previous_ownership_epoch : arg1.ownership_epoch_snapshot,
            ownership_epoch          : arg1.ownership_epoch_snapshot,
        };
        0x2::event::emit<SoulAppearanceV6OwnershipSynced>(v0);
    }

    public fun transfer_safe(arg0: &SoulAppearanceStateV6) : bool {
        arg0.transfer_safe
    }

    public fun version(arg0: &SoulAppearanceStateV6) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

