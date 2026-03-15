module 0xca6a3421cfca2331bce752018283f3a6d66d23b519ddce846f93c76d4043912c::avatar {
    struct AVATAR has drop {
        dummy_field: bool,
    }

    struct MintAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintConfig has store, key {
        id: 0x2::object::UID,
        treasury: address,
        mint_price_mist: u64,
    }

    struct Avatar has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        display_description: 0x1::string::String,
        manifest_blob_id: 0x1::string::String,
        preview_blob_id: 0x1::string::String,
        preview_url: 0x1::string::String,
        image_url: 0x1::string::String,
        project_url: 0x1::string::String,
        url: 0x1::string::String,
        wins: u64,
        losses: u64,
        hp: u64,
        xp: u64,
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
        wins: u64,
        losses: u64,
        hp: u64,
        xp: u64,
        schema_version: u64,
    }

    struct AvatarUpdated has copy, drop {
        avatar_id: address,
        owner: address,
        manifest_blob_id: 0x1::string::String,
        preview_blob_id: 0x1::string::String,
        wins: u64,
        losses: u64,
        hp: u64,
        xp: u64,
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

    struct MintConfigCreated has copy, drop {
        mint_config_id: address,
        treasury: address,
        mint_price_mist: u64,
    }

    struct MintConfigUpdated has copy, drop {
        mint_config_id: address,
        treasury: address,
        mint_price_mist: u64,
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

    public fun bootstrap_mint_config(arg0: 0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Avatar>(&arg0), 4);
        let v0 = 0x2::tx_context::sender(arg1);
        create_mint_admin_objects(v0, arg1);
        0x2::package::burn_publisher(arg0);
    }

    fun create_marketplace_policy(arg0: &0x2::package::Publisher, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<Avatar>(arg0, arg2);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Avatar>>(v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Avatar>>(v1, arg1);
    }

    fun create_mint_admin_objects(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MintConfig{
            id              : 0x2::object::new(arg1),
            treasury        : arg0,
            mint_price_mist : 5000000000,
        };
        let v1 = MintAdminCap{id: 0x2::object::new(arg1)};
        let v2 = 0x2::object::id<MintConfig>(&v0);
        let v3 = MintConfigCreated{
            mint_config_id  : 0x2::object::id_to_address(&v2),
            treasury        : v0.treasury,
            mint_price_mist : v0.mint_price_mist,
        };
        0x2::event::emit<MintConfigCreated>(v3);
        0x2::transfer::public_share_object<MintConfig>(v0);
        0x2::transfer::public_transfer<MintAdminCap>(v1, arg0);
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

    public fun hp(arg0: &Avatar) : u64 {
        arg0.hp
    }

    public fun image_url(arg0: &Avatar) : &0x1::string::String {
        &arg0.image_url
    }

    fun init(arg0: AVATAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<AVATAR>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"link"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{display_description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{url}"));
        let v6 = 0x2::display::new_with_fields<Avatar>(&v1, v2, v4, arg1);
        0x2::display::update_version<Avatar>(&mut v6);
        0x2::transfer::public_share_object<0x2::display::Display<Avatar>>(v6);
        create_marketplace_policy(&v1, v0, arg1);
        create_mint_admin_objects(v0, arg1);
        0x2::package::burn_publisher(v1);
    }

    public fun losses(arg0: &Avatar) : u64 {
        arg0.losses
    }

    public fun manifest_blob_id(arg0: &Avatar) : &0x1::string::String {
        &arg0.manifest_blob_id
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        abort 2
    }

    fun mint_avatar(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = Avatar{
            id                  : 0x2::object::new(arg12),
            name                : arg1,
            description         : arg2,
            display_description : arg3,
            manifest_blob_id    : arg4,
            preview_blob_id     : arg5,
            preview_url         : arg6,
            image_url           : arg6,
            project_url         : arg7,
            url                 : arg7,
            wins                : arg8,
            losses              : arg9,
            hp                  : arg10,
            xp                  : 0,
            schema_version      : normalize_schema_version(arg11),
        };
        let v1 = 0x2::object::id<Avatar>(&v0);
        let v2 = AvatarMinted{
            avatar_id        : 0x2::object::id_to_address(&v1),
            owner            : arg0,
            manifest_blob_id : v0.manifest_blob_id,
            preview_blob_id  : v0.preview_blob_id,
            wins             : v0.wins,
            losses           : v0.losses,
            hp               : v0.hp,
            xp               : v0.xp,
            schema_version   : v0.schema_version,
        };
        0x2::event::emit<AvatarMinted>(v2);
        0x2::transfer::public_transfer<Avatar>(v0, arg0);
    }

    public fun mint_paid(arg0: &MintConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg13);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.mint_price_mist, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.treasury);
        mint_avatar(v0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public fun mint_price_mist(arg0: &MintConfig) : u64 {
        arg0.mint_price_mist
    }

    fun normalize_schema_version(arg0: u64) : u64 {
        if (arg0 < 3) {
            3
        } else {
            arg0
        }
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

    public fun treasury(arg0: &MintConfig) : address {
        arg0.treasury
    }

    public fun update(arg0: &mut Avatar, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::tx_context::TxContext) {
        arg0.name = arg1;
        arg0.description = arg2;
        arg0.display_description = arg3;
        arg0.manifest_blob_id = arg4;
        arg0.preview_blob_id = arg5;
        arg0.preview_url = arg6;
        arg0.image_url = arg6;
        arg0.project_url = arg7;
        arg0.url = arg7;
        arg0.wins = arg8;
        arg0.losses = arg9;
        arg0.hp = arg10;
        arg0.xp = arg11;
        arg0.schema_version = normalize_schema_version(arg12);
        let v0 = 0x2::object::id<Avatar>(arg0);
        let v1 = AvatarUpdated{
            avatar_id        : 0x2::object::id_to_address(&v0),
            owner            : 0x2::tx_context::sender(arg13),
            manifest_blob_id : arg0.manifest_blob_id,
            preview_blob_id  : arg0.preview_blob_id,
            wins             : arg0.wins,
            losses           : arg0.losses,
            hp               : arg0.hp,
            xp               : arg0.xp,
            schema_version   : arg0.schema_version,
        };
        0x2::event::emit<AvatarUpdated>(v1);
    }

    public fun update_mint_config(arg0: &MintAdminCap, arg1: &mut MintConfig, arg2: address, arg3: u64) {
        arg1.treasury = arg2;
        arg1.mint_price_mist = arg3;
        let v0 = 0x2::object::id<MintConfig>(arg1);
        let v1 = MintConfigUpdated{
            mint_config_id  : 0x2::object::id_to_address(&v0),
            treasury        : arg1.treasury,
            mint_price_mist : arg1.mint_price_mist,
        };
        0x2::event::emit<MintConfigUpdated>(v1);
    }

    public fun url(arg0: &Avatar) : &0x1::string::String {
        &arg0.url
    }

    public fun wins(arg0: &Avatar) : u64 {
        arg0.wins
    }

    public fun xp(arg0: &Avatar) : u64 {
        arg0.xp
    }

    // decompiled from Move bytecode v6
}

