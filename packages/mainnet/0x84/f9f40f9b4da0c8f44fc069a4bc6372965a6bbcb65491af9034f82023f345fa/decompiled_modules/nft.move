module 0x84f9f40f9b4da0c8f44fc069a4bc6372965a6bbcb65491af9034f82023f345fa::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct MyNFT has store, key {
        id: 0x2::object::UID,
        github_id: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    public entry fun Burn(arg0: MyNFT) {
        let MyNFT {
            id        : v0,
            github_id : _,
            image_url : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun Mint(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg1),
            github_id : 0x1::string::utf8(b"Veincealan"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/95604105?v=4&size=64"),
        };
        0x2::transfer::public_transfer<MyNFT>(v0, arg0);
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"github_id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{github_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<MyNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<MyNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MyNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

