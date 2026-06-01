module 0x2b9f8cd7949d96ebf45c850d581917753502563fb7a812644eb61a08f31bebdb::lofi {
    struct LOFI has drop {
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

    public entry fun change_admin_wallet(arg0: &mut AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.admin_address = arg1;
    }

    fun init(arg0: LOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = b"https://i.postimg.cc/mgPSv160/LOFI.png";
        let v2 = if (0x1::vector::is_empty<u8>(&v1)) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LOFI>(arg0, 9, b"LOFI", b"LOFI", b"LOFI Price (LOFI)", v2, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOFI>>(v4);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LOFI>>(v3);
        let v5 = AdminCap{
            id            : 0x2::object::new(arg1),
            admin_address : v0,
            buy_tax_rate  : 0,
            sell_tax_rate : 800,
        };
        0x2::transfer::public_transfer<AdminCap>(v5, v0);
        let v6 = TaxStorage{
            id        : 0x2::object::new(arg1),
            dex_pools : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<TaxStorage>(v6);
    }

    public entry fun register_dex_pool(arg0: &AdminCap, arg1: &mut TaxStorage, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, bool>(&arg1.dex_pools, arg2)) {
            0x2::table::add<address, bool>(&mut arg1.dex_pools, arg2, true);
        };
    }

    public entry fun transfer_with_tax(arg0: &TaxStorage, arg1: &AdminCap, arg2: 0x2::coin::Coin<LOFI>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::into_balance<LOFI>(arg2);
        let v2 = 0;
        let v3 = 0x2::table::contains<address, bool>(&arg0.dex_pools, v0);
        let v4 = 0x2::table::contains<address, bool>(&arg0.dex_pools, arg4);
        if (v3 && !v4) {
            v2 = arg1.buy_tax_rate;
        } else if (!v3 && v4) {
            v2 = arg1.sell_tax_rate;
        };
        if (v2 > 0) {
            let v5 = arg3 * v2 / 10000;
            0x2::transfer::public_transfer<0x2::coin::Coin<LOFI>>(0x2::coin::from_balance<LOFI>(0x2::balance::split<LOFI>(&mut v1, v5), arg5), arg1.admin_address);
            0x2::transfer::public_transfer<0x2::coin::Coin<LOFI>>(0x2::coin::from_balance<LOFI>(0x2::balance::split<LOFI>(&mut v1, arg3 - v5), arg5), arg4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<LOFI>>(0x2::coin::from_balance<LOFI>(0x2::balance::split<LOFI>(&mut v1, arg3), arg5), arg4);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<LOFI>>(0x2::coin::from_balance<LOFI>(v1, arg5), v0);
    }

    public entry fun update_tax_rates(arg0: &mut AdminCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 2000 && arg2 <= 2000, 0);
        arg0.buy_tax_rate = arg1;
        arg0.sell_tax_rate = arg2;
    }

    // decompiled from Move bytecode v7
}

