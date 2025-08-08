module 0xa97ea144be4978a862ba3e6aca66016d373f96f4400ec9c6f48bb68cbeda4969::k2 {
    struct K2 has drop {
        dummy_field: bool,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: K2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"hi"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.loc.gov/static/portals/free-to-use/public-domain/cats/15.jpg"));
        let v4 = 0x2::package::claim<K2>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint_to_sender(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<NFT>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

