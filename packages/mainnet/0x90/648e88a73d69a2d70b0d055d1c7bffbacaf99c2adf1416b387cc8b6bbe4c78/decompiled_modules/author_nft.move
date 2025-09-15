module 0x90648e88a73d69a2d70b0d055d1c7bffbacaf99c2adf1416b387cc8b6bbe4c78::author_nft {
    struct AUTHOR_NFT has drop {
        dummy_field: bool,
    }

    struct AuthorNFT has store, key {
        id: 0x2::object::UID,
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
    }

    struct PublisherCap has store, key {
        id: 0x2::object::UID,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        author: 0x1::string::String,
        title: 0x1::string::String,
        minted_to: address,
        edition: u64,
        kiosk_id: 0x2::object::ID,
    }

    struct KioskCreated has copy, drop {
        kiosk_id: 0x2::object::ID,
        owner: address,
    }

    public fun author(arg0: &AuthorNFT) : &0x1::string::String {
        &arg0.author
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
        let v0 = 0x1::string::utf8(b"Author: ");
        0x1::string::append(&mut v0, arg0.author);
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a5469746c653a20"));
        0x1::string::append(&mut v0, arg0.title);
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a5075626c69636174696f6e20446174653a20"));
        0x1::string::append(&mut v0, arg0.publication_date);
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a4669727374205075626c697368656420576974683a20"));
        0x1::string::append(&mut v0, arg0.first_published_with);
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a47656e72653a20"));
        0x1::string::append(&mut v0, arg0.genre);
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a77616c7275735f626c6f625f69643a20"));
        0x1::string::append(&mut v0, arg0.walrus_blob_id);
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a73746f72795f657863657270743a20"));
        0x1::string::append(&mut v0, arg0.story_excerpt);
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a73746f72795f636f6e74656e745f686173683a20"));
        0x1::string::append(&mut v0, arg0.story_content_hash);
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a6465736372697074696f6e3a20"));
        0x1::string::append(&mut v0, arg0.description);
        v0
    }

    fun init(arg0: AUTHOR_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<AUTHOR_NFT>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = PublisherCap{id: 0x2::object::new(arg1)};
        let v3 = 0x2::display::new<AuthorNFT>(&v0, arg1);
        0x2::display::add<AuthorNFT>(&mut v3, 0x1::string::utf8(b"author"), 0x1::string::utf8(b"{author}"));
        0x2::display::add<AuthorNFT>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{title}"));
        0x2::display::add<AuthorNFT>(&mut v3, 0x1::string::utf8(b"publication_date"), 0x1::string::utf8(b"{publication_date}"));
        0x2::display::add<AuthorNFT>(&mut v3, 0x1::string::utf8(b"first_published_with"), 0x1::string::utf8(b"{first_published_with}"));
        0x2::display::add<AuthorNFT>(&mut v3, 0x1::string::utf8(b"genre"), 0x1::string::utf8(b"{genre}"));
        0x2::display::add<AuthorNFT>(&mut v3, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"{story_url}"));
        0x2::display::add<AuthorNFT>(&mut v3, 0x1::string::utf8(b"walrus_blob_id"), 0x1::string::utf8(b"{walrus_blob_id}"));
        0x2::display::add<AuthorNFT>(&mut v3, 0x1::string::utf8(b"story_excerpt"), 0x1::string::utf8(b"{story_excerpt}"));
        0x2::display::add<AuthorNFT>(&mut v3, 0x1::string::utf8(b"story_content_hash"), 0x1::string::utf8(b"{story_content_hash}"));
        0x2::display::add<AuthorNFT>(&mut v3, 0x1::string::utf8(b"word_count"), 0x1::string::utf8(b"{word_count}"));
        0x2::display::add<AuthorNFT>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{metadata_url}"));
        0x2::display::add<AuthorNFT>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<AuthorNFT>(&mut v3, 0x1::string::utf8(b"edition"), 0x1::string::utf8(b"{edition}"));
        0x2::display::add<AuthorNFT>(&mut v3, 0x1::string::utf8(b"total_supply"), 0x1::string::utf8(b"{total_supply}"));
        0x2::display::update_version<AuthorNFT>(&mut v3);
        let (v4, v5) = 0x2::transfer_policy::new<AuthorNFT>(&v0, arg1);
        0x2::transfer::public_transfer<PublisherCap>(v2, v1);
        0x2::transfer::public_share_object<0x2::display::Display<AuthorNFT>>(v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<AuthorNFT>>(v4);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<AuthorNFT>>(v5, v1);
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

    public fun mint_to_author(arg0: &PublisherCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u64, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: u64, arg14: u64, arg15: address, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = AuthorNFT{
            id                   : 0x2::object::new(arg16),
            author               : arg1,
            title                : arg2,
            publication_date     : arg3,
            first_published_with : arg4,
            genre                : arg5,
            story_url            : 0x2::url::new_unsafe(0x1::ascii::string(*0x1::string::bytes(&arg6))),
            walrus_blob_id       : arg7,
            story_excerpt        : arg8,
            story_content_hash   : arg9,
            word_count           : arg10,
            metadata_url         : 0x2::url::new_unsafe(0x1::ascii::string(*0x1::string::bytes(&arg11))),
            description          : arg12,
            edition              : arg13,
            total_supply         : arg14,
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<AuthorNFT>(&v0),
            author    : v0.author,
            title     : v0.title,
            minted_to : arg15,
            edition   : arg13,
            kiosk_id  : 0x2::object::id_from_address(@0x0),
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<AuthorNFT>(v0, arg15);
    }

    public fun mint_to_kiosk(arg0: &PublisherCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u64, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: u64, arg14: u64, arg15: &mut 0x2::kiosk::Kiosk, arg16: &0x2::kiosk::KioskOwnerCap, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = AuthorNFT{
            id                   : 0x2::object::new(arg17),
            author               : arg1,
            title                : arg2,
            publication_date     : arg3,
            first_published_with : arg4,
            genre                : arg5,
            story_url            : 0x2::url::new_unsafe(0x1::ascii::string(*0x1::string::bytes(&arg6))),
            walrus_blob_id       : arg7,
            story_excerpt        : arg8,
            story_content_hash   : arg9,
            word_count           : arg10,
            metadata_url         : 0x2::url::new_unsafe(0x1::ascii::string(*0x1::string::bytes(&arg11))),
            description          : arg12,
            edition              : arg13,
            total_supply         : arg14,
        };
        0x2::kiosk::place<AuthorNFT>(arg15, arg16, v0);
        let v1 = NFTMinted{
            object_id : 0x2::object::id<AuthorNFT>(&v0),
            author    : arg1,
            title     : arg2,
            minted_to : 0x2::kiosk::owner(arg15),
            edition   : arg13,
            kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg15),
        };
        0x2::event::emit<NFTMinted>(v1);
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

