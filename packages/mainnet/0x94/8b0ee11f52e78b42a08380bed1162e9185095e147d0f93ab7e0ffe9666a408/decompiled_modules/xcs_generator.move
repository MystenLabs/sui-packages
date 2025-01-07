module 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::xcs_generator {
    struct XcsMintLimit has drop, store {
        left: u64,
    }

    struct XcsRaffle has key {
        id: 0x2::object::UID,
        xcs_mint_limit: 0x2::vec_map::VecMap<0x1::string::String, XcsMintLimit>,
    }

    struct DrawEvent has copy, drop {
        xcs_drawn: 0x1::string::String,
        to: address,
    }

    public fun add_admin(arg0: &mut 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::ControlledCaps, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::add_capability<0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::AdminCap>(arg0, arg1, 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::new_admin_cap(), arg2);
    }

    public fun add_drawer(arg0: &mut 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::ControlledCaps, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::add_capability<0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::DrawCap>(arg0, arg1, 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::new_draw_cap(), arg2);
    }

    public fun add_xcs_raffle(arg0: &mut 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::ControlledCaps, arg1: &mut XcsRaffle, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::has_cap<0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::AdminCap>(arg0, 0x2::tx_context::sender(arg4)), 0);
        let v0 = XcsMintLimit{left: arg3};
        0x2::vec_map::insert<0x1::string::String, XcsMintLimit>(&mut arg1.xcs_mint_limit, arg2, v0);
    }

    fun arithmetic_is_less_than(arg0: u8, arg1: u8, arg2: u8) : u8 {
        assert!(arg2 >= arg1 && arg1 > 0, 7);
        let v0 = arg2 / arg1;
        (v0 - arg0 / arg1) / v0
    }

    entry fun draw(arg0: &XcsRaffle, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0;
        while (v1 < 5) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, XcsMintLimit>(&arg0.xcs_mint_limit, v1);
            if (v3.left >= 1) {
                0x1::vector::push_back<0x1::string::String>(&mut v0, *v2);
            };
            v1 = v1 + 1;
        };
        if (0x1::vector::length<0x1::string::String>(&v0) == 0) {
            return 0x1::string::utf8(b"NOXCS")
        };
        let v4 = ((100 / 0x1::vector::length<0x1::string::String>(&v0)) as u8);
        let v5 = 0x2::random::new_generator(arg1, arg2);
        v1 = 0;
        let v6 = 0;
        let v7 = 0x1::string::utf8(b"");
        while (v1 < 0x1::vector::length<0x1::string::String>(&v0)) {
            let v8 = v6 + v4;
            v6 = v8;
            if (v4 == 33 && 0x2::random::generate_u8_in_range(&mut v5, 1, 3) == ((v1 + 1) as u8)) {
                v6 = v8 + 1;
            };
            if (arithmetic_is_less_than(0x2::random::generate_u8_in_range(&mut v5, 1, 100), v6, 100) == 1) {
                v7 = 0x1::vector::remove<0x1::string::String>(&mut v0, v1);
                break
            };
            v1 = v1 + 1;
        };
        v7
    }

    entry fun draw_and_mint(arg0: &0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::ControlledCaps, arg1: &mut 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::ControlledTreasury<0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::xcsas::XCSAS>, arg2: &mut 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::ControlledTreasury<0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::xcsfe::XCSFE>, arg3: &mut 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::ControlledTreasury<0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::xcsgm::XCSGM>, arg4: &mut 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::ControlledTreasury<0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::xcsmh::XCSMH>, arg5: &mut 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::treasury::ControlledTreasury<0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::xcssu::XCSSU>, arg6: &mut XcsRaffle, arg7: &0x2::random::Random, arg8: address, arg9: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        assert!(0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::has_cap<0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::DrawCap>(arg0, 0x2::tx_context::sender(arg9)), 0);
        let v0 = draw(arg6, arg7, arg9);
        if (v0 == 0x1::string::utf8(b"XCSAS")) {
            let v1 = &mut 0x2::vec_map::get_mut<0x1::string::String, XcsMintLimit>(&mut arg6.xcs_mint_limit, &v0).left;
            assert!(1 <= *v1, 1);
            *v1 = *v1 - 1;
            let v2 = DrawEvent{
                xcs_drawn : v0,
                to        : arg8,
            };
            0x2::event::emit<DrawEvent>(v2);
            0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::xcsas::mint<0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::xcsas::XCSAS>(arg1, 1, arg8, arg9);
        } else if (v0 == 0x1::string::utf8(b"XCSFE")) {
            let v3 = &mut 0x2::vec_map::get_mut<0x1::string::String, XcsMintLimit>(&mut arg6.xcs_mint_limit, &v0).left;
            assert!(1 <= *v3, 1);
            *v3 = *v3 - 1;
            let v4 = DrawEvent{
                xcs_drawn : v0,
                to        : arg8,
            };
            0x2::event::emit<DrawEvent>(v4);
            0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::xcsfe::mint<0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::xcsfe::XCSFE>(arg2, 1, arg8, arg9);
        } else if (v0 == 0x1::string::utf8(b"XCSGM")) {
            let v5 = &mut 0x2::vec_map::get_mut<0x1::string::String, XcsMintLimit>(&mut arg6.xcs_mint_limit, &v0).left;
            assert!(1 <= *v5, 1);
            *v5 = *v5 - 1;
            let v6 = DrawEvent{
                xcs_drawn : v0,
                to        : arg8,
            };
            0x2::event::emit<DrawEvent>(v6);
            0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::xcsgm::mint<0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::xcsgm::XCSGM>(arg3, 1, arg8, arg9);
        } else if (v0 == 0x1::string::utf8(b"XCSMH")) {
            let v7 = &mut 0x2::vec_map::get_mut<0x1::string::String, XcsMintLimit>(&mut arg6.xcs_mint_limit, &v0).left;
            assert!(1 <= *v7, 1);
            *v7 = *v7 - 1;
            let v8 = DrawEvent{
                xcs_drawn : v0,
                to        : arg8,
            };
            0x2::event::emit<DrawEvent>(v8);
            0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::xcsmh::mint<0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::xcsmh::XCSMH>(arg4, 1, arg8, arg9);
        } else if (v0 == 0x1::string::utf8(b"XCSSU")) {
            let v9 = &mut 0x2::vec_map::get_mut<0x1::string::String, XcsMintLimit>(&mut arg6.xcs_mint_limit, &v0).left;
            assert!(1 <= *v9, 1);
            *v9 = *v9 - 1;
            let v10 = DrawEvent{
                xcs_drawn : v0,
                to        : arg8,
            };
            0x2::event::emit<DrawEvent>(v10);
            0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::xcssu::mint<0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::xcssu::XCSSU>(arg5, 1, arg8, arg9);
        } else {
            let v11 = DrawEvent{
                xcs_drawn : v0,
                to        : arg8,
            };
            0x2::event::emit<DrawEvent>(v11);
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::new(0x2::tx_context::sender(arg0), arg0);
        0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::add_capability<0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::DrawCap>(&mut v0, 0x2::tx_context::sender(arg0), 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::new_draw_cap(), arg0);
        0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::share(v0);
    }

    public fun new_xcs_raffle(arg0: &mut 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::ControlledCaps, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::has_cap<0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::AdminCap>(arg0, 0x2::tx_context::sender(arg1)), 0);
        let v0 = XcsRaffle{
            id             : 0x2::object::new(arg1),
            xcs_mint_limit : 0x2::vec_map::empty<0x1::string::String, XcsMintLimit>(),
        };
        0x2::transfer::share_object<XcsRaffle>(v0);
    }

    public fun remove_admin(arg0: &mut 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::ControlledCaps, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::remove_capability<0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::AdminCap>(arg0, arg1, arg2);
    }

    public fun remove_drawer(arg0: &mut 0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::ControlledCaps, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::remove_capability<0x948b0ee11f52e78b42a08380bed1162e9185095e147d0f93ab7e0ffe9666a408::capability::DrawCap>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

