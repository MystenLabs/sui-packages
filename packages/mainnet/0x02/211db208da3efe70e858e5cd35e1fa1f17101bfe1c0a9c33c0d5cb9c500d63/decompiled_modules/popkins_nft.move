module 0x2211db208da3efe70e858e5cd35e1fa1f17101bfe1c0a9c33c0d5cb9c500d63::popkins_nft {
    struct POPKINS_NFT has drop {
        dummy_field: bool,
    }

    struct PopkinsNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        video_url: 0x1::string::String,
        website: 0x1::string::String,
        creator: 0x1::string::String,
        key: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct PopkinsRegistryPolicy has key {
        id: 0x2::object::UID,
        version: u8,
        transfer_policy: 0x2::transfer_policy::TransferPolicy<PopkinsNFT>,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<PopkinsNFT>,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        key: 0x1::string::String,
        minter: address,
        kiosk_id: 0x2::object::ID,
    }

    struct NFTBurned has copy, drop {
        nft_id: 0x2::object::ID,
        key: 0x1::string::String,
        burner: address,
    }

    public fun id(arg0: &PopkinsNFT) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun attributes(arg0: &PopkinsNFT) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    fun build_attributes_map(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0x1::vector::length<0x1::string::String>(&arg0);
        assert!(v1 == 0x1::vector::length<0x1::string::String>(&arg1), 2);
        let v2 = 0;
        while (v2 < v1) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg0, v2), *0x1::vector::borrow<0x1::string::String>(&arg1, v2));
            v2 = v2 + 1;
        };
        v0
    }

    public entry fun burn(arg0: &PopkinsRegistryPolicy, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        validate_policy_version(arg0);
        let PopkinsNFT {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            video_url   : _,
            website     : _,
            creator     : _,
            key         : v7,
            attributes  : _,
        } = 0x2::kiosk::take<PopkinsNFT>(arg1, arg2, arg3);
        let v9 = v0;
        let v10 = NFTBurned{
            nft_id : 0x2::object::uid_to_inner(&v9),
            key    : v7,
            burner : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<NFTBurned>(v10);
        0x2::object::delete(v9);
    }

    public fun creator(arg0: &PopkinsNFT) : 0x1::string::String {
        arg0.creator
    }

    public fun description(arg0: &PopkinsNFT) : 0x1::string::String {
        arg0.description
    }

    public fun get_transfer_policy(arg0: &PopkinsRegistryPolicy) : &0x2::transfer_policy::TransferPolicy<PopkinsNFT> {
        &arg0.transfer_policy
    }

    public fun image_url(arg0: &PopkinsNFT) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: POPKINS_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<POPKINS_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"video_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"website"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{video_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{website}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{website}"));
        let v5 = 0x2::display::new_with_fields<PopkinsNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<PopkinsNFT>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<PopkinsNFT>(&v0, arg1);
        let v8 = v7;
        let v9 = v6;
        0x2211db208da3efe70e858e5cd35e1fa1f17101bfe1c0a9c33c0d5cb9c500d63::royalty_rule::add_to_policy<PopkinsNFT>(&mut v9, &v8, 0x2211db208da3efe70e858e5cd35e1fa1f17101bfe1c0a9c33c0d5cb9c500d63::royalty_rule::new_config<PopkinsNFT>(@0x3993606b5fd91994ce0575ffc7579177054a26092b87ead515b41e7952647fdb, 700));
        let v10 = PopkinsRegistryPolicy{
            id              : 0x2::object::new(arg1),
            version         : 1,
            transfer_policy : v9,
            policy_cap      : v8,
        };
        0x2::transfer::public_transfer<0x2::display::Display<PopkinsNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<PopkinsRegistryPolicy>(v10);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun key(arg0: &PopkinsNFT) : 0x1::string::String {
        arg0.key
    }

    public fun mint(arg0: &0x2211db208da3efe70e858e5cd35e1fa1f17101bfe1c0a9c33c0d5cb9c500d63::registry::WhiteListMintRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg9: &mut 0x2::tx_context::TxContext) : PopkinsNFT {
        mint_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    fun mint_internal(arg0: &0x2211db208da3efe70e858e5cd35e1fa1f17101bfe1c0a9c33c0d5cb9c500d63::registry::WhiteListMintRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg9: &mut 0x2::tx_context::TxContext) : PopkinsNFT {
        assert!(0x2211db208da3efe70e858e5cd35e1fa1f17101bfe1c0a9c33c0d5cb9c500d63::registry::is_whitelisted(arg0, 0x2::tx_context::sender(arg9)), 0);
        PopkinsNFT{
            id          : 0x2::object::new(arg9),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
            video_url   : arg4,
            website     : arg5,
            creator     : arg6,
            key         : arg7,
            attributes  : arg8,
        }
    }

    public entry fun mint_to_kiosk(arg0: &0x2211db208da3efe70e858e5cd35e1fa1f17101bfe1c0a9c33c0d5cb9c500d63::registry::WhiteListMintRegistry, arg1: &PopkinsRegistryPolicy, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: vector<0x1::string::String>, arg10: vector<0x1::string::String>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_internal(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, build_attributes_map(arg9, arg10), arg11);
        let (v1, v2) = 0x2::kiosk::new(arg11);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::tx_context::sender(arg11);
        0x2::kiosk::lock<PopkinsNFT>(&mut v4, &v3, &arg1.transfer_policy, v0);
        let v6 = NFTMinted{
            nft_id   : 0x2::object::id<PopkinsNFT>(&v0),
            name     : v0.name,
            key      : v0.key,
            minter   : v5,
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(&v4),
        };
        0x2::event::emit<NFTMinted>(v6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, v5);
    }

    public fun name(arg0: &PopkinsNFT) : 0x1::string::String {
        arg0.name
    }

    public fun validate_policy_version(arg0: &PopkinsRegistryPolicy) {
        assert!(arg0.version == 1, 1);
    }

    public fun video_url(arg0: &PopkinsNFT) : 0x1::string::String {
        arg0.video_url
    }

    public fun website(arg0: &PopkinsNFT) : 0x1::string::String {
        arg0.website
    }

    // decompiled from Move bytecode v6
}

