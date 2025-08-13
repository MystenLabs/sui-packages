module 0x7b3c21b45ea400b10253bf3678862aa94a927c37f069d312fdf7a4b804179b5e::colors {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ColorsControl has store, key {
        id: 0x2::object::UID,
        paused: bool,
        price: u64,
        treasury: address,
        name_max_length: u64,
        used_colors: 0x2::table::Table<0x1::string::String, bool>,
        used_names: 0x2::table::Table<0x1::string::String, bool>,
    }

    struct Color has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        color: 0x1::string::String,
    }

    struct FreeColor has store, key {
        id: 0x2::object::UID,
    }

    struct COLORS has drop {
        dummy_field: bool,
    }

    struct ColorMinted has copy, drop {
        id: 0x2::object::ID,
        minted_by: address,
        color: 0x1::string::String,
    }

    struct NameChanged has copy, drop {
        id: 0x2::object::ID,
        new_name: 0x1::string::String,
    }

    fun calculate_mint_amount(arg0: u64, arg1: u64) : u64 {
        let v0 = arg1;
        if (arg0 >= 5 && arg0 < 10) {
            v0 = arg1 * 90 / 100;
        } else if (arg0 >= 10 && arg0 < 20) {
            v0 = arg1 * 85 / 100;
        } else if (arg0 >= 20 && arg0 < 30) {
            v0 = arg1 * 80 / 100;
        } else if (arg0 >= 30 && arg0 < 40) {
            v0 = arg1 * 70 / 100;
        } else if (arg0 >= 40) {
            v0 = arg1 * 50 / 100;
        };
        v0
    }

    public fun change_name(arg0: &mut ColorsControl, arg1: &mut Color, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) >= 3 && 0x1::vector::length<u8>(&arg2) <= arg0.name_max_length, 5);
        let v0 = 0x1::string::utf8(arg2);
        assert!(0x2::table::contains<0x1::string::String, bool>(&arg0.used_names, v0) == false, 6);
        if (0x2::table::contains<0x1::string::String, bool>(&arg0.used_names, arg1.name)) {
            0x2::table::remove<0x1::string::String, bool>(&mut arg0.used_names, arg1.name);
        };
        arg1.name = v0;
        0x2::table::add<0x1::string::String, bool>(&mut arg0.used_names, v0, true);
        let v1 = NameChanged{
            id       : 0x2::object::uid_to_inner(&arg1.id),
            new_name : 0x1::string::utf8(arg2),
        };
        0x2::event::emit<NameChanged>(v1);
    }

    public fun change_name_max_length(arg0: &mut ColorsControl, arg1: &AdminCap, arg2: u64) {
        arg0.name_max_length = arg2;
    }

    public fun change_price(arg0: &mut ColorsControl, arg1: &AdminCap, arg2: u64) {
        arg0.price = arg2;
    }

    public fun change_treasury(arg0: &mut ColorsControl, arg1: &AdminCap, arg2: address) {
        arg0.treasury = arg2;
    }

    public fun get_color(arg0: &Color) : 0x1::string::String {
        arg0.color
    }

    public fun get_treasury(arg0: &ColorsControl) : address {
        arg0.treasury
    }

    public fun giveaway(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FreeColor{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<FreeColor>(v0, arg1);
    }

    fun init(arg0: COLORS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suicolors.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SuiColors"));
        let v4 = 0x2::package::claim<COLORS>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Color>(&v4, v0, v2, arg1);
        0x2::display::update_version<Color>(&mut v5);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Free Sui Color"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://suicolors.com/free_color.gif"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://suicolors.com"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"SuiColors"));
        let v8 = 0x2::display::new_with_fields<FreeColor>(&v4, v0, v6, arg1);
        0x2::display::update_version<FreeColor>(&mut v8);
        let v9 = 0x2::tx_context::sender(arg1);
        let v10 = ColorsControl{
            id              : 0x2::object::new(arg1),
            paused          : false,
            price           : 1000000000,
            treasury        : v9,
            name_max_length : 20,
            used_colors     : 0x2::table::new<0x1::string::String, bool>(arg1),
            used_names      : 0x2::table::new<0x1::string::String, bool>(arg1),
        };
        let v11 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v9);
        0x2::transfer::public_transfer<0x2::display::Display<Color>>(v5, v9);
        0x2::transfer::public_transfer<0x2::display::Display<FreeColor>>(v8, v9);
        0x2::transfer::public_transfer<AdminCap>(v11, v9);
        0x2::transfer::share_object<ColorsControl>(v10);
    }

    fun is_valid_hex_char(arg0: u8) : bool {
        if (arg0 >= 48 && arg0 <= 57) {
            true
        } else if (arg0 >= 65 && arg0 <= 70) {
            true
        } else {
            arg0 >= 97 && arg0 <= 102
        }
    }

    fun is_valid_hex_color(arg0: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg0) != 6) {
            return false
        };
        let v0 = 0;
        while (v0 < 6) {
            if (!is_valid_hex_char(*0x1::vector::borrow<u8>(arg0, v0))) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun mint(arg0: &mut ColorsControl, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused == false, 7);
        let v0 = 0x1::vector::length<vector<u8>>(&arg2);
        assert!(v0 > 0 && v0 <= 50, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == calculate_mint_amount(v0, arg0.price * v0), 4);
        let v1 = 0;
        let v2 = 0x2::tx_context::sender(arg3);
        while (v1 < v0) {
            let v3 = mint_internal(arg0, *0x1::vector::borrow<vector<u8>>(&arg2, v1), arg3);
            0x2::transfer::public_transfer<Color>(v3, v2);
            v1 = v1 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.treasury);
    }

    public fun mint_free(arg0: &mut ColorsControl, arg1: FreeColor, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : Color {
        let FreeColor { id: v0 } = arg1;
        0x2::object::delete(v0);
        mint_internal(arg0, arg2, arg3)
    }

    fun mint_internal(arg0: &mut ColorsControl, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : Color {
        assert!(is_valid_hex_color(&arg1), 1);
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, bool>(&arg0.used_colors, v0) == false, 2);
        let v1 = 0x1::string::utf8(b"Sui Color #");
        0x1::string::append(&mut v1, v0);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, b"<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"1000\" height=\"1000\"><rect width=\"1000\" height=\"1000\" style=\"fill:#");
        0x1::vector::append<u8>(&mut v2, arg1);
        0x1::vector::append<u8>(&mut v2, b";\"/></svg>");
        let v3 = 0x1::string::utf8(b"data:image/svg+xml;base64,");
        0x1::string::append_utf8(&mut v3, to_base64(v2));
        let v4 = Color{
            id        : 0x2::object::new(arg2),
            name      : v1,
            image_url : v3,
            color     : v0,
        };
        0x2::table::add<0x1::string::String, bool>(&mut arg0.used_colors, v0, true);
        let v5 = ColorMinted{
            id        : 0x2::object::uid_to_inner(&v4.id),
            minted_by : 0x2::tx_context::sender(arg2),
            color     : v4.color,
        };
        0x2::event::emit<ColorMinted>(v5);
        v4
    }

    public fun pause(arg0: &mut ColorsControl, arg1: &AdminCap) {
        arg0.paused = true;
    }

    fun to_base64(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::length<u8>(&arg0);
        let v2 = 0;
        while (v2 + 2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(&arg0, v2);
            let v4 = *0x1::vector::borrow<u8>(&arg0, v2 + 1);
            let v5 = *0x1::vector::borrow<u8>(&arg0, v2 + 2);
            let v6 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v6, ((v3 >> 2) as u64)));
            let v7 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v7, (((v3 & 3) << 4 | v4 >> 4) as u64)));
            let v8 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v8, (((v4 & 15) << 2 | v5 >> 6) as u64)));
            let v9 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v9, ((v5 & 63) as u64)));
            v2 = v2 + 3;
        };
        let v10 = v1 - v2;
        if (v10 == 1) {
            let v11 = *0x1::vector::borrow<u8>(&arg0, v2);
            let v12 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v12, ((v11 >> 2) as u64)));
            let v13 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v13, (((v11 & 3) << 4) as u64)));
            0x1::vector::push_back<u8>(&mut v0, 61);
            0x1::vector::push_back<u8>(&mut v0, 61);
        } else if (v10 == 2) {
            let v14 = *0x1::vector::borrow<u8>(&arg0, v2);
            let v15 = *0x1::vector::borrow<u8>(&arg0, v2 + 1);
            let v16 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v16, ((v14 >> 2) as u64)));
            let v17 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v17, (((v14 & 3) << 4 | v15 >> 4) as u64)));
            let v18 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v18, (((v15 & 15) << 2) as u64)));
            0x1::vector::push_back<u8>(&mut v0, 61);
        };
        v0
    }

    public fun unpause(arg0: &mut ColorsControl, arg1: &AdminCap) {
        arg0.paused = false;
    }

    // decompiled from Move bytecode v6
}

