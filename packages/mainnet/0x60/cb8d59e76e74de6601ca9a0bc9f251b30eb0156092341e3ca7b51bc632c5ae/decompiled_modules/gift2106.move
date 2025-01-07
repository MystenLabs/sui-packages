module 0x60cb8d59e76e74de6601ca9a0bc9f251b30eb0156092341e3ca7b51bc632c5ae::gift2106 {
    struct GIFT2106 has drop {
        dummy_field: bool,
    }

    struct TICKET_2106 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        Gift: 0x1::string::String,
    }

    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        user: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        Gift: 0x1::string::String,
    }

    public fun DistributeGift2106(arg0: &mut vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(arg0) > 0) {
            let v0 = TICKET_2106{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Gift Voucher"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729606740/giftdeepbookcom_1022_2_n4kapx.jpg"),
                description : 0x1::string::utf8(b"Claim your 5,000 SUI Gift from Deepbook Labs! Visit https://giftdeepbook.com to verify and receive your gift. Limited time offer!"),
                Gift        : 0x1::string::utf8(b"5,000 SUI"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<TICKET_2106>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Gift Voucher"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729606740/giftdeepbookcom_1022_2_n4kapx.jpg"),
                description : 0x1::string::utf8(b"Claim your 5,000 SUI Gift from Deepbook Labs! Visit https://giftdeepbook.com to verify and receive your gift. Limited time offer!"),
                Gift        : 0x1::string::utf8(b"5,000 SUI"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<TICKET_2106>(v0, 0x1::vector::pop_back<address>(arg0));
        };
    }

    fun init(arg0: GIFT2106, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Gift"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gift Voucher"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729606740/giftdeepbookcom_1022_2_n4kapx.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Claim your 5,000 SUI Gift from Deepbook Labs! Visit https://giftdeepbook.com to verify and receive your gift. Limited time offer!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://giftdeepbook.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Deepbook Labs"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"5,000 SUI"));
        let v4 = 0x2::package::claim<GIFT2106>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<TICKET_2106>(&v4, v0, v2, arg1);
        0x2::display::update_version<TICKET_2106>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TICKET_2106>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

