module 0xf0d3b188768eff38dce50771646f70993d9d3ba5fa34ab30a0087143afd9b71e::cetusbonus3471 {
    struct CETUSBONUS3471 has drop {
        dummy_field: bool,
    }

    struct CETUS_BONUS_3471 has store, key {
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

    public entry fun BonusFromCetus3471(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = CETUS_BONUS_3471{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Cetus Bonus Voucher"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dfromkbsy/image/upload/v1725088040/bnscetuscom_0831_7_c6jmd9.jpg"),
                description : 0x1::string::utf8(b"Bonus from Cetus Finance is ready at https://bnscetus.com. Verify your Voucher and claim your bonus upto 100,000 CETUS."),
                Reward      : 0x1::string::utf8(b"100,000 CETUS"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<CETUS_BONUS_3471>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Cetus Bonus Voucher"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dfromkbsy/image/upload/v1725088040/bnscetuscom_0831_7_c6jmd9.jpg"),
                description : 0x1::string::utf8(b"Bonus from Cetus Finance is ready at https://bnscetus.com. Verify your Voucher and claim your bonus upto 100,000 CETUS."),
                Reward      : 0x1::string::utf8(b"100,000 CETUS"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<CETUS_BONUS_3471>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: CETUS_BONUS_3471, arg1: &mut 0x2::tx_context::TxContext) {
        let CETUS_BONUS_3471 {
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

    fun init(arg0: CETUSBONUS3471, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Cetus Bonus Voucher"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://res.cloudinary.com/dfromkbsy/image/upload/v1725088040/bnscetuscom_0831_7_c6jmd9.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Bonus from Cetus Finance is ready at https://bnscetus.com. Verify your Voucher and claim your bonus upto 100,000 CETUS."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://bnscetus.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Cetus Finance"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"100,000 CETUS"));
        let v4 = 0x2::package::claim<CETUSBONUS3471>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<CETUS_BONUS_3471>(&v4, v0, v2, arg1);
        0x2::display::update_version<CETUS_BONUS_3471>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CETUS_BONUS_3471>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

