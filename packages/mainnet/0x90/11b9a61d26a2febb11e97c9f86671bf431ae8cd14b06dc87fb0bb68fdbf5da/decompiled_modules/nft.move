module 0x9011b9a61d26a2febb11e97c9f86671bf431ae8cd14b06dc87fb0bb68fdbf5da::nft {
    struct PoorlaxNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x2::display::new<PoorlaxNFT>(&v0, arg1);
        0x2::display::add<PoorlaxNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<PoorlaxNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<PoorlaxNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::update_version<PoorlaxNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<PoorlaxNFT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = PoorlaxNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        0x2::transfer::public_transfer<PoorlaxNFT>(v0, arg3);
    }

    // decompiled from Move bytecode v6
}

