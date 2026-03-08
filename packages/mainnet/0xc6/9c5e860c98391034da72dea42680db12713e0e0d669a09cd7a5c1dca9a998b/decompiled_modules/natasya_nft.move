module 0xc69c5e860c98391034da72dea42680db12713e0e0d669a09cd7a5c1dca9a998b::natasya_nft {
    struct NATASYA_NFT has drop {
        dummy_field: bool,
    }

    struct NatasyaNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        metadata_url: 0x1::string::String,
    }

    fun init(arg0: NATASYA_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NATASYA_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{metadata_url}"));
        let v5 = 0x2::display::new_with_fields<NatasyaNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<NatasyaNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NatasyaNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : NatasyaNFT {
        NatasyaNFT{
            id           : 0x2::object::new(arg4),
            name         : arg0,
            description  : arg1,
            image_url    : arg2,
            metadata_url : arg3,
        }
    }

    public fun mint_to(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<NatasyaNFT>(mint(arg0, arg1, arg2, arg3, arg5), arg4);
    }

    // decompiled from Move bytecode v6
}

