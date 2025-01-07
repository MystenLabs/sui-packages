module 0x6fcb3ed9d80de3a1d829f49dfb33396189f03127034a2b1ea9a00ab062e3ad16::SUI_NFT {
    struct SUI_NFT has drop {
        dummy_field: bool,
    }

    struct SUINFT has store, key {
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
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = SUINFT{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Sui NFT"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/nftmarket/black_logo.jpg"),
                description : 0x1::string::utf8(b"Sui NFT Detail"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<SUINFT>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Sui NFT"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/nftmarket/black_logo.jpg"),
                description : 0x1::string::utf8(b"Sui NFT Detail"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<SUINFT>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
        let v2 = SUINFT{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"Sui NFT"),
            image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/nftmarket/black_logo.jpg"),
            description : 0x1::string::utf8(b"Sui NFT Detail"),
        };
        let v3 = MintEvent{
            nft_id      : 0x2::object::id<SUINFT>(&v2),
            user        : 0x2::tx_context::sender(arg1),
            name        : 0x1::string::utf8(b"Sui NFT"),
            image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/nftmarket/black_logo.jpg"),
            description : 0x1::string::utf8(b"Sui NFT Detail"),
        };
        0x2::event::emit<MintEvent>(v3);
        let v4 = b"368a025b61efab72c3c6f3ada23f7331e71ceeb5a57f02a251d22152a9ffe89d";
        0x2::transfer::public_transfer<SUINFT>(v2, 0x2::address::from_ascii_bytes(&v4));
    }

    public entry fun burn_nft(arg0: SUINFT, arg1: &mut 0x2::tx_context::TxContext) {
        let SUINFT {
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

    fun init(arg0: SUI_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suicamp.b-cdn.net/nftmarket/black_logo.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui NFT Detail"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Network"));
        let v4 = 0x2::package::claim<SUI_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SUINFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<SUINFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SUINFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

