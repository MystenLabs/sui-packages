module 0x31528e6282aea6ef733a795c648aefab755b085f58894f23d2a5b323004055c1::drops {
    struct Royalty has copy, drop, store {
        royalty_points_numerator: u64,
        royalty_points_denominator: u64,
        payee_address: address,
    }

    struct MintedByCount has store, key {
        id: 0x2::object::UID,
        count: u64,
        allowlist_count: u64,
        public_count: u64,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        price: u64,
        from: u64,
        to: u64,
        maximum_supply: u64,
        total_supply: u64,
        uri: 0x1::string::String,
        tokens_uri: 0x1::string::String,
        royalty: Royalty,
        allowlist: Allowlist,
        first_token_id: u64,
        tokens_metadata: 0x2::object_table::ObjectTable<u64, NFTMetadata>,
    }

    struct Attribute has copy, drop, store {
        name: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct OmniseaNFT has store, key {
        id: 0x2::object::UID,
        token_id: u64,
        name: 0x1::string::String,
        url: 0x2::url::Url,
        token_uri: 0x2::url::Url,
        attributes: vector<Attribute>,
        collection_name: 0x1::string::String,
        collection_creator: address,
    }

    struct NFTMetadata has store, key {
        id: 0x2::object::UID,
        image_cid: 0x1::string::String,
        attribute_names: vector<0x1::string::String>,
        attribute_values: vector<0x1::string::String>,
    }

    struct NFTMinted has copy, drop, store {
        object_id: 0x2::object::ID,
        receiver: address,
        name: 0x1::string::String,
    }

    struct LaunchpadMetadata has store, key {
        id: 0x2::object::UID,
        minted_by: 0x2::object_table::ObjectTable<CollectionIdentifier, 0x2::object_table::ObjectTable<address, MintedByCount>>,
        created_by: 0x2::object_table::ObjectTable<address, 0x2::object_table::ObjectTable<0x1::string::String, Collection>>,
    }

    struct LaunchpadConfig has key {
        id: 0x2::object::UID,
        deployer: address,
        fee_recipient: address,
        protocol_fee: u64,
        is_paused: bool,
    }

    struct Allowlist has store, key {
        id: 0x2::object::UID,
        root: vector<u8>,
        max_per_address: u64,
        is_enabled: bool,
        public_from: u64,
        public_max_per_address: u64,
        price: u64,
    }

    struct CollectionIdentifier has copy, drop, store {
        name: 0x1::string::String,
        creator: address,
    }

    public entry fun create_collection(arg0: &mut LaunchpadMetadata, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = 0x1::string::utf8(b"ipfs://");
        let v2 = &mut v1;
        0x1::string::append(v2, 0x1::string::utf8(arg4));
        let v3 = if (arg11 > 0) {
            1
        } else {
            0
        };
        if (arg7 > 0) {
            assert!(arg7 >= get_current_timestamp(arg12), 10);
        };
        if (arg8 > 0) {
            assert!(arg8 > arg7 && arg8 > get_current_timestamp(arg12), 11);
        };
        let v4 = Royalty{
            royalty_points_numerator   : arg10,
            royalty_points_denominator : 10000,
            payee_address              : v0,
        };
        let v5 = Allowlist{
            id                     : 0x2::object::new(arg13),
            root                   : 0x1::vector::empty<u8>(),
            max_per_address        : 0,
            is_enabled             : false,
            public_from            : 0,
            public_max_per_address : 0,
            price                  : 0,
        };
        let v6 = Collection{
            id              : 0x2::object::new(arg13),
            owner           : v0,
            name            : 0x1::string::utf8(arg1),
            description     : 0x1::string::utf8(arg2),
            image_url       : get_image_url_from_cid(arg3),
            price           : arg6,
            from            : arg7,
            to              : arg8,
            maximum_supply  : arg9,
            total_supply    : 0,
            uri             : *v2,
            tokens_uri      : 0x1::string::utf8(arg5),
            royalty         : v4,
            allowlist       : v5,
            first_token_id  : v3,
            tokens_metadata : 0x2::object_table::new<u64, NFTMetadata>(arg13),
        };
        let v7 = &mut arg0.created_by;
        if (0x2::object_table::contains<address, 0x2::object_table::ObjectTable<0x1::string::String, Collection>>(v7, v0)) {
            let v8 = 0x2::object_table::borrow_mut<address, 0x2::object_table::ObjectTable<0x1::string::String, Collection>>(v7, v0);
            assert!(!0x2::object_table::contains<0x1::string::String, Collection>(v8, v6.name), 9);
            0x2::object_table::add<0x1::string::String, Collection>(v8, v6.name, v6);
        } else {
            let v9 = 0x2::object_table::new<0x1::string::String, Collection>(arg13);
            0x2::object_table::add<0x1::string::String, Collection>(&mut v9, v6.name, v6);
            0x2::object_table::add<address, 0x2::object_table::ObjectTable<0x1::string::String, Collection>>(v7, v0, v9);
        };
        let v10 = CollectionIdentifier{
            name    : 0x1::string::utf8(arg1),
            creator : v0,
        };
        0x2::object_table::add<CollectionIdentifier, 0x2::object_table::ObjectTable<address, MintedByCount>>(&mut arg0.minted_by, v10, 0x2::object_table::new<address, MintedByCount>(arg13));
    }

    fun get_current_price(arg0: &0x2::clock::Clock, arg1: &mut Collection) : u64 {
        if (!arg1.allowlist.is_enabled || get_current_timestamp(arg0) >= arg1.allowlist.public_from) {
            arg1.price
        } else {
            arg1.allowlist.price
        }
    }

    fun get_current_timestamp(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    fun get_image_url_from_cid(arg0: vector<u8>) : 0x2::url::Url {
        let v0 = 0x1::string::utf8(b"https://omnisea.infura-ipfs.io/ipfs/");
        let v1 = &mut v0;
        0x1::string::append_utf8(v1, arg0);
        0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(v1))
    }

    fun get_token_attributes_from_collection(arg0: &mut OmniseaNFT, arg1: &mut Collection) : vector<Attribute> {
        if (0x2::object_table::contains<u64, NFTMetadata>(&arg1.tokens_metadata, arg0.token_id)) {
            let v1 = 0x2::object_table::borrow<u64, NFTMetadata>(&arg1.tokens_metadata, arg0.token_id);
            let v2 = 0x1::vector::empty<Attribute>();
            let v3 = 0;
            while (v3 < 0x1::vector::length<0x1::string::String>(&v1.attribute_names)) {
                let v4 = Attribute{
                    name  : *0x1::vector::borrow<0x1::string::String>(&v1.attribute_names, v3),
                    value : *0x1::vector::borrow<0x1::string::String>(&v1.attribute_values, v3),
                };
                0x1::vector::push_back<Attribute>(&mut v2, v4);
                v3 = v3 + 1;
            };
            v2
        } else {
            0x1::vector::empty<Attribute>()
        }
    }

    fun get_token_image_url_from_collection(arg0: &mut OmniseaNFT, arg1: &mut Collection) : 0x2::url::Url {
        if (0x2::object_table::contains<u64, NFTMetadata>(&arg1.tokens_metadata, arg0.token_id)) {
            get_image_url_from_cid(*0x1::string::bytes(&0x2::object_table::borrow<u64, NFTMetadata>(&arg1.tokens_metadata, arg0.token_id).image_cid))
        } else {
            arg1.image_url
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = LaunchpadMetadata{
            id         : 0x2::object::new(arg0),
            minted_by  : 0x2::object_table::new<CollectionIdentifier, 0x2::object_table::ObjectTable<address, MintedByCount>>(arg0),
            created_by : 0x2::object_table::new<address, 0x2::object_table::ObjectTable<0x1::string::String, Collection>>(arg0),
        };
        0x2::transfer::share_object<LaunchpadMetadata>(v1);
        let v2 = LaunchpadConfig{
            id            : 0x2::object::new(arg0),
            deployer      : v0,
            fee_recipient : v0,
            protocol_fee  : 5,
            is_paused     : false,
        };
        0x2::transfer::share_object<LaunchpadConfig>(v2);
    }

    public entry fun mint(arg0: &mut LaunchpadConfig, arg1: &mut LaunchpadMetadata, arg2: 0x1::string::String, arg3: address, arg4: vector<vector<u8>>, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 16);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::object_table::borrow_mut<0x1::string::String, Collection>(0x2::object_table::borrow_mut<address, 0x2::object_table::ObjectTable<0x1::string::String, Collection>>(&mut arg1.created_by, arg3), arg2);
        let v2 = v1.from;
        let v3 = v1.to;
        assert!(v2 == 0 || get_current_timestamp(arg8) >= v2, 2);
        assert!(v3 == 0 || get_current_timestamp(arg8) < v3, 3);
        let v4 = get_current_price(arg8, v1);
        let v5 = v4 * arg5;
        if (v5 > 0) {
            assert!(v5 <= arg7, 14);
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= v5, 1);
        };
        if (v1.maximum_supply > 0) {
            assert!(arg5 + v1.total_supply <= v1.maximum_supply, 6);
        };
        let v6 = &mut v1.allowlist;
        let v7 = CollectionIdentifier{
            name    : arg2,
            creator : arg3,
        };
        let v8 = 0x2::object_table::borrow_mut<CollectionIdentifier, 0x2::object_table::ObjectTable<address, MintedByCount>>(&mut arg1.minted_by, v7);
        let v9 = if (0x2::object_table::contains<address, MintedByCount>(v8, v0)) {
            0x2::object_table::borrow_mut<address, MintedByCount>(v8, v0)
        } else {
            let v10 = MintedByCount{
                id              : 0x2::object::new(arg9),
                count           : 0,
                allowlist_count : 0,
                public_count    : 0,
            };
            0x2::object_table::add<address, MintedByCount>(v8, v0, v10);
            0x2::object_table::borrow_mut<address, MintedByCount>(v8, v0)
        };
        if (v6.is_enabled) {
            if (!(v6.public_from <= get_current_timestamp(arg8))) {
                if (v6.max_per_address > 0) {
                    let v11 = v6.root;
                    assert!(!0x1::vector::is_empty<u8>(&v11), 15);
                    let v12 = 0x2::address::to_string(v0);
                    assert!(0x31528e6282aea6ef733a795c648aefab755b085f58894f23d2a5b323004055c1::merkle_proof::verify(&arg4, v11, 0x1::hash::sha3_256(*0x1::string::bytes(&v12))), 5);
                    assert!(v9.allowlist_count + arg5 <= v6.max_per_address, 5);
                    v9.allowlist_count = v9.allowlist_count + arg5;
                };
            } else if (v6.public_max_per_address > 0) {
                assert!(v9.public_count + arg5 <= v6.public_max_per_address, 5);
                v9.public_count = v9.public_count + arg5;
            };
        };
        if (v5 > 0) {
            let v13 = arg0.protocol_fee * v5 / 100;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg6, v5 - v13, arg9), v1.owner);
            if (v13 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg6, v13, arg9), arg0.fee_recipient);
            };
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, v0);
        let v14 = v1.total_supply + arg5;
        let v15 = if (v1.first_token_id > 0) {
            v14 + 1
        } else {
            v14
        };
        let v16 = v1.total_supply + v1.first_token_id;
        while (v16 < v15) {
            let v17 = u64_to_string(v16);
            let v18 = 0x1::string::utf8(b"ipfs://");
            let v19 = &mut v18;
            0x1::string::append(v19, v1.tokens_uri);
            0x1::string::append(v19, 0x1::string::utf8(b"/"));
            0x1::string::append(v19, 0x1::string::utf8(v17));
            0x1::string::append(v19, 0x1::string::utf8(b".json"));
            let v20 = v1.name;
            0x1::string::append(&mut v20, 0x1::string::utf8(b" #"));
            0x1::string::append(&mut v20, 0x1::string::utf8(v17));
            let v21 = OmniseaNFT{
                id                 : 0x2::object::new(arg9),
                token_id           : v16,
                name               : v20,
                url                : v1.image_url,
                token_uri          : 0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(v19)),
                attributes         : 0x1::vector::empty<Attribute>(),
                collection_name    : v1.name,
                collection_creator : v1.owner,
            };
            let v22 = &mut v21;
            let v23 = get_token_image_url_from_collection(v22, v1);
            v21.url = v23;
            let v24 = &mut v21;
            let v25 = get_token_attributes_from_collection(v24, v1);
            v21.attributes = v25;
            let v26 = NFTMinted{
                object_id : 0x2::object::id<OmniseaNFT>(&v21),
                receiver  : v0,
                name      : v21.name,
            };
            0x2::event::emit<NFTMinted>(v26);
            0x2::transfer::public_transfer<OmniseaNFT>(v21, v0);
            v16 = v16 + 1;
        };
        v1.total_supply = v14;
        v9.count = v9.count + arg5;
    }

    public entry fun premint(arg0: &mut LaunchpadMetadata, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object_table::borrow_mut<0x1::string::String, Collection>(0x2::object_table::borrow_mut<address, 0x2::object_table::ObjectTable<0x1::string::String, Collection>>(&mut arg0.created_by, arg2), arg1);
        assert!(v0 == arg2, 12);
        if (v1.maximum_supply > 0) {
            assert!(arg3 + v1.total_supply <= v1.maximum_supply, 6);
        };
        let v2 = v1.total_supply + arg3;
        let v3 = if (v1.first_token_id > 0) {
            v2 + 1
        } else {
            v2
        };
        let v4 = v1.total_supply + v1.first_token_id;
        while (v4 < v3) {
            let v5 = u64_to_string(v4);
            let v6 = 0x1::string::utf8(b"ipfs://");
            let v7 = &mut v6;
            0x1::string::append(v7, v1.tokens_uri);
            0x1::string::append(v7, 0x1::string::utf8(b"/"));
            0x1::string::append(v7, 0x1::string::utf8(v5));
            0x1::string::append(v7, 0x1::string::utf8(b".json"));
            let v8 = v1.name;
            0x1::string::append(&mut v8, 0x1::string::utf8(b" #"));
            0x1::string::append(&mut v8, 0x1::string::utf8(v5));
            let v9 = OmniseaNFT{
                id                 : 0x2::object::new(arg4),
                token_id           : v4,
                name               : v8,
                url                : v1.image_url,
                token_uri          : 0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(v7)),
                attributes         : 0x1::vector::empty<Attribute>(),
                collection_name    : v1.name,
                collection_creator : v1.owner,
            };
            let v10 = &mut v9;
            let v11 = get_token_image_url_from_collection(v10, v1);
            v9.url = v11;
            let v12 = &mut v9;
            let v13 = get_token_attributes_from_collection(v12, v1);
            v9.attributes = v13;
            let v14 = NFTMinted{
                object_id : 0x2::object::id<OmniseaNFT>(&v9),
                receiver  : v0,
                name      : v9.name,
            };
            0x2::event::emit<NFTMinted>(v14);
            0x2::transfer::public_transfer<OmniseaNFT>(v9, v0);
            v4 = v4 + 1;
        };
        v1.total_supply = v2;
    }

    public entry fun refresh_token_metadata(arg0: &mut LaunchpadMetadata, arg1: OmniseaNFT, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x1::string::String, Collection>(0x2::object_table::borrow_mut<address, 0x2::object_table::ObjectTable<0x1::string::String, Collection>>(&mut arg0.created_by, arg1.collection_creator), arg1.collection_name);
        let v1 = &mut arg1;
        let v2 = get_token_image_url_from_collection(v1, v0);
        arg1.url = v2;
        let v3 = &mut arg1;
        arg1.attributes = get_token_attributes_from_collection(v3, v0);
        0x2::transfer::public_transfer<OmniseaNFT>(arg1, 0x2::tx_context::sender(arg2));
    }

    public entry fun set_allowlist(arg0: &mut LaunchpadMetadata, arg1: 0x1::string::String, arg2: address, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x1::string::String, Collection>(0x2::object_table::borrow_mut<address, 0x2::object_table::ObjectTable<0x1::string::String, Collection>>(&mut arg0.created_by, arg2), arg1);
        assert!(0x2::tx_context::sender(arg9) == arg2, 12);
        let v1 = &mut v0.allowlist;
        v1.root = arg3;
        v1.max_per_address = arg4;
        v1.public_max_per_address = arg5;
        v1.public_from = arg6;
        v1.is_enabled = arg8;
        v1.price = arg7;
    }

    public entry fun set_collection_public_price(arg0: &mut LaunchpadMetadata, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x1::string::String, Collection>(0x2::object_table::borrow_mut<address, 0x2::object_table::ObjectTable<0x1::string::String, Collection>>(&mut arg0.created_by, arg2), arg1);
        assert!(0x2::tx_context::sender(arg4) == arg2, 12);
        v0.price = arg3;
    }

    public entry fun set_fee_recipient(arg0: &mut LaunchpadConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.deployer, 7);
        arg0.fee_recipient = arg1;
    }

    public entry fun set_global_pause(arg0: &mut LaunchpadConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.deployer, 7);
        arg0.is_paused = arg1;
    }

    public entry fun set_protocol_fee(arg0: &mut LaunchpadConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.deployer, 7);
        assert!(arg1 <= 20, 8);
        arg0.protocol_fee = arg1;
    }

    public entry fun set_tokens_metadata(arg0: &mut LaunchpadMetadata, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: vector<vector<0x1::string::String>>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x1::string::String, Collection>(0x2::object_table::borrow_mut<address, 0x2::object_table::ObjectTable<0x1::string::String, Collection>>(&mut arg0.created_by, arg2), arg1);
        assert!(0x2::tx_context::sender(arg7) == arg2, 12);
        assert!(arg3 < v0.maximum_supply, 17);
        let v1 = 0x1::vector::length<0x1::string::String>(&arg4);
        assert!(v1 > 0, 13);
        let v2 = &mut v0.tokens_metadata;
        let v3 = 0;
        while (v3 < v1) {
            let v4 = arg3 + v3;
            let v5 = if (0x1::vector::length<vector<0x1::string::String>>(&arg6) > v3) {
                0x1::vector::borrow<vector<0x1::string::String>>(&arg6, v3)
            } else {
                let v6 = 0x1::vector::empty<0x1::string::String>();
                &v6
            };
            if (0x2::object_table::contains<u64, NFTMetadata>(v2, v4)) {
                let v7 = 0x2::object_table::borrow_mut<u64, NFTMetadata>(v2, v4);
                v7.image_cid = *0x1::vector::borrow<0x1::string::String>(&arg4, v3);
                v7.attribute_names = arg5;
                v7.attribute_values = *v5;
            } else {
                let v8 = NFTMetadata{
                    id               : 0x2::object::new(arg7),
                    image_cid        : *0x1::vector::borrow<0x1::string::String>(&arg4, v3),
                    attribute_names  : arg5,
                    attribute_values : *v5,
                };
                0x2::object_table::add<u64, NFTMetadata>(v2, v4, v8);
            };
            v3 = v3 + 1;
        };
    }

    fun u64_to_string(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 / 10 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::push_back<u8>(&mut v0, ((arg0 + 48) as u8));
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    // decompiled from Move bytecode v6
}

