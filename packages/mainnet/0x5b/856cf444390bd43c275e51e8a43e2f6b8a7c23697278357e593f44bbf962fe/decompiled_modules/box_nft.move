module 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::box_nft {
    struct BOX_NFT has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct MysteryBox has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        phase: u8,
        img_url: 0x2::url::Url,
    }

    struct BoxInfo has store, key {
        id: 0x2::object::UID,
        minted: u64,
        opened: u64,
    }

    struct AvatarNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x2::url::Url,
        attributes: 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::Avatar,
    }

    struct SpaceNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x2::url::Url,
        attributes: 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::Space,
    }

    struct CouponNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x2::url::Url,
        attributes: 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::Coupon,
    }

    struct BuyBoxNFTEvent has copy, drop {
        box_id: 0x2::object::ID,
        box_phase: u8,
        buyer: address,
        box_price: u64,
    }

    struct OpenBoxNFTEvent has copy, drop {
        box_id: 0x2::object::ID,
        box_phase: u8,
        creator: address,
    }

    struct ClaimCouponEvent has copy, drop {
        coupon_id: 0x2::object::ID,
        box_phase: u8,
        claimer: address,
    }

    fun burn_coupon(arg0: CouponNFT, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<CouponNFT>) {
        let v0 = Witness{dummy_field: false};
        let CouponNFT {
            id          : v1,
            name        : _,
            description : _,
            img_url     : _,
            attributes  : _,
        } = arg0;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<CouponNFT>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<CouponNFT>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<CouponNFT, Witness>(v0), &arg0), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<CouponNFT>(arg1), v1);
    }

    public entry fun buy_box(arg0: &0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::phase_config::Phase, arg1: &0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::admin::Contract, arg2: &0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::box_config::BoxConfig, arg3: &mut BoxInfo, arg4: &0x2::clock::Clock, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MysteryBox>, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::admin::assert_not_freeze(arg1);
        0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::phase_config::assert_phase_in_progress(arg0, arg4);
        let v0 = 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::phase_config::get_current_phase(arg0);
        0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::box_config::assert_box_same_phase(v0, arg2);
        0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::phase_config::assert_can_public_mint(0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::phase_config::get_phase_config(arg0));
        assert!(0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::box_config::get_box_price(arg2) * arg6 == 0x2::coin::value<0x2::sui::SUI>(&arg7), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::admin::get_receiver(arg1));
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = 0;
        while (v2 < arg6) {
            let v3 = MysteryBox{
                id          : 0x2::object::new(arg8),
                name        : 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::box_config::get_box_name(arg2),
                description : 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::box_config::get_box_description(arg2),
                phase       : v0,
                img_url     : 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::box_config::get_box_img_url(arg2),
            };
            let v4 = BuyBoxNFTEvent{
                box_id    : 0x2::object::uid_to_inner(&v3.id),
                box_phase : 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::phase_config::get_current_phase(arg0),
                buyer     : v1,
                box_price : 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::box_config::get_box_price(arg2),
            };
            0x2::event::emit<BuyBoxNFTEvent>(v4);
            let v5 = Witness{dummy_field: false};
            0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<MysteryBox>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<MysteryBox, Witness>(v5), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<MysteryBox>(arg5), &v3);
            0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<MysteryBox>(arg5, 1);
            arg3.minted = arg3.minted + 1;
            0x2::transfer::transfer<MysteryBox>(v3, v1);
            v2 = v2 + 1;
        };
    }

    public entry fun claim_coupon(arg0: CouponNFT, arg1: &mut 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::box_config::BoxConfig, arg2: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<CouponNFT>, arg3: &mut 0x2::tx_context::TxContext) {
        0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::box_config::add_coupon_claim_record(arg1, 0x2::tx_context::sender(arg3), 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::get_nft_coupon_amount(&arg0.attributes));
        let v0 = ClaimCouponEvent{
            coupon_id : 0x2::object::uid_to_inner(&arg0.id),
            box_phase : 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::box_config::get_box_phase(arg1),
            claimer   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ClaimCouponEvent>(v0);
        burn_coupon(arg0, arg2);
    }

    fun init(arg0: BOX_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<BOX_NFT, Witness>(v0);
        let v2 = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create<BOX_NFT>(v1, arg1);
        let v3 = 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<BOX_NFT>>(&v2);
        let v4 = 0x2::package::claim<BOX_NFT>(arg0, arg1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<BOX_NFT, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v1, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"AI ANIMO"), 0x1::string::utf8(b"AI ANIMO is an experimental project launched by StarryNift on Sui Mainnet that aims to push the boundaries of NFTs by combining the latest AIGC and Composable 3D technologies.")));
        let v5 = 0x2::display::new<MysteryBox>(&v4, arg1);
        0x2::display::add<MysteryBox>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<MysteryBox>(&mut v5, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<MysteryBox>(&mut v5, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{img_url}"));
        0x2::display::update_version<MysteryBox>(&mut v5);
        0x2::transfer::public_share_object<0x2::display::Display<MysteryBox>>(v5);
        let v6 = 0x2::display::new<AvatarNFT>(&v4, arg1);
        0x2::display::add<AvatarNFT>(&mut v6, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<AvatarNFT>(&mut v6, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<AvatarNFT>(&mut v6, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{img_url}"));
        0x2::display::add<AvatarNFT>(&mut v6, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<AvatarNFT>(&mut v6);
        0x2::transfer::public_share_object<0x2::display::Display<AvatarNFT>>(v6);
        let v7 = 0x2::display::new<SpaceNFT>(&v4, arg1);
        0x2::display::add<SpaceNFT>(&mut v7, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SpaceNFT>(&mut v7, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<SpaceNFT>(&mut v7, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{img_url}"));
        0x2::display::add<SpaceNFT>(&mut v7, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<SpaceNFT>(&mut v7);
        0x2::transfer::public_share_object<0x2::display::Display<SpaceNFT>>(v7);
        let v8 = 0x2::display::new<CouponNFT>(&v4, arg1);
        0x2::display::add<CouponNFT>(&mut v8, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<CouponNFT>(&mut v8, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<CouponNFT>(&mut v8, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{img_url}"));
        0x2::display::add<CouponNFT>(&mut v8, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<CouponNFT>(&mut v8);
        0x2::transfer::public_share_object<0x2::display::Display<CouponNFT>>(v8);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MysteryBox>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::new_unlimited<BOX_NFT, MysteryBox>(&arg0, v3, arg1));
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<AvatarNFT>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::new_unlimited<BOX_NFT, AvatarNFT>(&arg0, v3, arg1));
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<SpaceNFT>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::new_unlimited<BOX_NFT, SpaceNFT>(&arg0, v3, arg1));
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<CouponNFT>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::new_unlimited<BOX_NFT, CouponNFT>(&arg0, v3, arg1));
        0x2::transfer::public_share_object<0x2::package::Publisher>(v4);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<BOX_NFT>>(v2);
        let v9 = BoxInfo{
            id     : 0x2::object::new(arg1),
            minted : 0,
            opened : 0,
        };
        0x2::transfer::share_object<BoxInfo>(v9);
    }

    fun mint_nft(arg0: &0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::NFTConfig, arg1: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<AvatarNFT>, arg2: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<SpaceNFT>, arg3: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<CouponNFT>, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::Avatar>(0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::get_nft_avatar_attributes(arg0)) && 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::get_nft_can_mint(arg0)) {
            let v0 = AvatarNFT{
                id          : 0x2::object::new(arg4),
                name        : 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::get_nft_name(arg0),
                description : 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::get_nft_description(arg0),
                img_url     : 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::get_nft_img_url(arg0),
                attributes  : *0x1::option::borrow<0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::Avatar>(0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::get_nft_avatar_attributes(arg0)),
            };
            let v1 = Witness{dummy_field: false};
            0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<AvatarNFT>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<AvatarNFT, Witness>(v1), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<AvatarNFT>(arg1), &v0);
            0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<AvatarNFT>(arg1, 1);
            0x2::transfer::transfer<AvatarNFT>(v0, 0x2::tx_context::sender(arg4));
        } else if (0x1::option::is_some<0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::Space>(0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::get_nft_space_attributes(arg0)) && 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::get_nft_can_mint(arg0)) {
            let v2 = SpaceNFT{
                id          : 0x2::object::new(arg4),
                name        : 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::get_nft_name(arg0),
                description : 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::get_nft_description(arg0),
                img_url     : 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::get_nft_img_url(arg0),
                attributes  : *0x1::option::borrow<0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::Space>(0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::get_nft_space_attributes(arg0)),
            };
            let v3 = Witness{dummy_field: false};
            0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<SpaceNFT>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<SpaceNFT, Witness>(v3), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<SpaceNFT>(arg2), &v2);
            0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<SpaceNFT>(arg2, 1);
            0x2::transfer::transfer<SpaceNFT>(v2, 0x2::tx_context::sender(arg4));
        } else if (0x1::option::is_some<0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::Coupon>(0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::get_nft_coupon_attributes(arg0)) && 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::get_nft_can_mint(arg0)) {
            let v4 = CouponNFT{
                id          : 0x2::object::new(arg4),
                name        : 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::get_nft_name(arg0),
                description : 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::get_nft_description(arg0),
                img_url     : 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::get_nft_img_url(arg0),
                attributes  : *0x1::option::borrow<0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::Coupon>(0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::get_nft_coupon_attributes(arg0)),
            };
            let v5 = Witness{dummy_field: false};
            0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<CouponNFT>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<CouponNFT, Witness>(v5), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<CouponNFT>(arg3), &v4);
            0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<CouponNFT>(arg3, 1);
            0x2::transfer::transfer<CouponNFT>(v4, 0x2::tx_context::sender(arg4));
        };
    }

    public entry fun open_box(arg0: &0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::admin::Contract, arg1: &0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::box_config::BoxConfig, arg2: MysteryBox, arg3: &mut BoxInfo, arg4: &0x2::clock::Clock, arg5: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MysteryBox>, arg6: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<AvatarNFT>, arg7: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<SpaceNFT>, arg8: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<CouponNFT>, arg9: &0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::NFTConfig, arg10: &0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::NFTConfig, arg11: &0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::NFTConfig, arg12: vector<u8>, arg13: &mut 0x2::tx_context::TxContext) {
        0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::admin::assert_not_freeze(arg0);
        0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::box_config::assert_can_open_box(arg1, arg4);
        0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::ecdsa::assert_open_box_signature_valid(0x2::object::uid_as_inner(&arg2.id), 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::get_nft_id(arg9), 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::get_nft_id(arg10), 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::nft_config::get_nft_id(arg11), arg12, 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::admin::get_signer_public_key(arg0));
        mint_nft(arg9, arg6, arg7, arg8, arg13);
        mint_nft(arg10, arg6, arg7, arg8, arg13);
        mint_nft(arg11, arg6, arg7, arg8, arg13);
        let v0 = OpenBoxNFTEvent{
            box_id    : 0x2::object::uid_to_inner(&arg2.id),
            box_phase : arg2.phase,
            creator   : 0x2::tx_context::sender(arg13),
        };
        0x2::event::emit<OpenBoxNFTEvent>(v0);
        let v1 = Witness{dummy_field: false};
        let MysteryBox {
            id          : v2,
            name        : _,
            description : _,
            phase       : _,
            img_url     : _,
        } = arg2;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<MysteryBox>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<MysteryBox>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<MysteryBox, Witness>(v1), &arg2), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<MysteryBox>(arg5), v2);
        arg3.opened = arg3.opened + 1;
    }

    public entry fun private_buy_box(arg0: &0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::phase_config::Phase, arg1: &0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::admin::Contract, arg2: &mut 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::box_config::BoxConfig, arg3: &mut BoxInfo, arg4: &0x2::clock::Clock, arg5: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<MysteryBox>, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::admin::assert_not_freeze(arg1);
        0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::phase_config::assert_phase_in_progress(arg0, arg4);
        let v0 = 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::phase_config::get_current_phase(arg0);
        0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::box_config::assert_box_same_phase(v0, arg2);
        let v1 = 0x2::tx_context::sender(arg8);
        0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::ecdsa::assert_mint_signature_valid(v1, v0, arg6, arg7, 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::admin::get_signer_public_key(arg1));
        0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::box_config::assert_nonce_used(arg2, arg6);
        let v2 = MysteryBox{
            id          : 0x2::object::new(arg8),
            name        : 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::box_config::get_box_name(arg2),
            description : 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::box_config::get_box_description(arg2),
            phase       : v0,
            img_url     : 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::box_config::get_box_img_url(arg2),
        };
        let v3 = BuyBoxNFTEvent{
            box_id    : 0x2::object::uid_to_inner(&v2.id),
            box_phase : 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::phase_config::get_current_phase(arg0),
            buyer     : v1,
            box_price : 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::box_config::get_box_price(arg2),
        };
        0x2::event::emit<BuyBoxNFTEvent>(v3);
        let v4 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<MysteryBox>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<MysteryBox, Witness>(v4), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<MysteryBox>(arg5), &v2);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<MysteryBox>(arg5, 1);
        arg3.minted = arg3.minted + 1;
        0x2::transfer::transfer<MysteryBox>(v2, v1);
    }

    // decompiled from Move bytecode v6
}

