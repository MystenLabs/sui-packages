module 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::metadata {
    struct VaultMetadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        name: 0x1::ascii::String,
        description: 0x1::ascii::String,
        curator_name: 0x1::option::Option<0x1::ascii::String>,
        curator_url: 0x1::option::Option<0x1::ascii::String>,
        curator_logo_url: 0x1::option::Option<0x1::ascii::String>,
        extra_fields: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>,
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::object::UID, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::option::Option<0x1::ascii::String>, arg4: 0x1::option::Option<0x1::ascii::String>, arg5: 0x1::option::Option<0x1::ascii::String>, arg6: 0x1::option::Option<vector<0x1::ascii::String>>, arg7: 0x1::option::Option<vector<0x1::ascii::String>>) : VaultMetadata<T0> {
        let v0 = 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::keys::vault_metadata_key();
        assert!(!0x2::derived_object::exists<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::keys::VaultMetadataKey>(arg0, v0), 13835058394584580097);
        let v1 = &mut arg6;
        let v2 = if (0x1::option::is_some<vector<0x1::ascii::String>>(v1)) {
            0x1::option::extract<vector<0x1::ascii::String>>(v1)
        } else {
            0x1::vector::empty<0x1::ascii::String>()
        };
        let v3 = &mut arg7;
        let v4 = if (0x1::option::is_some<vector<0x1::ascii::String>>(v3)) {
            0x1::option::extract<vector<0x1::ascii::String>>(v3)
        } else {
            0x1::vector::empty<0x1::ascii::String>()
        };
        VaultMetadata<T0>{
            id               : 0x2::derived_object::claim<0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::keys::VaultMetadataKey>(arg0, v0),
            vault_id         : 0x2::object::uid_to_inner(arg0),
            name             : arg1,
            description      : arg2,
            curator_name     : arg3,
            curator_url      : arg4,
            curator_logo_url : arg5,
            extra_fields     : 0x2::vec_map::from_keys_values<0x1::ascii::String, 0x1::ascii::String>(v2, v4),
        }
    }

    public(friend) fun set_curator_logo_url<T0>(arg0: &mut VaultMetadata<T0>, arg1: 0x1::ascii::String) {
        arg0.curator_logo_url = 0x1::option::some<0x1::ascii::String>(arg1);
        0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::events::emit_update_vault_metadata(arg0.vault_id, 0x1::string::utf8(b"curator_logo_url"), 0x1::string::from_ascii(arg1));
    }

    public(friend) fun set_curator_name<T0>(arg0: &mut VaultMetadata<T0>, arg1: 0x1::ascii::String) {
        arg0.curator_name = 0x1::option::some<0x1::ascii::String>(arg1);
        0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::events::emit_update_vault_metadata(arg0.vault_id, 0x1::string::utf8(b"curator_name"), 0x1::string::from_ascii(arg1));
    }

    public(friend) fun set_curator_url<T0>(arg0: &mut VaultMetadata<T0>, arg1: 0x1::ascii::String) {
        arg0.curator_url = 0x1::option::some<0x1::ascii::String>(arg1);
        0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::events::emit_update_vault_metadata(arg0.vault_id, 0x1::string::utf8(b"curator_url"), 0x1::string::from_ascii(arg1));
    }

    public(friend) fun set_description<T0>(arg0: &mut VaultMetadata<T0>, arg1: 0x1::ascii::String) {
        arg0.description = arg1;
        0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::events::emit_update_vault_metadata(arg0.vault_id, 0x1::string::utf8(b"description"), 0x1::string::from_ascii(arg1));
    }

    public(friend) fun set_extra_field<T0>(arg0: &mut VaultMetadata<T0>, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) {
        let v0 = &mut arg0.extra_fields;
        if (!0x2::vec_map::contains<0x1::ascii::String, 0x1::ascii::String>(v0, &arg1)) {
            0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(v0, arg1, arg2);
        } else {
            *0x2::vec_map::get_mut<0x1::ascii::String, 0x1::ascii::String>(v0, &arg1) = arg2;
        };
        0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::events::emit_update_vault_metadata(arg0.vault_id, 0x1::string::from_ascii(arg1), 0x1::string::from_ascii(arg2));
    }

    public(friend) fun set_name<T0>(arg0: &mut VaultMetadata<T0>, arg1: 0x1::ascii::String) {
        arg0.name = arg1;
        0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::events::emit_update_vault_metadata(arg0.vault_id, 0x1::string::utf8(b"name"), 0x1::string::from_ascii(arg1));
    }

    public(friend) fun vault_id<T0>(arg0: &VaultMetadata<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v7
}

