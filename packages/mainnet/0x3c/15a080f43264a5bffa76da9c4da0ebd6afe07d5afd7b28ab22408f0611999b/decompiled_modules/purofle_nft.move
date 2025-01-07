module 0x3c15a080f43264a5bffa76da9c4da0ebd6afe07d5afd7b28ab22408f0611999b::purofle_nft {
    struct PurofleNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x1::string::String,
    }

    struct PUROFLE_NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUROFLE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"img_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://{img_url}"));
        let v4 = 0x2::package::claim<PUROFLE_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<PurofleNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<PurofleNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<PurofleNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : PurofleNFT {
        PurofleNFT{
            id      : 0x2::object::new(arg2),
            name    : arg0,
            img_url : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

