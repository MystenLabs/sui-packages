module 0x246569ade9881913eb84c55f8883ab670872a8d5762957614544a166a2512bd6::content {
    struct ContentNFT has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        media_blob_id: 0x1::string::String,
        metadata_blob_id: 0x1::string::String,
        content_hash: 0x1::string::String,
        creator: address,
        created_at: u64,
        likes: u64,
        tips: u64,
    }

    struct ContentMinted has copy, drop {
        object_id: address,
        creator: address,
        created_at: u64,
    }

    struct ContentLiked has copy, drop {
        object_id: address,
        likes: u64,
    }

    struct ContentTipped has copy, drop {
        object_id: address,
        creator: address,
        amount: u64,
    }

    public entry fun burn_content(arg0: ContentNFT, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 0);
        let ContentNFT {
            id               : v0,
            title            : _,
            description      : _,
            media_blob_id    : _,
            metadata_blob_id : _,
            content_hash     : _,
            creator          : _,
            created_at       : _,
            likes            : _,
            tips             : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun creator(arg0: &ContentNFT) : address {
        arg0.creator
    }

    public entry fun like_content(arg0: &mut ContentNFT) {
        arg0.likes = arg0.likes + 1;
        let v0 = ContentLiked{
            object_id : 0x2::object::uid_to_address(&arg0.id),
            likes     : arg0.likes,
        };
        0x2::event::emit<ContentLiked>(v0);
    }

    public fun likes(arg0: &ContentNFT) : u64 {
        arg0.likes
    }

    public entry fun mint_content(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object::new(arg6);
        let v2 = ContentNFT{
            id               : v1,
            title            : arg0,
            description      : arg1,
            media_blob_id    : arg2,
            metadata_blob_id : arg3,
            content_hash     : arg4,
            creator          : v0,
            created_at       : 0x2::clock::timestamp_ms(arg5),
            likes            : 0,
            tips             : 0,
        };
        let v3 = ContentMinted{
            object_id  : 0x2::object::uid_to_address(&v1),
            creator    : v0,
            created_at : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ContentMinted>(v3);
        0x2::transfer::public_transfer<ContentNFT>(v2, v0);
    }

    public entry fun tip_creator(arg0: &mut ContentNFT, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        arg0.tips = arg0.tips + v0;
        let v1 = ContentTipped{
            object_id : 0x2::object::uid_to_address(&arg0.id),
            creator   : arg0.creator,
            amount    : v0,
        };
        0x2::event::emit<ContentTipped>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.creator);
    }

    public fun tips(arg0: &ContentNFT) : u64 {
        arg0.tips
    }

    public fun title(arg0: &ContentNFT) : &0x1::string::String {
        &arg0.title
    }

    // decompiled from Move bytecode v7
}

