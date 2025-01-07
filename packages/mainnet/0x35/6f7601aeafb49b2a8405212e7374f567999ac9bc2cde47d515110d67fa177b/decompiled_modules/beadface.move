module 0x356f7601aeafb49b2a8405212e7374f567999ac9bc2cde47d515110d67fa177b::beadface {
    struct GlobalRegistry has key {
        id: 0x2::object::UID,
        limit: u64,
        supply: u64,
        minted: u64,
        inventory: vector<CollectionMeta>,
        url: 0x2::url::Url,
        creator: address,
        graces: vector<0x2::object::ID>,
        majesties: vector<0x2::object::ID>,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        limit: u64,
        supply: u64,
        minted: u64,
        image_url: 0x2::url::Url,
        animation_url: 0x2::url::Url,
        url: 0x2::url::Url,
        inventory: vector<NFTMeta>,
        templates: 0x2::table::Table<0x1::string::String, NFTTemplate>,
        creator: address,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        collection: 0x1::string::String,
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        index: u64,
        supply: u64,
        image_url: 0x2::url::Url,
        animation_url: 0x2::url::Url,
        url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        creator: address,
    }

    struct NFTTemplate has copy, store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        index: u64,
        supply: u64,
        image_url: 0x2::url::Url,
        animation_url: 0x2::url::Url,
        url: 0x2::url::Url,
    }

    struct CollectionMeta has store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        collection_id: 0x2::object::ID,
        limit: u64,
        image_url: 0x2::url::Url,
    }

    struct NFTMeta has store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        limit: u64,
        image_url: 0x2::url::Url,
    }

    struct TreasuryCapability has store, key {
        id: 0x2::object::UID,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        index: u64,
        creator: address,
    }

    struct CollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        limit: u64,
        creator: address,
    }

    struct BEADFACE has drop {
        dummy_field: bool,
    }

    fun claim_admin_cap(arg0: &BEADFACE, arg1: &mut 0x2::tx_context::TxContext) : TreasuryCapability {
        TreasuryCapability{id: 0x2::object::new(arg1)}
    }

    public entry fun create_collection(arg0: &TreasuryCapability, arg1: &mut GlobalRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 101);
        assert!(arg1.limit + arg4 <= 18000000, 901);
        let v0 = Collection{
            id            : 0x2::object::new(arg8),
            name          : arg2,
            description   : arg3,
            limit         : arg4,
            supply        : 0,
            minted        : 0,
            image_url     : 0x2::url::new_unsafe_from_bytes(arg5),
            animation_url : 0x2::url::new_unsafe_from_bytes(arg6),
            url           : 0x2::url::new_unsafe_from_bytes(arg7),
            inventory     : 0x1::vector::empty<NFTMeta>(),
            templates     : 0x2::table::new<0x1::string::String, NFTTemplate>(arg8),
            creator       : 0x2::tx_context::sender(arg8),
        };
        let v1 = 0x2::object::id<Collection>(&v0);
        let v2 = CollectionCreated{
            collection_id : v1,
            name          : arg2,
            description   : arg3,
            limit         : arg4,
            creator       : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<CollectionCreated>(v2);
        0x2::transfer::share_object<Collection>(v0);
        let v3 = CollectionMeta{
            name          : arg2,
            description   : arg3,
            collection_id : v1,
            limit         : arg4,
            image_url     : 0x2::url::new_unsafe_from_bytes(arg5),
        };
        0x1::vector::push_back<CollectionMeta>(&mut arg1.inventory, v3);
        arg1.limit = arg1.limit + arg4;
    }

    fun create_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<NFT> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"animation_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"attributes"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{animation_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{attributes}"));
        let v4 = 0x2::display::new_with_fields<NFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v4);
        v4
    }

    public entry fun create_template(arg0: &TreasuryCapability, arg1: &mut GlobalRegistry, arg2: &mut Collection, arg3: vector<u8>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>) {
        assert!(!0x2::table::contains<0x1::string::String, NFTTemplate>(&arg2.templates, arg4), 104);
        let v0 = grade_quota(arg3);
        assert!(arg2.supply + v0 <= arg2.limit, 902);
        let v1 = NFTTemplate{
            name          : arg4,
            description   : arg5,
            index         : 0,
            supply        : v0,
            image_url     : 0x2::url::new_unsafe_from_bytes(arg6),
            animation_url : 0x2::url::new_unsafe_from_bytes(arg7),
            url           : 0x2::url::new_unsafe_from_bytes(arg8),
        };
        0x2::table::add<0x1::string::String, NFTTemplate>(&mut arg2.templates, arg4, v1);
        let v2 = NFTMeta{
            name        : arg4,
            description : arg5,
            limit       : v0,
            image_url   : 0x2::url::new_unsafe_from_bytes(arg6),
        };
        0x1::vector::push_back<NFTMeta>(&mut arg2.inventory, v2);
        arg2.supply = arg2.supply + v0;
        arg1.supply = arg1.supply + v0;
    }

    public fun grade_quota(arg0: vector<u8>) : u64 {
        if (arg0 == b"COMMON") {
            1999
        } else if (arg0 == b"SUPERIOR") {
            800
        } else if (arg0 == b"RARE") {
            440
        } else if (arg0 == b"EPIC") {
            210
        } else if (arg0 == b"LEGENDARY") {
            99
        } else if (arg0 == b"IMMORTAL") {
            35
        } else if (arg0 == b"ULTIMATE") {
            7
        } else if (arg0 == b"GRACE") {
            3
        } else {
            assert!(arg0 == b"MAJESTY", 102);
            1
        }
    }

    fun init(arg0: BEADFACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_admin_cap(&arg0, arg1);
        let v1 = 0x2::package::claim<BEADFACE>(arg0, arg1);
        let v2 = create_display(&v1, arg1);
        let v3 = GlobalRegistry{
            id        : 0x2::object::new(arg1),
            limit     : 0,
            supply    : 0,
            minted    : 0,
            inventory : 0x1::vector::empty<CollectionMeta>(),
            url       : 0x2::url::new_unsafe_from_bytes(b""),
            creator   : 0x2::tx_context::sender(arg1),
            graces    : 0x1::vector::empty<0x2::object::ID>(),
            majesties : 0x1::vector::empty<0x2::object::ID>(),
        };
        new_transfer_policy(&v1, arg1);
        0x2::transfer::share_object<GlobalRegistry>(v3);
        0x2::transfer::public_transfer<TreasuryCapability>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &TreasuryCapability, arg1: &mut GlobalRegistry, arg2: &mut Collection, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 101);
        assert!(0x2::table::contains<0x1::string::String, NFTTemplate>(&arg2.templates, arg3), 103);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, NFTTemplate>(&mut arg2.templates, arg3);
        assert!(v0.index + arg4 <= v0.supply, 903);
        let v1 = 0;
        while (v1 < arg4) {
            v0.index = v0.index + 1;
            let v2 = NFT{
                id            : 0x2::object::new(arg7),
                collection    : arg2.name,
                collection_id : 0x2::object::id<Collection>(arg2),
                name          : v0.name,
                description   : v0.description,
                index         : v0.index,
                supply        : v0.supply,
                image_url     : v0.image_url,
                animation_url : v0.animation_url,
                url           : v0.url,
                attributes    : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
                creator       : 0x2::tx_context::sender(arg7),
            };
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v2.attributes, 0x1::string::utf8(b"message"), arg5);
            let v3 = NFTMinted{
                nft_id  : 0x2::object::id<NFT>(&v2),
                name    : v2.name,
                index   : v2.index,
                creator : 0x2::tx_context::sender(arg7),
            };
            0x2::event::emit<NFTMinted>(v3);
            0x2::transfer::public_transfer<NFT>(v2, arg6);
            v1 = v1 + 1;
        };
        arg2.minted = arg2.minted + arg4;
        arg1.minted = arg1.minted + arg4;
    }

    fun new_transfer_policy(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<NFT>(arg0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<NFT>>(v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<NFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

