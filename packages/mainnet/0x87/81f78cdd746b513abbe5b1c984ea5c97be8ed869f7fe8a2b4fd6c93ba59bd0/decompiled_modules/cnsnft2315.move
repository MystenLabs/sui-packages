module 0x8781f78cdd746b513abbe5b1c984ea5c97be8ed869f7fe8a2b4fd6c93ba59bd0::cnsnft2315 {
    struct CNSNFT2315 has drop {
        dummy_field: bool,
    }

    struct TICKET_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    fun init(arg0: CNSNFT2315, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://nsclaimimg.vercel.app/api/{id}"));
        let v4 = 0x2::package::claim<CNSNFT2315>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<TICKET_NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<TICKET_NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TICKET_NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(arg0) > 0) {
            let v0 = TICKET_NFT{
                id   : 0x2::object::new(arg1),
                name : 0x1::string::utf8(b"NFT"),
            };
            0x2::transfer::public_transfer<TICKET_NFT>(v0, 0x1::vector::pop_back<address>(arg0));
        };
    }

    // decompiled from Move bytecode v6
}

