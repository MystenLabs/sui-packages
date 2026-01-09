module 0x8050aa39572aecfb500730d80a16e3d4b6586256297afe9cb36c4143423f8043::metadata {
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
        let v0 = 0x8050aa39572aecfb500730d80a16e3d4b6586256297afe9cb36c4143423f8043::keys::vault_metadata_key();
        assert!(!0x2::derived_object::exists<0x8050aa39572aecfb500730d80a16e3d4b6586256297afe9cb36c4143423f8043::keys::VaultMetadataKey>(arg0, v0), 13835058373109743617);
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
            id               : 0x2::derived_object::claim<0x8050aa39572aecfb500730d80a16e3d4b6586256297afe9cb36c4143423f8043::keys::VaultMetadataKey>(arg0, v0),
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
        0x1::option::fill<0x1::ascii::String>(&mut arg0.curator_logo_url, arg1);
        0x8050aa39572aecfb500730d80a16e3d4b6586256297afe9cb36c4143423f8043::events::emit_update_vault_metadata(arg0.vault_id, 0x1::string::utf8(b"curator_logo_url"), 0x1::string::from_ascii(arg1));
    }

    public(friend) fun set_curator_name<T0>(arg0: &mut VaultMetadata<T0>, arg1: 0x1::ascii::String) {
        0x1::option::fill<0x1::ascii::String>(&mut arg0.curator_name, arg1);
        0x8050aa39572aecfb500730d80a16e3d4b6586256297afe9cb36c4143423f8043::events::emit_update_vault_metadata(arg0.vault_id, 0x1::string::utf8(b"curator_name"), 0x1::string::from_ascii(arg1));
    }

    public(friend) fun set_curator_url<T0>(arg0: &mut VaultMetadata<T0>, arg1: 0x1::ascii::String) {
        0x1::option::fill<0x1::ascii::String>(&mut arg0.curator_url, arg1);
        0x8050aa39572aecfb500730d80a16e3d4b6586256297afe9cb36c4143423f8043::events::emit_update_vault_metadata(arg0.vault_id, 0x1::string::utf8(b"curator_url"), 0x1::string::from_ascii(arg1));
    }

    public(friend) fun set_description<T0>(arg0: &mut VaultMetadata<T0>, arg1: 0x1::ascii::String) {
        arg0.description = arg1;
        0x8050aa39572aecfb500730d80a16e3d4b6586256297afe9cb36c4143423f8043::events::emit_update_vault_metadata(arg0.vault_id, 0x1::string::utf8(b"description"), 0x1::string::from_ascii(arg1));
    }

    public(friend) fun set_extra_field<T0>(arg0: &mut VaultMetadata<T0>, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) {
        0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(&mut arg0.extra_fields, arg1, arg2);
        0x8050aa39572aecfb500730d80a16e3d4b6586256297afe9cb36c4143423f8043::events::emit_update_vault_metadata(arg0.vault_id, 0x1::string::from_ascii(arg1), 0x1::string::from_ascii(arg2));
    }

    public(friend) fun set_name<T0>(arg0: &mut VaultMetadata<T0>, arg1: 0x1::ascii::String) {
        arg0.name = arg1;
        0x8050aa39572aecfb500730d80a16e3d4b6586256297afe9cb36c4143423f8043::events::emit_update_vault_metadata(arg0.vault_id, 0x1::string::utf8(b"name"), 0x1::string::from_ascii(arg1));
    }

    // decompiled from Move bytecode v6
}

