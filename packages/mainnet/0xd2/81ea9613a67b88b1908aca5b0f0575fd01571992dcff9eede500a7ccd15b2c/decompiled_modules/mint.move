module 0xd281ea9613a67b88b1908aca5b0f0575fd01571992dcff9eede500a7ccd15b2c::mint {
    struct ClaimEvent has copy, drop {
        kiosk: 0x2::object::ID,
        claimed_nfts: vector<0x2::object::ID>,
        user_address: address,
    }

    public entry fun claim_and_create_kiosk(arg0: 0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::AtlansuiLab, arg1: &0x2::transfer_policy::TransferPolicy<0xd281ea9613a67b88b1908aca5b0f0575fd01571992dcff9eede500a7ccd15b2c::mermaid::Mermaid>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg2);
        let v2 = v0;
        let v3 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v2, v1, arg2);
        let v4 = 0x1::vector::empty<0x2::object::ID>();
        let v5 = 0xd281ea9613a67b88b1908aca5b0f0575fd01571992dcff9eede500a7ccd15b2c::mermaid::mint_nft(0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::get_slot_no(&arg0), arg2);
        0x1::vector::push_back<0x2::object::ID>(&mut v4, 0x2::object::id<0xd281ea9613a67b88b1908aca5b0f0575fd01571992dcff9eede500a7ccd15b2c::mermaid::Mermaid>(&v5));
        0x2::kiosk::lock<0xd281ea9613a67b88b1908aca5b0f0575fd01571992dcff9eede500a7ccd15b2c::mermaid::Mermaid>(&mut v2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(&v3), arg1, v5);
        0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::burn(arg0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(v3, arg2);
        let v6 = ClaimEvent{
            kiosk        : 0x2::object::id<0x2::kiosk::Kiosk>(&v2),
            claimed_nfts : v4,
            user_address : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ClaimEvent>(v6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    public entry fun claim_nfts_and_create_kiosk(arg0: vector<0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::AtlansuiLab>, arg1: &0x2::transfer_policy::TransferPolicy<0xd281ea9613a67b88b1908aca5b0f0575fd01571992dcff9eede500a7ccd15b2c::mermaid::Mermaid>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg2);
        let v2 = v0;
        let v3 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v2, v1, arg2);
        let v4 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(&v3);
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        while (0x1::vector::length<0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::AtlansuiLab>(&arg0) > 0) {
            let v6 = 0x1::vector::pop_back<0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::AtlansuiLab>(&mut arg0);
            let v7 = 0xd281ea9613a67b88b1908aca5b0f0575fd01571992dcff9eede500a7ccd15b2c::mermaid::mint_nft(0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::get_slot_no(&v6), arg2);
            0x1::vector::push_back<0x2::object::ID>(&mut v5, 0x2::object::id<0xd281ea9613a67b88b1908aca5b0f0575fd01571992dcff9eede500a7ccd15b2c::mermaid::Mermaid>(&v7));
            0x2::kiosk::lock<0xd281ea9613a67b88b1908aca5b0f0575fd01571992dcff9eede500a7ccd15b2c::mermaid::Mermaid>(&mut v2, v4, arg1, v7);
            0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::burn(v6);
        };
        0x1::vector::destroy_empty<0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::AtlansuiLab>(arg0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(v3, arg2);
        let v8 = ClaimEvent{
            kiosk        : 0x2::object::id<0x2::kiosk::Kiosk>(&v2),
            claimed_nfts : v5,
            user_address : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ClaimEvent>(v8);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    public entry fun claim_to_kiosk(arg0: 0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::AtlansuiLab, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: &0x2::transfer_policy::TransferPolicy<0xd281ea9613a67b88b1908aca5b0f0575fd01571992dcff9eede500a7ccd15b2c::mermaid::Mermaid>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::is_personal(arg1), 100);
        let v0 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg2);
        assert!(0x2::kiosk::has_access(arg1, v0), 101);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0xd281ea9613a67b88b1908aca5b0f0575fd01571992dcff9eede500a7ccd15b2c::mermaid::mint_nft(0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::get_slot_no(&arg0), arg4);
        0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::id<0xd281ea9613a67b88b1908aca5b0f0575fd01571992dcff9eede500a7ccd15b2c::mermaid::Mermaid>(&v2));
        0x2::kiosk::lock<0xd281ea9613a67b88b1908aca5b0f0575fd01571992dcff9eede500a7ccd15b2c::mermaid::Mermaid>(arg1, v0, arg3, v2);
        0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::burn(arg0);
        let v3 = ClaimEvent{
            kiosk        : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            claimed_nfts : v1,
            user_address : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ClaimEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

