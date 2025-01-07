module 0xc8bbe3e8b15ea636eee1e54999be6304c007293012597cdf346173b3ca8fecad::kriya_basecamp_nft {
    struct KriyaBasecampNFT has store, key {
        id: 0x2::object::UID,
        multiplier: u8,
    }

    struct KRIYA_BASECAMP_NFT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun transfer(arg0: KriyaBasecampNFT, arg1: address) {
        0x2::transfer::public_transfer<KriyaBasecampNFT>(arg0, arg1);
    }

    fun init(arg0: KRIYA_BASECAMP_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Kriya Basecamp NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmfEq8uUQvTihEe9XtwkUiPvJs41nKnDP9cEip4Sv5b86V"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Kriya Basecamp NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.kriya.finance"));
        let v4 = 0x2::package::claim<KRIYA_BASECAMP_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<KriyaBasecampNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<KriyaBasecampNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<KriyaBasecampNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &AdminCap, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : KriyaBasecampNFT {
        KriyaBasecampNFT{
            id         : 0x2::object::new(arg2),
            multiplier : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

