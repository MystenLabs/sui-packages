module 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::ika_dwallet_2pc_mpc_display {
    struct ObjectDisplay has key {
        id: 0x2::object::UID,
        inner: 0x2::object_bag::ObjectBag,
    }

    struct PublisherKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun create(arg0: 0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_bag::new(arg7);
        let v1 = init_dwallet_cap_display(&arg0, arg1, arg7);
        0x2::object_bag::add<0x1::type_name::TypeName, 0x2::display::Display<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>>(&mut v0, 0x1::type_name::get<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(), v1);
        let v2 = init_imported_key_dwallet_cap_display(&arg0, arg2, arg7);
        0x2::object_bag::add<0x1::type_name::TypeName, 0x2::display::Display<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyDWalletCap>>(&mut v0, 0x1::type_name::get<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyDWalletCap>(), v2);
        let v3 = init_unverified_presign_cap_display(&arg0, arg3, arg7);
        0x2::object_bag::add<0x1::type_name::TypeName, 0x2::display::Display<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>>(&mut v0, 0x1::type_name::get<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(), v3);
        let v4 = init_verified_presign_cap_display(&arg0, arg4, arg7);
        0x2::object_bag::add<0x1::type_name::TypeName, 0x2::display::Display<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPresignCap>>(&mut v0, 0x1::type_name::get<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPresignCap>(), v4);
        let v5 = init_unverified_partial_user_signature_cap_display(&arg0, arg5, arg7);
        0x2::object_bag::add<0x1::type_name::TypeName, 0x2::display::Display<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap>>(&mut v0, 0x1::type_name::get<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap>(), v5);
        let v6 = init_verified_partial_user_signature_cap_display(&arg0, arg6, arg7);
        0x2::object_bag::add<0x1::type_name::TypeName, 0x2::display::Display<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPartialUserSignatureCap>>(&mut v0, 0x1::type_name::get<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPartialUserSignatureCap>(), v6);
        let v7 = PublisherKey{dummy_field: false};
        0x2::object_bag::add<PublisherKey, 0x2::package::Publisher>(&mut v0, v7, arg0);
        let v8 = ObjectDisplay{
            id    : 0x2::object::new(arg7),
            inner : v0,
        };
        0x2::transfer::share_object<ObjectDisplay>(v8);
    }

    fun init_dwallet_cap_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap> {
        let v0 = 0x2::display::new<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(arg0, arg2);
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"DWallet Cap"));
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"DWallet cap for: {dwallet_id}"));
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut v0, 0x1::string::utf8(b"image_url"), arg1);
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut v0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://ika.xyz/"));
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut v0, 0x1::string::utf8(b"link"), 0x1::string::utf8(b""));
        0x2::display::update_version<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut v0);
        v0
    }

    fun init_imported_key_dwallet_cap_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyDWalletCap> {
        let v0 = 0x2::display::new<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyDWalletCap>(arg0, arg2);
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyDWalletCap>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Imported Key DWallet Cap"));
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyDWalletCap>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Imported key dWallet cap for: {dwallet_id}"));
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyDWalletCap>(&mut v0, 0x1::string::utf8(b"image_url"), arg1);
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyDWalletCap>(&mut v0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://ika.xyz/"));
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyDWalletCap>(&mut v0, 0x1::string::utf8(b"link"), 0x1::string::utf8(b""));
        0x2::display::update_version<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyDWalletCap>(&mut v0);
        v0
    }

    fun init_unverified_partial_user_signature_cap_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap> {
        let v0 = 0x2::display::new<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap>(arg0, arg2);
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Unverified Partial User Signature Cap"));
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Unverified partial user signature cap for: {partial_centralized_signed_message_id}"));
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap>(&mut v0, 0x1::string::utf8(b"image_url"), arg1);
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap>(&mut v0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://ika.xyz/"));
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap>(&mut v0, 0x1::string::utf8(b"link"), 0x1::string::utf8(b""));
        0x2::display::update_version<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap>(&mut v0);
        v0
    }

    fun init_unverified_presign_cap_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap> {
        let v0 = 0x2::display::new<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(arg0, arg2);
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Unverified Presign Cap"));
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Unverified presign cap for: {presign_id}, dWallet: {dwallet_id}"));
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&mut v0, 0x1::string::utf8(b"image_url"), arg1);
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&mut v0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://ika.xyz/"));
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&mut v0, 0x1::string::utf8(b"link"), 0x1::string::utf8(b""));
        0x2::display::update_version<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&mut v0);
        v0
    }

    fun init_verified_partial_user_signature_cap_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPartialUserSignatureCap> {
        let v0 = 0x2::display::new<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPartialUserSignatureCap>(arg0, arg2);
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPartialUserSignatureCap>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Verified Partial User Signature Cap"));
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPartialUserSignatureCap>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Verified partial user signature cap for: {partial_centralized_signed_message_id}"));
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPartialUserSignatureCap>(&mut v0, 0x1::string::utf8(b"image_url"), arg1);
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPartialUserSignatureCap>(&mut v0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://ika.xyz/"));
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPartialUserSignatureCap>(&mut v0, 0x1::string::utf8(b"link"), 0x1::string::utf8(b""));
        0x2::display::update_version<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPartialUserSignatureCap>(&mut v0);
        v0
    }

    fun init_verified_presign_cap_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPresignCap> {
        let v0 = 0x2::display::new<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPresignCap>(arg0, arg2);
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPresignCap>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Verified Presign Cap"));
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPresignCap>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Verified presign cap for: {presign_id}, dWallet: {dwallet_id}"));
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPresignCap>(&mut v0, 0x1::string::utf8(b"image_url"), arg1);
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPresignCap>(&mut v0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://ika.xyz/"));
        0x2::display::add<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPresignCap>(&mut v0, 0x1::string::utf8(b"link"), 0x1::string::utf8(b""));
        0x2::display::update_version<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPresignCap>(&mut v0);
        v0
    }

    // decompiled from Move bytecode v6
}

