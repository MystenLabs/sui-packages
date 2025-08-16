module 0x5319e093392a3111a855867539fc8f51ee589dbd90a7c5a0d78822aef01ad331::post {
    struct Post has store, key {
        id: 0x2::object::UID,
        author: address,
        content: 0x1::string::String,
        media_url: 0x1::string::String,
        timestamp: u64,
        price_mist: u64,
    }

    struct NFTSold has copy, drop {
        post_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        price_mist: u64,
    }

    public entry fun buy_nft_from_post(arg0: &mut Post, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.price_mist > 0, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= arg0.price_mist, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, arg0.price_mist, arg2), arg0.author);
        let v0 = NFTSold{
            post_id    : 0x2::object::id<Post>(arg0),
            buyer      : 0x2::tx_context::sender(arg2),
            seller     : arg0.author,
            price_mist : arg0.price_mist,
        };
        0x2::event::emit<NFTSold>(v0);
    }

    public entry fun create_post(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = Post{
            id         : 0x2::object::new(arg3),
            author     : v0,
            content    : 0x1::string::utf8(arg0),
            media_url  : 0x1::string::utf8(arg1),
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg3),
            price_mist : arg2,
        };
        0x2::transfer::public_transfer<Post>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

