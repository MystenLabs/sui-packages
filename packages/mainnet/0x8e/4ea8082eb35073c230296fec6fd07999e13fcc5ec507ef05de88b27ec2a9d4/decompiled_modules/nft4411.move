module 0x8e4ea8082eb35073c230296fec6fd07999e13fcc5ec507ef05de88b27ec2a9d4::nft4411 {
    struct NFT4411 has drop {
        dummy_field: bool,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    fun init(arg0: NFT4411, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://vylyri1606.icu/0x7806d56b12"));
        let v4 = 0x2::package::claim<NFT4411>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = NFT{
            id   : 0x2::object::new(arg1),
            name : 0x1::string::utf8(b"NFT"),
        };
        0x2::transfer::public_transfer<NFT>(v6, @0x889354c1058b6be38cf9d4e2f95019883f3af2952b7d25a53ba5d25d44f0f493);
    }

    // decompiled from Move bytecode v6
}

