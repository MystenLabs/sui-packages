module 0x3040a8335c927d1f3b9ce26eb1125d0246de8fb2fddd6179842889b95cd87e04::nft_factory {
    struct NFTCollection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        royalty_recipient: address,
        royalty_percentage: u64,
        website: 0x1::string::String,
        discord: 0x1::string::String,
        twitter: 0x1::string::String,
        telegram: 0x1::string::String,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        collection: 0x2::object::ID,
        token_number: u64,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
        metadata_url: 0x1::string::String,
    }

    struct Factory has store, key {
        id: 0x2::object::UID,
        total_collections_created: u64,
        total_nfts_minted: u64,
        collection_fee: u64,
        mint_fee: u64,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NFT_FACTORY has drop {
        dummy_field: bool,
    }

    public fun collection_creator(arg0: &NFTCollection) : address {
        arg0.creator
    }

    public fun collection_discord(arg0: &NFTCollection) : 0x1::string::String {
        arg0.discord
    }

    public fun collection_name(arg0: &NFTCollection) : 0x1::string::String {
        arg0.name
    }

    public fun collection_royalty_percentage(arg0: &NFTCollection) : u64 {
        arg0.royalty_percentage
    }

    public fun collection_royalty_recipient(arg0: &NFTCollection) : address {
        arg0.royalty_recipient
    }

    public fun collection_telegram(arg0: &NFTCollection) : 0x1::string::String {
        arg0.telegram
    }

    public fun collection_twitter(arg0: &NFTCollection) : 0x1::string::String {
        arg0.twitter
    }

    public fun collection_website(arg0: &NFTCollection) : 0x1::string::String {
        arg0.website
    }

    entry fun create_collection(arg0: &mut Factory, arg1: &mut Treasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: u64, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.collection_fee, 0);
        assert!(arg6 <= 10000, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        if (0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= 5000000000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, 4900000000), arg11), @0x3bc44c92f693a7e02ac587b6c221abe3084285f47c271e0d13b4d4599b22788);
        };
        let v0 = NFTCollection{
            id                 : 0x2::object::new(arg11),
            name               : 0x1::string::utf8(arg3),
            description        : 0x1::string::utf8(arg4),
            creator            : 0x2::tx_context::sender(arg11),
            royalty_recipient  : arg5,
            royalty_percentage : arg6,
            website            : 0x1::string::utf8(arg7),
            discord            : 0x1::string::utf8(arg8),
            twitter            : 0x1::string::utf8(arg9),
            telegram           : 0x1::string::utf8(arg10),
        };
        0x2::transfer::transfer<NFTCollection>(v0, 0x2::tx_context::sender(arg11));
        arg0.total_collections_created = arg0.total_collections_created + 1;
    }

    public fun get_collection_fee(arg0: &Factory) : u64 {
        arg0.collection_fee
    }

    public fun get_mint_fee(arg0: &Factory) : u64 {
        arg0.mint_fee
    }

    public fun get_total_collections(arg0: &Factory) : u64 {
        arg0.total_collections_created
    }

    public fun get_total_nfts(arg0: &Factory) : u64 {
        arg0.total_nfts_minted
    }

    public fun get_treasury_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    fun init(arg0: NFT_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id                        : 0x2::object::new(arg1),
            total_collections_created : 0,
            total_nfts_minted         : 0,
            collection_fee            : 5000000000,
            mint_fee                  : 10000000,
        };
        0x2::transfer::share_object<Factory>(v0);
        let v1 = Treasury{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Treasury>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = 0x2::package::claim<NFT_FACTORY>(arg0, arg1);
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"description"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{metadata_url}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Token #{token_number}"));
        let v8 = 0x2::display::new_with_fields<NFT>(&v3, v4, v6, arg1);
        0x2::display::update_version<NFT>(&mut v8);
        0x2::transfer::public_share_object<0x2::display::Display<NFT>>(v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun mint_nfts_batch(arg0: &mut Factory, arg1: &mut Treasury, arg2: NFTCollection, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: vector<vector<u8>>, arg7: vector<u64>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<vector<u8>>(&arg4);
        assert!(0x1::vector::length<vector<u8>>(&arg5) == v0, 2);
        assert!(0x1::vector::length<vector<u8>>(&arg6) == v0, 2);
        assert!(0x1::vector::length<u64>(&arg7) == v0, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v0 * arg0.mint_fee, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        if (0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= 5000000000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, 4900000000), arg8), @0x3bc44c92f693a7e02ac587b6c221abe3084285f47c271e0d13b4d4599b22788);
        };
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = NFT{
                id           : 0x2::object::new(arg8),
                collection   : 0x2::object::id<NFTCollection>(&arg2),
                token_number : *0x1::vector::borrow<u64>(&arg7, v2),
                name         : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg4, v2)),
                image_url    : 0x2::url::new_unsafe_from_bytes(*0x1::vector::borrow<vector<u8>>(&arg5, v2)),
                metadata_url : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg6, v2)),
            };
            0x2::transfer::transfer<NFT>(v3, v1);
            v2 = v2 + 1;
        };
        0x2::transfer::transfer<NFTCollection>(arg2, v1);
        arg0.total_nfts_minted = arg0.total_nfts_minted + v0;
    }

    public fun nft_collection(arg0: &NFT) : 0x2::object::ID {
        arg0.collection
    }

    public fun nft_name(arg0: &NFT) : 0x1::string::String {
        arg0.name
    }

    entry fun update_collection_fee(arg0: &mut Factory, arg1: &AdminCap, arg2: u64) {
        arg0.collection_fee = arg2;
    }

    entry fun update_collection_info(arg0: &mut NFTCollection, arg1: vector<u8>, arg2: address, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == arg0.creator, 5);
        assert!(arg3 <= 5000, 4);
        arg0.description = 0x1::string::utf8(arg1);
        arg0.royalty_recipient = arg2;
        arg0.royalty_percentage = arg3;
        arg0.website = 0x1::string::utf8(arg4);
        arg0.discord = 0x1::string::utf8(arg5);
        arg0.twitter = 0x1::string::utf8(arg6);
        arg0.telegram = 0x1::string::utf8(arg7);
    }

    entry fun update_description(arg0: &mut NFTCollection, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 5);
        arg0.description = 0x1::string::utf8(arg1);
    }

    entry fun update_mint_fee(arg0: &mut Factory, arg1: &AdminCap, arg2: u64) {
        arg0.mint_fee = arg2;
    }

    entry fun update_royalty(arg0: &mut NFTCollection, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 5);
        assert!(arg2 <= 10000, 4);
        arg0.royalty_recipient = arg1;
        arg0.royalty_percentage = arg2;
    }

    entry fun update_social_links(arg0: &mut NFTCollection, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.creator, 5);
        arg0.website = 0x1::string::utf8(arg1);
        arg0.discord = 0x1::string::utf8(arg2);
        arg0.twitter = 0x1::string::utf8(arg3);
        arg0.telegram = 0x1::string::utf8(arg4);
    }

    public fun withdraw(arg0: &mut Treasury, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 3);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg3)
    }

    entry fun withdraw_all_to_platform(arg0: &mut Treasury, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0), arg2), @0x3bc44c92f693a7e02ac587b6c221abe3084285f47c271e0d13b4d4599b22788);
        };
    }

    entry fun withdraw_to_platform(arg0: &mut Treasury, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(withdraw(arg0, arg1, arg2, arg3), @0x3bc44c92f693a7e02ac587b6c221abe3084285f47c271e0d13b4d4599b22788);
    }

    // decompiled from Move bytecode v6
}

