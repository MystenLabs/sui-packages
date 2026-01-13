module 0xc8f579db15583fe2f71642ef206ee2a4db7a19a488ecc21d964787b520cb0b14::nft {
    struct Hero has store, key {
        id: 0x2::object::UID,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public entry fun MagmaFinance(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0)) {
            let v1 = Hero{id: 0x2::object::new(arg1)};
            0x2::transfer::transfer<Hero>(v1, *0x1::vector::borrow<address>(&arg0, v0));
            v0 = v0 + 1;
        };
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"dddsds"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.io/ipfs/Qmb7qSCVPXJcfshUCFiRyXEVL1MY6m1nPDXWLWwEico4FD"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b" "));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Hero>(&v4, v0, v2, arg1);
        0x2::display::update_version<Hero>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Hero>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Hero{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<Hero>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

