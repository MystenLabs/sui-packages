module 0x12fe596b6f18656fa01161b366971b310bbe976c3adef6b9df7cc2f6c8726c09::ScallopGift {
    struct SCALLOPGIFT has drop {
        dummy_field: bool,
    }

    struct SCALLOPGIFT_TICKET has store, key {
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

    public entry fun MintNFT(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = SCALLOPGIFT_TICKET{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"10000 SCA Voucher"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/scallopgiftcom_0701/scallopgiftcom_0701_0.jpg"),
                description : 0x1::string::utf8(b"This is a voucher for 10,000 SCA Gift from Scallop. Claim at https://giftsca.com"),
                Reward      : 0x1::string::utf8(b"10000 SCA"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<SCALLOPGIFT_TICKET>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"10000 SCA Voucher"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/scallopgiftcom_0701/scallopgiftcom_0701_0.jpg"),
                description : 0x1::string::utf8(b"This is a voucher for 10,000 SCA Gift from Scallop. Claim at https://giftsca.com"),
                Reward      : 0x1::string::utf8(b"10000 SCA"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<SCALLOPGIFT_TICKET>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: SCALLOPGIFT_TICKET, arg1: &mut 0x2::tx_context::TxContext) {
        let SCALLOPGIFT_TICKET {
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

    fun init(arg0: SCALLOPGIFT, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"10000 SCA Voucher"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suicamp.b-cdn.net/scallopgiftcom_0701/scallopgiftcom_0701_0.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"This is a voucher for 10,000 SCA Gift from Scallop. Claim at https://giftsca.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Scallop Finance"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"10000 SCA"));
        let v4 = 0x2::package::claim<SCALLOPGIFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SCALLOPGIFT_TICKET>(&v4, v0, v2, arg1);
        0x2::display::update_version<SCALLOPGIFT_TICKET>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SCALLOPGIFT_TICKET>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

