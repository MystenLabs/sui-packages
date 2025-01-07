module 0xca5fb99af8ee7f40da48ed782107b40c8d669f17b85c76d7af7aec856d430f34::mint {
    struct KioskInfo has store {
        kiosk: 0x2::object::ID,
        cap: 0x2::object::ID,
    }

    struct MintMetadata has drop, store {
        attribute_keys: vector<0x1::ascii::String>,
        attribute_values: vector<0x1::ascii::String>,
    }

    struct MintState has store, key {
        id: 0x2::object::UID,
        kiosks: 0x2::table::Table<address, KioskInfo>,
        nft_table_by_id: 0x2::table::Table<u64, MintMetadata>,
        claimed: u64,
    }

    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    struct ClaimEvent has copy, drop {
        kiosk: 0x2::object::ID,
        claimed_nfts: vector<0x2::object::ID>,
        user_address: address,
    }

    public entry fun add_metadata_by_id(arg0: &OperatorCap, arg1: &mut MintState, arg2: u64, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x1::ascii::String>(&arg3) == 0x1::vector::length<0x1::ascii::String>(&arg4), 1);
        let v0 = MintMetadata{
            attribute_keys   : arg3,
            attribute_values : arg4,
        };
        0x2::table::add<u64, MintMetadata>(&mut arg1.nft_table_by_id, arg2, v0);
    }

    public entry fun claim_and_create_kiosk(arg0: 0x56d2bf0e2808c3771dd7187b6af84f88c4bb3709d0fd94eac659cd341e27dd2d::atlansui_lab::AtlansuiLab, arg1: &0x2::transfer_policy::TransferPolicy<0xca5fb99af8ee7f40da48ed782107b40c8d669f17b85c76d7af7aec856d430f34::mermaid::Mermaid>, arg2: &mut MintState, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg3);
        let v2 = v0;
        let v3 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v2, v1, arg3);
        if (!0x2::table::contains<address, KioskInfo>(&arg2.kiosks, 0x2::tx_context::sender(arg3))) {
            let v4 = KioskInfo{
                kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(&v2),
                cap   : 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(&v3),
            };
            0x2::table::add<address, KioskInfo>(&mut arg2.kiosks, 0x2::tx_context::sender(arg3), v4);
        };
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        let v6 = 0x56d2bf0e2808c3771dd7187b6af84f88c4bb3709d0fd94eac659cd341e27dd2d::atlansui_lab::get_slot_no(&arg0);
        let v7 = get_metadata_by_id(arg2, v6);
        let MintMetadata {
            attribute_keys   : v8,
            attribute_values : v9,
        } = v7;
        let v10 = 0xca5fb99af8ee7f40da48ed782107b40c8d669f17b85c76d7af7aec856d430f34::mermaid::mint_nft(v6, v8, v9, arg3);
        0x1::vector::push_back<0x2::object::ID>(&mut v5, 0x2::object::id<0xca5fb99af8ee7f40da48ed782107b40c8d669f17b85c76d7af7aec856d430f34::mermaid::Mermaid>(&v10));
        0x2::kiosk::lock<0xca5fb99af8ee7f40da48ed782107b40c8d669f17b85c76d7af7aec856d430f34::mermaid::Mermaid>(&mut v2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(&v3), arg1, v10);
        0x56d2bf0e2808c3771dd7187b6af84f88c4bb3709d0fd94eac659cd341e27dd2d::atlansui_lab::burn(arg0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(v3, arg3);
        arg2.claimed = arg2.claimed + 1;
        let v11 = ClaimEvent{
            kiosk        : 0x2::object::id<0x2::kiosk::Kiosk>(&v2),
            claimed_nfts : v5,
            user_address : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ClaimEvent>(v11);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    public entry fun claim_nfts_and_create_kiosk(arg0: vector<0x56d2bf0e2808c3771dd7187b6af84f88c4bb3709d0fd94eac659cd341e27dd2d::atlansui_lab::AtlansuiLab>, arg1: &0x2::transfer_policy::TransferPolicy<0xca5fb99af8ee7f40da48ed782107b40c8d669f17b85c76d7af7aec856d430f34::mermaid::Mermaid>, arg2: &mut MintState, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg3);
        let v2 = v0;
        let v3 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v2, v1, arg3);
        let v4 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(&v3);
        if (!0x2::table::contains<address, KioskInfo>(&arg2.kiosks, 0x2::tx_context::sender(arg3))) {
            let v5 = KioskInfo{
                kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(&v2),
                cap   : 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(&v3),
            };
            0x2::table::add<address, KioskInfo>(&mut arg2.kiosks, 0x2::tx_context::sender(arg3), v5);
        };
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        while (0x1::vector::length<0x56d2bf0e2808c3771dd7187b6af84f88c4bb3709d0fd94eac659cd341e27dd2d::atlansui_lab::AtlansuiLab>(&arg0) > 0) {
            let v7 = 0x1::vector::pop_back<0x56d2bf0e2808c3771dd7187b6af84f88c4bb3709d0fd94eac659cd341e27dd2d::atlansui_lab::AtlansuiLab>(&mut arg0);
            let v8 = 0x56d2bf0e2808c3771dd7187b6af84f88c4bb3709d0fd94eac659cd341e27dd2d::atlansui_lab::get_slot_no(&v7);
            let v9 = get_metadata_by_id(arg2, v8);
            let MintMetadata {
                attribute_keys   : v10,
                attribute_values : v11,
            } = v9;
            let v12 = 0xca5fb99af8ee7f40da48ed782107b40c8d669f17b85c76d7af7aec856d430f34::mermaid::mint_nft(v8, v10, v11, arg3);
            0x1::vector::push_back<0x2::object::ID>(&mut v6, 0x2::object::id<0xca5fb99af8ee7f40da48ed782107b40c8d669f17b85c76d7af7aec856d430f34::mermaid::Mermaid>(&v12));
            0x2::kiosk::lock<0xca5fb99af8ee7f40da48ed782107b40c8d669f17b85c76d7af7aec856d430f34::mermaid::Mermaid>(&mut v2, v4, arg1, v12);
            0x56d2bf0e2808c3771dd7187b6af84f88c4bb3709d0fd94eac659cd341e27dd2d::atlansui_lab::burn(v7);
            arg2.claimed = arg2.claimed + 1;
        };
        0x1::vector::destroy_empty<0x56d2bf0e2808c3771dd7187b6af84f88c4bb3709d0fd94eac659cd341e27dd2d::atlansui_lab::AtlansuiLab>(arg0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(v3, arg3);
        let v13 = ClaimEvent{
            kiosk        : 0x2::object::id<0x2::kiosk::Kiosk>(&v2),
            claimed_nfts : v6,
            user_address : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ClaimEvent>(v13);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    public entry fun claim_special_to_kiosk(arg0: &OperatorCap, arg1: address, arg2: &0x2::transfer_policy::TransferPolicy<0xca5fb99af8ee7f40da48ed782107b40c8d669f17b85c76d7af7aec856d430f34::mermaid::Mermaid>, arg3: u64, arg4: vector<u8>, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg7);
        let v2 = v1;
        let v3 = v0;
        0x2::kiosk::set_owner_custom(&mut v3, &v2, arg1);
        0x2::kiosk::lock<0xca5fb99af8ee7f40da48ed782107b40c8d669f17b85c76d7af7aec856d430f34::mermaid::Mermaid>(&mut v3, &v2, arg2, 0xca5fb99af8ee7f40da48ed782107b40c8d669f17b85c76d7af7aec856d430f34::mermaid::mint_special_nft(arg3, arg4, arg5, arg6, arg7));
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, arg1);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
    }

    public entry fun claim_to_kiosk(arg0: 0x56d2bf0e2808c3771dd7187b6af84f88c4bb3709d0fd94eac659cd341e27dd2d::atlansui_lab::AtlansuiLab, arg1: &mut MintState, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: &0x2::transfer_policy::TransferPolicy<0xca5fb99af8ee7f40da48ed782107b40c8d669f17b85c76d7af7aec856d430f34::mermaid::Mermaid>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::is_personal(arg2), 100);
        let v0 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3);
        assert!(0x2::kiosk::has_access(arg2, v0), 101);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0x56d2bf0e2808c3771dd7187b6af84f88c4bb3709d0fd94eac659cd341e27dd2d::atlansui_lab::get_slot_no(&arg0);
        let v3 = get_metadata_by_id(arg1, v2);
        let MintMetadata {
            attribute_keys   : v4,
            attribute_values : v5,
        } = v3;
        let v6 = 0xca5fb99af8ee7f40da48ed782107b40c8d669f17b85c76d7af7aec856d430f34::mermaid::mint_nft(v2, v4, v5, arg5);
        0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::id<0xca5fb99af8ee7f40da48ed782107b40c8d669f17b85c76d7af7aec856d430f34::mermaid::Mermaid>(&v6));
        0x2::kiosk::lock<0xca5fb99af8ee7f40da48ed782107b40c8d669f17b85c76d7af7aec856d430f34::mermaid::Mermaid>(arg2, v0, arg4, v6);
        0x56d2bf0e2808c3771dd7187b6af84f88c4bb3709d0fd94eac659cd341e27dd2d::atlansui_lab::burn(arg0);
        arg1.claimed = arg1.claimed + 1;
        let v7 = ClaimEvent{
            kiosk        : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            claimed_nfts : v1,
            user_address : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<ClaimEvent>(v7);
    }

    fun get_metadata_by_id(arg0: &mut MintState, arg1: u64) : MintMetadata {
        0x2::table::remove<u64, MintMetadata>(&mut arg0.nft_table_by_id, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = MintState{
            id              : 0x2::object::new(arg0),
            kiosks          : 0x2::table::new<address, KioskInfo>(arg0),
            nft_table_by_id : 0x2::table::new<u64, MintMetadata>(arg0),
            claimed         : 0,
        };
        0x2::transfer::public_share_object<MintState>(v1);
    }

    // decompiled from Move bytecode v6
}

