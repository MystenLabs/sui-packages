module 0x254abb890c9f4e52577e0c21ad4208bd3e81bea7d4cee90d841f87da5d7104df::SUI_PEPE_NFT {
    struct SUI_PEPE_NFT has drop {
        dummy_field: bool,
    }

    struct SuiPepeNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_PEPE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUI_PEPE_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<SuiPepeNFT>(&v0, arg1);
        0x2::display::add<SuiPepeNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SuiPepeNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<SuiPepeNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::update_version<SuiPepeNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<SuiPepeNFT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = SuiPepeNFT{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        0x2::transfer::public_transfer<SuiPepeNFT>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

