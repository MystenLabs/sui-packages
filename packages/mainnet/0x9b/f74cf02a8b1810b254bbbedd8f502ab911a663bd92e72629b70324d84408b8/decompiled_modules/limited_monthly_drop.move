module 0x9bf74cf02a8b1810b254bbbedd8f502ab911a663bd92e72629b70324d84408b8::limited_monthly_drop {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DropWindow has key {
        id: 0x2::object::UID,
        drop_number: u64,
        title: 0x1::string::String,
        image_url: 0x2::url::Url,
        price_mist: u64,
        max_supply: u64,
        minted_in_drop: u64,
        is_open: bool,
        claimed: 0x2::table::Table<address, bool>,
    }

    struct DropNFT has store, key {
        id: 0x2::object::UID,
        drop_number: u64,
        serial_in_drop: u64,
        title: 0x1::string::String,
        image_url: 0x2::url::Url,
        minted_at: u64,
    }

    public entry fun create_drop(arg0: &AdminCap, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = DropWindow{
            id             : 0x2::object::new(arg6),
            drop_number    : arg1,
            title          : 0x1::string::utf8(arg2),
            image_url      : 0x2::url::new_unsafe_from_bytes(arg3),
            price_mist     : arg4,
            max_supply     : arg5,
            minted_in_drop : 0,
            is_open        : true,
            claimed        : 0x2::table::new<address, bool>(arg6),
        };
        0x2::transfer::share_object<DropWindow>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: &mut DropWindow, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.is_open, 1);
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed, v0), 3);
        assert!(arg0.minted_in_drop < arg0.max_supply, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.price_mist, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg0.price_mist, arg2), @0xb735145d8976ab7b26e868a88c2d789dbda9b5ace13e956889a7d03c1927fcf0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        0x2::table::add<address, bool>(&mut arg0.claimed, v0, true);
        arg0.minted_in_drop = arg0.minted_in_drop + 1;
        let v1 = DropNFT{
            id             : 0x2::object::new(arg2),
            drop_number    : arg0.drop_number,
            serial_in_drop : arg0.minted_in_drop,
            title          : arg0.title,
            image_url      : arg0.image_url,
            minted_at      : 0x2::tx_context::epoch(arg2),
        };
        0x2::transfer::public_transfer<DropNFT>(v1, v0);
    }

    public entry fun set_open(arg0: &AdminCap, arg1: &mut DropWindow, arg2: bool) {
        arg1.is_open = arg2;
    }

    public fun treasury() : address {
        @0xb735145d8976ab7b26e868a88c2d789dbda9b5ace13e956889a7d03c1927fcf0
    }

    // decompiled from Move bytecode v7
}

