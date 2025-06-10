module 0xf2ce1b2ae9194ab8018279197f57ad4a4a3e832eebeeed2d0470615b1394be2f::lets_move {
    struct Flag has copy, drop {
        sender: address,
        flag: bool,
        ture_num: u64,
        github_id: 0x1::ascii::String,
    }

    struct Challenge has key {
        id: 0x2::object::UID,
        str: 0x1::ascii::String,
        difficulity: u64,
        ture_num: u64,
    }

    fun getRandomString(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : 0x1::ascii::String {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 4, 30);
        let v2 = b"";
        while (v1 != 0) {
            0x1::vector::push_back<u8>(&mut v2, 0x2::random::generate_u8_in_range(&mut v0, 34, 126));
            v1 = v1 - 1;
        };
        0x1::ascii::string(v2)
    }

    entry fun get_flag(arg0: vector<u8>, arg1: 0x1::ascii::String, arg2: &mut Challenge, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::tx_context::sender(arg4)));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<Challenge>(arg2));
        let v1 = 0x1::hash::sha3_256(v0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < arg2.difficulity) {
            v2 = v2 + (*0x1::vector::borrow<u8>(&v1, v3) as u32);
            v3 = v3 + 1;
        };
        assert!(v2 == 0, 0);
        let v4 = getRandomString(arg3, arg4);
        arg2.str = v4;
        arg2.ture_num = arg2.ture_num + 1;
        let v5 = Flag{
            sender    : 0x2::tx_context::sender(arg4),
            flag      : true,
            ture_num  : arg2.ture_num,
            github_id : arg1,
        };
        0x2::event::emit<Flag>(v5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Challenge{
            id          : 0x2::object::new(arg0),
            str         : 0x1::ascii::string(b"LetsMoveCTF"),
            difficulity : 3,
            ture_num    : 0,
        };
        0x2::transfer::share_object<Challenge>(v0);
    }

    // decompiled from Move bytecode v6
}

