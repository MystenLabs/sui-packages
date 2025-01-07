module 0xf9f8c7251759659b3e11a353a9674843c2c44616ce49cfcfb4d6d15edb424180::archie_nft {
    struct MintingCapability has key {
        id: 0x2::object::UID,
    }

    struct ARCHIE_NFT has drop {
        dummy_field: bool,
    }

    struct Archie_NFT has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: ARCHIE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ArchieR7"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"An NFT representing a ArchieR7"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/9522925?v=4"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ArchieR7"));
        let v4 = 0x2::package::claim<ARCHIE_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Archie_NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<Archie_NFT>(&mut v5);
        let v6 = MintingCapability{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MintingCapability>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Archie_NFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &MintingCapability, arg1: u16, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg1) {
            let v1 = Archie_NFT{id: 0x2::object::new(arg3)};
            0x2::transfer::public_transfer<Archie_NFT>(v1, arg2);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

