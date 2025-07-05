module 0x126cd5a3f0d5e846a2e48567cfce41906a1e6f7d3eaa40dcae583850f073cc80::events {
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

    public entry fun fake_batch_mint(arg0: vector<address>, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg0);
        let v1 = 0;
        let v2 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        let v3 = 0x2::tx_context::sender(arg4);
        assert!(v0 > 0, 0);
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

    public entry fun fake_mint_single(arg0: address, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg5);
        let v1 = NFTMinted{
            token_id    : arg1,
            recipient   : arg0,
            minter      : 0x2::tx_context::sender(arg5),
            name        : arg2,
            description : arg3,
            image_url   : arg4,
            timestamp   : v0,
        };
        0x2::event::emit<NFTMinted>(v1);
        let v2 = NFTTransferred{
            token_id  : arg1,
            from      : @0x0,
            to        : arg0,
            timestamp : v0,
        };
        0x2::event::emit<NFTTransferred>(v2);
    }

    public entry fun minimal_fake_mint(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTTransferred{
            token_id  : 1,
            from      : @0x0,
            to        : arg0,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<NFTTransferred>(v0);
    }

    public entry fun simple_test(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = NFTMinted{
            token_id    : 999,
            recipient   : v0,
            minter      : v0,
            name        : 0x1::string::utf8(b"Test"),
            description : 0x1::string::utf8(b"Test NFT"),
            image_url   : 0x1::string::utf8(b"https://test.com"),
            timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        0x2::event::emit<NFTMinted>(v1);
    }

    public entry fun ultra_cheap_fake_mint(arg0: vector<address>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg0);
        assert!(v0 > 0, 0);
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

