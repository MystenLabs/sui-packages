module 0xa0be0726a015752b61ad11cceffbb1e5148aa430d45ec46c3db636b6f2a83bce::events {
    struct NFTMinted has copy, drop {
        token_id: u64,
        recipient: address,
        minter: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        timestamp: u64,
    }

    struct NFTTransferred has copy, drop {
        token_id: u64,
        from: address,
        to: address,
        timestamp: u64,
    }

    struct BatchNFTMinted has copy, drop {
        start_token_id: u64,
        end_token_id: u64,
        recipients: vector<address>,
        collection_name: 0x1::string::String,
        base_image_url: 0x1::string::String,
        minter: address,
        timestamp: u64,
        total_count: u64,
    }

    struct CollectionCreated has copy, drop {
        collection_id: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        max_supply: u64,
        base_uri: 0x1::string::String,
        timestamp: u64,
    }

    public entry fun create_fake_collection(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectionCreated{
            collection_id : arg0,
            name          : arg1,
            description   : arg2,
            creator       : 0x2::tx_context::sender(arg5),
            max_supply    : arg3,
            base_uri      : arg4,
            timestamp     : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x2::event::emit<CollectionCreated>(v0);
    }

    public entry fun fake_batch_mint(arg0: vector<address>, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg0);
        let v1 = 0;
        let v2 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        let v3 = 0x2::tx_context::sender(arg4);
        while (v1 < v0) {
            let v4 = arg1 + v1;
            let v5 = *0x1::vector::borrow<address>(&arg0, v1);
            let v6 = NFTMinted{
                token_id    : v4,
                recipient   : v5,
                minter      : v3,
                name        : arg2,
                description : 0x1::string::utf8(b"Generated NFT"),
                image_url   : arg3,
                timestamp   : v2,
            };
            0x2::event::emit<NFTMinted>(v6);
            let v7 = NFTTransferred{
                token_id  : v4,
                from      : @0x0,
                to        : v5,
                timestamp : v2,
            };
            0x2::event::emit<NFTTransferred>(v7);
            v1 = v1 + 1;
        };
        let v8 = BatchNFTMinted{
            start_token_id  : arg1,
            end_token_id    : arg1 + v0 - 1,
            recipients      : arg0,
            collection_name : arg2,
            base_image_url  : arg3,
            minter          : v3,
            timestamp       : v2,
            total_count     : v0,
        };
        0x2::event::emit<BatchNFTMinted>(v8);
    }

    public entry fun fake_mint_custom_metadata(arg0: vector<address>, arg1: vector<u64>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg0);
        assert!(v0 == 0x1::vector::length<u64>(&arg1), 0);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg2), 1);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg3), 2);
        let v1 = 0;
        let v2 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        while (v1 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg1, v1);
            let v4 = *0x1::vector::borrow<address>(&arg0, v1);
            let v5 = NFTMinted{
                token_id    : v3,
                recipient   : v4,
                minter      : 0x2::tx_context::sender(arg4),
                name        : *0x1::vector::borrow<0x1::string::String>(&arg2, v1),
                description : 0x1::string::utf8(b"Custom NFT"),
                image_url   : *0x1::vector::borrow<0x1::string::String>(&arg3, v1),
                timestamp   : v2,
            };
            0x2::event::emit<NFTMinted>(v5);
            let v6 = NFTTransferred{
                token_id  : v3,
                from      : @0x0,
                to        : v4,
                timestamp : v2,
            };
            0x2::event::emit<NFTTransferred>(v6);
            v1 = v1 + 1;
        };
    }

    public entry fun fake_mint_sequential(arg0: vector<address>, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        while (v0 < 0x1::vector::length<address>(&arg0)) {
            let v2 = arg1 + v0;
            let v3 = *0x1::vector::borrow<address>(&arg0, v0);
            let v4 = NFTMinted{
                token_id    : v2,
                recipient   : v3,
                minter      : 0x2::tx_context::sender(arg3),
                name        : arg2,
                description : 0x1::string::utf8(b"Sequential NFT"),
                image_url   : 0x1::string::utf8(b"https://api.example.com/sequential/"),
                timestamp   : v1,
            };
            0x2::event::emit<NFTMinted>(v4);
            let v5 = NFTTransferred{
                token_id  : v2,
                from      : @0x0,
                to        : v3,
                timestamp : v1,
            };
            0x2::event::emit<NFTTransferred>(v5);
            v0 = v0 + 1;
        };
    }

    public entry fun fake_mint_single(arg0: address, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTMinted{
            token_id    : arg1,
            recipient   : arg0,
            minter      : 0x2::tx_context::sender(arg5),
            name        : arg2,
            description : arg3,
            image_url   : arg4,
            timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x2::event::emit<NFTMinted>(v0);
        let v1 = NFTTransferred{
            token_id  : arg1,
            from      : @0x0,
            to        : arg0,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x2::event::emit<NFTTransferred>(v1);
    }

    public entry fun fake_transfer(arg0: u64, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTTransferred{
            token_id  : arg0,
            from      : arg1,
            to        : arg2,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<NFTTransferred>(v0);
    }

    public entry fun ultra_cheap_fake_mint(arg0: vector<address>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg0);
        let v1 = BatchNFTMinted{
            start_token_id  : arg1,
            end_token_id    : arg1 + v0 - 1,
            recipients      : arg0,
            collection_name : 0x1::string::utf8(b"Cheap NFT"),
            base_image_url  : 0x1::string::utf8(b"https://api.example.com/nft/"),
            minter          : 0x2::tx_context::sender(arg2),
            timestamp       : 0x2::tx_context::epoch_timestamp_ms(arg2),
            total_count     : v0,
        };
        0x2::event::emit<BatchNFTMinted>(v1);
    }

    // decompiled from Move bytecode v6
}

