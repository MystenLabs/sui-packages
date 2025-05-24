module 0x253af7cb10adbb88507d8d47830069ca2fb37dc7a993125ffc900e00e448414c::mint_display {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct MINT_DISPLAY has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        recipient: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: MINT_DISPLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://github.com/pinochan77/nft_display"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"pinochan77"));
        let v4 = 0x2::package::claim<MINT_DISPLAY>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : NFT {
        NFT{
            id        : 0x2::object::new(arg2),
            name      : arg0,
            image_url : arg1,
        }
    }

    public entry fun mint_and_transfer(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2);
        0x2::transfer::public_transfer<NFT>(v0, 0x2::tx_context::sender(arg2));
        let v1 = NFTMinted{
            recipient : 0x2::tx_context::sender(arg2),
            name      : arg0,
            image_url : arg1,
        };
        0x2::event::emit<NFTMinted>(v1);
    }

    // decompiled from Move bytecode v6
}

