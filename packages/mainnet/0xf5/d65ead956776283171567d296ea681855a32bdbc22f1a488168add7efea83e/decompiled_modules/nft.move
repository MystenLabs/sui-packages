module 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct MintConfig has key {
        id: 0x2::object::UID,
        backend_public_key: vector<u8>,
    }

    struct RevealConfig has key {
        id: 0x2::object::UID,
        backend_public_key: vector<u8>,
    }

    struct TimeCapsuleNFT has store, key {
        id: 0x2::object::UID,
        mint_sequence: u64,
        registry_id: 0x2::object::ID,
        recipient_address: address,
        tier: 0x1::option::Option<u64>,
        campaign_id: vector<u8>,
        campaign_slug: 0x1::string::String,
        event_name: 0x1::string::String,
        prize_name: 0x1::string::String,
        prize_description: 0x1::string::String,
        image_path: 0x1::string::String,
        has_physical_prize: 0x1::option::Option<bool>,
        physical_prize_name: 0x1::option::Option<0x1::string::String>,
        physical_prize_description: 0x1::option::Option<0x1::string::String>,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct NFTMinted has copy, drop {
        nft_object_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        mint_sequence: u64,
        recipient_address: address,
    }

    struct NFTRevealed has copy, drop {
        nft_object_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        mint_sequence: u64,
        tier_level: u64,
        recipient_address: address,
    }

    fun create_mint_message(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"MINT");
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x2::hash::keccak256(&v0)
    }

    fun create_reveal_message(arg0: 0x2::object::ID, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"REVEAL");
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x2::hash::keccak256(&v0)
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = x"80acff5df06d38c7149b5367cbc89475158089c1f8d53ae8edfb8c8821005fce";
        let v2 = MintConfig{
            id                 : 0x2::object::new(arg1),
            backend_public_key : v1,
        };
        0x2::transfer::share_object<MintConfig>(v2);
        let v3 = RevealConfig{
            id                 : 0x2::object::new(arg1),
            backend_public_key : v1,
        };
        0x2::transfer::share_object<RevealConfig>(v3);
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"attributes"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"creator"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{prize_name} #{mint_sequence} - {event_name}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{prize_description}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://content.liquidplus.com/liquid-vault/{campaign_slug}/{image_path}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{attributes}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://teamliquid.com/liquid-vault"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Team Liquid"));
        let v8 = 0x2::display::new_with_fields<TimeCapsuleNFT>(&v0, v4, v6, arg1);
        0x2::display::update_version<TimeCapsuleNFT>(&mut v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TimeCapsuleNFT>>(v8, 0x2::tx_context::sender(arg1));
    }

    fun integer_to_ascii(arg0: u8) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, arg0 % 10 + 48);
            arg0 = arg0 / 10;
        };
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::length<u8>(&v0);
        while (v2 > 0) {
            v2 = v2 - 1;
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
        };
        v1
    }

    fun integer_to_string(arg0: u8) : 0x1::string::String {
        0x1::string::utf8(integer_to_ascii(arg0))
    }

    public fun is_revealed(arg0: &TimeCapsuleNFT) : bool {
        0x1::option::is_some<u64>(&arg0.tier)
    }

    fun mint_nft_internal(arg0: &mut 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::Registry, arg1: &mut 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::global_kiosk_registry::GlobalKioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<TimeCapsuleNFT>, arg3: &MintConfig, arg4: address, arg5: u64, arg6: vector<u8>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 == 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::get_user_nonce(arg0, arg4), 2);
        assert!(!0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::is_paused(arg0), 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::common::campaign_paused());
        assert!(0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::is_in_claim_phase(arg0), 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::common::campaign_not_in_claim());
        assert!(!0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::has_claimed_address(arg0, arg4), 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::common::not_authorized());
        let v0 = 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::minted_count(arg0);
        assert!(v0 < 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::total_supply(arg0), 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::common::supply_exceeded());
        let v1 = v0 + 1;
        let v2 = create_mint_message(0x2::object::id<0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::Registry>(arg0), arg4, arg5, arg7);
        assert!(verify_signature_with_timestamp(&arg6, &arg3.backend_public_key, &v2, arg5, arg8), 1);
        0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::increment_user_nonce(arg0, arg4);
        0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::create_mint_record(arg0, v1, arg4, arg9);
        let (_, v4, v5, v6, _, _, _) = 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::registry_details(arg0);
        let v10 = 0x1::string::utf8(v5);
        let v11 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v11, 0x1::string::utf8(b"Campaign"), v10);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v11, 0x1::string::utf8(b"Number"), 0x1::u64::to_string(v1));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v11, 0x1::string::utf8(b"Status"), 0x1::string::utf8(b"Unrevealed"));
        let v12 = TimeCapsuleNFT{
            id                         : 0x2::object::new(arg9),
            mint_sequence              : v1,
            registry_id                : 0x2::object::id<0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::Registry>(arg0),
            recipient_address          : arg4,
            tier                       : 0x1::option::none<u64>(),
            campaign_id                : v4,
            campaign_slug              : 0x1::string::utf8(v6),
            event_name                 : v10,
            prize_name                 : 0x1::string::utf8(b"Team Liquid Time Capsule"),
            prize_description          : 0x1::string::utf8(b"Team Liquid Time Capsule. Not yet revealed"),
            image_path                 : 0x1::string::utf8(b"loading.webp"),
            has_physical_prize         : 0x1::option::none<bool>(),
            physical_prize_name        : 0x1::option::none<0x1::string::String>(),
            physical_prize_description : 0x1::option::none<0x1::string::String>(),
            attributes                 : v11,
        };
        let v13 = 0x2::object::uid_to_inner(&v12.id);
        0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::link_nft_object(arg0, v1, v13);
        if (0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::global_kiosk_registry::has_user_kiosk(arg1, arg4)) {
            0x2::transfer::transfer<TimeCapsuleNFT>(v12, arg4);
        } else {
            let (v14, v15) = 0x2::kiosk::new(arg9);
            let v16 = v15;
            let v17 = v14;
            0x2::kiosk::lock<TimeCapsuleNFT>(&mut v17, &v16, arg2, v12);
            0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v17);
            0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::global_kiosk_registry::set_user_kiosk(arg1, arg4, 0x2::object::id<0x2::kiosk::Kiosk>(&v17), &v16, arg9);
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v16, arg4);
        };
        let v18 = NFTMinted{
            nft_object_id     : v13,
            registry_id       : 0x2::object::id<0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::Registry>(arg0),
            mint_sequence     : v1,
            recipient_address : arg4,
        };
        0x2::event::emit<NFTMinted>(v18);
    }

    public entry fun mint_nft_to_kiosk(arg0: &mut 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::Registry, arg1: &0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::global_kiosk_registry::GlobalKioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<TimeCapsuleNFT>, arg3: &MintConfig, arg4: address, arg5: u64, arg6: vector<u8>, arg7: u64, arg8: &mut 0x2::kiosk::Kiosk, arg9: &0x2::kiosk::KioskOwnerCap, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        mint_nft_to_kiosk_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    fun mint_nft_to_kiosk_internal(arg0: &mut 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::Registry, arg1: &0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::global_kiosk_registry::GlobalKioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<TimeCapsuleNFT>, arg3: &MintConfig, arg4: address, arg5: u64, arg6: vector<u8>, arg7: u64, arg8: &mut 0x2::kiosk::Kiosk, arg9: &0x2::kiosk::KioskOwnerCap, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 == 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::get_user_nonce(arg0, arg4), 2);
        assert!(!0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::is_paused(arg0), 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::common::campaign_paused());
        assert!(0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::is_in_claim_phase(arg0), 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::common::campaign_not_in_claim());
        assert!(!0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::has_claimed_address(arg0, arg4), 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::common::not_authorized());
        let v0 = 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::minted_count(arg0);
        assert!(v0 < 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::total_supply(arg0), 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::common::supply_exceeded());
        let v1 = v0 + 1;
        let v2 = create_mint_message(0x2::object::id<0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::Registry>(arg0), arg4, arg5, arg7);
        assert!(verify_signature_with_timestamp(&arg6, &arg3.backend_public_key, &v2, arg5, arg10), 1);
        let v3 = 0x2::object::id<0x2::kiosk::Kiosk>(arg8);
        assert!(0x2::kiosk::kiosk_owner_cap_for(arg9) == v3, 999);
        assert!(0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::global_kiosk_registry::has_user_kiosk(arg1, arg4), 998);
        assert!(0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::global_kiosk_registry::get_user_kiosk_or_fail(arg1, arg4) == v3, 997);
        0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::increment_user_nonce(arg0, arg4);
        0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::create_mint_record(arg0, v1, arg4, arg11);
        let (_, v5, v6, v7, _, _, _) = 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::registry_details(arg0);
        let v11 = 0x1::string::utf8(v6);
        let v12 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v12, 0x1::string::utf8(b"Campaign"), v11);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v12, 0x1::string::utf8(b"Number"), 0x1::u64::to_string(v1));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v12, 0x1::string::utf8(b"Status"), 0x1::string::utf8(b"Unrevealed"));
        let v13 = TimeCapsuleNFT{
            id                         : 0x2::object::new(arg11),
            mint_sequence              : v1,
            registry_id                : 0x2::object::id<0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::Registry>(arg0),
            recipient_address          : arg4,
            tier                       : 0x1::option::none<u64>(),
            campaign_id                : v5,
            campaign_slug              : 0x1::string::utf8(v7),
            event_name                 : v11,
            prize_name                 : 0x1::string::utf8(b"Team Liquid Time Capsule"),
            prize_description          : 0x1::string::utf8(b"Team Liquid Time Capsule. Not yet revealed"),
            image_path                 : 0x1::string::utf8(b"loading.webp"),
            has_physical_prize         : 0x1::option::none<bool>(),
            physical_prize_name        : 0x1::option::none<0x1::string::String>(),
            physical_prize_description : 0x1::option::none<0x1::string::String>(),
            attributes                 : v12,
        };
        let v14 = 0x2::object::uid_to_inner(&v13.id);
        0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::link_nft_object(arg0, v1, v14);
        0x2::kiosk::lock<TimeCapsuleNFT>(arg8, arg9, arg2, v13);
        let v15 = NFTMinted{
            nft_object_id     : v14,
            registry_id       : 0x2::object::id<0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::Registry>(arg0),
            mint_sequence     : v1,
            recipient_address : arg4,
        };
        0x2::event::emit<NFTMinted>(v15);
    }

    public entry fun mint_nft_with_signature(arg0: &mut 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::Registry, arg1: &mut 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::global_kiosk_registry::GlobalKioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<TimeCapsuleNFT>, arg3: &MintConfig, arg4: address, arg5: u64, arg6: vector<u8>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        mint_nft_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun nft_details(arg0: &TimeCapsuleNFT) : (0x2::object::ID, u64, 0x2::object::ID, address, 0x1::option::Option<u64>, vector<u8>, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::option::Option<bool>, 0x1::option::Option<0x1::string::String>, 0x1::option::Option<0x1::string::String>, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) {
        (0x2::object::uid_to_inner(&arg0.id), arg0.mint_sequence, arg0.registry_id, arg0.recipient_address, arg0.tier, arg0.campaign_id, arg0.event_name, arg0.campaign_slug, arg0.prize_name, arg0.image_path, arg0.has_physical_prize, arg0.physical_prize_name, arg0.physical_prize_description, arg0.attributes)
    }

    public fun nft_prize_info(arg0: &TimeCapsuleNFT) : (0x1::option::Option<u64>, 0x1::option::Option<bool>, 0x1::option::Option<0x1::string::String>, 0x1::option::Option<0x1::string::String>) {
        (arg0.tier, arg0.has_physical_prize, arg0.physical_prize_name, arg0.physical_prize_description)
    }

    public entry fun reveal_nft_with_signature(arg0: &mut 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<TimeCapsuleNFT>, arg4: &RevealConfig, arg5: 0x2::object::ID, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::is_paused(arg0), 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::common::campaign_paused());
        assert!(0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::is_in_reveal_phase(arg0), 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::common::campaign_not_in_reveal());
        assert!(0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::is_shuffled(arg0), 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::common::not_shuffled());
        let v0 = create_reveal_message(arg5, arg6);
        assert!(verify_signature_with_timestamp(&arg7, &arg4.backend_public_key, &v0, arg6, arg8), 1);
        let (v1, v2) = 0x2::kiosk::borrow_val<TimeCapsuleNFT>(arg1, arg2, arg5);
        let v3 = v1;
        assert!(v3.registry_id == 0x2::object::id<0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::Registry>(arg0), 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::common::wrong_registry());
        assert!(0x1::option::is_none<u64>(&v3.tier), 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::common::already_revealed());
        let (_, _, v6, _) = 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::get_nft_detail(arg0, v3.mint_sequence);
        let v8 = v6;
        assert!(0x1::option::is_some<0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::common::Prize>(&v8), 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::common::no_prize_assigned());
        let v9 = 0x1::option::borrow<0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::common::Prize>(&v8);
        let v10 = 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::common::prize_tier_level(v9);
        v3.tier = 0x1::option::some<u64>(v10);
        let v11 = 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::common::prize_has_physical(v9);
        let v12 = 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::common::prize_physical_name(v9);
        v3.has_physical_prize = 0x1::option::some<bool>(v11);
        v3.physical_prize_name = 0x1::option::some<0x1::string::String>(0x1::string::utf8(v12));
        v3.physical_prize_description = 0x1::option::some<0x1::string::String>(0x1::string::utf8(0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::common::prize_physical_description(v9)));
        let v13 = 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::common::prize_name(v9);
        v3.prize_name = 0x1::string::utf8(v13);
        v3.prize_description = 0x1::string::utf8(0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::common::prize_description(v9));
        v3.image_path = 0x1::string::utf8(b"tier");
        0x1::string::append(&mut v3.image_path, u64_to_string(v10));
        0x1::string::append(&mut v3.image_path, 0x1::string::utf8(b".webp"));
        let v14 = 0x1::string::utf8(b"Status");
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v3.attributes, &v14);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3.attributes, 0x1::string::utf8(b"Status"), 0x1::string::utf8(b"Revealed"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3.attributes, 0x1::string::utf8(b"Tier"), 0x1::u64::to_string(v10));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3.attributes, 0x1::string::utf8(b"Prize Type"), 0x1::string::utf8(v13));
        if (v11) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3.attributes, 0x1::string::utf8(b"Physical Prize"), 0x1::string::utf8(b"Yes"));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3.attributes, 0x1::string::utf8(b"Physical Prize Name"), 0x1::string::utf8(v12));
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3.attributes, 0x1::string::utf8(b"Physical Prize"), 0x1::string::utf8(b"No"));
        };
        let v17 = v3.mint_sequence;
        0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::mark_nft_claimed(arg0, v17);
        0x2::kiosk::return_val<TimeCapsuleNFT>(arg1, v3, v2);
        let v18 = NFTRevealed{
            nft_object_id     : arg5,
            registry_id       : 0x2::object::id<0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::Registry>(arg0),
            mint_sequence     : v17,
            tier_level        : v10,
            recipient_address : v3.recipient_address,
        };
        0x2::event::emit<NFTRevealed>(v18);
    }

    public entry fun setup_transfer_policy(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<TimeCapsuleNFT>(arg0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<TimeCapsuleNFT>>(v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<TimeCapsuleNFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    fun u64_to_ascii(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::length<u8>(&v0);
        while (v2 > 0) {
            v2 = v2 - 1;
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
        };
        v1
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        0x1::string::utf8(u64_to_ascii(arg0))
    }

    public fun validate_mint_eligibility(arg0: &0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::Registry, arg1: address, arg2: u64) : bool {
        if (0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::is_paused(arg0)) {
            return false
        };
        if (arg2 != 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::get_user_nonce(arg0, arg1)) {
            return false
        };
        if (!0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::is_in_claim_phase(arg0)) {
            return false
        };
        if (0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::has_claimed_address(arg0, arg1)) {
            return false
        };
        if (0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::minted_count(arg0) >= 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::registry::total_supply(arg0)) {
            return false
        };
        true
    }

    fun verify_signature_with_timestamp(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u64, arg4: &0x2::clock::Clock) : bool {
        assert!(0x1::vector::length<u8>(arg1) == 32, 6);
        assert!(0x1::vector::length<u8>(arg0) == 64, 7);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (v0 < arg3) {
            abort 4
        };
        if (v0 - arg3 > 120000) {
            abort 3
        };
        if (!0x2::ed25519::ed25519_verify(arg0, arg1, arg2)) {
            abort 5
        };
        true
    }

    // decompiled from Move bytecode v6
}

