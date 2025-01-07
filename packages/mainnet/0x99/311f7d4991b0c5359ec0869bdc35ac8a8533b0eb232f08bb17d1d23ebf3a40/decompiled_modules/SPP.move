module 0x99311f7d4991b0c5359ec0869bdc35ac8a8533b0eb232f08bb17d1d23ebf3a40::SPP {
    struct SPP has drop {
        dummy_field: bool,
    }

    struct SPP_NFT has store, key {
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

    public entry fun MintNFT(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"36dbfe51e2857ae239f922b12e1c2b99e94345ae459314146b3e61625d57033f";
        if (0x2::tx_context::sender(arg1) == 0x2::address::from_ascii_bytes(&v0)) {
            while (0x1::vector::length<address>(&arg0) > 0) {
                let v1 = SPP_NFT{
                    id          : 0x2::object::new(arg1),
                    name        : 0x1::string::utf8(b"SPP NFT"),
                    image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dututcxrh/image/upload/v1720837358/suiNftTrade/black_logo_tuoydv.jpg"),
                    description : 0x1::string::utf8(b"SPP NFT Detail"),
                };
                let v2 = MintEvent{
                    nft_id      : 0x2::object::id<SPP_NFT>(&v1),
                    user        : 0x2::tx_context::sender(arg1),
                    name        : 0x1::string::utf8(b"SPP NFT"),
                    image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dututcxrh/image/upload/v1720837358/suiNftTrade/black_logo_tuoydv.jpg"),
                    description : 0x1::string::utf8(b"SPP NFT Detail"),
                };
                0x2::event::emit<MintEvent>(v2);
                0x2::transfer::public_transfer<SPP_NFT>(v1, 0x1::vector::pop_back<address>(&mut arg0));
            };
        };
    }

    public entry fun burn_nft(arg0: SPP_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let SPP_NFT {
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

    fun init(arg0: SPP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SPP NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://res.cloudinary.com/dututcxrh/image/upload/v1720837358/suiNftTrade/black_logo_tuoydv.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SPP NFT Detail"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sppnft.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SPP Labs"));
        let v4 = 0x2::package::claim<SPP>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SPP_NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<SPP_NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SPP_NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

