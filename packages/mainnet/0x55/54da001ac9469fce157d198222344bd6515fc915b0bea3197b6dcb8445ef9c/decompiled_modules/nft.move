module 0x5554da001ac9469fce157d198222344bd6515fc915b0bea3197b6dcb8445ef9c::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct GithubNFT has store, key {
        id: 0x2::object::UID,
        tokenId: u64,
        githubName: 0x1::ascii::String,
        image_url_prefixe: 0x1::ascii::String,
    }

    struct State has key {
        id: 0x2::object::UID,
        count: u64,
    }

    public fun createGithubNFT(arg0: u64, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) : GithubNFT {
        GithubNFT{
            id                : 0x2::object::new(arg2),
            tokenId           : arg0,
            githubName        : arg1,
            image_url_prefixe : 0x1::ascii::string(b"https://avatars.githubusercontent.com/"),
        }
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"token_id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"collection"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"GithubNFT #{tokenId}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Github #{githubName}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Github Avatars Collection"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url_prefixe}/{githubName}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"This is Github User {githubName} Avatar NFT"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<GithubNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<GithubNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GithubNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = State{
            id    : 0x2::object::new(arg1),
            count : 0,
        };
        0x2::transfer::share_object<State>(v6);
    }

    public entry fun mint(arg0: &mut State, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        arg0.count = arg0.count + 1;
        0x2::transfer::public_transfer<GithubNFT>(createGithubNFT(arg0.count, arg1, arg2), v0);
    }

    public entry fun update_name(arg0: &mut GithubNFT, arg1: 0x1::ascii::String) {
        arg0.githubName = arg1;
    }

    // decompiled from Move bytecode v6
}

