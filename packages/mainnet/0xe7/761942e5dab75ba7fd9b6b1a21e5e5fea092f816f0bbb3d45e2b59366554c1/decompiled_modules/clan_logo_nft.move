module 0xe7761942e5dab75ba7fd9b6b1a21e5e5fea092f816f0bbb3d45e2b59366554c1::clan_logo_nft {
    struct CLAN_LOGO_NFT has drop {
        dummy_field: bool,
    }

    struct ClanLogoNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        project_url: 0x1::string::String,
    }

    fun init(arg0: CLAN_LOGO_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CLAN_LOGO_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{project_url}"));
        let v5 = 0x2::display::new_with_fields<ClanLogoNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<ClanLogoNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<ClanLogoNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ClanLogoNFT{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"Clan World: AElder Whispers"),
            description : 0x1::string::utf8(b"The official Clan World crest. Art on Walrus, identity on Sui."),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/9uCKVZktCJPMjm6vyZS1ayPSTh9B5yLU5dSs-2AFLdw"),
            project_url : 0x1::string::utf8(b"https://clanworld.wal.app"),
        };
        0x2::transfer::public_transfer<ClanLogoNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

