module 0xf7ca9bc982b6e3aa11b55ecc3b19f49ee13995830301085f1e077397377e0fa8::author_nft {
    struct AUTHOR_NFT has drop {
        dummy_field: bool,
    }

    struct LiteraryCollection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        website: 0x1::string::String,
        creator: address,
        total_minted: u64,
        authors: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        collection_image: 0x2::url::Url,
        twitter: 0x1::string::String,
    }

    struct AuthorNFT has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        author: 0x1::string::String,
        title: 0x1::string::String,
        publication_date: 0x1::string::String,
        first_published_with: 0x1::string::String,
        genre: 0x1::string::String,
        story_url: 0x2::url::Url,
        walrus_blob_id: 0x1::string::String,
        story_excerpt: 0x1::string::String,
        story_content_hash: 0x1::string::String,
        word_count: u64,
        metadata_url: 0x2::url::Url,
        description: 0x1::string::String,
        edition: u64,
        total_supply: u64,
        collection_number: u64,
    }

    struct PublisherCap has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
    }

    struct CollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        author: 0x1::string::String,
        title: 0x1::string::String,
        minted_to: address,
        edition: u64,
        collection_number: u64,
        kiosk_id: 0x2::object::ID,
    }

    struct KioskCreated has copy, drop {
        kiosk_id: 0x2::object::ID,
        owner: address,
    }

    public fun author(arg0: &AuthorNFT) : &0x1::string::String {
        &arg0.author
    }

    public fun collection_authors(arg0: &LiteraryCollection) : &0x2::vec_map::VecMap<0x1::string::String, u64> {
        &arg0.authors
    }

    public fun collection_creator(arg0: &LiteraryCollection) : address {
        arg0.creator
    }

    public fun collection_description(arg0: &LiteraryCollection) : &0x1::string::String {
        &arg0.description
    }

    public fun collection_id(arg0: &AuthorNFT) : 0x2::object::ID {
        arg0.collection_id
    }

    public fun collection_name(arg0: &LiteraryCollection) : &0x1::string::String {
        &arg0.name
    }

    public fun collection_number(arg0: &AuthorNFT) : u64 {
        arg0.collection_number
    }

    public fun collection_total_minted(arg0: &LiteraryCollection) : u64 {
        arg0.total_minted
    }

    public fun collection_website(arg0: &LiteraryCollection) : &0x1::string::String {
        &arg0.website
    }

    public fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::tx_context::sender(arg0);
        let v5 = KioskCreated{
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(&v3),
            owner    : v4,
        };
        0x2::event::emit<KioskCreated>(v5);
        0x2::kiosk::set_owner_custom(&mut v3, &v2, v4);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, v4);
    }

    public fun delist_nft(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::delist<AuthorNFT>(arg0, arg1, arg2);
    }

    public fun description(arg0: &AuthorNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun edition(arg0: &AuthorNFT) : u64 {
        arg0.edition
    }

    public fun first_published_with(arg0: &AuthorNFT) : &0x1::string::String {
        &arg0.first_published_with
    }

    public fun genre(arg0: &AuthorNFT) : &0x1::string::String {
        &arg0.genre
    }

    public fun get_metadata_string(arg0: &AuthorNFT) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"Literary Magazine Collection #");
        0x1::string::append(&mut v0, 0x1::string::utf8(b""));
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a417574686f723a20"));
        0x1::string::append(&mut v0, arg0.author);
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a5469746c653a20"));
        0x1::string::append(&mut v0, arg0.title);
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a5075626c69636174696f6e20446174653a20"));
        0x1::string::append(&mut v0, arg0.publication_date);
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a4669727374205075626c697368656420576974683a20"));
        0x1::string::append(&mut v0, arg0.first_published_with);
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a47656e72653a20"));
        0x1::string::append(&mut v0, arg0.genre);
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a57616c72757320426c6f622049443a20"));
        0x1::string::append(&mut v0, arg0.walrus_blob_id);
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a53746f727920457863657270743a20"));
        0x1::string::append(&mut v0, arg0.story_excerpt);
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a53746f727920436f6e74656e7420486173683a20"));
        0x1::string::append(&mut v0, arg0.story_content_hash);
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a4465736372697074696f6e3a20"));
        0x1::string::append(&mut v0, arg0.description);
        v0
    }

    fun init(arg0: AUTHOR_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<AUTHOR_NFT>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = LiteraryCollection{
            id               : 0x2::object::new(arg1),
            name             : 0x1::string::utf8(b"Issue 05 - Walrus Lit Blob"),
            description      : 0x1::string::utf8(b"The preview issue of Walrus Protocol Poetry and Prose, a web3 literary journal."),
            website          : 0x1::string::utf8(b"https://walrusproetry.wal.app"),
            creator          : v1,
            total_minted     : 0,
            authors          : 0x2::vec_map::empty<0x1::string::String, u64>(),
            collection_image : 0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/SxaosVFUxu1tgZ0FvFmiNDS8XkGmPX16LWu_SyVjRqI"),
            twitter          : 0x1::string::utf8(b"@WalrusProetry"),
        };
        let v3 = 0x2::object::id<LiteraryCollection>(&v2);
        let v4 = PublisherCap{
            id            : 0x2::object::new(arg1),
            collection_id : v3,
        };
        let v5 = 0x2::display::new<AuthorNFT>(&v0, arg1);
        0x2::display::add<AuthorNFT>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Literary Magazine #{collection_number}: {title}"));
        0x2::display::add<AuthorNFT>(&mut v5, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Part of the Literary Magazine Collection. {description}"));
        0x2::display::add<AuthorNFT>(&mut v5, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{metadata_url}"));
        0x2::display::add<AuthorNFT>(&mut v5, 0x1::string::utf8(b"external_url"), 0x1::string::utf8(b"{story_url}"));
        0x2::display::add<AuthorNFT>(&mut v5, 0x1::string::utf8(b"collection"), 0x1::string::utf8(b"Literary Magazine Collection"));
        0x2::display::add<AuthorNFT>(&mut v5, 0x1::string::utf8(b"collection_number"), 0x1::string::utf8(b"#{collection_number}"));
        0x2::display::add<AuthorNFT>(&mut v5, 0x1::string::utf8(b"author"), 0x1::string::utf8(b"{author}"));
        0x2::display::add<AuthorNFT>(&mut v5, 0x1::string::utf8(b"title"), 0x1::string::utf8(b"{title}"));
        0x2::display::add<AuthorNFT>(&mut v5, 0x1::string::utf8(b"publication_date"), 0x1::string::utf8(b"{publication_date}"));
        0x2::display::add<AuthorNFT>(&mut v5, 0x1::string::utf8(b"first_published_with"), 0x1::string::utf8(b"{first_published_with}"));
        0x2::display::add<AuthorNFT>(&mut v5, 0x1::string::utf8(b"genre"), 0x1::string::utf8(b"{genre}"));
        0x2::display::add<AuthorNFT>(&mut v5, 0x1::string::utf8(b"walrus_blob_id"), 0x1::string::utf8(b"{walrus_blob_id}"));
        0x2::display::add<AuthorNFT>(&mut v5, 0x1::string::utf8(b"story_excerpt"), 0x1::string::utf8(b"{story_excerpt}"));
        0x2::display::add<AuthorNFT>(&mut v5, 0x1::string::utf8(b"story_content_hash"), 0x1::string::utf8(b"{story_content_hash}"));
        0x2::display::add<AuthorNFT>(&mut v5, 0x1::string::utf8(b"word_count"), 0x1::string::utf8(b"{word_count}"));
        0x2::display::add<AuthorNFT>(&mut v5, 0x1::string::utf8(b"edition"), 0x1::string::utf8(b"Edition {edition} of {total_supply}"));
        0x2::display::add<AuthorNFT>(&mut v5, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"[{\"trait_type\": \"Author\", \"value\": \"{author}\"}, {\"trait_type\": \"Genre\", \"value\": \"{genre}\"}, {\"trait_type\": \"Word Count\", \"value\": {word_count}}, {\"trait_type\": \"Edition\", \"value\": \"{edition}/{total_supply}\"}, {\"trait_type\": \"Collection Number\", \"value\": \"{collection_number}\"}]"));
        0x2::display::update_version<AuthorNFT>(&mut v5);
        let v6 = 0x2::display::new<LiteraryCollection>(&v0, arg1);
        0x2::display::add<LiteraryCollection>(&mut v6, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<LiteraryCollection>(&mut v6, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<LiteraryCollection>(&mut v6, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{collection_image}"));
        0x2::display::add<LiteraryCollection>(&mut v6, 0x1::string::utf8(b"external_url"), 0x1::string::utf8(b"{website}"));
        0x2::display::add<LiteraryCollection>(&mut v6, 0x1::string::utf8(b"total_minted"), 0x1::string::utf8(b"{total_minted}"));
        0x2::display::add<LiteraryCollection>(&mut v6, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::add<LiteraryCollection>(&mut v6, 0x1::string::utf8(b"twitter"), 0x1::string::utf8(b"{twitter}"));
        0x2::display::update_version<LiteraryCollection>(&mut v6);
        let (v7, v8) = 0x2::transfer_policy::new<AuthorNFT>(&v0, arg1);
        let v9 = CollectionCreated{
            collection_id : v3,
            name          : v2.name,
            creator       : v1,
        };
        0x2::event::emit<CollectionCreated>(v9);
        0x2::transfer::public_transfer<PublisherCap>(v4, v1);
        0x2::transfer::public_share_object<LiteraryCollection>(v2);
        0x2::transfer::public_share_object<0x2::display::Display<AuthorNFT>>(v5);
        0x2::transfer::public_share_object<0x2::display::Display<LiteraryCollection>>(v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<AuthorNFT>>(v7);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<AuthorNFT>>(v8, v1);
    }

    public fun is_in_kiosk(arg0: &0x2::kiosk::Kiosk, arg1: 0x2::object::ID) : bool {
        0x2::kiosk::has_item(arg0, arg1)
    }

    public fun is_listed_in_kiosk(arg0: &0x2::kiosk::Kiosk, arg1: 0x2::object::ID) : bool {
        0x2::kiosk::is_listed(arg0, arg1)
    }

    public fun list_nft(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::list<AuthorNFT>(arg0, arg1, arg2, arg3);
    }

    public fun metadata_url(arg0: &AuthorNFT) : &0x2::url::Url {
        &arg0.metadata_url
    }

    public fun mint_to_author(arg0: &PublisherCap, arg1: &mut LiteraryCollection, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: u64, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: u64, arg15: u64, arg16: address, arg17: &mut 0x2::tx_context::TxContext) {
        arg1.total_minted = arg1.total_minted + 1;
        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg1.authors, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, u64>(&mut arg1.authors, &arg2);
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg1.authors, arg2, *0x2::vec_map::get<0x1::string::String, u64>(&arg1.authors, &arg2) + 1);
        } else {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg1.authors, arg2, 1);
        };
        let v2 = arg1.total_minted;
        let v3 = 0x2::object::id<LiteraryCollection>(arg1);
        let v4 = AuthorNFT{
            id                   : 0x2::object::new(arg17),
            collection_id        : v3,
            author               : arg2,
            title                : arg3,
            publication_date     : arg4,
            first_published_with : arg5,
            genre                : arg6,
            story_url            : 0x2::url::new_unsafe(0x1::ascii::string(*0x1::string::bytes(&arg7))),
            walrus_blob_id       : arg8,
            story_excerpt        : arg9,
            story_content_hash   : arg10,
            word_count           : arg11,
            metadata_url         : 0x2::url::new_unsafe(0x1::ascii::string(*0x1::string::bytes(&arg12))),
            description          : arg13,
            edition              : arg14,
            total_supply         : arg15,
            collection_number    : v2,
        };
        let v5 = NFTMinted{
            object_id         : 0x2::object::id<AuthorNFT>(&v4),
            collection_id     : v3,
            author            : v4.author,
            title             : v4.title,
            minted_to         : arg16,
            edition           : arg14,
            collection_number : v2,
            kiosk_id          : 0x2::object::id_from_address(@0x0),
        };
        0x2::event::emit<NFTMinted>(v5);
        0x2::transfer::public_transfer<AuthorNFT>(v4, arg16);
    }

    public fun mint_to_kiosk(arg0: &PublisherCap, arg1: &mut LiteraryCollection, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: u64, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: u64, arg15: u64, arg16: &mut 0x2::kiosk::Kiosk, arg17: &0x2::kiosk::KioskOwnerCap, arg18: &mut 0x2::tx_context::TxContext) {
        arg1.total_minted = arg1.total_minted + 1;
        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg1.authors, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, u64>(&mut arg1.authors, &arg2);
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg1.authors, arg2, *0x2::vec_map::get<0x1::string::String, u64>(&arg1.authors, &arg2) + 1);
        } else {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg1.authors, arg2, 1);
        };
        let v2 = arg1.total_minted;
        let v3 = 0x2::object::id<LiteraryCollection>(arg1);
        let v4 = AuthorNFT{
            id                   : 0x2::object::new(arg18),
            collection_id        : v3,
            author               : arg2,
            title                : arg3,
            publication_date     : arg4,
            first_published_with : arg5,
            genre                : arg6,
            story_url            : 0x2::url::new_unsafe(0x1::ascii::string(*0x1::string::bytes(&arg7))),
            walrus_blob_id       : arg8,
            story_excerpt        : arg9,
            story_content_hash   : arg10,
            word_count           : arg11,
            metadata_url         : 0x2::url::new_unsafe(0x1::ascii::string(*0x1::string::bytes(&arg12))),
            description          : arg13,
            edition              : arg14,
            total_supply         : arg15,
            collection_number    : v2,
        };
        0x2::kiosk::place<AuthorNFT>(arg16, arg17, v4);
        let v5 = NFTMinted{
            object_id         : 0x2::object::id<AuthorNFT>(&v4),
            collection_id     : v3,
            author            : arg2,
            title             : arg3,
            minted_to         : 0x2::kiosk::owner(arg16),
            edition           : arg14,
            collection_number : v2,
            kiosk_id          : 0x2::object::id<0x2::kiosk::Kiosk>(arg16),
        };
        0x2::event::emit<NFTMinted>(v5);
    }

    public fun place_nft(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: AuthorNFT, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::place<AuthorNFT>(arg0, arg1, arg2);
    }

    public fun publication_date(arg0: &AuthorNFT) : &0x1::string::String {
        &arg0.publication_date
    }

    public fun purchase_nft(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::transfer_policy::TransferPolicy<AuthorNFT>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::purchase<AuthorNFT>(arg0, arg1, arg2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<AuthorNFT>(arg3, v1);
        0x2::transfer::public_transfer<AuthorNFT>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun story_content_hash(arg0: &AuthorNFT) : &0x1::string::String {
        &arg0.story_content_hash
    }

    public fun story_excerpt(arg0: &AuthorNFT) : &0x1::string::String {
        &arg0.story_excerpt
    }

    public fun story_url(arg0: &AuthorNFT) : &0x2::url::Url {
        &arg0.story_url
    }

    public fun take_nft(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<AuthorNFT>(0x2::kiosk::take<AuthorNFT>(arg0, arg1, arg2), 0x2::tx_context::sender(arg3));
    }

    public fun title(arg0: &AuthorNFT) : &0x1::string::String {
        &arg0.title
    }

    public fun total_supply(arg0: &AuthorNFT) : u64 {
        arg0.total_supply
    }

    public fun transfer_publisher_cap(arg0: PublisherCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<PublisherCap>(arg0, arg1);
    }

    public fun update_collection_info(arg0: &PublisherCap, arg1: &mut LiteraryCollection, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        arg1.name = arg2;
        arg1.description = arg3;
        arg1.website = arg4;
        arg1.collection_image = 0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(&arg5));
        arg1.twitter = arg6;
    }

    public fun update_metadata_url(arg0: &PublisherCap, arg1: &mut AuthorNFT, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.metadata_url = 0x2::url::new_unsafe(0x1::ascii::string(*0x1::string::bytes(&arg2)));
    }

    public fun update_story_url(arg0: &PublisherCap, arg1: &mut AuthorNFT, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.story_url = 0x2::url::new_unsafe(0x1::ascii::string(*0x1::string::bytes(&arg2)));
    }

    public fun walrus_blob_id(arg0: &AuthorNFT) : &0x1::string::String {
        &arg0.walrus_blob_id
    }

    public fun word_count(arg0: &AuthorNFT) : u64 {
        arg0.word_count
    }

    // decompiled from Move bytecode v6
}

