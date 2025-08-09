module 0xe4d3fa3b114e41c042a91f0738020301717db23f23a1fb5789cf9be89058a012::bauchi_sui_nft {
    struct BAUCHI_SUI_NFT has drop {
        dummy_field: bool,
    }

    struct BauchiSuiNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    fun init(arg0: BAUCHI_SUI_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<BAUCHI_SUI_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<BauchiSuiNFT>(&v0, arg1);
        0x2::display::add<BauchiSuiNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://i.ibb.co/FqdZ6rXX/20250809-135450.jpg"));
        0x2::display::update_version<BauchiSuiNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<BauchiSuiNFT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_to_address(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BauchiSuiNFT{
            id          : 0x2::object::new(arg2),
            name        : arg0,
            description : 0x1::string::utf8(b"Bauch Sui Workshop 9th August 2025 (BlockchainBard)"),
        };
        0x2::transfer::transfer<BauchiSuiNFT>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

