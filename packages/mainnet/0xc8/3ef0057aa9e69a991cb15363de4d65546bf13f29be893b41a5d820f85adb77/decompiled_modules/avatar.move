module 0xc83ef0057aa9e69a991cb15363de4d65546bf13f29be893b41a5d820f85adb77::avatar {
    struct AVATAR has drop {
        dummy_field: bool,
    }

    struct Avatar has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        manifest_blob_id: 0x1::string::String,
        preview_blob_id: 0x1::string::String,
        preview_url: 0x1::string::String,
        project_url: 0x1::string::String,
        schema_version: u64,
    }

    struct AvatarChildSlot has copy, drop, store {
        name: 0x1::string::String,
    }

    struct AvatarMinted has copy, drop {
        avatar_id: address,
        owner: address,
        manifest_blob_id: 0x1::string::String,
        preview_blob_id: 0x1::string::String,
        schema_version: u64,
    }

    struct AvatarUpdated has copy, drop {
        avatar_id: address,
        owner: address,
        manifest_blob_id: 0x1::string::String,
        preview_blob_id: 0x1::string::String,
        schema_version: u64,
    }

    struct AvatarChildAttached has copy, drop {
        avatar_id: address,
        owner: address,
        child_object_id: address,
        field_name: 0x1::string::String,
        child_type: 0x1::string::String,
    }

    struct AvatarChildDetached has copy, drop {
        avatar_id: address,
        owner: address,
        child_object_id: address,
        field_name: 0x1::string::String,
        child_type: 0x1::string::String,
    }

    public fun attach_child<T0: store + key>(arg0: &mut Avatar, arg1: 0x1::string::String, arg2: T0, arg3: &0x2::tx_context::TxContext) {
        let v0 = AvatarChildSlot{name: arg1};
        assert!(!0x2::dynamic_object_field::exists_<AvatarChildSlot>(&arg0.id, v0), 0);
        let v1 = 0x2::object::id<T0>(&arg2);
        0x2::dynamic_object_field::add<AvatarChildSlot, T0>(&mut arg0.id, v0, arg2);
        let v2 = 0x2::object::id<Avatar>(arg0);
        let v3 = AvatarChildAttached{
            avatar_id       : 0x2::object::id_to_address(&v2),
            owner           : 0x2::tx_context::sender(arg3),
            child_object_id : 0x2::object::id_to_address(&v1),
            field_name      : v0.name,
            child_type      : 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()))),
        };
        0x2::event::emit<AvatarChildAttached>(v3);
    }

    public fun detach_child<T0: store + key>(arg0: &mut Avatar, arg1: 0x1::string::String, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = AvatarChildSlot{name: arg1};
        assert!(0x2::dynamic_object_field::exists_with_type<AvatarChildSlot, T0>(&arg0.id, v0), 1);
        let v1 = 0x2::dynamic_object_field::remove<AvatarChildSlot, T0>(&mut arg0.id, v0);
        let v2 = 0x2::object::id<T0>(&v1);
        let v3 = 0x2::object::id<Avatar>(arg0);
        let v4 = AvatarChildDetached{
            avatar_id       : 0x2::object::id_to_address(&v3),
            owner           : 0x2::tx_context::sender(arg3),
            child_object_id : 0x2::object::id_to_address(&v2),
            field_name      : v0.name,
            child_type      : 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()))),
        };
        0x2::event::emit<AvatarChildDetached>(v4);
        0x2::transfer::public_transfer<T0>(v1, arg2);
    }

    fun init(arg0: AVATAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<AVATAR>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{preview_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{project_url}"));
        let v5 = 0x2::display::new_with_fields<Avatar>(&v0, v1, v3, arg1);
        0x2::display::update_version<Avatar>(&mut v5);
        0x2::transfer::public_share_object<0x2::display::Display<Avatar>>(v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun manifest_blob_id(arg0: &Avatar) : &0x1::string::String {
        &arg0.manifest_blob_id
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = Avatar{
            id               : 0x2::object::new(arg7),
            name             : arg0,
            description      : arg1,
            manifest_blob_id : arg2,
            preview_blob_id  : arg3,
            preview_url      : arg4,
            project_url      : arg5,
            schema_version   : arg6,
        };
        let v2 = 0x2::object::id<Avatar>(&v1);
        let v3 = AvatarMinted{
            avatar_id        : 0x2::object::id_to_address(&v2),
            owner            : v0,
            manifest_blob_id : v1.manifest_blob_id,
            preview_blob_id  : v1.preview_blob_id,
            schema_version   : v1.schema_version,
        };
        0x2::event::emit<AvatarMinted>(v3);
        0x2::transfer::public_transfer<Avatar>(v1, v0);
    }

    public fun preview_blob_id(arg0: &Avatar) : &0x1::string::String {
        &arg0.preview_blob_id
    }

    public fun preview_url(arg0: &Avatar) : &0x1::string::String {
        &arg0.preview_url
    }

    public fun project_url(arg0: &Avatar) : &0x1::string::String {
        &arg0.project_url
    }

    public fun schema_version(arg0: &Avatar) : u64 {
        arg0.schema_version
    }

    public fun update(arg0: &mut Avatar, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: &0x2::tx_context::TxContext) {
        arg0.name = arg1;
        arg0.description = arg2;
        arg0.manifest_blob_id = arg3;
        arg0.preview_blob_id = arg4;
        arg0.preview_url = arg5;
        arg0.project_url = arg6;
        arg0.schema_version = arg7;
        let v0 = 0x2::object::id<Avatar>(arg0);
        let v1 = AvatarUpdated{
            avatar_id        : 0x2::object::id_to_address(&v0),
            owner            : 0x2::tx_context::sender(arg8),
            manifest_blob_id : arg0.manifest_blob_id,
            preview_blob_id  : arg0.preview_blob_id,
            schema_version   : arg0.schema_version,
        };
        0x2::event::emit<AvatarUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

