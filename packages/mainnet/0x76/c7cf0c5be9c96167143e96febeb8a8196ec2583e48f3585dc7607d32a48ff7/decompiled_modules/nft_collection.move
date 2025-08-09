module 0x76c7cf0c5be9c96167143e96febeb8a8196ec2583e48f3585dc7607d32a48ff7::nft_collection {
    struct NFT_COLLECTION has drop {
        dummy_field: bool,
    }

    struct MagicEyeBallNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        token_id: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        owner: address,
        total_minted: u64,
        wallet_mints: 0x2::table::Table<address, u64>,
    }

    struct NFTMinted has copy, drop {
        nft_id: address,
        token_id: u64,
        minter: address,
        name: 0x1::string::String,
    }

    struct BulkNFTMinted has copy, drop {
        minter: address,
        amount: u64,
        token_ids: vector<u64>,
        total_paid: u64,
    }

    public fun get_collection_info(arg0: &Collection) : (u64, u64, address) {
        (arg0.total_minted, 500, arg0.owner)
    }

    public fun get_collection_limits() : (u64, u64, u64) {
        (10, 10, 4500000000)
    }

    public fun get_nft_info(arg0: &MagicEyeBallNFT) : (0x1::string::String, 0x1::string::String, 0x1::string::String, u64) {
        (arg0.name, arg0.description, arg0.image_url, arg0.token_id)
    }

    public fun get_remaining_mints_for_wallet(arg0: &Collection, arg1: address) : u64 {
        let v0 = get_wallet_mint_count(arg0, arg1);
        if (v0 >= 10) {
            0
        } else {
            10 - v0
        }
    }

    public fun get_wallet_mint_count(arg0: &Collection, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.wallet_mints, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.wallet_mints, arg1)
        } else {
            0
        }
    }

    fun init(arg0: NFT_COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://magiceyeball.xyz/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Magic Eye Ball"));
        let v4 = 0x2::package::claim<NFT_COLLECTION>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<MagicEyeBallNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<MagicEyeBallNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<MagicEyeBallNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        let v6 = Collection{
            id           : 0x2::object::new(arg1),
            owner        : 0x2::tx_context::sender(arg1),
            total_minted : 0,
            wallet_mints : 0x2::table::new<address, u64>(arg1),
        };
        0x2::transfer::share_object<Collection>(v6);
    }

    public entry fun mint_multiple_nfts(arg0: &mut Collection, arg1: &mut 0x76c7cf0c5be9c96167143e96febeb8a8196ec2583e48f3585dc7607d32a48ff7::attributes::CollectionData, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 7);
        assert!(arg3 <= 10, 6);
        mint_nfts_internal(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun mint_nft(arg0: &mut Collection, arg1: &mut 0x76c7cf0c5be9c96167143e96febeb8a8196ec2583e48f3585dc7607d32a48ff7::attributes::CollectionData, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        mint_nfts_internal(arg0, arg1, arg2, 1, arg3, arg4);
    }

    fun mint_nfts_internal(arg0: &mut Collection, arg1: &mut 0x76c7cf0c5be9c96167143e96febeb8a8196ec2583e48f3585dc7607d32a48ff7::attributes::CollectionData, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg0.total_minted + arg3 <= 500, 1);
        assert!(0x76c7cf0c5be9c96167143e96febeb8a8196ec2583e48f3585dc7607d32a48ff7::attributes::nfts_left(arg1) >= arg3, 4);
        let v1 = if (0x2::table::contains<address, u64>(&arg0.wallet_mints, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.wallet_mints, v0)
        } else {
            0
        };
        assert!(v1 + arg3 <= 10, 5);
        let v2 = 4500000000 * arg3;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.owner);
        let v3 = 0x2::random::new_generator(arg4, arg5);
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0;
        while (v5 < arg3) {
            let v6 = 0x76c7cf0c5be9c96167143e96febeb8a8196ec2583e48f3585dc7607d32a48ff7::attributes::nfts_left(arg1);
            let v7 = if (v6 == 1) {
                0
            } else {
                0x2::random::generate_u64_in_range(&mut v3, 0, v6 - 1)
            };
            let (v8, v9, v10, v11, v12, v13) = 0x76c7cf0c5be9c96167143e96febeb8a8196ec2583e48f3585dc7607d32a48ff7::attributes::get_nft(arg1, v7);
            let v14 = v13;
            let v15 = v12;
            let v16 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
            let v17 = 0;
            while (v17 < 0x1::vector::length<0x1::string::String>(&v15)) {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v16, *0x1::vector::borrow<0x1::string::String>(&v15, v17), *0x1::vector::borrow<0x1::string::String>(&v14, v17));
                v17 = v17 + 1;
            };
            let v18 = MagicEyeBallNFT{
                id          : 0x2::object::new(arg5),
                name        : v10,
                description : v11,
                image_url   : v9,
                token_id    : v8,
                attributes  : v16,
            };
            0x1::vector::push_back<u64>(&mut v4, v8);
            let v19 = NFTMinted{
                nft_id   : 0x2::object::uid_to_address(&v18.id),
                token_id : v8,
                minter   : v0,
                name     : v18.name,
            };
            0x2::event::emit<NFTMinted>(v19);
            0x2::transfer::public_transfer<MagicEyeBallNFT>(v18, v0);
            v5 = v5 + 1;
        };
        arg0.total_minted = arg0.total_minted + arg3;
        if (0x2::table::contains<address, u64>(&arg0.wallet_mints, v0)) {
            0x2::table::add<address, u64>(&mut arg0.wallet_mints, v0, 0x2::table::remove<address, u64>(&mut arg0.wallet_mints, v0) + arg3);
        } else {
            0x2::table::add<address, u64>(&mut arg0.wallet_mints, v0, arg3);
        };
        if (arg3 > 1) {
            let v20 = BulkNFTMinted{
                minter     : v0,
                amount     : arg3,
                token_ids  : v4,
                total_paid : v2,
            };
            0x2::event::emit<BulkNFTMinted>(v20);
        };
    }

    // decompiled from Move bytecode v6
}

