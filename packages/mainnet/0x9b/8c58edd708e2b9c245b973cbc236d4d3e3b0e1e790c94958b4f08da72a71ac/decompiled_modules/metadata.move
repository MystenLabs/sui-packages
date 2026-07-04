module 0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::metadata {
    struct VendorMetadataKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct AuthorizedVendorAuthorityCapKey<phantom T0> has copy, drop, store {
        cap_id: 0x2::object::ID,
    }

    struct VendorMetadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
        description: 0x1::ascii::String,
        extra_fields: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>,
    }

    public fun assert_has_active_vendor_authority<T0, T1>(arg0: &VendorMetadata<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::VENDOR<T0>, T1>) {
        assert!(has_vendor_authority<T0, T1>(arg0, arg1), 13835621718200418309);
    }

    public(friend) fun authorize_vendor_assistant_cap<T0>(arg0: &mut VendorMetadata<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::VENDOR<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>) {
        let v0 = AuthorizedVendorAuthorityCapKey<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>{cap_id: 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::VENDOR<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>>(arg1)};
        0x2::dynamic_field::add<AuthorizedVendorAuthorityCapKey<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>, bool>(&mut arg0.id, v0, true);
    }

    public(friend) fun deauthorize_vendor_assistant_cap<T0>(arg0: &mut VendorMetadata<T0>, arg1: 0x2::object::ID) {
        assert!(is_vendor_authority_cap_authorized<T0>(arg0, arg1), 13835621885704142853);
        let v0 = AuthorizedVendorAuthorityCapKey<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>{cap_id: arg1};
        0x2::dynamic_field::remove<AuthorizedVendorAuthorityCapKey<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>, bool>(&mut arg0.id, v0);
    }

    public(friend) fun has_vendor_authority<T0, T1>(arg0: &VendorMetadata<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::VENDOR<T0>, T1>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        v0 == 0x1::type_name::with_defining_ids<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>() || v0 == 0x1::type_name::with_defining_ids<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>() && is_vendor_authority_cap_authorized<T0>(arg0, 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::VENDOR<T0>, T1>>(arg1))
    }

    fun is_vendor_authority_cap_authorized<T0>(arg0: &VendorMetadata<T0>, arg1: 0x2::object::ID) : bool {
        let v0 = AuthorizedVendorAuthorityCapKey<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>{cap_id: arg1};
        0x2::dynamic_field::exists<AuthorizedVendorAuthorityCapKey<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>>(&arg0.id, v0)
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::object::UID, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) : VendorMetadata<T0> {
        let v0 = VendorMetadataKey<T0>{dummy_field: false};
        assert!(!0x2::derived_object::exists<VendorMetadataKey<T0>>(arg0, v0), 13835058450419154945);
        VendorMetadata<T0>{
            id           : 0x2::derived_object::claim<VendorMetadataKey<T0>>(arg0, v0),
            name         : arg1,
            description  : arg2,
            extra_fields : 0x2::vec_map::empty<0x1::ascii::String, 0x1::ascii::String>(),
        }
    }

    public fun set_description<T0, T1>(arg0: &mut VendorMetadata<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::VENDOR<T0>, T1>, arg2: 0x1::ascii::String) {
        assert_has_active_vendor_authority<T0, T1>(arg0, arg1);
        arg0.description = arg2;
    }

    public fun set_extra_field<T0, T1>(arg0: &mut VendorMetadata<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::VENDOR<T0>, T1>, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String) {
        let v0 = vector[];
        assert!(!0x1::vector::contains<vector<u8>>(&v0, 0x1::ascii::as_bytes(&arg2)), 13835340174504099843);
        assert_has_active_vendor_authority<T0, T1>(arg0, arg1);
        let v1 = &mut arg0.extra_fields;
        if (!0x2::vec_map::contains<0x1::ascii::String, 0x1::ascii::String>(v1, &arg2)) {
            0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(v1, arg2, arg3);
        } else {
            *0x2::vec_map::get_mut<0x1::ascii::String, 0x1::ascii::String>(v1, &arg2) = arg3;
        };
    }

    public fun set_name<T0, T1>(arg0: &mut VendorMetadata<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::VENDOR<T0>, T1>, arg2: 0x1::ascii::String) {
        assert_has_active_vendor_authority<T0, T1>(arg0, arg1);
        arg0.name = arg2;
    }

    // decompiled from Move bytecode v7
}

