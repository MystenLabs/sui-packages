module 0x93e9a32844f273a2531cfacff10688d184a95a2086a868e6fea18ef0325e244d::mint {
    struct KioskInfo has store {
        kiosk: 0x2::object::ID,
        cap: 0x2::object::ID,
    }

    struct MintState has store, key {
        id: 0x2::object::UID,
        kiosks: 0x2::bag::Bag,
    }

    struct ClaimEvent has copy, drop {
        kiosk: 0x2::object::ID,
        claimed_nfts: vector<0x2::object::ID>,
        user_address: address,
    }

    public entry fun claim_and_create_kiosk(arg0: 0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::AtlansuiLab, arg1: &0x2::transfer_policy::TransferPolicy<0x93e9a32844f273a2531cfacff10688d184a95a2086a868e6fea18ef0325e244d::mermaid::Mermaid>, arg2: &mut MintState, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg3);
        let v2 = v0;
        let v3 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v2, v1, arg3);
        if (!0x2::bag::contains<address>(&arg2.kiosks, 0x2::tx_context::sender(arg3))) {
            let v4 = KioskInfo{
                kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(&v2),
                cap   : 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(&v3),
            };
            0x2::bag::add<address, KioskInfo>(&mut arg2.kiosks, 0x2::tx_context::sender(arg3), v4);
        };
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        let v6 = 0x93e9a32844f273a2531cfacff10688d184a95a2086a868e6fea18ef0325e244d::mermaid::mint_nft(0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::get_slot_no(&arg0), arg3);
        0x1::vector::push_back<0x2::object::ID>(&mut v5, 0x2::object::id<0x93e9a32844f273a2531cfacff10688d184a95a2086a868e6fea18ef0325e244d::mermaid::Mermaid>(&v6));
        0x2::kiosk::lock<0x93e9a32844f273a2531cfacff10688d184a95a2086a868e6fea18ef0325e244d::mermaid::Mermaid>(&mut v2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(&v3), arg1, v6);
        0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::burn(arg0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(v3, arg3);
        let v7 = ClaimEvent{
            kiosk        : 0x2::object::id<0x2::kiosk::Kiosk>(&v2),
            claimed_nfts : v5,
            user_address : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ClaimEvent>(v7);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    public entry fun claim_nfts_and_create_kiosk(arg0: vector<0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::AtlansuiLab>, arg1: &0x2::transfer_policy::TransferPolicy<0x93e9a32844f273a2531cfacff10688d184a95a2086a868e6fea18ef0325e244d::mermaid::Mermaid>, arg2: &mut MintState, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg3);
        let v2 = v0;
        let v3 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v2, v1, arg3);
        let v4 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(&v3);
        if (!0x2::bag::contains<address>(&arg2.kiosks, 0x2::tx_context::sender(arg3))) {
            let v5 = KioskInfo{
                kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(&v2),
                cap   : 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(&v3),
            };
            0x2::bag::add<address, KioskInfo>(&mut arg2.kiosks, 0x2::tx_context::sender(arg3), v5);
        };
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        while (0x1::vector::length<0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::AtlansuiLab>(&arg0) > 0) {
            let v7 = 0x1::vector::pop_back<0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::AtlansuiLab>(&mut arg0);
            let v8 = 0x93e9a32844f273a2531cfacff10688d184a95a2086a868e6fea18ef0325e244d::mermaid::mint_nft(0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::get_slot_no(&v7), arg3);
            0x1::vector::push_back<0x2::object::ID>(&mut v6, 0x2::object::id<0x93e9a32844f273a2531cfacff10688d184a95a2086a868e6fea18ef0325e244d::mermaid::Mermaid>(&v8));
            0x2::kiosk::lock<0x93e9a32844f273a2531cfacff10688d184a95a2086a868e6fea18ef0325e244d::mermaid::Mermaid>(&mut v2, v4, arg1, v8);
            0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::burn(v7);
        };
        0x1::vector::destroy_empty<0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::AtlansuiLab>(arg0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(v3, arg3);
        let v9 = ClaimEvent{
            kiosk        : 0x2::object::id<0x2::kiosk::Kiosk>(&v2),
            claimed_nfts : v6,
            user_address : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ClaimEvent>(v9);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    public entry fun claim_to_kiosk(arg0: 0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::AtlansuiLab, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: &0x2::transfer_policy::TransferPolicy<0x93e9a32844f273a2531cfacff10688d184a95a2086a868e6fea18ef0325e244d::mermaid::Mermaid>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::is_personal(arg1), 100);
        let v0 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg2);
        assert!(0x2::kiosk::has_access(arg1, v0), 101);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0x93e9a32844f273a2531cfacff10688d184a95a2086a868e6fea18ef0325e244d::mermaid::mint_nft(0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::get_slot_no(&arg0), arg4);
        0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::id<0x93e9a32844f273a2531cfacff10688d184a95a2086a868e6fea18ef0325e244d::mermaid::Mermaid>(&v2));
        0x2::kiosk::lock<0x93e9a32844f273a2531cfacff10688d184a95a2086a868e6fea18ef0325e244d::mermaid::Mermaid>(arg1, v0, arg3, v2);
        0x68cfca9b88cf98ea8ff2d69f7125d56ea4ef654c180d4fc8d7a2fe5076c478ec::atlansui_lab::burn(arg0);
        let v3 = ClaimEvent{
            kiosk        : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            claimed_nfts : v1,
            user_address : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ClaimEvent>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MintState{
            id     : 0x2::object::new(arg0),
            kiosks : 0x2::bag::new(arg0),
        };
        0x2::transfer::public_share_object<MintState>(v0);
    }

    // decompiled from Move bytecode v6
}

