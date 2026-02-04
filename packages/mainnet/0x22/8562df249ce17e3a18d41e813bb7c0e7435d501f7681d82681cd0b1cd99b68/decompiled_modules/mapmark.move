module 0x228562df249ce17e3a18d41e813bb7c0e7435d501f7681d82681cd0b1cd99b68::mapmark {
    struct Mapmark has key {
        id: 0x2::object::UID,
        marks: vector<u64>,
        total: u64,
        price: u64,
        treasury_address: address,
        whitelist: 0x2::table::Table<address, bool>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CityMarkedEvent has copy, drop {
        plate: u8,
        total: u64,
        new_count: u64,
        payer: address,
    }

    struct MapmarkNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        plate: u8,
    }

    struct MAPMARK has drop {
        dummy_field: bool,
    }

    entry fun add_batch_to_whitelist(arg0: &mut Mapmark, arg1: &AdminCap, arg2: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (!0x2::table::contains<address, bool>(&arg0.whitelist, v1)) {
                0x2::table::add<address, bool>(&mut arg0.whitelist, v1, false);
            };
            v0 = v0 + 1;
        };
    }

    entry fun add_to_whitelist(arg0: &mut Mapmark, arg1: &AdminCap, arg2: address) {
        if (!0x2::table::contains<address, bool>(&arg0.whitelist, arg2)) {
            0x2::table::add<address, bool>(&mut arg0.whitelist, arg2, false);
        };
    }

    public fun can_use_free_mark(arg0: &Mapmark, arg1: address) : bool {
        if (!0x2::table::contains<address, bool>(&arg0.whitelist, arg1)) {
            return false
        };
        !*0x2::table::borrow<address, bool>(&arg0.whitelist, arg1)
    }

    public fun get_image_url(arg0: u8) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"https://www.mapmark.fun/nft/");
        if (arg0 < 10) {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"0"));
        };
        0x1::string::append(&mut v0, 0x1::u8::to_string(arg0));
        0x1::string::append(&mut v0, 0x1::string::utf8(b".png"));
        v0
    }

    fun increase_mark(arg0: &mut Mapmark, arg1: u8) : u64 {
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.marks, (arg1 as u64));
        *v0 = *v0 + 1;
        *v0
    }

    fun init(arg0: MAPMARK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Mapmark #{plate}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::package::claim<MAPMARK>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<MapmarkNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<MapmarkNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MapmarkNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = vector[];
        let v7 = 0;
        while (v7 < 82) {
            0x1::vector::push_back<u64>(&mut v6, 0);
            v7 = v7 + 1;
        };
        let v8 = Mapmark{
            id               : 0x2::object::new(arg1),
            marks            : v6,
            total            : 0,
            price            : 100000000,
            treasury_address : @0xbd72745af9db6eacb7a1fb15cb8380270ff755cba570ba3973dcec42fc737d56,
            whitelist        : 0x2::table::new<address, bool>(arg1),
        };
        let v9 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<Mapmark>(v8);
        0x2::transfer::transfer<AdminCap>(v9, 0x2::tx_context::sender(arg1));
    }

    public fun is_whitelisted(arg0: &Mapmark, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.whitelist, arg1)
    }

    entry fun mark_and_transfer(arg0: &mut Mapmark, arg1: u8, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 0 && arg1 <= 81, 0);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v1 = arg0.price;
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0) >= v1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0, v1), arg3), arg0.treasury_address);
        let v2 = increase_mark(arg0, arg1);
        arg0.total = arg0.total + 1;
        let v3 = MapmarkNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(b"Mapmark NFT"),
            description : 0x1::string::utf8(b"A unique NFT for marking a city on Mapmark."),
            image_url   : get_image_url(arg1),
            plate       : arg1,
        };
        0x2::transfer::public_transfer<MapmarkNFT>(v3, 0x2::tx_context::sender(arg3));
        let v4 = CityMarkedEvent{
            plate     : arg1,
            total     : arg0.total,
            new_count : v2,
            payer     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<CityMarkedEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg3), 0x2::tx_context::sender(arg3));
    }

    public fun mark_count(arg0: &Mapmark, arg1: u8) : u64 {
        assert!(arg1 >= 0 && arg1 <= 81, 0);
        *0x1::vector::borrow<u64>(&arg0.marks, (arg1 as u64))
    }

    entry fun mark_free_for_trwal_holders(arg0: &mut Mapmark, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 0 && arg1 <= 81, 0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, bool>(&arg0.whitelist, v0), 4);
        assert!(!*0x2::table::borrow<address, bool>(&arg0.whitelist, v0), 5);
        *0x2::table::borrow_mut<address, bool>(&mut arg0.whitelist, v0) = true;
        let v1 = increase_mark(arg0, arg1);
        arg0.total = arg0.total + 1;
        let v2 = MapmarkNFT{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(b"Mapmark NFT"),
            description : 0x1::string::utf8(b"A unique NFT for marking a city on Mapmark."),
            image_url   : get_image_url(arg1),
            plate       : arg1,
        };
        0x2::transfer::public_transfer<MapmarkNFT>(v2, 0x2::tx_context::sender(arg2));
        let v3 = CityMarkedEvent{
            plate     : arg1,
            total     : arg0.total,
            new_count : v1,
            payer     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<CityMarkedEvent>(v3);
    }

    public fun price(arg0: &Mapmark) : u64 {
        arg0.price
    }

    entry fun remove_from_whitelist(arg0: &mut Mapmark, arg1: &AdminCap, arg2: address) {
        if (0x2::table::contains<address, bool>(&arg0.whitelist, arg2)) {
            0x2::table::remove<address, bool>(&mut arg0.whitelist, arg2);
        };
    }

    entry fun set_price(arg0: &mut Mapmark, arg1: &AdminCap, arg2: u64) {
        arg0.price = arg2;
    }

    public fun total(arg0: &Mapmark) : u64 {
        arg0.total
    }

    // decompiled from Move bytecode v6
}

