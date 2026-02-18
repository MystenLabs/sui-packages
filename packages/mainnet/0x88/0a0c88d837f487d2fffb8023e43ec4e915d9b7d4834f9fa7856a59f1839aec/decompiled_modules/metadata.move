module 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::metadata {
    struct VaultMetadataKey has copy, drop, store {
        dummy_field: bool,
    }

    struct VaultMetadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        name: 0x1::ascii::String,
        description: 0x1::ascii::String,
        curator_name: 0x1::ascii::String,
        curator_url: 0x1::ascii::String,
        curator_logo_url: 0x1::ascii::String,
        extra_fields: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>,
    }

    public(friend) fun create_vault_metadata_and_share<T0>(arg0: &mut 0x2::object::UID, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String) {
        let v0 = VaultMetadataKey{dummy_field: false};
        assert!(!0x2::derived_object::exists<VaultMetadataKey>(arg0, v0), 13835058385994645505);
        let v1 = VaultMetadata<T0>{
            id               : 0x2::derived_object::claim<VaultMetadataKey>(arg0, v0),
            vault_id         : 0x2::object::uid_to_inner(arg0),
            name             : arg1,
            description      : arg2,
            curator_name     : arg3,
            curator_url      : arg4,
            curator_logo_url : arg5,
            extra_fields     : 0x2::vec_map::empty<0x1::ascii::String, 0x1::ascii::String>(),
        };
        0x2::transfer::share_object<VaultMetadata<T0>>(v1);
    }

    public fun set_curator_logo_url<T0, T1>(arg0: &mut VaultMetadata<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: 0x1::ascii::String) {
        assert!(0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::vault_id<T0, T1>(arg1) == arg0.vault_id && 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::is_admin(0x1::type_name::with_defining_ids<T1>()), 13835340419317235715);
        arg0.curator_logo_url = arg2;
    }

    public fun set_curator_name<T0, T1>(arg0: &mut VaultMetadata<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: 0x1::ascii::String) {
        assert!(0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::vault_id<T0, T1>(arg1) == arg0.vault_id && 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::is_admin(0x1::type_name::with_defining_ids<T1>()), 13835340419317235715);
        arg0.curator_name = arg2;
    }

    public fun set_curator_url<T0, T1>(arg0: &mut VaultMetadata<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: 0x1::ascii::String) {
        assert!(0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::vault_id<T0, T1>(arg1) == arg0.vault_id && 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::is_admin(0x1::type_name::with_defining_ids<T1>()), 13835340419317235715);
        arg0.curator_url = arg2;
    }

    public fun set_description<T0, T1>(arg0: &mut VaultMetadata<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: 0x1::ascii::String) {
        assert!(0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::vault_id<T0, T1>(arg1) == arg0.vault_id && 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::is_admin(0x1::type_name::with_defining_ids<T1>()), 13835340419317235715);
        arg0.description = arg2;
    }

    public fun set_extra_field<T0, T1>(arg0: &mut VaultMetadata<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String) {
        assert!(0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::vault_id<T0, T1>(arg1) == arg0.vault_id && 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::is_admin(0x1::type_name::with_defining_ids<T1>()), 13835340419317235715);
        let v0 = &mut arg0.extra_fields;
        if (!0x2::vec_map::contains<0x1::ascii::String, 0x1::ascii::String>(v0, &arg2)) {
            0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(v0, arg2, arg3);
        } else {
            *0x2::vec_map::get_mut<0x1::ascii::String, 0x1::ascii::String>(v0, &arg2) = arg3;
        };
    }

    public fun set_name<T0, T1>(arg0: &mut VaultMetadata<T0>, arg1: &0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::AuthorityCap<0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::VAULT<T0>, T1>, arg2: 0x1::ascii::String) {
        assert!(0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::vault_id<T0, T1>(arg1) == arg0.vault_id && 0x880a0c88d837f487d2fffb8023e43ec4e915d9b7d4834f9fa7856a59f1839aec::authority::is_admin(0x1::type_name::with_defining_ids<T1>()), 13835340419317235715);
        arg0.name = arg2;
    }

    // decompiled from Move bytecode v6
}

