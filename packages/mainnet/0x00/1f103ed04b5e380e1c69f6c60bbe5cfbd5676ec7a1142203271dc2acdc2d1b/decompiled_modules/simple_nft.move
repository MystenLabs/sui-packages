module 0x1f103ed04b5e380e1c69f6c60bbe5cfbd5676ec7a1142203271dc2acdc2d1b::simple_nft {
    struct SIMPLE_NFT has drop {
        dummy_field: bool,
    }

    struct BlockblockNft has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: SIMPLE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SIMPLE_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<BlockblockNft>(&v0, arg1);
        0x2::display::add<BlockblockNft>(&mut v1, 0x1::string::utf8(b"id"), 0x1::string::utf8(b"{id}"));
        0x2::display::add<BlockblockNft>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<BlockblockNft>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<BlockblockNft>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<BlockblockNft>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = BlockblockNft{
            id        : 0x2::object::new(arg3),
            name      : arg0,
            image_url : arg1,
        };
        0x2::transfer::transfer<BlockblockNft>(v0, arg2);
    }

    entry fun mint_self(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BlockblockNft{
            id        : 0x2::object::new(arg2),
            name      : arg0,
            image_url : arg1,
        };
        0x2::transfer::transfer<BlockblockNft>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

