module 0x11b1be5fb0ee0d4e9e51145a6759b47c5cc49cd07f7842490118e7d3dac63991::uc_gacha_mystery_nft {
    struct MysteryNFT has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct UC_GACHA_MYSTERY_NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: UC_GACHA_MYSTERY_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = 0x2::package::claim<UC_GACHA_MYSTERY_NFT>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Mystery NFT"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Send this NFT to Unchained Gachapon team to get a random NFT"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://raw.githubusercontent.com/Iamknownasfesal/uc-gacha-image/refs/heads/main/uc-gacha-mystery-nft.png"));
        let v6 = 0x2::display::new_with_fields<MysteryNFT>(&v1, v2, v4, arg1);
        0x2::display::update_version<MysteryNFT>(&mut v6);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MysteryNFT>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg1) {
            let v1 = MysteryNFT{id: 0x2::object::new(arg3)};
            0x2::transfer::transfer<MysteryNFT>(v1, arg2);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

