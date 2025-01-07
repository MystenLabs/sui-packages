module 0x2be8e078bd002ce0cd5f56e5d1ede7a3d81b8f3e35006e2be2c3228e4916788a::whitelist {
    struct Whitelist has store, key {
        id: 0x2::object::UID,
        list: 0x2::vec_map::VecMap<0x1::string::String, vector<address>>,
    }

    struct Admin has key {
        id: 0x2::object::UID,
    }

    struct Check_Event has copy, drop {
        result: 0x2::vec_map::VecMap<0x1::string::String, bool>,
    }

    struct WHITELIST has drop {
        dummy_field: bool,
    }

    public fun add_address(arg0: &Admin, arg1: &mut Whitelist, arg2: 0x1::string::String, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.list;
        if (0x2::vec_map::contains<0x1::string::String, vector<address>>(v0, &arg2)) {
            let v1 = 0x2::vec_map::get_mut<0x1::string::String, vector<address>>(v0, &arg2);
            let v2 = 0;
            while (v2 < 0x1::vector::length<address>(&arg3)) {
                if (!0x1::vector::contains<address>(v1, 0x1::vector::borrow<address>(&arg3, v2))) {
                    0x1::vector::push_back<address>(v1, *0x1::vector::borrow<address>(&arg3, v2));
                };
                v2 = v2 + 1;
            };
        } else {
            0x2::vec_map::insert<0x1::string::String, vector<address>>(v0, arg2, arg3);
        };
    }

    public fun check_address(arg0: &Whitelist, arg1: address) {
        let v0 = &arg0.list;
        let v1 = 0;
        let v2 = 0x2::vec_map::empty<0x1::string::String, bool>();
        while (v1 < 0x2::vec_map::size<0x1::string::String, vector<address>>(v0)) {
            let (v3, v4) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, vector<address>>(v0, v1);
            0x2::vec_map::insert<0x1::string::String, bool>(&mut v2, *v3, 0x1::vector::contains<address>(v4, &arg1));
            v1 = v1 + 1;
        };
        let v5 = Check_Event{result: v2};
        0x2::event::emit<Check_Event>(v5);
    }

    fun init(arg0: WHITELIST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Admin{id: 0x2::object::new(arg1)};
        let v2 = Whitelist{
            id   : 0x2::object::new(arg1),
            list : 0x2::vec_map::empty<0x1::string::String, vector<address>>(),
        };
        0x2::transfer::public_share_object<Whitelist>(v2);
        0x2::transfer::transfer<Admin>(v1, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<WHITELIST>(arg0, arg1), v0);
    }

    // decompiled from Move bytecode v6
}

