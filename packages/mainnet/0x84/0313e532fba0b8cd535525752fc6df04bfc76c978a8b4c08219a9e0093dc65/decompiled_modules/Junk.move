module 0x840313e532fba0b8cd535525752fc6df04bfc76c978a8b4c08219a9e0093dc65::Junk {
    struct JUNK has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TraitNFT has store, key {
        id: 0x2::object::UID,
        edition_id: 0x1::string::String,
        edition_number: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct EditionInfo has store, key {
        id: 0x2::object::UID,
        edition_id: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        max_supply: u64,
        current_supply: u64,
        total_burned: u64,
    }

    struct CollectionInfo has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        total_editions: u64,
        total_nfts_minted: u64,
        total_nfts_burned: u64,
    }

    struct EditionCreated has copy, drop {
        edition_id: 0x1::string::String,
        name: 0x1::string::String,
        max_supply: u64,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        edition_id: 0x1::string::String,
        edition_number: u64,
        recipient: address,
    }

    struct NFTBurned has copy, drop {
        nft_id: 0x2::object::ID,
        edition_id: 0x1::string::String,
        edition_number: u64,
    }

    public fun burn_nft(arg0: &mut CollectionInfo, arg1: &mut EditionInfo, arg2: TraitNFT) {
        arg1.total_burned = arg1.total_burned + 1;
        arg0.total_nfts_burned = arg0.total_nfts_burned + 1;
        let v0 = NFTBurned{
            nft_id         : 0x2::object::id<TraitNFT>(&arg2),
            edition_id     : arg2.edition_id,
            edition_number : arg2.edition_number,
        };
        0x2::event::emit<NFTBurned>(v0);
        let TraitNFT {
            id             : v1,
            edition_id     : _,
            edition_number : _,
            name           : _,
            description    : _,
            image_url      : _,
        } = arg2;
        0x2::object::delete(v1);
    }

    public fun create_edition(arg0: &AdminCap, arg1: &mut CollectionInfo, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 0);
        let v0 = 0x1::string::utf8(arg2);
        let v1 = EditionInfo{
            id             : 0x2::object::new(arg7),
            edition_id     : v0,
            name           : 0x1::string::utf8(arg3),
            description    : 0x1::string::utf8(arg4),
            image_url      : 0x1::string::utf8(arg5),
            max_supply     : arg6,
            current_supply : 0,
            total_burned   : 0,
        };
        arg1.total_editions = arg1.total_editions + 1;
        let v2 = EditionCreated{
            edition_id : v0,
            name       : 0x1::string::utf8(arg3),
            max_supply : arg6,
        };
        0x2::event::emit<EditionCreated>(v2);
        0x2::transfer::share_object<EditionInfo>(v1);
    }

    public fun get_collection_name(arg0: &CollectionInfo) : 0x1::string::String {
        arg0.name
    }

    public fun get_edition_circulating_supply(arg0: &EditionInfo) : u64 {
        arg0.current_supply - arg0.total_burned
    }

    public fun get_edition_current_supply(arg0: &EditionInfo) : u64 {
        arg0.current_supply
    }

    public fun get_edition_id(arg0: &EditionInfo) : 0x1::string::String {
        arg0.edition_id
    }

    public fun get_edition_max_supply(arg0: &EditionInfo) : u64 {
        arg0.max_supply
    }

    public fun get_edition_name(arg0: &EditionInfo) : 0x1::string::String {
        arg0.name
    }

    public fun get_edition_total_burned(arg0: &EditionInfo) : u64 {
        arg0.total_burned
    }

    public fun get_nft_description(arg0: &TraitNFT) : 0x1::string::String {
        arg0.description
    }

    public fun get_nft_edition_id(arg0: &TraitNFT) : 0x1::string::String {
        arg0.edition_id
    }

    public fun get_nft_edition_number(arg0: &TraitNFT) : u64 {
        arg0.edition_number
    }

    public fun get_nft_image_url(arg0: &TraitNFT) : 0x1::string::String {
        arg0.image_url
    }

    public fun get_nft_name(arg0: &TraitNFT) : 0x1::string::String {
        arg0.name
    }

    public fun get_total_editions(arg0: &CollectionInfo) : u64 {
        arg0.total_editions
    }

    public fun get_total_nfts_burned(arg0: &CollectionInfo) : u64 {
        arg0.total_nfts_burned
    }

    public fun get_total_nfts_minted(arg0: &CollectionInfo) : u64 {
        arg0.total_nfts_minted
    }

    fun init(arg0: JUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = CollectionInfo{
            id                : 0x2::object::new(arg1),
            name              : 0x1::string::utf8(b"Junk Traits"),
            description       : 0x1::string::utf8(b"Collectible trait NFTs for customization"),
            total_editions    : 0,
            total_nfts_minted : 0,
            total_nfts_burned : 0,
        };
        0x2::transfer::share_object<CollectionInfo>(v1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"edition_id"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"edition_number"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{edition_id}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{edition_number}"));
        let v6 = 0x2::package::claim<JUNK>(arg0, arg1);
        let v7 = 0x2::display::new_with_fields<TraitNFT>(&v6, v2, v4, arg1);
        0x2::display::update_version<TraitNFT>(&mut v7);
        0x2::transfer::public_transfer<0x2::display::Display<TraitNFT>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun mint_nft(arg0: &AdminCap, arg1: &mut CollectionInfo, arg2: &mut EditionInfo, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.current_supply < arg2.max_supply, 1);
        arg2.current_supply = arg2.current_supply + 1;
        arg1.total_nfts_minted = arg1.total_nfts_minted + 1;
        let v0 = TraitNFT{
            id             : 0x2::object::new(arg4),
            edition_id     : arg2.edition_id,
            edition_number : arg2.current_supply,
            name           : arg2.name,
            description    : arg2.description,
            image_url      : arg2.image_url,
        };
        let v1 = NFTMinted{
            nft_id         : 0x2::object::id<TraitNFT>(&v0),
            edition_id     : arg2.edition_id,
            edition_number : arg2.current_supply,
            recipient      : arg3,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<TraitNFT>(v0, arg3);
    }

    public fun mint_nft_batch(arg0: &AdminCap, arg1: &mut CollectionInfo, arg2: &mut EditionInfo, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 0);
        assert!(arg2.current_supply + arg4 <= arg2.max_supply, 1);
        let v0 = 0;
        while (v0 < arg4) {
            mint_nft(arg0, arg1, arg2, arg3, arg5);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

