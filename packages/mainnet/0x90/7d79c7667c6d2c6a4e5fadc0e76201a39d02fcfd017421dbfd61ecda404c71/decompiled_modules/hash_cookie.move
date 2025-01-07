module 0x907d79c7667c6d2c6a4e5fadc0e76201a39d02fcfd017421dbfd61ecda404c71::hash_cookie {
    struct GlobalCookie has store, key {
        id: 0x2::object::UID,
        next_serial_number: u32,
        prize_bag: 0x2::bag::Bag,
        prize_amount: u64,
        cookie_owner: 0x2::vec_map::VecMap<u32, address>,
        prize_log: 0x2::vec_map::VecMap<u32, u64>,
        operator: address,
    }

    struct HashCookie has store, key {
        id: 0x2::object::UID,
        serial_number: u32,
        serial_number_base64: 0x1::string::String,
    }

    struct HashCookieMinted has copy, drop {
        creator: address,
        cookie_id: 0x2::object::ID,
        serial_number: u32,
        timestamp: u64,
    }

    struct PrizeDrawn has copy, drop {
        winner_id: u32,
        ticket_id: u32,
        prize_amount: u64,
    }

    struct PrizeAdded has copy, drop {
        amount: u64,
        coin_type: 0x1::ascii::String,
    }

    struct PrizeClaimed has copy, drop {
        winner: address,
        serial_number: u32,
        prize_amount: u64,
    }

    struct HASH_COOKIE has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: &mut GlobalCookie, arg1: HashCookie, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.serial_number;
        *0x2::vec_map::get_mut<u32, address>(&mut arg0.cookie_owner, &v0) = arg2;
        0x2::transfer::public_transfer<HashCookie>(arg1, arg2);
    }

    public fun add_prize<T0>(arg0: &mut GlobalCookie, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.prize_bag, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.prize_bag, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.prize_bag, v0), arg1);
        let v1 = PrizeAdded{
            amount    : 0x2::balance::value<T0>(&arg1),
            coin_type : 0x1::type_name::into_string(v0),
        };
        0x2::event::emit<PrizeAdded>(v1);
    }

    fun base64_encode_6digits(arg0: u32) : 0x1::string::String {
        let v0 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        let v1 = 0x1::vector::empty<u8>();
        let v2 = arg0 / 100000 + 48 << 16 | arg0 / 10000 % 10 + 48 << 8 | arg0 / 1000 % 10 + 48;
        let v3 = arg0 / 100 % 10 + 48 << 16 | arg0 / 10 % 10 + 48 << 8 | arg0 % 10 + 48;
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v2 >> 18 & 63) as u64)));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v2 >> 12 & 63) as u64)));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v2 >> 6 & 63) as u64)));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v2 & 63) as u64)));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v3 >> 18 & 63) as u64)));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v3 >> 12 & 63) as u64)));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v3 >> 6 & 63) as u64)));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v3 & 63) as u64)));
        0x1::string::utf8(v1)
    }

    public entry fun burn(arg0: &mut GlobalCookie, arg1: HashCookie, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.serial_number;
        *0x2::vec_map::get_mut<u32, address>(&mut arg0.cookie_owner, &v0) = @0x0;
        let HashCookie {
            id                   : v1,
            serial_number        : _,
            serial_number_base64 : _,
        } = arg1;
        0x2::object::delete(v1);
    }

    public entry fun claim_prize<T0>(arg0: &mut GlobalCookie, arg1: &HashCookie, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = arg1.serial_number;
        assert!(0x2::vec_map::get<u32, address>(&arg0.cookie_owner, &v1) == &v0, 3);
        assert!(0x2::vec_map::contains<u32, u64>(&arg0.prize_log, &v1), 4);
        let v2 = *0x2::vec_map::get<u32, u64>(&arg0.prize_log, &v1);
        let v3 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.prize_bag, 0x1::type_name::get<T0>());
        assert!(0x2::balance::value<T0>(v3) >= v2, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v3, v2), arg2), v0);
        let (_, _) = 0x2::vec_map::remove<u32, u64>(&mut arg0.prize_log, &v1);
        *0x2::vec_map::get_mut<u32, address>(&mut arg0.cookie_owner, &v1) = @0x0;
        let v6 = PrizeClaimed{
            winner        : v0,
            serial_number : v1,
            prize_amount  : v2,
        };
        0x2::event::emit<PrizeClaimed>(v6);
    }

    fun create_display(arg0: &0x2::package::Publisher, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<HashCookie> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"serial_number"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(arg1));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(arg2));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(arg3));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"#{serial_number}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(arg4));
        let v4 = 0x2::display::new_with_fields<HashCookie>(arg0, v0, v2, arg5);
        0x2::display::update_version<HashCookie>(&mut v4);
        v4
    }

    public entry fun create_global_cookie(arg0: &0x907d79c7667c6d2c6a4e5fadc0e76201a39d02fcfd017421dbfd61ecda404c71::vault_user::VaultUser, arg1: &mut 0x2::tx_context::TxContext) {
        0x907d79c7667c6d2c6a4e5fadc0e76201a39d02fcfd017421dbfd61ecda404c71::vault_user::assert_vault_admin(arg0, arg1);
        let v0 = GlobalCookie{
            id                 : 0x2::object::new(arg1),
            next_serial_number : 1,
            prize_bag          : 0x2::bag::new(arg1),
            prize_amount       : 0,
            cookie_owner       : 0x2::vec_map::empty<u32, address>(),
            prize_log          : 0x2::vec_map::empty<u32, u64>(),
            operator           : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_transfer<GlobalCookie>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun draw_prize<T0>(arg0: &mut GlobalCookie, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.operator, 6);
        let v0 = arg0.prize_amount;
        assert!(0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.prize_bag, 0x1::type_name::get<T0>())) >= v0, 1);
        let v1 = 0x2::random::new_generator(arg1, arg2);
        let v2 = 0;
        let v3 = 0;
        while (v2 < 100) {
            v3 = 0x2::random::generate_u32_in_range(&mut v1, 0, arg0.next_serial_number - 1);
            if (!0x2::vec_map::contains<u32, u64>(&arg0.prize_log, &v3)) {
                break
            };
            v2 = v2 + 1;
        };
        assert!(v2 < 100, 2);
        0x2::vec_map::insert<u32, u64>(&mut arg0.prize_log, v3, v0);
        let v4 = PrizeDrawn{
            winner_id    : v3,
            ticket_id    : (v3 as u32),
            prize_amount : v0,
        };
        0x2::event::emit<PrizeDrawn>(v4);
    }

    fun generate_display_args() : (vector<u8>, vector<u8>, vector<u8>, vector<u8>) {
        (b"HashCookie", b"HashCookie NFT created by HashCook, become a cookie owner and win prizes!", b"data:image/svg+xml;base64,PHN2ZyB4bWxucz0naHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmcnIHdpZHRoPSczMDAnIGhlaWdodD0nMzAwJyB2aWV3Qm94PScwIDAgMzAwIDMwMCc+CjxkZWZzPgo8bGluZWFyR3JhZGllbnQgaWQ9J2dyYWQnIHgxPScwJScgeTE9JzAlJyB4Mj0nMTAwJScgeTI9JzMwJSc+CjxzdG9wIG9mZnNldD0nMCUnIHN0eWxlPSdzdG9wLWNvbG9yOnJlZDtzdG9wLW9wYWNpdHk6MScgLz4KPHN0b3Agb2Zmc2V0PScyMCUnIHN0eWxlPSdzdG9wLWNvbG9yOiNiZmZmMDA7c3RvcC1vcGFjaXR5OjEnIC8+CjxzdG9wIG9mZnNldD0nNDAlJyBzdHlsZT0nc3RvcC1jb2xvcjojMDBmZmIxO3N0b3Atb3BhY2l0eTowLjknIC8+CjxzdG9wIG9mZnNldD0nNjAlJyBzdHlsZT0nc3RvcC1jb2xvcjojM2I5Y2ZmO3N0b3Atb3BhY2l0eTowLjknIC8+CjxzdG9wIG9mZnNldD0nODAlJyBzdHlsZT0nc3RvcC1jb2xvcjojZGE0MGZmO3N0b3Atb3BhY2l0eTowLjgnIC8+CjxzdG9wIG9mZnNldD0nMTAwJScgc3R5bGU9J3N0b3AtY29sb3I6I2ZmMzMzMztzdG9wLW9wYWNpdHk6MC43JyAvPgo8YW5pbWF0ZSBhdHRyaWJ1dGVOYW1lPSd4MScgdmFsdWVzPSctMjAlOzAlOzIwJScgZHVyPScxMHMnIHJlcGVhdENvdW50PSdpbmRlZmluaXRlJyAvPgo8YW5pbWF0ZSBhdHRyaWJ1dGVOYW1lPSd4MicgdmFsdWVzPSc4MCU7MTAwJTsxMjAlJyBkdXI9JzEwcycgcmVwZWF0Q291bnQ9J2luZGVmaW5pdGUnIC8+CjwvbGluZWFyR3JhZGllbnQ+CjwvZGVmcz4KPHJlY3Qgd2lkdGg9JzEwMCUnIGhlaWdodD0nMTAwJScgZmlsbD0ncmdiYSgzMCwzMCwzMCwxKScgLz4gIAo8Zz4KPGNpcmNsZSBjeD0nNTAlJyBjeT0nNTAlJyByPSc0MCUnIGZpbGw9J3VybCgjZ3JhZCknIC8+Cjx0ZXh0IHg9JzUwJScgeT0nNDUlJyBmb250LWZhbWlseT0nQXJpYWwsIHNhbnMtc2VyaWYnIGZvbnQtc2l6ZT0nMjgnIGZvbnQtd2VpZ2h0PSdib2xkJyBmaWxsPSd1cmwoI2dyYWQpJyB0ZXh0LWFuY2hvcj0nbWlkZGxlJyBkb21pbmFudC1iYXNlbGluZT0nbWlkZGxlJz5A{serial_number_base64}PC90ZXh0Pgo8dGV4dCB4PSc1MCUnIHk9JzYwJScgZm9udC1mYW1pbHk9J0FyaWFsLCBzYW5zLXNlcmlmJyBmb250LXNpemU9JzE2JyBmb250LXdlaWdodD0nYm9sZCcgZmlsbD0ncmdiYSgyNTUsMjU1LDI1NSwwLjcpJyB0ZXh0LWFuY2hvcj0nbWlkZGxlJyBkb21pbmFudC1iYXNlbGluZT0nbWlkZGxlJz5IYXNoQ29va2llPC90ZXh0Pgo8dGV4dCB4PSc1MCUnIHk9JzY1JScgZm9udC1mYW1pbHk9J0FyaWFsLCBzYW5zLXNlcmlmJyBmb250LXNpemU9JzEwJyBmb250LXdlaWdodD0nYm9sZCcgZmlsbD0ncmdiYSgyNTUsMjU1LDI1NSwwLjcpJyB0ZXh0LWFuY2hvcj0nbWlkZGxlJyBkb21pbmFudC1iYXNlbGluZT0nbWlkZGxlJz7CqWhhc2hjb29rLmNvbTwvdGV4dD4KPC9nPgo8L3N2Zz4=", b"https://hashcook.com")
    }

    public fun get_cookie_prize_amount(arg0: &GlobalCookie, arg1: u32) : u64 {
        if (0x2::vec_map::contains<u32, u64>(&arg0.prize_log, &arg1)) {
            *0x2::vec_map::get<u32, u64>(&arg0.prize_log, &arg1)
        } else {
            0
        }
    }

    public fun get_prize_amount(arg0: &GlobalCookie) : u64 {
        arg0.prize_amount
    }

    public fun get_serial_number(arg0: &HashCookie) : u32 {
        arg0.serial_number
    }

    public fun get_total_prize<T0>(arg0: &GlobalCookie) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.prize_bag, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.prize_bag, v0))
        } else {
            0
        }
    }

    fun init(arg0: HASH_COOKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<HASH_COOKIE>(arg0, arg1);
        let (v1, v2, v3, v4) = generate_display_args();
        let v5 = create_display(&v0, v1, v2, v3, v4, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<HashCookie>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut GlobalCookie, arg1: &mut 0x907d79c7667c6d2c6a4e5fadc0e76201a39d02fcfd017421dbfd61ecda404c71::vault_user::VaultUser, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.next_serial_number > 999999) {
            return
        };
        assert!(0x907d79c7667c6d2c6a4e5fadc0e76201a39d02fcfd017421dbfd61ecda404c71::vault_user::consume_ticket(arg1, 0, arg2), 1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = arg0.next_serial_number;
        let v2 = HashCookie{
            id                   : 0x2::object::new(arg2),
            serial_number        : v1,
            serial_number_base64 : base64_encode_6digits(v1),
        };
        arg0.next_serial_number = v1 + 1;
        0x2::vec_map::insert<u32, address>(&mut arg0.cookie_owner, v1, v0);
        let v3 = HashCookieMinted{
            creator       : v0,
            cookie_id     : 0x2::object::id<HashCookie>(&v2),
            serial_number : v1,
            timestamp     : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<HashCookieMinted>(v3);
        0x2::transfer::transfer<HashCookie>(v2, v0);
    }

    public entry fun set_operator(arg0: &mut GlobalCookie, arg1: &0x907d79c7667c6d2c6a4e5fadc0e76201a39d02fcfd017421dbfd61ecda404c71::vault_user::VaultUser, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x907d79c7667c6d2c6a4e5fadc0e76201a39d02fcfd017421dbfd61ecda404c71::vault_user::assert_vault_admin(arg1, arg3);
        arg0.operator = arg2;
    }

    public entry fun set_prize_amount(arg0: &mut GlobalCookie, arg1: &0x907d79c7667c6d2c6a4e5fadc0e76201a39d02fcfd017421dbfd61ecda404c71::vault_user::VaultUser, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x907d79c7667c6d2c6a4e5fadc0e76201a39d02fcfd017421dbfd61ecda404c71::vault_user::assert_vault_admin(arg1, arg3);
        arg0.prize_amount = arg2;
    }

    public entry fun update_display(arg0: &mut 0x2::display::Display<HashCookie>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        if (!0x1::vector::is_empty<u8>(&arg1)) {
            0x2::display::edit<HashCookie>(arg0, 0x1::string::utf8(b"name"), 0x1::string::utf8(arg1));
        };
        if (!0x1::vector::is_empty<u8>(&arg2)) {
            0x2::display::edit<HashCookie>(arg0, 0x1::string::utf8(b"description"), 0x1::string::utf8(arg2));
        };
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            0x2::display::edit<HashCookie>(arg0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(arg3));
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x2::display::edit<HashCookie>(arg0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(arg4));
        };
        0x2::display::update_version<HashCookie>(arg0);
    }

    // decompiled from Move bytecode v6
}

