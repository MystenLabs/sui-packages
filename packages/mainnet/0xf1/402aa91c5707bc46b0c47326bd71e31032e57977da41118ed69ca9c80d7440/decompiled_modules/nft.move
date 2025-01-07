module 0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct SBT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    struct MintNFTEvent has copy, drop {
        creator: address,
        nft_config_id: 0x2::object::ID,
    }

    public entry fun claim(arg0: &0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::admin::Contract, arg1: &mut 0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::nft_config::NFTConfig, arg2: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<SBT>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::admin::assert_not_freeze(arg0);
        let v0 = 0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::nft_config::get_nft_id(arg1);
        0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::ecdsa::assert_mint_signature_valid(0x2::tx_context::sender(arg4), &v0, arg3, 0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::admin::get_signer_public_key(arg0));
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v1, 0x1::ascii::string(b"reward_index"));
        0x1::vector::push_back<0x1::ascii::String>(&mut v1, 0x1::ascii::string(b"campaign_id"));
        0x1::vector::push_back<0x1::ascii::String>(&mut v1, 0x1::ascii::string(b"campaign_name"));
        let v2 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v2, 0x1::string::to_ascii(0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::nft_config::get_nft_reward_index(arg1)));
        0x1::vector::push_back<0x1::ascii::String>(&mut v2, 0x1::string::to_ascii(0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::nft_config::get_nft_campaign_id(arg1)));
        0x1::vector::push_back<0x1::ascii::String>(&mut v2, 0x1::string::to_ascii(0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::nft_config::get_nft_campaign_name(arg1)));
        let v3 = SBT{
            id          : 0x2::object::new(arg4),
            name        : 0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::nft_config::get_nft_name(arg1),
            description : 0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::nft_config::get_nft_description(arg1),
            img_url     : 0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::nft_config::get_nft_img_url(arg1),
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(v1, v2),
        };
        let v4 = 0x2::tx_context::sender(arg4);
        0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::nft_config::add_creator(arg1, v4);
        let v5 = MintNFTEvent{
            creator       : v4,
            nft_config_id : 0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::nft_config::get_nft_id(arg1),
        };
        0x2::event::emit<MintNFTEvent>(v5);
        let v6 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<SBT>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<SBT, Witness>(v6), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<SBT>(arg2), &v3);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<SBT>(arg2, 1);
        0x2::transfer::transfer<SBT>(v3, v4);
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<NFT, SBT>(&arg0, 0x1::option::none<u64>(), arg1);
        let v2 = v0;
        let v3 = 0x2::package::claim<NFT>(arg0, arg1);
        let v4 = Witness{dummy_field: false};
        let v5 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v5, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::tokenised_asset());
        let v6 = 0x2::display::new<SBT>(&v3, arg1);
        0x2::display::add<SBT>(&mut v6, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SBT>(&mut v6, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<SBT>(&mut v6, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{img_url}"));
        0x2::display::add<SBT>(&mut v6, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<SBT>(&mut v6, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v5));
        0x2::display::update_version<SBT>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<SBT>>(v6, 0x2::tx_context::sender(arg1));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<SBT, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<SBT, Witness>(v4), &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Trantor soulbound token"), 0x1::string::utf8(b"This collection contains all SBT issued by Trantor on Sui mainnet which are provided exclusively for the campaign participators on Trantor platform. Find out more details from Trantor Official Website: https://trantor.xyz")));
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<SBT>>(v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<SBT>>(v2);
    }

    public entry fun mint_for_users(arg0: &0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::admin::Contract, arg1: &mut 0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::nft_config::NFTConfig, arg2: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<SBT>, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::admin::assert_admin(arg0, arg4);
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v0, 0x1::ascii::string(b"reward_index"));
        0x1::vector::push_back<0x1::ascii::String>(&mut v0, 0x1::ascii::string(b"campaign_id"));
        0x1::vector::push_back<0x1::ascii::String>(&mut v0, 0x1::ascii::string(b"campaign_name"));
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v1, 0x1::string::to_ascii(0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::nft_config::get_nft_reward_index(arg1)));
        0x1::vector::push_back<0x1::ascii::String>(&mut v1, 0x1::string::to_ascii(0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::nft_config::get_nft_campaign_id(arg1)));
        0x1::vector::push_back<0x1::ascii::String>(&mut v1, 0x1::string::to_ascii(0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::nft_config::get_nft_campaign_name(arg1)));
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg3)) {
            let v3 = SBT{
                id          : 0x2::object::new(arg4),
                name        : 0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::nft_config::get_nft_name(arg1),
                description : 0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::nft_config::get_nft_description(arg1),
                img_url     : 0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::nft_config::get_nft_img_url(arg1),
                attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(v0, v1),
            };
            let v4 = *0x1::vector::borrow<address>(&arg3, v2);
            0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::nft_config::add_creator(arg1, v4);
            let v5 = MintNFTEvent{
                creator       : v4,
                nft_config_id : 0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::nft_config::get_nft_id(arg1),
            };
            0x2::event::emit<MintNFTEvent>(v5);
            let v6 = Witness{dummy_field: false};
            0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<SBT>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<SBT, Witness>(v6), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<SBT>(arg2), &v3);
            0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<SBT>(arg2, 1);
            0x2::transfer::transfer<SBT>(v3, v4);
            v2 = v2 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

