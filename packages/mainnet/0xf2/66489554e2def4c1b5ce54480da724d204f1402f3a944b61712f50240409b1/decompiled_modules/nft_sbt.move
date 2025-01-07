module 0xf266489554e2def4c1b5ce54480da724d204f1402f3a944b61712f50240409b1::nft_sbt {
    struct NFT_SBT has drop {
        dummy_field: bool,
    }

    struct MySBT has key {
        id: 0x2::object::UID,
        tokenId: u64,
    }

    struct State has key {
        id: 0x2::object::UID,
        count: u64,
    }

    fun init(arg0: NFT_SBT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"collection"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Whitehare2023 SBT#{tokenId}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"MySBT Collection"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://aquamarine-cheerful-giraffe-141.mypinata.cloud/ipfs/QmfCPNvgraRie4WuW6t92hzH8TcAiD2CYEhCNWvbBTHjSb"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"This is My SBT"));
        let v4 = 0x2::package::claim<NFT_SBT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<MySBT>(&v4, v0, v2, arg1);
        0x2::display::update_version<MySBT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MySBT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = State{
            id    : 0x2::object::new(arg1),
            count : 0,
        };
        0x2::transfer::share_object<State>(v6);
    }

    public entry fun mint(arg0: &mut State, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.count = arg0.count + 1;
        let v0 = MySBT{
            id      : 0x2::object::new(arg1),
            tokenId : arg0.count,
        };
        0x2::transfer::transfer<MySBT>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

