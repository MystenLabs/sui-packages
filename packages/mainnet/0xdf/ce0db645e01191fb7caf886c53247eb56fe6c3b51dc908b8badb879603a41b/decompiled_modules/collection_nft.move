module 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft {
    struct COLLECTION_NFT has drop {
        dummy_field: bool,
    }

    struct CollectionNftMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        image_url: 0x2::url::Url,
        title: 0x1::string::String,
        maintainer_balance_change: u64,
        timestamp_ms: u64,
    }

    fun init(arg0: COLLECTION_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x2::package::claim<COLLECTION_NFT>(arg0, arg1);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{title}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"This AI artwork was created by the community of The Collection. It was minted as artwork #{index}."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://thecollection.ai"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"The Collection"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://arweave.net/K_N97SKiJU-jv-O4_7MwEwRnuGt5z7rJJp3GKJcRqBs"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"A collection of AI art as selected by the community."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Ethos"));
        let v5 = 0x2::display::new_with_fields<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft>(&v2, v0, v3, arg1);
        0x2::display::update_version<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::assert_maintainer_version_and_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg8);
        let (v1, v2) = pay_and_create(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, v0);
        0x2::transfer::public_transfer<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft>(v1, v0);
    }

    public entry fun mint_with_bundle(arg0: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_bundle::CollectionBundle, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_bundle::assert_valid_purchase(arg3, 3);
        0x2::transfer::public_transfer<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft>(pay_and_create_with_bundle(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0, arg7, arg8), v0);
    }

    public(friend) fun pay_and_create(arg0: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft, 0x2::coin::Coin<0x2::sui::SUI>) {
        let (v0, v1) = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::pay_for_nft_mint(arg3, arg0, arg8);
        (private_mint(arg0, arg1, arg2, arg4, arg5, arg6, v0, arg7, arg8), v1)
    }

    public(friend) fun pay_and_create_with_bundle(arg0: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_bundle::CollectionBundle, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft {
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_bundle::assert_valid_purchase(arg3, 3);
        let v0 = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::ticket_units_for_nft_mint(arg0);
        assert!(v0 > 0, 1);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_bundle::decrement(arg3, v0);
        private_mint(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    fun private_mint(arg0: &mut 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::CollectionMaintainer, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft {
        assert!(!0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::is_image_minted(arg3, arg0), 2);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::create(arg1, arg2, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::public_key(arg0), 0x1::string::utf8(arg3), 0x2::url::new_unsafe_from_bytes(arg4), 0x1::string::utf8(arg5), v0, 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::increment_nft_mint_count(arg0), arg7, arg8);
        0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_maintainer::add_minted_image(arg0, arg3, 0x2::object::id<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft>(&v1));
        let v2 = CollectionNftMinted{
            object_id                 : 0x2::object::id<0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::CollectionNft>(&v1),
            creator                   : v0,
            image_url                 : 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::image_url(&v1),
            title                     : 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_nft_type::title(&v1),
            maintainer_balance_change : arg6,
            timestamp_ms              : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<CollectionNftMinted>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

