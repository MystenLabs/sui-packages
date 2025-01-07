module 0x98b6b50159eb20d6edd17fe773c7d833c522ba52ac575470c29c7cdcda4349a0::black_nft_w {
    struct BLACK_NFT_W has drop {
        dummy_field: bool,
    }

    struct BLACK_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        user: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct BurnEvent has copy, drop {
        nft_id: 0x2::object::ID,
        user: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    public entry fun MultiMint(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = BLACK_NFT{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"NFT BLACK"),
                image_url   : 0x1::string::utf8(b"ipfs://QmNfDJezspmxy9gnoNJmasCDM1JVjss7P2Jgz8tAz4fy1o"),
                description : 0x1::string::utf8(b"BLACK NFT by Anany"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<BLACK_NFT>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"NFT BLACK"),
                image_url   : 0x1::string::utf8(b"ipfs://QmNfDJezspmxy9gnoNJmasCDM1JVjss7P2Jgz8tAz4fy1o"),
                description : 0x1::string::utf8(b"BLACK NFT by Anany"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<BLACK_NFT>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: BLACK_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let BLACK_NFT {
            id          : v0,
            name        : v1,
            image_url   : v2,
            description : v3,
        } = arg0;
        let v4 = v0;
        let v5 = BurnEvent{
            nft_id      : 0x2::object::uid_to_inner(&v4),
            user        : 0x2::tx_context::sender(arg1),
            name        : v1,
            image_url   : v2,
            description : v3,
        };
        0x2::event::emit<BurnEvent>(v5);
        0x2::object::delete(v4);
    }

    fun init(arg0: BLACK_NFT_W, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"NFT BLACK"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://QmNfDJezspmxy9gnoNJmasCDM1JVjss7P2Jgz8tAz4fy1o"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"BLACK NFT by Anany"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Anany"));
        let v4 = 0x2::package::claim<BLACK_NFT_W>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<BLACK_NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<BLACK_NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<BLACK_NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

