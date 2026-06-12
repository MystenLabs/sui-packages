module 0x476a84cbf4621623ef19623467b5aabd9e51f79e4826bb15609a27ab142c881c::lofi4 {
    struct LOFI4 has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        admin_address: address,
        buy_tax_rate: u64,
        sell_tax_rate: u64,
    }

    struct TaxStorage has key {
        id: 0x2::object::UID,
        dex_pools: 0x2::table::Table<address, bool>,
    }

    struct CoinSocialLinks has key {
        id: 0x2::object::UID,
        website: 0x1::string::String,
        twitter: 0x1::string::String,
        telegram: 0x1::string::String,
    }

    public entry fun change_admin_wallet(arg0: &mut AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.admin_address = arg1;
    }

    fun init(arg0: LOFI4, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = b"https://i.postimg.cc/mgPSv160/LOFI.png";
        let v2 = if (0x1::vector::is_empty<u8>(&v1)) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LOFI4>(arg0, 9, b"LOFI4", b"LOFI4", b"Embrace Your Inner Yeti", v2, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOFI4>>(v4);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LOFI4>>(v3);
        let v5 = CoinSocialLinks{
            id       : 0x2::object::new(arg1),
            website  : 0x1::string::utf8(b"https://lofitheyeti.com/"),
            twitter  : 0x1::string::utf8(b""),
            telegram : 0x1::string::utf8(b""),
        };
        0x2::transfer::share_object<CoinSocialLinks>(v5);
        let v6 = AdminCap{
            id            : 0x2::object::new(arg1),
            admin_address : v0,
            buy_tax_rate  : 0,
            sell_tax_rate : 300,
        };
        0x2::transfer::public_transfer<AdminCap>(v6, v0);
        let v7 = TaxStorage{
            id        : 0x2::object::new(arg1),
            dex_pools : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<TaxStorage>(v7);
    }

    public entry fun register_dex_pool(arg0: &AdminCap, arg1: &mut TaxStorage, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, bool>(&arg1.dex_pools, arg2)) {
            0x2::table::add<address, bool>(&mut arg1.dex_pools, arg2, true);
        };
    }

    public entry fun transfer_with_tax(arg0: &TaxStorage, arg1: &AdminCap, arg2: &mut 0x2::coin::Coin<LOFI4>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x2::table::contains<address, bool>(&arg0.dex_pools, 0x2::tx_context::sender(arg5));
        let v2 = 0x2::table::contains<address, bool>(&arg0.dex_pools, arg4);
        if (v1 && !v2) {
            v0 = arg1.buy_tax_rate;
        } else if (!v1 && v2) {
            v0 = arg1.sell_tax_rate;
        };
        let v3 = 0x2::balance::split<LOFI4>(0x2::coin::balance_mut<LOFI4>(arg2), arg3);
        if (v0 > 0) {
            let v4 = arg3 * v0 / 10000;
            0x2::transfer::public_transfer<0x2::coin::Coin<LOFI4>>(0x2::coin::from_balance<LOFI4>(0x2::balance::split<LOFI4>(&mut v3, v4), arg5), arg1.admin_address);
            0x2::transfer::public_transfer<0x2::coin::Coin<LOFI4>>(0x2::coin::from_balance<LOFI4>(0x2::balance::split<LOFI4>(&mut v3, arg3 - v4), arg5), arg4);
            0x2::balance::destroy_zero<LOFI4>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<LOFI4>>(0x2::coin::from_balance<LOFI4>(v3, arg5), arg4);
        };
    }

    public entry fun update_tax_rates(arg0: &mut AdminCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 2000 && arg2 <= 2000, 0);
        arg0.buy_tax_rate = arg1;
        arg0.sell_tax_rate = arg2;
    }

    // decompiled from Move bytecode v7
}

