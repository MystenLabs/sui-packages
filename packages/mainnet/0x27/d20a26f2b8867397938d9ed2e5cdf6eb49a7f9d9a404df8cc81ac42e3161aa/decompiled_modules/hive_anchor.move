module 0x27d20a26f2b8867397938d9ed2e5cdf6eb49a7f9d9a404df8cc81ac42e3161aa::hive_anchor {
    struct HiveAnchor has key {
        id: 0x2::object::UID,
        owner: address,
        registry_blob_id: 0x1::string::String,
        updated_at: u64,
        version: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        anchor_id: 0x2::object::ID,
    }

    struct ContributorCap has store, key {
        id: 0x2::object::UID,
        anchor_id: 0x2::object::ID,
        contributor: address,
    }

    struct AgentField has store {
        data: 0x1::string::String,
    }

    struct AnchorCreated has copy, drop {
        anchor_id: 0x2::object::ID,
        owner: address,
    }

    struct AnchorUpdated has copy, drop {
        anchor_id: 0x2::object::ID,
        old_blob_id: 0x1::string::String,
        new_blob_id: 0x1::string::String,
        updated_by: address,
        version: u64,
    }

    struct ContributorAdded has copy, drop {
        anchor_id: 0x2::object::ID,
        contributor: address,
    }

    struct ContributorRemoved has copy, drop {
        anchor_id: 0x2::object::ID,
        contributor: address,
    }

    public entry fun add_agent_field(arg0: &mut HiveAnchor, arg1: &AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert_admin_for_anchor(arg0, arg1);
        let v0 = key_from_name(&arg2);
        if (0x2::dynamic_field::exists_with_type<vector<u8>, AgentField>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow_mut<vector<u8>, AgentField>(&mut arg0.id, v0).data = arg3;
        } else {
            let v1 = AgentField{data: arg3};
            0x2::dynamic_field::add<vector<u8>, AgentField>(&mut arg0.id, v0, v1);
        };
    }

    public entry fun add_agent_field_as_admin(arg0: &mut HiveAnchor, arg1: &AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        add_agent_field(arg0, arg1, arg2, arg3);
    }

    public entry fun add_agent_field_as_contributor(arg0: &mut HiveAnchor, arg1: &ContributorCap, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert_contributor_for_anchor(arg0, arg1);
        let v0 = key_from_name(&arg2);
        if (0x2::dynamic_field::exists_with_type<vector<u8>, AgentField>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow_mut<vector<u8>, AgentField>(&mut arg0.id, v0).data = arg3;
        } else {
            let v1 = AgentField{data: arg3};
            0x2::dynamic_field::add<vector<u8>, AgentField>(&mut arg0.id, v0, v1);
        };
    }

    public entry fun add_contributor(arg0: &mut HiveAnchor, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin_for_anchor(arg0, arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        let v0 = ContributorCap{
            id          : 0x2::object::new(arg3),
            anchor_id   : 0x2::object::id<HiveAnchor>(arg0),
            contributor : arg2,
        };
        0x2::transfer::transfer<ContributorCap>(v0, arg2);
        let v1 = ContributorAdded{
            anchor_id   : 0x2::object::id<HiveAnchor>(arg0),
            contributor : arg2,
        };
        0x2::event::emit<ContributorAdded>(v1);
    }

    fun assert_admin_for_anchor(arg0: &HiveAnchor, arg1: &AdminCap) {
        assert!(arg1.anchor_id == 0x2::object::id<HiveAnchor>(arg0), 2);
    }

    fun assert_contributor_for_anchor(arg0: &HiveAnchor, arg1: &ContributorCap) {
        assert!(arg1.anchor_id == 0x2::object::id<HiveAnchor>(arg0), 2);
    }

    fun assert_non_empty_blob_id(arg0: &0x1::string::String) {
        assert!(0x1::string::length(arg0) > 0, 1);
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : (HiveAnchor, AdminCap) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = HiveAnchor{
            id               : 0x2::object::new(arg0),
            owner            : v0,
            registry_blob_id : 0x1::string::utf8(b""),
            updated_at       : 0,
            version          : 0,
        };
        let v2 = 0x2::object::id<HiveAnchor>(&v1);
        let v3 = AdminCap{
            id        : 0x2::object::new(arg0),
            anchor_id : v2,
        };
        let v4 = AnchorCreated{
            anchor_id : v2,
            owner     : v0,
        };
        0x2::event::emit<AnchorCreated>(v4);
        (v1, v3)
    }

    entry fun create_shared(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let (v1, v2) = create(arg0);
        0x2::transfer::share_object<HiveAnchor>(v1);
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    fun do_update_blob_id(arg0: &mut HiveAnchor, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_non_empty_blob_id(&arg1);
        let v0 = arg0.version + 1;
        arg0.registry_blob_id = arg1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        arg0.version = v0;
        let v1 = AnchorUpdated{
            anchor_id   : 0x2::object::id<HiveAnchor>(arg0),
            old_blob_id : arg0.registry_blob_id,
            new_blob_id : arg0.registry_blob_id,
            updated_by  : 0x2::tx_context::sender(arg3),
            version     : v0,
        };
        0x2::event::emit<AnchorUpdated>(v1);
    }

    public fun get_agent_field(arg0: &HiveAnchor, arg1: 0x1::string::String) : 0x1::string::String {
        let v0 = key_from_name(&arg1);
        assert!(0x2::dynamic_field::exists_with_type<vector<u8>, AgentField>(&arg0.id, v0), 3);
        0x2::dynamic_field::borrow<vector<u8>, AgentField>(&arg0.id, v0).data
    }

    public fun get_blob_id(arg0: &HiveAnchor) : 0x1::string::String {
        arg0.registry_blob_id
    }

    public fun get_version(arg0: &HiveAnchor) : u64 {
        arg0.version
    }

    fun key_from_name(arg0: &0x1::string::String) : vector<u8> {
        *0x1::string::bytes(arg0)
    }

    public entry fun remove_agent_field(arg0: &mut HiveAnchor, arg1: &AdminCap, arg2: 0x1::string::String) {
        assert_admin_for_anchor(arg0, arg1);
        remove_agent_field_internal(arg0, arg2);
    }

    public entry fun remove_agent_field_as_admin(arg0: &mut HiveAnchor, arg1: &AdminCap, arg2: 0x1::string::String) {
        remove_agent_field(arg0, arg1, arg2);
    }

    public entry fun remove_agent_field_as_contributor(arg0: &mut HiveAnchor, arg1: &ContributorCap, arg2: 0x1::string::String) {
        assert_contributor_for_anchor(arg0, arg1);
        remove_agent_field_internal(arg0, arg2);
    }

    fun remove_agent_field_internal(arg0: &mut HiveAnchor, arg1: 0x1::string::String) {
        let v0 = key_from_name(&arg1);
        assert!(0x2::dynamic_field::exists_with_type<vector<u8>, AgentField>(&arg0.id, v0), 3);
        let AgentField {  } = 0x2::dynamic_field::remove<vector<u8>, AgentField>(&mut arg0.id, v0);
    }

    public entry fun remove_contributor(arg0: &HiveAnchor, arg1: &AdminCap, arg2: ContributorCap, arg3: &0x2::tx_context::TxContext) {
        assert_admin_for_anchor(arg0, arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(arg2.anchor_id == 0x2::object::id<HiveAnchor>(arg0), 2);
        let ContributorCap {
            id          : v0,
            anchor_id   : _,
            contributor : _,
        } = arg2;
        0x2::object::delete(v0);
        let v3 = ContributorRemoved{
            anchor_id   : 0x2::object::id<HiveAnchor>(arg0),
            contributor : arg2.contributor,
        };
        0x2::event::emit<ContributorRemoved>(v3);
    }

    public entry fun transfer_ownership(arg0: &mut HiveAnchor, arg1: AdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.anchor_id == 0x2::object::id<HiveAnchor>(arg0), 2);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        arg0.owner = arg2;
        0x2::transfer::transfer<AdminCap>(arg1, arg2);
    }

    public entry fun update_blob_id(arg0: &mut HiveAnchor, arg1: &AdminCap, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_admin_for_anchor(arg0, arg1);
        do_update_blob_id(arg0, arg2, arg3, arg4);
    }

    public entry fun update_blob_id_as_admin(arg0: &mut HiveAnchor, arg1: &AdminCap, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        update_blob_id(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun update_blob_id_as_contributor(arg0: &mut HiveAnchor, arg1: &ContributorCap, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_contributor_for_anchor(arg0, arg1);
        do_update_blob_id(arg0, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

