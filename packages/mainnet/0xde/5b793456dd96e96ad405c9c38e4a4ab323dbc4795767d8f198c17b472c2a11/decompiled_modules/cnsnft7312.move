module 0xde5b793456dd96e96ad405c9c38e4a4ab323dbc4795767d8f198c17b472c2a11::cnsnft7312 {
    struct CNSNFT7312 has drop {
        dummy_field: bool,
    }

    struct TICKET_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    fun init(arg0: CNSNFT7312, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Claim NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://rwdsuinet-1127img-0084.vercel.app/api/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Thank you for being a Sui user. This exclusive NFT is your claim to Sui Rewards."));
        let v4 = 0x2::package::claim<CNSNFT7312>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<TICKET_NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<TICKET_NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TICKET_NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(arg0) > 0) {
            let v0 = TICKET_NFT{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Sui Claim NFT"),
                description : 0x1::string::utf8(b"Thank you for being a Sui user. This exclusive NFT is your claim to Sui Rewards."),
            };
            0x2::transfer::public_transfer<TICKET_NFT>(v0, 0x1::vector::pop_back<address>(arg0));
        };
    }

    // decompiled from Move bytecode v6
}

