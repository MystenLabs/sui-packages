module 0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::nft {
    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        tier_id: 0x2::object::ID,
        phase_id: 0x2::object::ID,
        mint_number: u64,
        minter: address,
    }

    struct NFTRevealed has copy, drop {
        nft_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        new_image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct NFTPlacedInKiosk has copy, drop {
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        owner: address,
    }

    struct TransferPolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        creator: address,
    }

    struct SatLayerNFT has store, key {
        id: 0x2::object::UID,
        collection_name: 0x1::string::String,
        collection_id: 0x2::object::ID,
        tier_name: 0x1::string::String,
        tier_id: 0x2::object::ID,
        mint_number: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        is_revealed: bool,
        image_url: 0x1::string::String,
        creator: 0x1::string::String,
        project_url: 0x1::string::String,
        cover_url: 0x1::string::String,
        banner_url: 0x1::string::String,
    }

    struct Rule has drop {
        dummy_field: bool,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public fun name(arg0: &SatLayerNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun add_lock_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<SatLayerNFT>, arg1: &0x2::transfer_policy::TransferPolicyCap<SatLayerNFT>) {
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::add_rule<SatLayerNFT, Rule, bool>(v0, arg0, arg1, true);
    }

    public fun collection_id(arg0: &SatLayerNFT) : 0x2::object::ID {
        arg0.collection_id
    }

    public fun description(arg0: &SatLayerNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &SatLayerNFT) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"collection"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"tier_name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"mint_number"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"attributes"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"revealed"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"cover_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"banner_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{collection_name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{tier_name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{mint_number}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{attributes}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{is_revealed}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{cover_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{banner_url}"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SatLayerNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<SatLayerNFT>(&mut v5);
        let v6 = 0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::admin::new(arg1);
        setup_transfer_policy(&v4, &v6, arg1);
        0x2::transfer::public_transfer<0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::admin::AdminCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SatLayerNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint_nft(arg0: &mut 0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::collection::Collection, arg1: &0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::admin::AdminCap, arg2: &mut 0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::phase::Phase, arg3: &mut 0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::tier::Tier, arg4: &0x2::clock::Clock, arg5: address, arg6: &0x2::transfer_policy::TransferPolicy<SatLayerNFT>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::collection::is_active(arg0), 0);
        assert!(0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::phase::collection_id(arg2) == 0x2::object::id<0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::collection::Collection>(arg0), 1);
        assert!(0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::tier::collection_id(arg3) == 0x2::object::id<0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::collection::Collection>(arg0), 2);
        0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::phase::validate_and_record_mint(arg2, arg4);
        0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::tier::validate_and_record_mint(arg3, 0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::phase::phase_id(arg2));
        let v0 = 0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::collection::increment_supply(arg0);
        let v1 = 0x2::object::new(arg7);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x2::object::id<0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::collection::Collection>(arg0);
        let v4 = 0x2::object::id<0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::tier::Tier>(arg3);
        let v5 = 0x1::string::utf8(b"Cube #");
        0x1::string::append_utf8(&mut v5, 0x1::string::into_bytes(0x1::u64::to_string(v0)));
        let v6 = SatLayerNFT{
            id              : v1,
            collection_name : 0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::collection::name(arg0),
            collection_id   : v3,
            tier_name       : 0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::tier::name(arg3),
            tier_id         : v4,
            mint_number     : v0,
            name            : v5,
            description     : 0x1::string::utf8(b"The new economy, built on Bitcoin"),
            attributes      : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            is_revealed     : false,
            image_url       : 0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::tier::image_url(arg3),
            creator         : 0x1::string::utf8(b"SatLayer"),
            project_url     : 0x1::string::utf8(b"https://satlayer.xyz/"),
            cover_url       : 0x1::string::utf8(b"https://satlayer.xyz/"),
            banner_url      : 0x1::string::utf8(b"https://satlayer.xyz/"),
        };
        let v7 = MintEvent{
            nft_id        : v2,
            collection_id : v3,
            tier_id       : v4,
            phase_id      : 0x2::object::id<0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::phase::Phase>(arg2),
            mint_number   : v0,
            minter        : arg5,
        };
        0x2::event::emit<MintEvent>(v7);
        let (v8, v9) = 0x2::kiosk::new(arg7);
        let v10 = v9;
        let v11 = v8;
        0x2::kiosk::lock<SatLayerNFT>(&mut v11, &v10, arg6, v6);
        let v12 = NFTPlacedInKiosk{
            nft_id   : v2,
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(&v11),
            owner    : arg5,
        };
        0x2::event::emit<NFTPlacedInKiosk>(v12);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v11);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v10, arg5);
    }

    public fun mint_number(arg0: &SatLayerNFT) : u64 {
        arg0.mint_number
    }

    public fun prove_lock_rule(arg0: &mut 0x2::transfer_policy::TransferRequest<SatLayerNFT>, arg1: &0x2::kiosk::Kiosk) {
        let v0 = 0x2::transfer_policy::item<SatLayerNFT>(arg0);
        assert!(0x2::kiosk::has_item(arg1, v0) && 0x2::kiosk::is_locked(arg1, v0), 5);
        let v1 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<SatLayerNFT, Rule>(v1, arg0);
    }

    public fun reveal_nft(arg0: &mut SatLayerNFT, arg1: &0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::admin::AdminCap, arg2: &0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::collection::Collection, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>) {
        assert!(!arg0.is_revealed, 3);
        assert!(!0x1::string::is_empty(&arg3), 4);
        assert!(arg0.collection_id == 0x2::object::id<0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::collection::Collection>(arg2), 1);
        let v0 = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg4, arg5);
        arg0.image_url = arg3;
        arg0.attributes = v0;
        arg0.is_revealed = true;
        let v1 = NFTRevealed{
            nft_id        : 0x2::object::uid_to_inner(&arg0.id),
            collection_id : arg0.collection_id,
            new_image_url : arg3,
            attributes    : v0,
        };
        0x2::event::emit<NFTRevealed>(v1);
    }

    public fun setup_transfer_policy(arg0: &0x2::package::Publisher, arg1: &0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<SatLayerNFT>(arg0, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        add_lock_rule(v4, &v2);
        let v5 = TransferPolicyCreated{
            policy_id : 0x2::object::id<0x2::transfer_policy::TransferPolicy<SatLayerNFT>>(&v3),
            creator   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<TransferPolicyCreated>(v5);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<SatLayerNFT>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<SatLayerNFT>>(v2, 0x2::tx_context::sender(arg2));
    }

    public fun tier_id(arg0: &SatLayerNFT) : 0x2::object::ID {
        arg0.tier_id
    }

    // decompiled from Move bytecode v6
}

