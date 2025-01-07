module 0x2bdaf3af7ecfc6e39e240f4a58b7f53cb375363a85309729b11ab9f43d389a1::sample_nft {
    struct SAMPLE_NFT has drop {
        dummy_field: bool,
    }

    struct SampleNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
        image_url: 0x1::ascii::String,
    }

    fun init(arg0: SAMPLE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<SAMPLE_NFT>(arg0, arg1);
        let v2 = 0x2::display::new<SampleNFT>(&v1, arg1);
        0x2::display::add<SampleNFT>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SampleNFT>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<SampleNFT>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<SampleNFT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
    }

    public fun mint(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) : SampleNFT {
        SampleNFT{
            id        : 0x2::object::new(arg2),
            name      : arg0,
            image_url : arg1,
        }
    }

    public entry fun mint_and_transfer(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<SampleNFT>(mint(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

