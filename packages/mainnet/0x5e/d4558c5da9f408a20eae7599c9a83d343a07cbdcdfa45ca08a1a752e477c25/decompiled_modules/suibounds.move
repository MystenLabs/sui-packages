module 0x7b3c21b45ea400b10253bf3678862aa94a927c37f069d312fdf7a4b804179b5e::suibounds {
    struct SuiboundsControl has store, key {
        id: 0x2::object::UID,
        paused: bool,
        public_price: u64,
        whitelist_price: u64,
        treasury: address,
        mints: 0x2::table::Table<0x1::string::String, bool>,
    }

    struct Suibound has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        address: 0x1::string::String,
    }

    struct WhitelistPass has store, key {
        id: 0x2::object::UID,
    }

    struct FreeMintPass has store, key {
        id: 0x2::object::UID,
    }

    struct SuiboundMinted has copy, drop {
        id: 0x2::object::ID,
        address: 0x1::string::String,
        mint_type: 0x1::string::String,
    }

    public fun change_public_price(arg0: &mut SuiboundsControl, arg1: &0x7b3c21b45ea400b10253bf3678862aa94a927c37f069d312fdf7a4b804179b5e::colors::AdminCap, arg2: u64) {
        arg0.public_price = arg2;
    }

    public fun change_treasury(arg0: &mut SuiboundsControl, arg1: &0x7b3c21b45ea400b10253bf3678862aa94a927c37f069d312fdf7a4b804179b5e::colors::AdminCap, arg2: address) {
        arg0.treasury = arg2;
    }

    public fun change_whitelist_price(arg0: &mut SuiboundsControl, arg1: &0x7b3c21b45ea400b10253bf3678862aa94a927c37f069d312fdf7a4b804179b5e::colors::AdminCap, arg2: u64) {
        arg0.whitelist_price = arg2;
    }

    public fun manual_init(arg0: &0x7b3c21b45ea400b10253bf3678862aa94a927c37f069d312fdf7a4b804179b5e::colors::AdminCap, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
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
        let v4 = 0x2::display::new_with_fields<Suibound>(arg1, v0, v2, arg2);
        0x2::display::update_version<Suibound>(&mut v4);
        let v5 = 0x2::tx_context::sender(arg2);
        let v6 = SuiboundsControl{
            id              : 0x2::object::new(arg2),
            paused          : true,
            public_price    : 1000000000 * 3,
            whitelist_price : 1000000000 * 2,
            treasury        : v5,
            mints           : 0x2::table::new<0x1::string::String, bool>(arg2),
        };
        0x2::transfer::public_transfer<0x2::display::Display<Suibound>>(v4, v5);
        0x2::transfer::share_object<SuiboundsControl>(v6);
    }

    public fun mint_color_holder(arg0: &mut SuiboundsControl, arg1: &0x7b3c21b45ea400b10253bf3678862aa94a927c37f069d312fdf7a4b804179b5e::colors::Color, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg0.whitelist_price, 1);
        mint_internal(arg0, 0x1::string::utf8(b"color_holder"), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.treasury);
    }

    public fun mint_free(arg0: &mut SuiboundsControl, arg1: FreeMintPass, arg2: &mut 0x2::tx_context::TxContext) {
        mint_internal(arg0, 0x1::string::utf8(b"free"), arg2);
        let FreeMintPass { id: v0 } = arg1;
        0x2::object::delete(v0);
    }

    fun mint_internal(arg0: &mut SuiboundsControl, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused == false, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::address::to_string(v0);
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg0.mints, v1), 3);
        0x2::table::add<0x1::string::String, bool>(&mut arg0.mints, v1, true);
        let v2 = 0x1::string::utf8(b"Suibound ");
        0x1::string::append(&mut v2, shorten_address_string(v1));
        let v3 = 0x1::string::utf8(b"https://suicolors.com/api/image/suibound?address=");
        0x1::string::append(&mut v3, v1);
        let v4 = 0x2::object::new(arg2);
        let v5 = SuiboundMinted{
            id        : 0x2::object::uid_to_inner(&v4),
            address   : 0x2::address::to_string(v0),
            mint_type : arg1,
        };
        0x2::event::emit<SuiboundMinted>(v5);
        let v6 = Suibound{
            id        : v4,
            name      : v2,
            image_url : v3,
            address   : 0x2::address::to_string(v0),
        };
        0x2::transfer::transfer<Suibound>(v6, v0);
    }

    public fun mint_public(arg0: &mut SuiboundsControl, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.public_price, 1);
        mint_internal(arg0, 0x1::string::utf8(b"public"), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.treasury);
    }

    public fun mint_whitelist(arg0: &mut SuiboundsControl, arg1: WhitelistPass, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg0.whitelist_price, 1);
        mint_internal(arg0, 0x1::string::utf8(b"whitelist"), arg3);
        let WhitelistPass { id: v0 } = arg1;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.treasury);
    }

    public fun pause(arg0: &mut SuiboundsControl, arg1: &0x7b3c21b45ea400b10253bf3678862aa94a927c37f069d312fdf7a4b804179b5e::colors::AdminCap) {
        arg0.paused = true;
    }

    public fun send_free_mint_pass(arg0: &0x7b3c21b45ea400b10253bf3678862aa94a927c37f069d312fdf7a4b804179b5e::colors::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FreeMintPass{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<FreeMintPass>(v0, arg1);
    }

    public fun send_whitelist_pass(arg0: &0x7b3c21b45ea400b10253bf3678862aa94a927c37f069d312fdf7a4b804179b5e::colors::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = WhitelistPass{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<WhitelistPass>(v0, arg1);
    }

    fun shorten_address_string(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::as_bytes(&arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 < 12) {
            return arg0
        };
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < 8 && v3 < v1) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(v0, v3));
            v3 = v3 + 1;
        };
        0x1::vector::append<u8>(&mut v2, b"...");
        let v4 = v1 - 4;
        while (v4 < v1) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(v0, v4));
            v4 = v4 + 1;
        };
        0x1::string::utf8(v2)
    }

    public fun unpause(arg0: &mut SuiboundsControl, arg1: &0x7b3c21b45ea400b10253bf3678862aa94a927c37f069d312fdf7a4b804179b5e::colors::AdminCap) {
        arg0.paused = false;
    }

    // decompiled from Move bytecode v6
}

