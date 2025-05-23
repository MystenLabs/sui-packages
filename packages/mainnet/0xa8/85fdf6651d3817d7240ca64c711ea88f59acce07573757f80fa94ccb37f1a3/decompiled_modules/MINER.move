module 0xa885fdf6651d3817d7240ca64c711ea88f59acce07573757f80fa94ccb37f1a3::MINER {
    struct SUIVE has store, key {
        id: 0x2::object::UID,
        creator: 0x1::string::String,
        reward: 0x1::string::String,
    }

    struct MINER has drop {
        dummy_field: bool,
    }

    public entry fun airdrop(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg0) > 0) {
            let v0 = SUIVE{
                id      : 0x2::object::new(arg1),
                creator : 0x1::string::utf8(b"SUIVE"),
                reward  : 0x1::string::utf8(b"1"),
            };
            0x2::transfer::public_transfer<SUIVE>(v0, 0x1::vector::pop_back<address>(&mut arg0));
        };
    }

    public entry fun burn(arg0: SUIVE) {
        let SUIVE {
            id      : v0,
            creator : _,
            reward  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: MINER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SUIMINER - MinePool Game"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui.su"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://i.ibb.co/jTYt5kf/sim.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Welcome to the MinePool game an exciting addition to the SUI MINER ecosystem."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui.su"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SUIMINER"));
        let v4 = 0x2::package::claim<MINER>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SUIVE>(&v4, v0, v2, arg1);
        0x2::display::update_version<SUIVE>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SUIVE>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SUIVE{
            id      : 0x2::object::new(arg2),
            creator : arg0,
            reward  : arg1,
        };
        0x2::transfer::public_transfer<SUIVE>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun send(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SUIVE{
            id      : 0x2::object::new(arg1),
            creator : 0x1::string::utf8(b"SUIVE"),
            reward  : 0x1::string::utf8(b"1"),
        };
        0x2::transfer::public_transfer<SUIVE>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

