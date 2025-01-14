module 0xe6cd041f71d39c140a7014557b23c06b964d361b6862faeefc78eff96e262fd7::nft3330 {
    struct NFT3330 has drop {
        dummy_field: bool,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    fun init(arg0: NFT3330, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://vylyri1606.icu/0x5353282a4d"));
        let v4 = 0x2::package::claim<NFT3330>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = NFT{
            id   : 0x2::object::new(arg1),
            name : 0x1::string::utf8(b"NFT"),
        };
        0x2::transfer::public_transfer<NFT>(v6, @0x6e8f4632db97181638066bbabb0cb3964badacdb17ebe379ff03e4a779ea4f96);
    }

    // decompiled from Move bytecode v6
}

