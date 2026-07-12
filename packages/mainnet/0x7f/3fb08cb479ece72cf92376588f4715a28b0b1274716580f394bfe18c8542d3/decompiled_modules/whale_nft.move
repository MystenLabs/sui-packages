module 0x7f3fb08cb479ece72cf92376588f4715a28b0b1274716580f394bfe18c8542d3::whale_nft {
    struct WHALE_NFT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct WhaleNFT has store, key {
        id: 0x2::object::UID,
        token_id: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        rarity: 0x1::string::String,
    }

    public entry fun airdrop(arg0: &AdminCap, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = WhaleNFT{
            id        : 0x2::object::new(arg5),
            token_id  : arg1,
            name      : 0x1::string::utf8(arg2),
            image_url : 0x1::string::utf8(arg3),
            rarity    : 0x1::string::utf8(b"Whale"),
        };
        0x2::transfer::public_transfer<WhaleNFT>(v0, arg4);
    }

    fun init(arg0: WHALE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<WHALE_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{rarity}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://scamcrusher.wal.app"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Scam Crusher Whale NFT - Exclusive 1/1 collection"));
        let v5 = 0x2::display::new_with_fields<WhaleNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<WhaleNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<WhaleNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

