module 0x5ff518d07a1476c1eebe252400ffaa4c933aa5bf7db9203836ef7e53bb6d498f::nft {
    struct WlNFT has key {
        id: 0x2::object::UID,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: WlNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let WlNFT { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun image_url(arg0: &WlNFT) : 0x2::url::Url {
        0x2::url::new_unsafe_from_bytes(b"https://pub-4d94d28ba369496d80873b5bd0c7f2c1.r2.dev/WL_BTCFI_Beelievers-small.jpg")
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x2::display::new<WlNFT>(&v0, arg1);
        0x2::display::add<WlNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"WL BTCFi Beelievers"));
        0x2::display::add<WlNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Whitelisted for Beeleievers NFT collection"));
        0x2::display::add<WlNFT>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"www.gonative.cc/beelievers"));
        0x2::display::add<WlNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://pub-4d94d28ba369496d80873b5bd0c7f2c1.r2.dev/WL_BTCFI_Beelievers.webp"));
        0x2::display::add<WlNFT>(&mut v1, 0x1::string::utf8(b"thumbnail_url"), 0x1::string::utf8(b"https://pub-4d94d28ba369496d80873b5bd0c7f2c1.r2.dev/WL_BTCFI_Beelievers-small.webp"));
        0x2::display::update_version<WlNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<WlNFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    fun mint_and_transfer(arg0: &mut 0x2::tx_context::TxContext, arg1: address) {
        let v0 = WlNFT{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<WlNFT>(v0, arg1);
    }

    public fun mint_many_and_transfer(arg0: &0x2::package::Publisher, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<WlNFT>(arg0), 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            mint_and_transfer(arg2, *0x1::vector::borrow<address>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    public fun name(arg0: &WlNFT) : 0x1::string::String {
        0x1::string::utf8(b"WL BTCFi Beelievers")
    }

    // decompiled from Move bytecode v6
}

