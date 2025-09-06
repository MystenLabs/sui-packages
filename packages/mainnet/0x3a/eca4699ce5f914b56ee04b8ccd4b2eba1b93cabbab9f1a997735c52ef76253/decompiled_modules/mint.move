module 0x3aeca4699ce5f914b56ee04b8ccd4b2eba1b93cabbab9f1a997735c52ef76253::mint {
    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        token_id: u16,
        minter: address,
    }

    struct MintingStarted has copy, drop {
        timestamp: u64,
    }

    struct MINT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NftMetadata has store {
        image_id: 0x1::ascii::String,
        attrs: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct AttrBadge has store {
        name: 0x1::string::String,
        id: u16,
    }

    struct BeelieversCollection has key {
        id: 0x2::object::UID,
        postmint_start: u64,
        remaining_mythic: u16,
        remaining_nfts: vector<u16>,
        mythic_eligible_list: 0x2::table::Table<address, bool>,
        minted_addresses: 0x2::table::Table<address, bool>,
        remaining_mythic_eligible: u16,
        premint_completed: bool,
        minting_active: bool,
        mint_start_time: u64,
        auction_contract: address,
        treasury_address: address,
        nft_metadata: 0x2::table::Table<u16, NftMetadata>,
        preset_badges: 0x2::table::Table<address, vector<u16>>,
        future_badges: 0x2::table::Table<u16, vector<u16>>,
        badge_names: 0x2::table::Table<u16, 0x1::string::String>,
        attribute_badges: vector<AttrBadge>,
    }

    struct BeelieverNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_id: 0x1::ascii::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        token_id: u16,
        badges: vector<0x1::string::String>,
    }

    public entry fun mint(arg0: &mut BeelieversCollection, arg1: &0x2::transfer_policy::TransferPolicy<BeelieverNFT>, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &0xff4982cd449809676699d1a52c5562fc15b9b92cb41bde5f8845a14647186704::auction::Auction, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = (0x1::vector::length<u16>(&arg0.remaining_nfts) as u16);
        assert!(arg0.minting_active, 2);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.mint_start_time, 2);
        assert!(!has_minted(arg0, v0), 4);
        assert!(v1 >= 1, 1);
        let v2 = 0x2::object::id<0xff4982cd449809676699d1a52c5562fc15b9b92cb41bde5f8845a14647186704::auction::Auction>(arg4);
        assert!(0x2::object::id_to_address(&v2) == arg0.auction_contract, 10);
        let (v3, v4) = determine_mint_eligibility(arg0, v0, arg4);
        assert!(v3, 3);
        let v5 = arg0.remaining_mythic;
        let v6 = if (v4) {
            0
        } else {
            v5
        };
        let v7 = if (v4) {
            if (v5 >= arg0.remaining_mythic_eligible) {
                v5 >= 1
            } else {
                false
            }
        } else {
            false
        };
        let v8 = if (v7) {
            v5 - 1
        } else {
            v1 - 1
        };
        let v9 = 0x2::random::new_generator(arg2, arg7);
        mint_for_sender(arg0, (0x2::random::generate_u16_in_range(&mut v9, v6, v8) as u64), arg1, arg5, arg6, arg7);
        0x2::table::add<address, bool>(&mut arg0.minted_addresses, v0, true);
        if (v4) {
            arg0.remaining_mythic_eligible = arg0.remaining_mythic_eligible - 1;
            0x2::table::remove<address, bool>(&mut arg0.mythic_eligible_list, v0);
        };
    }

    public fun add_mythic_eligible(arg0: &AdminCap, arg1: &mut BeelieversCollection, arg2: vector<address>) {
        0x1::vector::reverse<address>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::table::contains<address, bool>(&arg1.mythic_eligible_list, v1)) {
                0x2::table::add<address, bool>(&mut arg1.mythic_eligible_list, v1, true);
                arg1.remaining_mythic_eligible = arg1.remaining_mythic_eligible + 1;
            };
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    fun badge_number_to_name(arg0: &BeelieversCollection, arg1: u16) : 0x1::string::String {
        if (0x2::table::contains<u16, 0x1::string::String>(&arg0.badge_names, arg1)) {
            *0x2::table::borrow<u16, 0x1::string::String>(&arg0.badge_names, arg1)
        } else {
            0x1::string::utf8(b"unknown_badge")
        }
    }

    fun create_nft(arg0: &mut BeelieversCollection, arg1: u16, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : BeelieverNFT {
        let v0 = 0x1::string::utf8(b"Beelievers #");
        0x1::string::append(&mut v0, 0x1::u16::to_string(arg1));
        let v1 = if (0x2::table::contains<u16, NftMetadata>(&arg0.nft_metadata, arg1)) {
            0x2::table::remove<u16, NftMetadata>(&mut arg0.nft_metadata, arg1)
        } else {
            empty_metadata()
        };
        let NftMetadata {
            image_id : v2,
            attrs    : v3,
        } = v1;
        let v4 = v3;
        let v5 = if (0x2::table::contains<address, vector<u16>>(&arg0.preset_badges, arg2)) {
            0x2::table::remove<address, vector<u16>>(&mut arg0.preset_badges, arg2)
        } else {
            0x1::vector::empty<u16>()
        };
        let v6 = v5;
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = 0;
        while (v8 < 0x1::vector::length<u16>(&v6)) {
            let v9 = *0x1::vector::borrow<u16>(&v6, v8);
            let v10 = badge_number_to_name(arg0, v9);
            0x1::vector::push_back<0x1::string::String>(&mut v7, v10);
            let v11 = &arg0.attribute_badges;
            let v12 = 0;
            while (v12 < 0x1::vector::length<AttrBadge>(v11)) {
                let v13 = 0x1::vector::borrow<AttrBadge>(v11, v12);
                if (v13.id == v9) {
                    0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v4, v13.name, v10);
                };
                v12 = v12 + 1;
            };
            v8 = v8 + 1;
        };
        BeelieverNFT{
            id         : 0x2::object::new(arg3),
            name       : v0,
            image_id   : v2,
            attributes : v4,
            token_id   : arg1,
            badges     : v7,
        }
    }

    fun determine_mint_eligibility(arg0: &BeelieversCollection, arg1: address, arg2: &0xff4982cd449809676699d1a52c5562fc15b9b92cb41bde5f8845a14647186704::auction::Auction) : (bool, bool) {
        if (is_mythic_eligible(arg0, arg1)) {
            return (true, true)
        };
        (0xff4982cd449809676699d1a52c5562fc15b9b92cb41bde5f8845a14647186704::auction::is_winner(arg2, arg1), false)
    }

    public(friend) fun empty_metadata() : NftMetadata {
        NftMetadata{
            image_id : 0x1::ascii::string(b""),
            attrs    : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        }
    }

    public fun get_badge_name(arg0: &BeelieversCollection, arg1: u16) : 0x1::string::String {
        if (0x2::table::contains<u16, 0x1::string::String>(&arg0.badge_names, arg1)) {
            *0x2::table::borrow<u16, 0x1::string::String>(&arg0.badge_names, arg1)
        } else {
            0x1::string::utf8(b"unknown_badge")
        }
    }

    public fun get_collection_stats(arg0: &BeelieversCollection) : (u16, u16, u16) {
        let v0 = 6021 - (0x1::vector::length<u16>(&arg0.remaining_nfts) as u16);
        let v1 = 21 - arg0.remaining_mythic;
        (v0, v1, v0 - v1)
    }

    public fun get_mint_start_time(arg0: &BeelieversCollection) : u64 {
        arg0.mint_start_time
    }

    public fun get_supply() : vector<u16> {
        let v0 = 0x1::vector::empty<u16>();
        let v1 = &mut v0;
        0x1::vector::push_back<u16>(v1, 6021);
        0x1::vector::push_back<u16>(v1, 21);
        0x1::vector::push_back<u16>(v1, 6000);
        v0
    }

    public fun has_minted(arg0: &BeelieversCollection, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.minted_addresses, arg1)
    }

    fun init(arg0: MINT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MINT>(arg0, arg1);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < (6021 as u64)) {
            0x1::vector::push_back<u16>(&mut v1, ((v2 + 1) as u16));
            v2 = v2 + 1;
        };
        let v3 = AttrBadge{
            name : 0x1::string::utf8(b"badge_rank"),
            id   : 4,
        };
        let v4 = 0x1::vector::empty<AttrBadge>();
        0x1::vector::push_back<AttrBadge>(&mut v4, v3);
        let v5 = BeelieversCollection{
            id                        : 0x2::object::new(arg1),
            postmint_start            : 1760054400000,
            remaining_mythic          : 21,
            remaining_nfts            : v1,
            mythic_eligible_list      : 0x2::table::new<address, bool>(arg1),
            minted_addresses          : 0x2::table::new<address, bool>(arg1),
            remaining_mythic_eligible : 0,
            premint_completed         : false,
            minting_active            : false,
            mint_start_time           : 0,
            auction_contract          : @0x161524be15687cca96dec58146568622458905c30479452351f231cac5d64c41,
            treasury_address          : @0xa30212c91b8fea7b494d47709d97be5774eee1e20c3515a88ec5684283b4430b,
            nft_metadata              : 0x2::table::new<u16, NftMetadata>(arg1),
            preset_badges             : 0x2::table::new<address, vector<u16>>(arg1),
            future_badges             : 0x2::table::new<u16, vector<u16>>(arg1),
            badge_names               : 0x2::table::new<u16, 0x1::string::String>(arg1),
            attribute_badges          : v4,
        };
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        let v7 = 0x2::display::new<BeelieverNFT>(&v0, arg1);
        0x2::display::add<BeelieverNFT>(&mut v7, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<BeelieverNFT>(&mut v7, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"BTCFi Beelievers is more than an NFT- it's a movement to make Bitcoin work in DeFi without bridges, wrappers, or custodians. The Beeliever NFT is your badge of conviction, fueling Native's nBTC and BYield on Sui."));
        0x2::display::add<BeelieverNFT>(&mut v7, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://walrus.tusky.io/{image_id}"));
        0x2::display::add<BeelieverNFT>(&mut v7, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<BeelieverNFT>(&mut v7, 0x1::string::utf8(b"badges"), 0x1::string::utf8(b"{badges}"));
        0x2::display::update_version<BeelieverNFT>(&mut v7);
        let (v8, v9) = 0x2::transfer_policy::new<BeelieverNFT>(&v0, arg1);
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<BeelieverNFT>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<BeelieverNFT>>(v9, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<BeelieverNFT>>(v8);
        0x2::transfer::share_object<BeelieversCollection>(v5);
    }

    public fun is_minting_active(arg0: &BeelieversCollection) : bool {
        arg0.minting_active
    }

    public fun is_mythic_eligible(arg0: &BeelieversCollection, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.mythic_eligible_list, arg1)
    }

    fun mint_for_sender(arg0: &mut BeelieversCollection, arg1: u64, arg2: &0x2::transfer_policy::TransferPolicy<BeelieverNFT>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = *0x1::vector::borrow<u16>(&arg0.remaining_nfts, arg1);
        let v2 = create_nft(arg0, v1, v0, arg5);
        if (v1 <= 21) {
            let v3 = ((arg0.remaining_mythic - 1) as u64);
            if (arg1 != v3) {
                0x1::vector::swap<u16>(&mut arg0.remaining_nfts, arg1, v3);
            };
            0x1::vector::swap_remove<u16>(&mut arg0.remaining_nfts, v3);
            arg0.remaining_mythic = arg0.remaining_mythic - 1;
        } else {
            0x1::vector::swap_remove<u16>(&mut arg0.remaining_nfts, arg1);
        };
        let v4 = NFTMinted{
            nft_id   : 0x2::object::id<BeelieverNFT>(&v2),
            token_id : v1,
            minter   : v0,
        };
        0x2::event::emit<NFTMinted>(v4);
        0x2::kiosk::lock<BeelieverNFT>(arg3, arg4, arg2, v2);
    }

    public fun pause_minting(arg0: &AdminCap, arg1: &mut BeelieversCollection) {
        arg1.minting_active = false;
    }

    public fun postmint_to_native(arg0: &AdminCap, arg1: &mut BeelieversCollection, arg2: u16, arg3: &0x2::transfer_policy::TransferPolicy<BeelieverNFT>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = (0x1::vector::length<u16>(&arg1.remaining_nfts) as u16);
        assert!(arg1.postmint_start <= 0x2::clock::timestamp_ms(arg6), 11);
        assert!(arg2 > 0 && arg2 < v0, 1);
        let v1 = 1;
        while (v1 <= arg2) {
            mint_for_sender(arg1, ((v0 - v1) as u64), arg3, arg4, arg5, arg7);
            v1 = v1 + 1;
        };
    }

    public fun premint_to_native(arg0: &AdminCap, arg1: &mut BeelieversCollection, arg2: &0x2::transfer_policy::TransferPolicy<BeelieverNFT>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.premint_completed, 9);
        let v0 = 0x2::random::new_generator(arg5, arg6);
        let v1 = 1;
        while (v1 <= 11) {
            let v2 = (0x2::random::generate_u16_in_range(&mut v0, 0, arg1.remaining_mythic - 1) as u64);
            mint_for_sender(arg1, v2, arg2, arg3, arg4, arg6);
            v1 = v1 + 1;
        };
        v1 = 1;
        while (v1 <= 200) {
            let v3 = (0x2::random::generate_u16_in_range(&mut v0, arg1.remaining_mythic, (0x1::vector::length<u16>(&arg1.remaining_nfts) as u16) - v1) as u64);
            mint_for_sender(arg1, v3, arg2, arg3, arg4, arg6);
            v1 = v1 + 1;
        };
        arg1.premint_completed = true;
    }

    public fun set_bulk_badge_names(arg0: &AdminCap, arg1: &mut BeelieversCollection, arg2: vector<u16>, arg3: vector<0x1::string::String>) {
        assert!(0x1::vector::length<u16>(&arg2) == 0x1::vector::length<0x1::string::String>(&arg3), 6);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u16>(&arg2)) {
            let v1 = *0x1::vector::borrow<u16>(&arg2, v0);
            if (0x2::table::contains<u16, 0x1::string::String>(&arg1.badge_names, v1)) {
                *0x2::table::borrow_mut<u16, 0x1::string::String>(&mut arg1.badge_names, v1) = *0x1::vector::borrow<0x1::string::String>(&arg3, v0);
            } else {
                0x2::table::add<u16, 0x1::string::String>(&mut arg1.badge_names, v1, *0x1::vector::borrow<0x1::string::String>(&arg3, v0));
            };
            v0 = v0 + 1;
        };
    }

    public fun set_bulk_nft_attributes(arg0: &AdminCap, arg1: &mut BeelieversCollection, arg2: vector<u16>, arg3: vector<vector<0x1::string::String>>, arg4: vector<vector<0x1::string::String>>) {
        let v0 = 0x1::vector::length<u16>(&arg2);
        assert!(v0 == 0x1::vector::length<vector<0x1::string::String>>(&arg3) && v0 == 0x1::vector::length<vector<0x1::string::String>>(&arg4), 6);
        let v1 = 0;
        while (v1 < v0) {
            set_nft_attributes(arg0, arg1, *0x1::vector::borrow<u16>(&arg2, v1), *0x1::vector::borrow<vector<0x1::string::String>>(&arg3, v1), *0x1::vector::borrow<vector<0x1::string::String>>(&arg4, v1));
            v1 = v1 + 1;
        };
    }

    public fun set_bulk_nft_images(arg0: &AdminCap, arg1: &mut BeelieversCollection, arg2: vector<u16>, arg3: vector<vector<u8>>) {
        assert!(0x1::vector::length<u16>(&arg2) == 0x1::vector::length<vector<u8>>(&arg3), 6);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u16>(&arg2)) {
            set_nft_image(arg0, arg1, *0x1::vector::borrow<u16>(&arg2, v0), *0x1::vector::borrow<vector<u8>>(&arg3, v0));
            v0 = v0 + 1;
        };
    }

    public fun set_bulk_preset_badges(arg0: &AdminCap, arg1: &mut BeelieversCollection, arg2: vector<address>, arg3: vector<vector<u16>>) {
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<vector<u16>>(&arg3), 6);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (0x2::table::contains<address, vector<u16>>(&arg1.preset_badges, v1)) {
                let v2 = *0x2::table::borrow<address, vector<u16>>(&arg1.preset_badges, v1);
                0x1::vector::append<u16>(&mut v2, *0x1::vector::borrow<vector<u16>>(&arg3, v0));
                *0x2::table::borrow_mut<address, vector<u16>>(&mut arg1.preset_badges, v1) = v2;
            } else {
                0x2::table::add<address, vector<u16>>(&mut arg1.preset_badges, v1, *0x1::vector::borrow<vector<u16>>(&arg3, v0));
            };
            v0 = v0 + 1;
        };
    }

    public fun set_future_badges(arg0: &AdminCap, arg1: &mut BeelieversCollection, arg2: u16, arg3: vector<u16>) {
        assert!(arg2 > 0 && arg2 <= 6021, 7);
        if (0x2::table::contains<u16, vector<u16>>(&arg1.future_badges, arg2)) {
            *0x2::table::borrow_mut<u16, vector<u16>>(&mut arg1.future_badges, arg2) = arg3;
        } else {
            0x2::table::add<u16, vector<u16>>(&mut arg1.future_badges, arg2, arg3);
        };
    }

    public fun set_nft_attributes(arg0: &AdminCap, arg1: &mut BeelieversCollection, arg2: u16, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>) {
        assert!(arg2 > 0 && arg2 <= 6021, 7);
        assert!(0x1::vector::length<0x1::string::String>(&arg3) == 0x1::vector::length<0x1::string::String>(&arg4), 6);
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg3, v1), *0x1::vector::borrow<0x1::string::String>(&arg4, v1));
            v1 = v1 + 1;
        };
        if (0x2::table::contains<u16, NftMetadata>(&arg1.nft_metadata, arg2)) {
            0x2::table::borrow_mut<u16, NftMetadata>(&mut arg1.nft_metadata, arg2).attrs = v0;
        } else {
            let v2 = empty_metadata();
            v2.attrs = v0;
            0x2::table::add<u16, NftMetadata>(&mut arg1.nft_metadata, arg2, v2);
        };
    }

    public fun set_nft_image(arg0: &AdminCap, arg1: &mut BeelieversCollection, arg2: u16, arg3: vector<u8>) {
        assert!(arg2 > 0 && arg2 <= 6021, 7);
        if (0x2::table::contains<u16, NftMetadata>(&arg1.nft_metadata, arg2)) {
            0x2::table::borrow_mut<u16, NftMetadata>(&mut arg1.nft_metadata, arg2).image_id = 0x1::ascii::string(arg3);
        } else {
            let v0 = NftMetadata{
                image_id : 0x1::ascii::string(arg3),
                attrs    : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            };
            0x2::table::add<u16, NftMetadata>(&mut arg1.nft_metadata, arg2, v0);
        };
    }

    public entry fun set_treasury(arg0: &AdminCap, arg1: &mut BeelieversCollection, arg2: address) {
        arg1.treasury_address = arg2;
    }

    public fun start_minting(arg0: &AdminCap, arg1: &mut BeelieversCollection, arg2: u64) {
        assert!(arg1.premint_completed, 8);
        assert!(0x2::table::length<address, bool>(&arg1.mythic_eligible_list) > 0, 5);
        arg1.minting_active = true;
        arg1.mint_start_time = arg2;
        let v0 = MintingStarted{timestamp: arg1.mint_start_time};
        0x2::event::emit<MintingStarted>(v0);
    }

    public fun upsert_nft_badges(arg0: &BeelieversCollection, arg1: &mut BeelieverNFT) {
        if (!0x2::table::contains<u16, vector<u16>>(&arg0.future_badges, arg1.token_id)) {
            return
        };
        let v0 = *0x2::table::borrow<u16, vector<u16>>(&arg0.future_badges, arg1.token_id);
        0x1::vector::reverse<u16>(&mut v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u16>(&v0)) {
            let v2 = *0x2::table::borrow<u16, 0x1::string::String>(&arg0.badge_names, 0x1::vector::pop_back<u16>(&mut v0));
            if (!0x1::vector::contains<0x1::string::String>(&arg1.badges, &v2)) {
                0x1::vector::push_back<0x1::string::String>(&mut arg1.badges, v2);
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u16>(v0);
    }

    // decompiled from Move bytecode v6
}

