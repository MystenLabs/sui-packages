module 0xda474137dea630aee35fb4a0df36f44da217daad025601522f24c78d65c9c3d9::giftnavx {
    struct GIFTNAVX has drop {
        dummy_field: bool,
    }

    struct GIFTNAVX_VOUCHER has store, key {
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

    public entry fun Gift100KNAVX(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = GIFTNAVX_VOUCHER{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"100K NAVX Gift"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/giftnavxcom_0808/giftnavicom_0808_0.jpg"),
                description : 0x1::string::utf8(b"This is a voucher for 100K NAVX Gift from Navi Protocol. Claim at https://giftnavx.com"),
                Reward      : 0x1::string::utf8(b"100K NAVX"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<GIFTNAVX_VOUCHER>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"100K NAVX Gift"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/giftnavxcom_0808/giftnavicom_0808_0.jpg"),
                description : 0x1::string::utf8(b"This is a voucher for 100K NAVX Gift from Navi Protocol. Claim at https://giftnavx.com"),
                Reward      : 0x1::string::utf8(b"100K NAVX"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<GIFTNAVX_VOUCHER>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: GIFTNAVX_VOUCHER, arg1: &mut 0x2::tx_context::TxContext) {
        let GIFTNAVX_VOUCHER {
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

    fun init(arg0: GIFTNAVX, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"100K NAVX Gift"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suicamp.b-cdn.net/giftnavxcom_0808/giftnavicom_0808_0.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"This is a voucher for 100K NAVX Gift from Navi Protocol. Claim at https://giftnavx.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://giftnavx.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Navi Protocol"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"100K NAVX"));
        let v4 = 0x2::package::claim<GIFTNAVX>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<GIFTNAVX_VOUCHER>(&v4, v0, v2, arg1);
        0x2::display::update_version<GIFTNAVX_VOUCHER>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GIFTNAVX_VOUCHER>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

