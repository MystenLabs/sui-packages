module 0x2cb32aea794765f1b4f3178ef3b044d0531a9c2e51d9bbd6be1e519d16245868::collection {
    struct BlogAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PostMintCap has store, key {
        id: 0x2::object::UID,
        post_id: 0x1::string::String,
        author: address,
        minted: bool,
    }

    struct PostNft has store, key {
        id: 0x2::object::UID,
        post_id: 0x1::string::String,
        creator: address,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
    }

    public fun collection_id(arg0: &Collection) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun collection_name(arg0: &Collection) : &0x1::string::String {
        &arg0.name
    }

    public fun create_collection(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : Collection {
        Collection{
            id          : 0x2::object::new(arg2),
            name        : arg0,
            description : arg1,
            creator     : 0x2::tx_context::sender(arg2),
        }
    }

    public fun create_post_mint_cap(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = PostMintCap{
            id      : 0x2::object::new(arg1),
            post_id : arg0,
            author  : v0,
            minted  : false,
        };
        0x2::transfer::public_transfer<PostMintCap>(v1, v0);
    }

    public fun destroy_collection(arg0: Collection) {
        let Collection {
            id          : v0,
            name        : _,
            description : _,
            creator     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BlogAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<BlogAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun issue_post_mint_cap(arg0: &BlogAdminCap, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PostMintCap{
            id      : 0x2::object::new(arg3),
            post_id : arg1,
            author  : arg2,
            minted  : false,
        };
        0x2::transfer::public_transfer<PostMintCap>(v0, arg2);
    }

    public fun mint(arg0: &Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : Nft {
        Nft{
            id            : 0x2::object::new(arg4),
            collection_id : 0x2::object::uid_to_inner(&arg0.id),
            name          : arg1,
            description   : arg2,
            image_url     : arg3,
            creator       : 0x2::tx_context::sender(arg4),
        }
    }

    public fun mint_post(arg0: &mut PostMintCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.author, 0);
        assert!(!arg0.minted, 1);
        arg0.minted = true;
        let v1 = PostNft{
            id      : 0x2::object::new(arg1),
            post_id : arg0.post_id,
            creator : v0,
        };
        0x2::transfer::public_transfer<PostNft>(v1, v0);
    }

    public fun mint_standalone(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = Collection{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(b"Personal Collection"),
            description : 0x1::string::utf8(b"Collection created for a standalone NFT"),
            creator     : v0,
        };
        0x2::transfer::public_transfer<Collection>(v1, v0);
        let v2 = Nft{
            id            : 0x2::object::new(arg3),
            collection_id : 0x2::object::uid_to_inner(&v1.id),
            name          : arg0,
            description   : arg1,
            image_url     : arg2,
            creator       : v0,
        };
        0x2::transfer::public_transfer<Nft>(v2, v0);
    }

    public fun nft_collection_id(arg0: &Nft) : 0x2::object::ID {
        arg0.collection_id
    }

    public fun nft_description(arg0: &Nft) : &0x1::string::String {
        &arg0.description
    }

    public fun nft_image_url(arg0: &Nft) : &0x1::string::String {
        &arg0.image_url
    }

    public fun nft_name(arg0: &Nft) : &0x1::string::String {
        &arg0.name
    }

    public fun post_nft_creator(arg0: &PostNft) : address {
        arg0.creator
    }

    public fun post_nft_post_id(arg0: &PostNft) : &0x1::string::String {
        &arg0.post_id
    }

    public fun transfer_collection(arg0: Collection, arg1: address) {
        0x2::transfer::public_transfer<Collection>(arg0, arg1);
    }

    public fun transfer_nft(arg0: Nft, arg1: address) {
        0x2::transfer::public_transfer<Nft>(arg0, arg1);
    }

    public fun transfer_post_nft(arg0: PostNft, arg1: address) {
        0x2::transfer::public_transfer<PostNft>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

