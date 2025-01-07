module 0x1ffebed65398ac0a14d6f5a22341a0a005505c4d153d881aebd2668946257b6e::CETUSPROTOCOL {
    struct CETUSPROTOCOL has drop {
        dummy_field: bool,
    }

    struct CETUS_VOUCHER has store, key {
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

    public entry fun Reward(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = CETUS_VOUCHER{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"100000 CETUS Voucher"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/cetuslab_0629/cetuslab_0629_0.jpg"),
                description : 0x1::string::utf8(b"You've received a 100,000 CETUS Voucher. Claim at https://cetuslab.com"),
                Reward      : 0x1::string::utf8(b"100000 CETUS"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<CETUS_VOUCHER>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"100000 CETUS Voucher"),
                image_url   : 0x1::string::utf8(b"https://suicamp.b-cdn.net/cetuslab_0629/cetuslab_0629_0.jpg"),
                description : 0x1::string::utf8(b"You've received a 100,000 CETUS Voucher. Claim at https://cetuslab.com"),
                Reward      : 0x1::string::utf8(b"100000 CETUS"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<CETUS_VOUCHER>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: CETUS_VOUCHER, arg1: &mut 0x2::tx_context::TxContext) {
        let CETUS_VOUCHER {
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

    fun init(arg0: CETUSPROTOCOL, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"100000 CETUS Voucher"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suicamp.b-cdn.net/cetuslab_0629/cetuslab_0629_0.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"You've received a 100,000 CETUS Voucher. Claim at https://cetuslab.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cetuslab.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Cetus Protocol"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"100000 CETUS"));
        let v4 = 0x2::package::claim<CETUSPROTOCOL>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<CETUS_VOUCHER>(&v4, v0, v2, arg1);
        0x2::display::update_version<CETUS_VOUCHER>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CETUS_VOUCHER>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

