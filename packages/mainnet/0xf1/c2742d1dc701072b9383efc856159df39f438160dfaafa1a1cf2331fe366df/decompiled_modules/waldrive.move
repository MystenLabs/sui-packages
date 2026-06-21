module 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::waldrive {
    struct WALDRIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALDRIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<WALDRIVE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Encrypted file stored on Walrus. Size: {size} bytes."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://waldrive.xyz/file-icon.png"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://waldrive.xyz"));
        let v5 = 0x2::display::new_with_fields<0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::file_registry::FileObject>(&v0, v1, v3, arg1);
        0x2::display::update_version<0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::file_registry::FileObject>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::file_registry::FileObject>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"project_url"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"Waldrive {tier_name} Plan"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"Storage: {storage_used}/{storage_limit} bytes | Files: {file_count}/{max_files} | Shares: {share_count}/{max_shares}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://waldrive.xyz/plan-icon.png"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://waldrive.xyz"));
        let v10 = 0x2::display::new_with_fields<0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::subscription::UserSubscription>(&v0, v6, v8, arg1);
        0x2::display::update_version<0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::subscription::UserSubscription>(&mut v10);
        0x2::transfer::public_transfer<0x2::display::Display<0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::subscription::UserSubscription>>(v10, 0x2::tx_context::sender(arg1));
        let v11 = 0x1::vector::empty<0x1::string::String>();
        let v12 = &mut v11;
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"project_url"));
        let v13 = 0x1::vector::empty<0x1::string::String>();
        let v14 = &mut v13;
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"Waldrive collection. {description}"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"https://waldrive.xyz/collection-icon.png"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"https://waldrive.xyz"));
        let v15 = 0x2::display::new_with_fields<0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::collections::Collection>(&v0, v11, v13, arg1);
        0x2::display::update_version<0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::collections::Collection>(&mut v15);
        0x2::transfer::public_transfer<0x2::display::Display<0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::collections::Collection>>(v15, 0x2::tx_context::sender(arg1));
        let v16 = 0x1::vector::empty<0x1::string::String>();
        let v17 = &mut v16;
        0x1::vector::push_back<0x1::string::String>(v17, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v17, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v17, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v17, 0x1::string::utf8(b"project_url"));
        let v18 = 0x1::vector::empty<0x1::string::String>();
        let v19 = &mut v18;
        0x1::vector::push_back<0x1::string::String>(v19, 0x1::string::utf8(b"Share: {label}"));
        0x1::vector::push_back<0x1::string::String>(v19, 0x1::string::utf8(b"Shared file link. Permission: {permission}. Expires: {expires_at_ms}ms."));
        0x1::vector::push_back<0x1::string::String>(v19, 0x1::string::utf8(b"https://waldrive.xyz/share-icon.png"));
        0x1::vector::push_back<0x1::string::String>(v19, 0x1::string::utf8(b"https://waldrive.xyz"));
        let v20 = 0x2::display::new_with_fields<0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::sharing::ShareLink>(&v0, v16, v18, arg1);
        0x2::display::update_version<0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::sharing::ShareLink>(&mut v20);
        0x2::transfer::public_transfer<0x2::display::Display<0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::sharing::ShareLink>>(v20, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

