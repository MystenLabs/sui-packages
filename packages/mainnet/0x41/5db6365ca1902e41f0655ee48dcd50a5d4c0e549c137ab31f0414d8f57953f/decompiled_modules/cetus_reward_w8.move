module 0x415db6365ca1902e41f0655ee48dcd50a5d4c0e549c137ab31f0414d8f57953f::cetus_reward_w8 {
    struct CETUS_REWARD_W8 has drop {
        dummy_field: bool,
    }

    struct CETUS_REWARD has store, key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
    }

    public entry fun DisperseNFT(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = CETUS_REWARD{
                id        : 0x2::object::new(arg1),
                image_url : 0x1::string::utf8(b"ipfs://QmdgJAU9AEWPFyq7ZKtQokBqmEwta3PS8T1utKbyCDJ7Ls"),
            };
            0x2::transfer::public_transfer<CETUS_REWARD>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn_nft(arg0: CETUS_REWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let CETUS_REWARD {
            id        : v0,
            image_url : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: CETUS_REWARD_W8, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Reward"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"TBA"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://QmdgJAU9AEWPFyq7ZKtQokBqmEwta3PS8T1utKbyCDJ7Ls"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"TBA"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"TBA"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"TBA"));
        let v4 = 0x2::package::claim<CETUS_REWARD_W8>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<CETUS_REWARD>(&v4, v0, v2, arg1);
        0x2::display::update_version<CETUS_REWARD>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CETUS_REWARD>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

