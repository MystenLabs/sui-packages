module 0x8b1402e5a28a69d280959b05db83eaf110d5dc5b08e65050aa6e025b7403b5c2::lihuazhang_nft {
    struct LIHUAZHANG_NFT has drop {
        dummy_field: bool,
    }

    struct GithubAvatarNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        github_id: 0x1::string::String,
        img_url: 0x1::string::String,
    }

    struct GithubAvatarNFTIssuerCap has key {
        id: 0x2::object::UID,
        supply: u64,
        issued_counter: u64,
    }

    public fun burn(arg0: &mut GithubAvatarNFTIssuerCap, arg1: GithubAvatarNFT) {
        let GithubAvatarNFT {
            id        : v0,
            name      : _,
            github_id : _,
            img_url   : _,
        } = arg1;
        arg0.supply = arg0.supply - 1;
        0x2::object::delete(v0);
    }

    fun init(arg0: LIHUAZHANG_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://github.com/{github_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"My Github Avatar NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://github.com/lihuazhang/letsmove"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Move Beginner"));
        let v4 = 0x2::package::claim<LIHUAZHANG_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<GithubAvatarNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<GithubAvatarNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GithubAvatarNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = GithubAvatarNFTIssuerCap{
            id             : 0x2::object::new(arg1),
            supply         : 0,
            issued_counter : 0,
        };
        0x2::transfer::transfer<GithubAvatarNFTIssuerCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut GithubAvatarNFTIssuerCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        arg0.issued_counter = arg0.issued_counter + 1;
        arg0.supply = arg0.supply + 1;
        assert!(arg0.supply <= 1000, 0);
        let v0 = GithubAvatarNFT{
            id        : 0x2::object::new(arg5),
            name      : arg1,
            github_id : arg2,
            img_url   : arg3,
        };
        0x2::transfer::transfer<GithubAvatarNFT>(v0, arg4);
    }

    // decompiled from Move bytecode v6
}

