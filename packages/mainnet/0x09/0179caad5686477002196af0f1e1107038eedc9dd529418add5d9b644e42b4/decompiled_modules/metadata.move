module 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::metadata {
    struct Metadata has store {
        assembly_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct MetadataChangedEvent has copy, drop {
        assembly_id: 0x2::object::ID,
        assembly_key: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    public(friend) fun create_metadata(arg0: 0x2::object::ID, arg1: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String) : Metadata {
        let v0 = Metadata{
            assembly_id : arg0,
            name        : arg2,
            description : arg3,
            url         : arg4,
        };
        emit_metadata_changed(&v0, arg1);
        v0
    }

    public(friend) fun delete(arg0: Metadata) {
        let Metadata {
            assembly_id : _,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
    }

    public fun description(arg0: &Metadata) : 0x1::string::String {
        arg0.description
    }

    fun emit_metadata_changed(arg0: &Metadata, arg1: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId) {
        let v0 = MetadataChangedEvent{
            assembly_id  : arg0.assembly_id,
            assembly_key : arg1,
            name         : arg0.name,
            description  : arg0.description,
            url          : arg0.url,
        };
        0x2::event::emit<MetadataChangedEvent>(v0);
    }

    public fun name(arg0: &Metadata) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun update_description(arg0: &mut Metadata, arg1: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId, arg2: 0x1::string::String) {
        arg0.description = arg2;
        emit_metadata_changed(arg0, arg1);
    }

    public(friend) fun update_name(arg0: &mut Metadata, arg1: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId, arg2: 0x1::string::String) {
        arg0.name = arg2;
        emit_metadata_changed(arg0, arg1);
    }

    public(friend) fun update_url(arg0: &mut Metadata, arg1: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId, arg2: 0x1::string::String) {
        arg0.url = arg2;
        emit_metadata_changed(arg0, arg1);
    }

    public fun url(arg0: &Metadata) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v6
}

