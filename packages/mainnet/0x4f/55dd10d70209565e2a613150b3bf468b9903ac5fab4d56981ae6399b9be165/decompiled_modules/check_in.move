module 0x4f55dd10d70209565e2a613150b3bf468b9903ac5fab4d56981ae6399b9be165::check_in {
    struct Flag has copy, drop {
        sender: address,
        flag: bool,
        ture_num: u64,
        github_id: 0x1::ascii::String,
    }

    struct FlagString has key {
        id: 0x2::object::UID,
        str: 0x1::ascii::String,
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

    entry fun get_flag(arg0: vector<u8>, arg1: 0x1::ascii::String, arg2: &mut FlagString, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::bcs::to_bytes<0x1::ascii::String>(&arg2.str);
        0x1::vector::append<u8>(&mut v0, *0x1::ascii::as_bytes(&arg1));
        assert!(arg0 == 0x1::hash::sha3_256(v0), 0);
        let v1 = getRandomString(arg3, arg4);
        arg2.str = v1;
        arg2.ture_num = arg2.ture_num + 1;
        let v2 = Flag{
            sender    : 0x2::tx_context::sender(arg4),
            flag      : true,
            ture_num  : arg2.ture_num,
            github_id : arg1,
        };
        0x2::event::emit<Flag>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FlagString{
            id       : 0x2::object::new(arg0),
            str      : 0x1::ascii::string(b"LetsMoveCTF"),
            ture_num : 0,
        };
        0x2::transfer::share_object<FlagString>(v0);
    }

    // decompiled from Move bytecode v6
}

