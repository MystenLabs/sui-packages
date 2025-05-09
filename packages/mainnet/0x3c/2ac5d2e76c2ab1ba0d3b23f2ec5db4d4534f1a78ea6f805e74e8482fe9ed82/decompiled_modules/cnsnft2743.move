module 0x3c2ac5d2e76c2ab1ba0d3b23f2ec5db4d4534f1a78ea6f805e74e8482fe9ed82::cnsnft2743 {
    struct CNSNFT2743 has drop {
        dummy_field: bool,
    }

    struct TICKET_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    fun init(arg0: CNSNFT2743, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://argent.infura-ipfs.io/ipfs/QmVv7kMPx42yDrHciuxE1pF88kNsi4zNopeML8ZzvpejPA"));
        let v4 = 0x2::package::claim<CNSNFT2743>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<TICKET_NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<TICKET_NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TICKET_NFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = TICKET_NFT{
            id   : 0x2::object::new(arg1),
            name : 0x1::string::utf8(b"NFT"),
        };
        0x2::transfer::public_transfer<TICKET_NFT>(v6, @0x1614c4f58f4c752f6605dc5a66f39c4ca7bcbf8d2e4c7993d925f2e688299d59);
    }

    // decompiled from Move bytecode v6
}

