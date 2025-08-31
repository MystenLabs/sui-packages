module 0x6fd5af4cfc13b99e82b65779031dc87ef220c246fd373dbc0e9da28e25c9f964::author_nft {
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
    }

    public fun author(arg0: &AuthorNFT) : &0x1::string::String {
        &arg0.author
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
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a47656e72653a20"));
        0x1::string::append(&mut v0, arg0.genre);
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a5075626c69636174696f6e20446174653a20"));
        0x1::string::append(&mut v0, arg0.publication_date);
        0x1::string::append(&mut v0, 0x1::string::utf8(x"0a4669727374205075626c697368656420576974683a20"));
        0x1::string::append(&mut v0, arg0.first_published_with);
        v0
    }

    fun init(arg0: AUTHOR_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<AUTHOR_NFT>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = PublisherCap{id: 0x2::object::new(arg1)};
        let v3 = 0x2::display::new<AuthorNFT>(&v0, arg1);
        0x2::display::add<AuthorNFT>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{title}"));
        0x2::display::add<AuthorNFT>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<AuthorNFT>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{metadata_url}"));
        0x2::display::add<AuthorNFT>(&mut v3, 0x1::string::utf8(b"author"), 0x1::string::utf8(b"{author}"));
        0x2::display::add<AuthorNFT>(&mut v3, 0x1::string::utf8(b"genre"), 0x1::string::utf8(b"{genre}"));
        0x2::display::add<AuthorNFT>(&mut v3, 0x1::string::utf8(b"publication_date"), 0x1::string::utf8(b"{publication_date}"));
        0x2::display::add<AuthorNFT>(&mut v3, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"{story_url}"));
        0x2::display::update_version<AuthorNFT>(&mut v3);
        0x2::transfer::public_transfer<PublisherCap>(v2, v1);
        0x2::transfer::public_share_object<0x2::display::Display<AuthorNFT>>(v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v1);
    }

    public fun metadata_url(arg0: &AuthorNFT) : &0x2::url::Url {
        &arg0.metadata_url
    }

    public entry fun mint_to_author(arg0: &PublisherCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: u64, arg10: u64, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = AuthorNFT{
            id                   : 0x2::object::new(arg12),
            author               : 0x1::string::utf8(arg1),
            title                : 0x1::string::utf8(arg2),
            publication_date     : 0x1::string::utf8(arg3),
            first_published_with : 0x1::string::utf8(arg4),
            genre                : 0x1::string::utf8(arg5),
            story_url            : 0x2::url::new_unsafe_from_bytes(arg6),
            metadata_url         : 0x2::url::new_unsafe_from_bytes(arg7),
            description          : 0x1::string::utf8(arg8),
            edition              : arg9,
            total_supply         : arg10,
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<AuthorNFT>(&v0),
            author    : v0.author,
            title     : v0.title,
            minted_to : arg11,
            edition   : arg9,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<AuthorNFT>(v0, arg11);
    }

    public fun publication_date(arg0: &AuthorNFT) : &0x1::string::String {
        &arg0.publication_date
    }

    public fun story_url(arg0: &AuthorNFT) : &0x2::url::Url {
        &arg0.story_url
    }

    public fun title(arg0: &AuthorNFT) : &0x1::string::String {
        &arg0.title
    }

    public fun total_supply(arg0: &AuthorNFT) : u64 {
        arg0.total_supply
    }

    public entry fun transfer_publisher_cap(arg0: PublisherCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<PublisherCap>(arg0, arg1);
    }

    public entry fun update_metadata_url(arg0: &PublisherCap, arg1: &mut AuthorNFT, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.metadata_url = 0x2::url::new_unsafe_from_bytes(arg2);
    }

    public entry fun update_story_url(arg0: &PublisherCap, arg1: &mut AuthorNFT, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.story_url = 0x2::url::new_unsafe_from_bytes(arg2);
    }

    // decompiled from Move bytecode v6
}

