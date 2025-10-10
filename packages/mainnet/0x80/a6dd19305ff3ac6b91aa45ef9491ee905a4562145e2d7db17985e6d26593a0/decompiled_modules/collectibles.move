module 0x80a6dd19305ff3ac6b91aa45ef9491ee905a4562145e2d7db17985e6d26593a0::collectibles {
    struct NFT has store, key {
        id: 0x2::object::UID,
        reward_id: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        data: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
    }

    struct WhitelistKeys has store, key {
        id: 0x2::object::UID,
        keys: 0x2::table::Table<0x2::object::ID, vector<0x1::string::String>>,
    }

    struct MintLimitDir has store, key {
        id: 0x2::object::UID,
        mint_limit: 0x2::table::Table<0x1::string::String, u64>,
    }

    struct MintCounter has store, key {
        id: 0x2::object::UID,
        mint_count: 0x2::table::Table<0x1::string::String, u64>,
    }

    struct RewardIdRegistry has store, key {
        id: 0x2::object::UID,
        used: 0x2::table::Table<0x1::string::String, bool>,
    }

    struct COLLECTIBLES has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        reward_id: 0x1::string::String,
        recipient: address,
    }

    struct MetaDataUpdated has copy, drop {
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct NFTDataUpdated has copy, drop {
        user_address: address,
        nft_id: 0x2::object::ID,
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct WhitelistKeyAdded has copy, drop {
        nft_id: 0x2::object::ID,
        key: 0x1::string::String,
    }

    struct WhitelistKeyRemoved has copy, drop {
        nft_id: 0x2::object::ID,
        key: 0x1::string::String,
    }

    struct NFTBurned has copy, drop {
        object_id: 0x2::object::ID,
    }

    struct ImageUrlUpdated has copy, drop {
        object_id: 0x2::object::ID,
        image_url: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
    }

    struct MintLimitSet has copy, drop {
        reward_id: 0x1::string::String,
        mint_limit: u64,
    }

    public fun add_whitelist_key(arg0: &mut WhitelistKeys, arg1: &NFT, arg2: 0x1::string::String, arg3: &0x80a6dd19305ff3ac6b91aa45ef9491ee905a4562145e2d7db17985e6d26593a0::admin::AdminRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x80a6dd19305ff3ac6b91aa45ef9491ee905a4562145e2d7db17985e6d26593a0::admin::is_admin(arg3, 0x2::tx_context::sender(arg4)), 0);
        let v0 = 0x2::object::id<NFT>(arg1);
        if (0x2::table::contains<0x2::object::ID, vector<0x1::string::String>>(&arg0.keys, v0)) {
            let v1 = 0x2::table::borrow_mut<0x2::object::ID, vector<0x1::string::String>>(&mut arg0.keys, v0);
            if (!0x1::vector::contains<0x1::string::String>(v1, &arg2)) {
                0x1::vector::push_back<0x1::string::String>(v1, arg2);
                let v2 = WhitelistKeyAdded{
                    nft_id : v0,
                    key    : arg2,
                };
                0x2::event::emit<WhitelistKeyAdded>(v2);
            };
        } else {
            let v3 = 0x1::vector::empty<0x1::string::String>();
            0x1::vector::push_back<0x1::string::String>(&mut v3, arg2);
            0x2::table::add<0x2::object::ID, vector<0x1::string::String>>(&mut arg0.keys, v0, v3);
            let v4 = WhitelistKeyAdded{
                nft_id : v0,
                key    : arg2,
            };
            0x2::event::emit<WhitelistKeyAdded>(v4);
        };
    }

    public fun burn_nft(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let NFT {
            id            : v0,
            reward_id     : _,
            name          : _,
            description   : _,
            image_url     : _,
            thumbnail_url : _,
            data          : v6,
        } = arg0;
        0x2::table::drop<0x1::string::String, 0x1::string::String>(v6);
        let v7 = NFTBurned{object_id: 0x2::object::id<NFT>(&arg0)};
        0x2::event::emit<NFTBurned>(v7);
        0x2::object::delete(v0);
    }

    public fun get_mint_count(arg0: &MintCounter, arg1: 0x1::string::String) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.mint_count, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.mint_count, arg1)
        } else {
            0
        }
    }

    public fun get_mint_limit(arg0: &MintLimitDir, arg1: 0x1::string::String) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.mint_limit, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.mint_limit, arg1)
        } else {
            0
        }
    }

    fun increase_mint_counter(arg0: &mut MintCounter, arg1: 0x1::string::String) {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.mint_count, arg1)) {
            let v0 = 0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.mint_count, arg1);
            *v0 = *v0 + 1;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.mint_count, arg1, 1);
        };
    }

    fun init(arg0: COLLECTIBLES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"collection_name"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{thumbnail_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://playnet.xyz/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"PlayNet"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"PlayNet Collectibles"));
        let v4 = 0x2::package::claim<COLLECTIBLES>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        let v6 = MintLimitDir{
            id         : 0x2::object::new(arg1),
            mint_limit : 0x2::table::new<0x1::string::String, u64>(arg1),
        };
        let v7 = MintCounter{
            id         : 0x2::object::new(arg1),
            mint_count : 0x2::table::new<0x1::string::String, u64>(arg1),
        };
        let v8 = WhitelistKeys{
            id   : 0x2::object::new(arg1),
            keys : 0x2::table::new<0x2::object::ID, vector<0x1::string::String>>(arg1),
        };
        let v9 = RewardIdRegistry{
            id   : 0x2::object::new(arg1),
            used : 0x2::table::new<0x1::string::String, bool>(arg1),
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MintLimitDir>(v6);
        0x2::transfer::share_object<MintCounter>(v7);
        0x2::transfer::share_object<WhitelistKeys>(v8);
        0x2::transfer::share_object<RewardIdRegistry>(v9);
    }

    fun is_mint_limit_reached(arg0: &MintLimitDir, arg1: &MintCounter, arg2: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, u64>(&arg0.mint_limit, arg2) && 0x2::table::contains<0x1::string::String, u64>(&arg1.mint_count, arg2) && *0x2::table::borrow<0x1::string::String, u64>(&arg1.mint_count, arg2) >= *0x2::table::borrow<0x1::string::String, u64>(&arg0.mint_limit, arg2)
    }

    public fun mint_nft_to_recipient(arg0: &MintLimitDir, arg1: &mut MintCounter, arg2: &0x80a6dd19305ff3ac6b91aa45ef9491ee905a4562145e2d7db17985e6d26593a0::admin::AdminRegistry, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x80a6dd19305ff3ac6b91aa45ef9491ee905a4562145e2d7db17985e6d26593a0::admin::is_admin(arg2, 0x2::tx_context::sender(arg9)), 0);
        assert!(!is_mint_limit_reached(arg0, arg1, arg3), 1);
        let v0 = NFT{
            id            : 0x2::object::new(arg9),
            reward_id     : arg3,
            name          : arg4,
            description   : arg5,
            image_url     : arg6,
            thumbnail_url : arg7,
            data          : 0x2::table::new<0x1::string::String, 0x1::string::String>(arg9),
        };
        increase_mint_counter(arg1, arg3);
        let v1 = NFTMinted{
            object_id : 0x2::object::id<NFT>(&v0),
            reward_id : arg3,
            recipient : arg8,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<NFT>(v0, arg8);
    }

    public fun remove_whitelist_key(arg0: &mut WhitelistKeys, arg1: &NFT, arg2: 0x1::string::String, arg3: &0x80a6dd19305ff3ac6b91aa45ef9491ee905a4562145e2d7db17985e6d26593a0::admin::AdminRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x80a6dd19305ff3ac6b91aa45ef9491ee905a4562145e2d7db17985e6d26593a0::admin::is_admin(arg3, 0x2::tx_context::sender(arg4)), 0);
        let v0 = 0x2::object::id<NFT>(arg1);
        if (0x2::table::contains<0x2::object::ID, vector<0x1::string::String>>(&arg0.keys, v0)) {
            let v1 = 0x2::table::borrow_mut<0x2::object::ID, vector<0x1::string::String>>(&mut arg0.keys, v0);
            if (0x1::vector::contains<0x1::string::String>(v1, &arg2)) {
                let (_, v3) = 0x1::vector::index_of<0x1::string::String>(v1, &arg2);
                0x1::vector::remove<0x1::string::String>(v1, v3);
                let v4 = WhitelistKeyRemoved{
                    nft_id : v0,
                    key    : arg2,
                };
                0x2::event::emit<WhitelistKeyRemoved>(v4);
            };
        };
    }

    public fun set_mint_limit(arg0: &0x2::package::Publisher, arg1: &mut MintLimitDir, arg2: &MintCounter, arg3: 0x1::string::String, arg4: u64) {
        assert!(0x2::package::from_module<COLLECTIBLES>(arg0), 0);
        assert!(arg4 >= get_mint_count(arg2, arg3), 1);
        if (0x2::table::contains<0x1::string::String, u64>(&arg1.mint_limit, arg3)) {
            *0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg1.mint_limit, arg3) = arg4;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg1.mint_limit, arg3, arg4);
        };
        let v0 = MintLimitSet{
            reward_id  : arg3,
            mint_limit : arg4,
        };
        0x2::event::emit<MintLimitSet>(v0);
    }

    public fun update_collection_name(arg0: &0x2::package::Publisher, arg1: &mut 0x2::display::Display<NFT>, arg2: 0x1::string::String) {
        assert!(0x2::package::from_module<COLLECTIBLES>(arg0), 0);
        0x2::display::edit<NFT>(arg1, 0x1::string::utf8(b"collection_name"), arg2);
        0x2::display::update_version<NFT>(arg1);
        let v0 = MetaDataUpdated{
            key   : 0x1::string::utf8(b"collection_name"),
            value : arg2,
        };
        0x2::event::emit<MetaDataUpdated>(v0);
    }

    public fun update_creator(arg0: &0x2::package::Publisher, arg1: &mut 0x2::display::Display<NFT>, arg2: 0x1::string::String) {
        assert!(0x2::package::from_module<COLLECTIBLES>(arg0), 0);
        0x2::display::edit<NFT>(arg1, 0x1::string::utf8(b"creator"), arg2);
        0x2::display::update_version<NFT>(arg1);
        let v0 = MetaDataUpdated{
            key   : 0x1::string::utf8(b"creator"),
            value : arg2,
        };
        0x2::event::emit<MetaDataUpdated>(v0);
    }

    public fun update_data(arg0: &mut NFT, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &WhitelistKeys, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<NFT>(arg0);
        assert!(0x2::table::contains<0x2::object::ID, vector<0x1::string::String>>(&arg3.keys, v0), 2);
        assert!(0x1::vector::contains<0x1::string::String>(0x2::table::borrow<0x2::object::ID, vector<0x1::string::String>>(&arg3.keys, v0), &arg1), 2);
        if (0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.data, arg1)) {
            *0x2::table::borrow_mut<0x1::string::String, 0x1::string::String>(&mut arg0.data, arg1) = arg2;
        } else {
            0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg0.data, arg1, arg2);
        };
        let v1 = NFTDataUpdated{
            user_address : 0x2::tx_context::sender(arg4),
            nft_id       : 0x2::object::id<NFT>(arg0),
            key          : arg1,
            value        : arg2,
        };
        0x2::event::emit<NFTDataUpdated>(v1);
    }

    public fun update_image_url(arg0: &mut NFT, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        arg0.image_url = arg1;
        arg0.thumbnail_url = arg2;
        let v0 = ImageUrlUpdated{
            object_id     : 0x2::object::id<NFT>(arg0),
            image_url     : arg1,
            thumbnail_url : arg2,
        };
        0x2::event::emit<ImageUrlUpdated>(v0);
    }

    public fun update_project_url(arg0: &0x2::package::Publisher, arg1: &mut 0x2::display::Display<NFT>, arg2: 0x1::string::String) {
        assert!(0x2::package::from_module<COLLECTIBLES>(arg0), 0);
        0x2::display::edit<NFT>(arg1, 0x1::string::utf8(b"project_url"), arg2);
        0x2::display::update_version<NFT>(arg1);
        let v0 = MetaDataUpdated{
            key   : 0x1::string::utf8(b"project_url"),
            value : arg2,
        };
        0x2::event::emit<MetaDataUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

