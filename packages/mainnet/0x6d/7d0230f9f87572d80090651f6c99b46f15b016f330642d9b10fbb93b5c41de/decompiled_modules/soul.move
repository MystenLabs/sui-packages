module 0x6d7d0230f9f87572d80090651f6c99b46f15b016f330642d9b10fbb93b5c41de::soul {
    struct SOUL has drop {
        dummy_field: bool,
    }

    struct Soul has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        protected_blob: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob,
        provenance_kind: u8,
        origin_ref: 0x1::option::Option<0x1::string::String>,
        creator: address,
    }

    struct ActiveGrantSlot has copy, drop, store {
        grant_id: 0x2::object::ID,
        grantee: address,
        scope_mask: u64,
        expires_at_ms: 0x1::option::Option<u64>,
        ownership_epoch_snapshot: u64,
    }

    struct SoulState has key {
        id: 0x2::object::UID,
        soul_id: 0x2::object::ID,
        creator: address,
        creator_royalty_bps: u16,
        current_owner: address,
        current_kiosk_id: 0x2::object::ID,
        ownership_epoch: u64,
        grant_capacity: u64,
        active_grants: 0x2::table::Table<address, ActiveGrantSlot>,
        active_grant_ids: 0x2::table::Table<0x2::object::ID, address>,
        active_grant_count: u64,
        memory_id: 0x1::option::Option<0x2::object::ID>,
        metadata_id: 0x1::option::Option<0x2::object::ID>,
        skills_id: 0x1::option::Option<0x2::object::ID>,
        assets_id: 0x1::option::Option<0x2::object::ID>,
        collection_id: 0x1::option::Option<0x2::object::ID>,
        access_list_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct SoulCreated has copy, drop {
        soul_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
        creator: address,
        owner: address,
        provenance_kind: u8,
    }

    struct SoulOwnershipRotated has copy, drop {
        soul_id: 0x2::object::ID,
        previous_owner: address,
        new_owner: address,
        ownership_epoch: u64,
    }

    public fun access_list_id(arg0: &SoulState) : &0x1::option::Option<0x2::object::ID> {
        &arg0.access_list_id
    }

    public(friend) fun active_grant_contains_grantee(arg0: &SoulState, arg1: address) : bool {
        if (!0x2::table::contains<address, ActiveGrantSlot>(&arg0.active_grants, arg1)) {
            return false
        };
        0x2::table::borrow<address, ActiveGrantSlot>(&arg0.active_grants, arg1).ownership_epoch_snapshot == arg0.ownership_epoch && arg0.active_grant_count > 0
    }

    public(friend) fun active_grant_contains_id(arg0: &SoulState, arg1: 0x2::object::ID) : bool {
        if (!0x2::table::contains<0x2::object::ID, address>(&arg0.active_grant_ids, arg1)) {
            return false
        };
        let v0 = *0x2::table::borrow<0x2::object::ID, address>(&arg0.active_grant_ids, arg1);
        if (!0x2::table::contains<address, ActiveGrantSlot>(&arg0.active_grants, v0)) {
            return false
        };
        let v1 = 0x2::table::borrow<address, ActiveGrantSlot>(&arg0.active_grants, v0);
        if (v1.grant_id == arg1) {
            if (v1.ownership_epoch_snapshot == arg0.ownership_epoch) {
                arg0.active_grant_count > 0
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun active_grant_count(arg0: &SoulState) : u64 {
        arg0.active_grant_count
    }

    public(friend) fun active_grant_grantee_by_id(arg0: &SoulState, arg1: 0x2::object::ID) : 0x1::option::Option<address> {
        if (0x2::table::contains<0x2::object::ID, address>(&arg0.active_grant_ids, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<0x2::object::ID, address>(&arg0.active_grant_ids, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public(friend) fun active_grant_has_grantee_row(arg0: &SoulState, arg1: address) : bool {
        0x2::table::contains<address, ActiveGrantSlot>(&arg0.active_grants, arg1)
    }

    public fun active_grant_slot_expires_at_ms(arg0: &ActiveGrantSlot) : &0x1::option::Option<u64> {
        &arg0.expires_at_ms
    }

    public(friend) fun active_grant_slot_for_grantee(arg0: &SoulState, arg1: address) : &ActiveGrantSlot {
        0x2::table::borrow<address, ActiveGrantSlot>(&arg0.active_grants, arg1)
    }

    public fun active_grant_slot_grant_id(arg0: &ActiveGrantSlot) : 0x2::object::ID {
        arg0.grant_id
    }

    public fun active_grant_slot_grantee(arg0: &ActiveGrantSlot) : address {
        arg0.grantee
    }

    public fun active_grant_slot_ownership_epoch_snapshot(arg0: &ActiveGrantSlot) : u64 {
        arg0.ownership_epoch_snapshot
    }

    public fun active_grant_slot_scope_mask(arg0: &ActiveGrantSlot) : u64 {
        arg0.scope_mask
    }

    public(friend) fun assert_matches_state(arg0: &Soul, arg1: &SoulState) {
        assert!(0x2::object::id<Soul>(arg0) == arg1.soul_id, 14);
    }

    public(friend) fun assert_owner(arg0: &SoulState, arg1: address) {
        assert!(arg0.current_owner == arg1, 1);
    }

    public fun assets_id(arg0: &SoulState) : &0x1::option::Option<0x2::object::ID> {
        &arg0.assets_id
    }

    public(friend) fun bind_collection(arg0: &mut SoulState, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.collection_id), 2);
        arg0.collection_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public(friend) fun clear_active_grant_count_for_owner_rotation(arg0: &mut SoulState) {
        arg0.active_grant_count = 0;
    }

    public fun collection_id(arg0: &SoulState) : &0x1::option::Option<0x2::object::ID> {
        &arg0.collection_id
    }

    fun create_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<Soul> {
        let v0 = 0x2::display::new<Soul>(arg0, arg1);
        0x2::display::add<Soul>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Soul>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Soul>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Soul>(&mut v0, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::add<Soul>(&mut v0, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"{origin_ref}"));
        0x2::display::add<Soul>(&mut v0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"{origin_ref}"));
        0x2::display::update_version<Soul>(&mut v0);
        v0
    }

    public(friend) fun create_state(arg0: 0x2::object::ID, arg1: address, arg2: u16, arg3: address, arg4: 0x2::object::ID, arg5: 0x1::option::Option<0x2::object::ID>, arg6: &mut 0x2::tx_context::TxContext) : SoulState {
        assert!(arg3 != @0x0, 3);
        assert!(arg2 <= 10000, 0);
        SoulState{
            id                  : 0x2::object::new(arg6),
            soul_id             : arg0,
            creator             : arg1,
            creator_royalty_bps : arg2,
            current_owner       : arg3,
            current_kiosk_id    : arg4,
            ownership_epoch     : 0,
            grant_capacity      : 1,
            active_grants       : 0x2::table::new<address, ActiveGrantSlot>(arg6),
            active_grant_ids    : 0x2::table::new<0x2::object::ID, address>(arg6),
            active_grant_count  : 0,
            memory_id           : arg5,
            metadata_id         : 0x1::option::none<0x2::object::ID>(),
            skills_id           : 0x1::option::none<0x2::object::ID>(),
            assets_id           : 0x1::option::none<0x2::object::ID>(),
            collection_id       : 0x1::option::none<0x2::object::ID>(),
            access_list_id      : 0x1::option::none<0x2::object::ID>(),
        }
    }

    public fun creator(arg0: &Soul) : address {
        arg0.creator
    }

    public fun creator_royalty_bps(arg0: &SoulState) : u16 {
        arg0.creator_royalty_bps
    }

    public fun current_kiosk_id(arg0: &SoulState) : 0x2::object::ID {
        arg0.current_kiosk_id
    }

    public fun current_owner(arg0: &SoulState) : address {
        arg0.current_owner
    }

    public fun description(arg0: &Soul) : &0x1::string::String {
        &arg0.description
    }

    public(friend) fun emit_created(arg0: &SoulState, arg1: u8) {
        let v0 = SoulCreated{
            soul_id         : arg0.soul_id,
            state_id        : 0x2::object::id<SoulState>(arg0),
            metadata_id     : *0x1::option::borrow<0x2::object::ID>(&arg0.metadata_id),
            creator         : arg0.creator,
            owner           : arg0.current_owner,
            provenance_kind : arg1,
        };
        0x2::event::emit<SoulCreated>(v0);
    }

    public fun grant_capacity(arg0: &SoulState) : u64 {
        arg0.grant_capacity
    }

    public fun image_url(arg0: &Soul) : &0x1::string::String {
        &arg0.image_url
    }

    fun init(arg0: SOUL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SOUL>(arg0, arg1);
        let v1 = create_display(&v0, arg1);
        0x2::transfer::public_transfer<0x2::display::Display<Soul>>(v1, 0x2::tx_context::sender(arg1));
        0x2::package::burn_publisher(v0);
    }

    public fun memory_id(arg0: &SoulState) : &0x1::option::Option<0x2::object::ID> {
        &arg0.memory_id
    }

    public fun metadata_id(arg0: &SoulState) : &0x1::option::Option<0x2::object::ID> {
        &arg0.metadata_id
    }

    public(friend) fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg4: address, arg5: u16, arg6: u8, arg7: 0x1::option::Option<0x1::string::String>, arg8: &mut 0x2::tx_context::TxContext) : Soul {
        assert!(arg5 <= 10000, 0);
        Soul{
            id              : 0x2::object::new(arg8),
            name            : arg0,
            description     : arg1,
            image_url       : arg2,
            protected_blob  : arg3,
            provenance_kind : arg6,
            origin_ref      : arg7,
            creator         : arg4,
        }
    }

    public fun name(arg0: &Soul) : &0x1::string::String {
        &arg0.name
    }

    public fun origin_ref(arg0: &Soul) : &0x1::option::Option<0x1::string::String> {
        &arg0.origin_ref
    }

    public fun ownership_epoch(arg0: &SoulState) : u64 {
        arg0.ownership_epoch
    }

    public fun protected_blob_object_id(arg0: &Soul) : 0x2::object::ID {
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::object_id(&arg0.protected_blob)
    }

    public(friend) fun provenance_imported() : u8 {
        1
    }

    public fun provenance_kind(arg0: &Soul) : u8 {
        arg0.provenance_kind
    }

    public(friend) fun provenance_native() : u8 {
        0
    }

    public(friend) fun provenance_personal_join() : u8 {
        2
    }

    public(friend) fun push_active_grant(arg0: &mut SoulState, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: u64) {
        let v0 = ActiveGrantSlot{
            grant_id                 : arg1,
            grantee                  : arg2,
            scope_mask               : arg3,
            expires_at_ms            : arg4,
            ownership_epoch_snapshot : arg5,
        };
        0x2::table::add<address, ActiveGrantSlot>(&mut arg0.active_grants, arg2, v0);
        0x2::table::add<0x2::object::ID, address>(&mut arg0.active_grant_ids, arg1, arg2);
        arg0.active_grant_count = arg0.active_grant_count + 1;
    }

    public(friend) fun remove_active_grant_for_grantee(arg0: &mut SoulState, arg1: address) : ActiveGrantSlot {
        let v0 = 0x2::table::remove<address, ActiveGrantSlot>(&mut arg0.active_grants, arg1);
        0x2::table::remove<0x2::object::ID, address>(&mut arg0.active_grant_ids, v0.grant_id);
        if (v0.ownership_epoch_snapshot == arg0.ownership_epoch && arg0.active_grant_count > 0) {
            arg0.active_grant_count = arg0.active_grant_count - 1;
        };
        v0
    }

    public(friend) fun rotate_owner(arg0: &mut SoulState, arg1: address, arg2: 0x2::object::ID) {
        assert!(arg1 != @0x0, 3);
        arg0.current_owner = arg1;
        arg0.current_kiosk_id = arg2;
        arg0.ownership_epoch = arg0.ownership_epoch + 1;
        let v0 = SoulOwnershipRotated{
            soul_id         : arg0.soul_id,
            previous_owner  : arg0.current_owner,
            new_owner       : arg1,
            ownership_epoch : arg0.ownership_epoch,
        };
        0x2::event::emit<SoulOwnershipRotated>(v0);
    }

    public(friend) fun set_access_list_id(arg0: &mut SoulState, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.access_list_id), 13);
        arg0.access_list_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public(friend) fun set_assets_id(arg0: &mut SoulState, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.assets_id), 12);
        arg0.assets_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public(friend) fun set_grant_capacity(arg0: &mut SoulState, arg1: u64) {
        arg0.grant_capacity = arg1;
    }

    public(friend) fun set_memory_id(arg0: &mut SoulState, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.memory_id), 5);
        arg0.memory_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public(friend) fun set_metadata_id(arg0: &mut SoulState, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.metadata_id), 6);
        arg0.metadata_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public(friend) fun set_skills_id(arg0: &mut SoulState, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.skills_id), 4);
        arg0.skills_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public(friend) fun share_state(arg0: SoulState) {
        0x2::transfer::share_object<SoulState>(arg0);
    }

    public fun skills_id(arg0: &SoulState) : &0x1::option::Option<0x2::object::ID> {
        &arg0.skills_id
    }

    public fun soul_id(arg0: &SoulState) : 0x2::object::ID {
        arg0.soul_id
    }

    public fun state_creator(arg0: &SoulState) : address {
        arg0.creator
    }

    public fun state_id(arg0: &SoulState) : 0x2::object::ID {
        0x2::object::id<SoulState>(arg0)
    }

    // decompiled from Move bytecode v7
}

