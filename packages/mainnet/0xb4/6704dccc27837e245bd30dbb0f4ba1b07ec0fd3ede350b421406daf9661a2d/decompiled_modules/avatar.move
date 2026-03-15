module 0xb46704dccc27837e245bd30dbb0f4ba1b07ec0fd3ede350b421406daf9661a2d::avatar {
    struct AVATAR has drop {
        dummy_field: bool,
    }

    struct Avatar has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        display_description: 0x1::string::String,
        manifest_blob_id: 0x1::string::String,
        preview_blob_id: 0x1::string::String,
        preview_url: 0x1::string::String,
        project_url: 0x1::string::String,
        wins: u64,
        losses: u64,
        hp: u64,
        schema_version: u64,
    }

    struct AvatarAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AvatarMintTreasury has store, key {
        id: 0x2::object::UID,
        mint_price_mist: u64,
        mint_enabled: bool,
        fees: 0x2::balance::Balance<0x2::sui::SUI>,
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

    struct MintConfigUpdated has copy, drop {
        mint_price_mist: u64,
        mint_enabled: bool,
    }

    struct MintFeesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
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

    public fun hp(arg0: &Avatar) : u64 {
        arg0.hp
    }

    fun init(arg0: AVATAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<AVATAR>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{display_description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{preview_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{preview_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{preview_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{project_url}"));
        let v5 = 0x2::display::new_with_fields<Avatar>(&v0, v1, v3, arg1);
        0x2::display::update_version<Avatar>(&mut v5);
        0x2::transfer::public_share_object<0x2::display::Display<Avatar>>(v5);
        let (v6, v7) = 0x2::transfer_policy::new<Avatar>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Avatar>>(v6);
        let v8 = AvatarAdminCap{id: 0x2::object::new(arg1)};
        let v9 = AvatarMintTreasury{
            id              : 0x2::object::new(arg1),
            mint_price_mist : 0,
            mint_enabled    : true,
            fees            : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::public_share_object<AvatarMintTreasury>(v9);
        0x2::transfer::public_transfer<AvatarAdminCap>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Avatar>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun losses(arg0: &Avatar) : u64 {
        arg0.losses
    }

    public fun manifest_blob_id(arg0: &Avatar) : &0x1::string::String {
        &arg0.manifest_blob_id
    }

    public fun mint(arg0: &mut AvatarMintTreasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(arg0.mint_enabled, 2);
        assert!(v1 >= arg0.mint_price_mist, 3);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.fees, arg1);
        let v2 = v1 - arg0.mint_price_mist;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.fees, v2, arg13), v0);
        };
        let v3 = Avatar{
            id                  : 0x2::object::new(arg13),
            name                : arg2,
            description         : arg3,
            display_description : arg4,
            manifest_blob_id    : arg5,
            preview_blob_id     : arg6,
            preview_url         : arg7,
            project_url         : arg8,
            wins                : arg9,
            losses              : arg10,
            hp                  : arg11,
            schema_version      : arg12,
        };
        let v4 = 0x2::object::id<Avatar>(&v3);
        let v5 = AvatarMinted{
            avatar_id        : 0x2::object::id_to_address(&v4),
            owner            : v0,
            manifest_blob_id : v3.manifest_blob_id,
            preview_blob_id  : v3.preview_blob_id,
            wins             : v3.wins,
            losses           : v3.losses,
            hp               : v3.hp,
            schema_version   : v3.schema_version,
        };
        0x2::event::emit<AvatarMinted>(v5);
        0x2::transfer::public_transfer<Avatar>(v3, v0);
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

    public fun set_mint_enabled(arg0: &mut AvatarMintTreasury, arg1: &AvatarAdminCap, arg2: bool) {
        arg0.mint_enabled = arg2;
        let v0 = MintConfigUpdated{
            mint_price_mist : arg0.mint_price_mist,
            mint_enabled    : arg0.mint_enabled,
        };
        0x2::event::emit<MintConfigUpdated>(v0);
    }

    public fun set_mint_price(arg0: &mut AvatarMintTreasury, arg1: &AvatarAdminCap, arg2: u64) {
        arg0.mint_price_mist = arg2;
        let v0 = MintConfigUpdated{
            mint_price_mist : arg0.mint_price_mist,
            mint_enabled    : arg0.mint_enabled,
        };
        0x2::event::emit<MintConfigUpdated>(v0);
    }

    public fun update(arg0: &mut Avatar, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::tx_context::TxContext) {
        arg0.name = arg1;
        arg0.description = arg2;
        arg0.display_description = arg3;
        arg0.manifest_blob_id = arg4;
        arg0.preview_blob_id = arg5;
        arg0.preview_url = arg6;
        arg0.project_url = arg7;
        arg0.wins = arg8;
        arg0.losses = arg9;
        arg0.hp = arg10;
        arg0.schema_version = arg11;
        let v0 = 0x2::object::id<Avatar>(arg0);
        let v1 = AvatarUpdated{
            avatar_id        : 0x2::object::id_to_address(&v0),
            owner            : 0x2::tx_context::sender(arg12),
            manifest_blob_id : arg0.manifest_blob_id,
            preview_blob_id  : arg0.preview_blob_id,
            wins             : arg0.wins,
            losses           : arg0.losses,
            hp               : arg0.hp,
            schema_version   : arg0.schema_version,
        };
        0x2::event::emit<AvatarUpdated>(v1);
    }

    public fun wins(arg0: &Avatar) : u64 {
        arg0.wins
    }

    public fun withdraw_fees(arg0: &mut AvatarMintTreasury, arg1: &AvatarAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fees);
        let v1 = MintFeesWithdrawn{
            amount    : v0,
            recipient : arg2,
        };
        0x2::event::emit<MintFeesWithdrawn>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.fees, v0, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

