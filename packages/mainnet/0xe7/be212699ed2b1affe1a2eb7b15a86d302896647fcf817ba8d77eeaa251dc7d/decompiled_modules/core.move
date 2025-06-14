module 0xe7be212699ed2b1affe1a2eb7b15a86d302896647fcf817ba8d77eeaa251dc7d::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        0xe7be212699ed2b1affe1a2eb7b15a86d302896647fcf817ba8d77eeaa251dc7d::mint::new_mint(10000, vector[6000, 3000, 750, 250], 8000000000, 10, arg1);
        0xe7be212699ed2b1affe1a2eb7b15a86d302896647fcf817ba8d77eeaa251dc7d::burn::new_burn(vector[5, 4, 3], arg1);
        0xe7be212699ed2b1affe1a2eb7b15a86d302896647fcf817ba8d77eeaa251dc7d::admin::create_admin(arg1);
        let v0 = 0x2::package::claim<CORE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"attributes"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"SAM NFTs enhance our points program by allowing users to earn bonus points. Users can stake their samSUI or other eligible tokens to earn points. Each wallet can stake up to 5 NFTs."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://{image_url}.png"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{attributes}"));
        let v5 = 0x2::display::new_with_fields<0xe7be212699ed2b1affe1a2eb7b15a86d302896647fcf817ba8d77eeaa251dc7d::clover::SamClover>(&v0, v1, v3, arg1);
        0x2::display::update_version<0xe7be212699ed2b1affe1a2eb7b15a86d302896647fcf817ba8d77eeaa251dc7d::clover::SamClover>(&mut v5);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"Sam Chest contains a mystery NFT from one of four tiers: Bronze (60% chance, 2% bonus), Silver (30% chance, 5% bonus), Gold (7.5% chance, 7.5% bonus), or Diamond (2.5% chance, 10% bonus). SAM is a yield aggregator built by Patara Labs."));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://sam.patara.app/chest.gif"));
        let v10 = 0x2::display::new_with_fields<0xe7be212699ed2b1affe1a2eb7b15a86d302896647fcf817ba8d77eeaa251dc7d::chest::SamChest>(&v0, v6, v8, arg1);
        let (v11, v12) = 0x2::transfer_policy::new<0xe7be212699ed2b1affe1a2eb7b15a86d302896647fcf817ba8d77eeaa251dc7d::clover::SamClover>(&v0, arg1);
        let v13 = v12;
        let v14 = v11;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::witness_rule::add<0xe7be212699ed2b1affe1a2eb7b15a86d302896647fcf817ba8d77eeaa251dc7d::clover::SamClover, 0xe7be212699ed2b1affe1a2eb7b15a86d302896647fcf817ba8d77eeaa251dc7d::burn::BURN_RULE>(&mut v14, &v13);
        0x2::display::update_version<0xe7be212699ed2b1affe1a2eb7b15a86d302896647fcf817ba8d77eeaa251dc7d::chest::SamChest>(&mut v10);
        let (v15, v16) = 0x2::transfer_policy::new<0xe7be212699ed2b1affe1a2eb7b15a86d302896647fcf817ba8d77eeaa251dc7d::clover::SamClover>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0xe7be212699ed2b1affe1a2eb7b15a86d302896647fcf817ba8d77eeaa251dc7d::clover::SamClover>>(v16, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0xe7be212699ed2b1affe1a2eb7b15a86d302896647fcf817ba8d77eeaa251dc7d::clover::SamClover>>(v13, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0xe7be212699ed2b1affe1a2eb7b15a86d302896647fcf817ba8d77eeaa251dc7d::clover::SamClover>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0xe7be212699ed2b1affe1a2eb7b15a86d302896647fcf817ba8d77eeaa251dc7d::chest::SamChest>>(v10, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0xe7be212699ed2b1affe1a2eb7b15a86d302896647fcf817ba8d77eeaa251dc7d::clover::SamClover>>(v14);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0xe7be212699ed2b1affe1a2eb7b15a86d302896647fcf817ba8d77eeaa251dc7d::clover::SamClover>>(v15);
    }

    // decompiled from Move bytecode v6
}

