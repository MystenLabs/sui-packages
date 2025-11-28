module 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::metadata {
    struct VaultMetadataKey has copy, drop, store {
        dummy_field: bool,
    }

    struct VaultMetadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        description: 0x1::ascii::String,
        curator_name: 0x1::ascii::String,
        curator_url: 0x1::ascii::String,
        curator_logo_url: 0x1::ascii::String,
        extra_fields: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>,
    }

    public(friend) fun create_vault_metadata_and_share<T0>(arg0: &mut 0x2::object::UID, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String) {
        let v0 = VaultMetadataKey{dummy_field: false};
        assert!(!0x2::derived_object::exists<VaultMetadataKey>(arg0, v0), 13835058368814776321);
        let v1 = VaultMetadata<T0>{
            id               : 0x2::derived_object::claim<VaultMetadataKey>(arg0, v0),
            vault_id         : 0x2::object::uid_to_inner(arg0),
            description      : arg1,
            curator_name     : arg2,
            curator_url      : arg3,
            curator_logo_url : arg4,
            extra_fields     : 0x2::vec_map::empty<0x1::ascii::String, 0x1::ascii::String>(),
        };
        0x2::transfer::share_object<VaultMetadata<T0>>(v1);
    }

    public fun set_curator_logo_url<T0, T1>(arg0: &mut VaultMetadata<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: 0x1::ascii::String) {
        assert!(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::vault_id<T1>(arg1) == arg0.vault_id && 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::is_admin(0x1::type_name::with_defining_ids<T1>()), 13835340294763184131);
        arg0.curator_logo_url = arg2;
    }

    public fun set_curator_name<T0, T1>(arg0: &mut VaultMetadata<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: 0x1::ascii::String) {
        assert!(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::vault_id<T1>(arg1) == arg0.vault_id && 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::is_admin(0x1::type_name::with_defining_ids<T1>()), 13835340294763184131);
        arg0.curator_name = arg2;
    }

    public fun set_curator_url<T0, T1>(arg0: &mut VaultMetadata<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: 0x1::ascii::String) {
        assert!(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::vault_id<T1>(arg1) == arg0.vault_id && 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::is_admin(0x1::type_name::with_defining_ids<T1>()), 13835340294763184131);
        arg0.curator_url = arg2;
    }

    public fun set_description<T0, T1>(arg0: &mut VaultMetadata<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: 0x1::ascii::String) {
        assert!(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::vault_id<T1>(arg1) == arg0.vault_id && 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::is_admin(0x1::type_name::with_defining_ids<T1>()), 13835340294763184131);
        arg0.description = arg2;
    }

    public fun set_extra_field<T0, T1>(arg0: &mut VaultMetadata<T0>, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::VAULT, T1>, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String) {
        assert!(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::vault_id<T1>(arg1) == arg0.vault_id && 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::is_admin(0x1::type_name::with_defining_ids<T1>()), 13835340294763184131);
        0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(&mut arg0.extra_fields, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

