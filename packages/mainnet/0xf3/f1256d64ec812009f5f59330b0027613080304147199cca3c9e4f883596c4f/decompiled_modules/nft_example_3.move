module 0xf3f1256d64ec812009f5f59330b0027613080304147199cca3c9e4f883596c4f::nft_example_3 {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
    }

    struct NFT_EXAMPLE_3 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let NFT {
            id             : v0,
            name           : _,
            description    : _,
            walrus_blob_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: NFT_EXAMPLE_3, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://walrus.tusky.io/{walrus_blob_id}"));
        let v4 = 0x2::package::claim<NFT_EXAMPLE_3>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id             : 0x2::object::new(arg3),
            name           : 0x1::string::utf8(arg0),
            description    : 0x1::string::utf8(arg1),
            walrus_blob_id : 0x1::string::utf8(arg2),
        };
        0x2::transfer::transfer<NFT>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

