module 0xb7dfcc6256f50c2e1d6eb4ec63850e3a0772118584b61681f0b9622c012ec0a7::og_nft {
    struct OGNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct OG_NFT has drop {
        dummy_field: bool,
    }

    struct CollectionCap has store, key {
        id: 0x2::object::UID,
        roles: 0xb7dfcc6256f50c2e1d6eb4ec63850e3a0772118584b61681f0b9622c012ec0a7::og_nft_roles::Roles<OG_NFT>,
        total_supply: u64,
        minted: u64,
    }

    struct OGNFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        owner: address,
    }

    public fun accept_ownership(arg0: &mut CollectionCap, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0xb7dfcc6256f50c2e1d6eb4ec63850e3a0772118584b61681f0b9622c012ec0a7::og_nft_roles::pending_owner<OG_NFT>(&arg0.roles);
        let v1 = if (0x1::option::is_some<address>(&v0)) {
            let v2 = 0x2::tx_context::sender(arg1);
            0x1::option::borrow<address>(&v0) == &v2
        } else {
            false
        };
        assert!(v1, 1);
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::accept_role<0xb7dfcc6256f50c2e1d6eb4ec63850e3a0772118584b61681f0b9622c012ec0a7::og_nft_roles::OwnerRole<OG_NFT>>(0xb7dfcc6256f50c2e1d6eb4ec63850e3a0772118584b61681f0b9622c012ec0a7::og_nft_roles::owner_role_mut<OG_NFT>(&mut arg0.roles), arg1);
    }

    public fun create_private_transfer_policy(arg0: &mut CollectionCap, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0xb7dfcc6256f50c2e1d6eb4ec63850e3a0772118584b61681f0b9622c012ec0a7::og_nft_roles::owner<OG_NFT>(&arg0.roles), 1);
        let (v0, v1) = 0x2::transfer_policy::new<OGNFT>(arg1, arg2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicy<OGNFT>>(v0, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<OGNFT>>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun get_attributes(arg0: &OGNFT) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun get_description(arg0: &OGNFT) : 0x1::string::String {
        arg0.description
    }

    public fun get_image_url(arg0: &OGNFT) : 0x1::string::String {
        arg0.image_url
    }

    public fun get_minted(arg0: &CollectionCap) : u64 {
        arg0.minted
    }

    public fun get_name(arg0: &OGNFT) : 0x1::string::String {
        arg0.name
    }

    public fun get_owner(arg0: &CollectionCap) : address {
        0xb7dfcc6256f50c2e1d6eb4ec63850e3a0772118584b61681f0b9622c012ec0a7::og_nft_roles::owner<OG_NFT>(&arg0.roles)
    }

    public fun get_symbol(arg0: &OGNFT) : 0x1::string::String {
        arg0.symbol
    }

    public fun get_total_supply(arg0: &CollectionCap) : u64 {
        arg0.total_supply
    }

    fun init(arg0: OG_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<OG_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"collection_name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"collection_description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"collection_media_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://stake.xmoney.com"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"XMoney Team"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"XMN APR Boost Collection"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Official XMoney NFT collection providing permanent staking APR boosts for XMN token holders. Each NFT grants +2% APR when staked in the XMoney protocol."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeifhunxvdl2lylrly2kjpqwchjtyqyyakpstkgsqi7cr6a367jbkfe"));
        let v5 = 0x2::display::new_with_fields<OGNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<OGNFT>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<OGNFT>(&v0, arg1);
        let v8 = v7;
        let v9 = v6;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<OGNFT>(&mut v9, &v8);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<OGNFT>(&mut v9, &v8, 500, 0);
        let v10 = CollectionCap{
            id           : 0x2::object::new(arg1),
            roles        : 0xb7dfcc6256f50c2e1d6eb4ec63850e3a0772118584b61681f0b9622c012ec0a7::og_nft_roles::new<OG_NFT>(0x2::tx_context::sender(arg1), arg1),
            total_supply : 1000,
            minted       : 0,
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<OGNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<OGNFT>>(v9);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<OGNFT>>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<CollectionCap>(v10, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut CollectionCap, arg1: &0x2::transfer_policy::TransferPolicy<OGNFT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::tx_context::sender(arg3) == 0xb7dfcc6256f50c2e1d6eb4ec63850e3a0772118584b61681f0b9622c012ec0a7::og_nft_roles::owner<OG_NFT>(&arg0.roles), 1);
        assert!(arg0.minted < arg0.total_supply, 2);
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"APR Boost"), 0x1::string::utf8(b"+2%"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Utility"), 0x1::string::utf8(b"Staking Boost"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Token"), 0x1::string::utf8(b"XMN"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Network"), 0x1::string::utf8(b"Sui"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Boost Type"), 0x1::string::utf8(b"Permanent While Staked"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Transferability"), 0x1::string::utf8(b"Transferable"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Version"), 0x1::string::utf8(b"V1"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"staking_apr_boost"), 0x1::string::utf8(b"2%"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"stackable"), 0x1::string::utf8(b"false"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"boost_scope"), 0x1::string::utf8(b"per_wallet"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"applies_while_held"), 0x1::string::utf8(b"false"));
        let v1 = OGNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(b"XMN APR Boost NFT"),
            symbol      : 0x1::string::utf8(b"XMNBOOST"),
            image_url   : 0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeifhunxvdl2lylrly2kjpqwchjtyqyyakpstkgsqi7cr6a367jbkfe"),
            description : 0x1::string::utf8(b"The XMN APR Boost NFT grants its holder a permanent +2% APR increase on XMN staking rewards. Designed for long-term supporters of the XMN ecosystem, this NFT unlocks enhanced staking yields and exclusive benefits across the protocol."),
            attributes  : v0,
        };
        let v2 = 0x2::object::id<OGNFT>(&v1);
        arg0.minted = arg0.minted + 1;
        let (v3, v4) = 0x2::kiosk::new(arg3);
        let v5 = v4;
        let v6 = v3;
        0x2::kiosk::lock<OGNFT>(&mut v6, &v5, arg1, v1);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::create_for(&mut v6, v5, arg2, arg3);
        let v7 = OGNFTMinted{
            object_id : v2,
            owner     : arg2,
        };
        0x2::event::emit<OGNFTMinted>(v7);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v6);
        v2
    }

    public fun set_total_supply(arg0: &mut CollectionCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0xb7dfcc6256f50c2e1d6eb4ec63850e3a0772118584b61681f0b9622c012ec0a7::og_nft_roles::owner<OG_NFT>(&arg0.roles), 1);
        assert!(arg1 >= arg0.minted, 3);
        arg0.total_supply = arg1;
    }

    public fun transfer_ownership(arg0: &mut CollectionCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0xb7dfcc6256f50c2e1d6eb4ec63850e3a0772118584b61681f0b9622c012ec0a7::og_nft_roles::owner<OG_NFT>(&arg0.roles) == 0x2::tx_context::sender(arg2), 1);
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::begin_role_transfer<0xb7dfcc6256f50c2e1d6eb4ec63850e3a0772118584b61681f0b9622c012ec0a7::og_nft_roles::OwnerRole<OG_NFT>>(0xb7dfcc6256f50c2e1d6eb4ec63850e3a0772118584b61681f0b9622c012ec0a7::og_nft_roles::owner_role_mut<OG_NFT>(&mut arg0.roles), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

