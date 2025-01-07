module 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::price_oracle {
    struct PriceStore has store {
        prices: 0x2::table::Table<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, PriceData>>,
    }

    struct PriceData has copy, drop, store {
        price: u64,
        last_update: u64,
    }

    struct FeedCap has store, key {
        id: 0x2::object::UID,
        oracle: address,
    }

    public fun get_price(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: address, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName) : (u64, u64) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        assert!(0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::contains<PriceStore>(arg0, arg1), 0);
        let v0 = &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow<PriceStore>(arg0, arg1).prices;
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, PriceData>>(v0, arg2)) {
            abort 1
        };
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, PriceData>>(v0, arg2);
        if (!0x2::table::contains<0x1::type_name::TypeName, PriceData>(v1, arg3)) {
            abort 1
        };
        let PriceData {
            price       : v2,
            last_update : v3,
        } = *0x2::table::borrow<0x1::type_name::TypeName, PriceData>(v1, arg3);
        (v2, v3)
    }

    public fun get_price_generic<T0, T1>(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: address) : (u64, u64) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        get_price(arg0, arg1, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>())
    }

    public fun is_account_registered(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: address) : bool {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::contains<PriceStore>(arg0, arg1)
    }

    fun now_seconds(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public entry fun register(arg0: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: &mut 0x2::tx_context::TxContext) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        assert!(!is_account_registered(arg0, 0x2::tx_context::sender(arg1)), 3);
        let v0 = PriceStore{prices: 0x2::table::new<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, PriceData>>(arg1)};
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::add<PriceStore>(arg0, v0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = FeedCap{
            id     : 0x2::object::new(arg1),
            oracle : v1,
        };
        0x2::transfer::transfer<FeedCap>(v2, v1);
    }

    public fun set_price(arg0: &FeedCap, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg1);
        set_price_with_cap(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun set_price_generic<T0, T1>(arg0: &FeedCap, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg1);
        set_price_with_cap(arg0, arg1, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), arg2, arg3, arg4);
    }

    public fun set_price_with_cap(arg0: &FeedCap, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg1);
        let v0 = arg0.oracle;
        assert!(0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::contains<PriceStore>(arg1, v0), 0);
        let v1 = &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut<PriceStore>(arg1, v0).prices;
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, PriceData>>(v1, arg2)) {
            0x2::table::add<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, PriceData>>(v1, arg2, 0x2::table::new<0x1::type_name::TypeName, PriceData>(arg6));
        };
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, PriceData>>(v1, arg2);
        if (0x2::table::contains<0x1::type_name::TypeName, PriceData>(v2, arg3)) {
            let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, PriceData>(v2, arg3);
            v3.price = arg4;
            v3.last_update = now_seconds(arg5);
        } else {
            let v4 = PriceData{
                price       : arg4,
                last_update : now_seconds(arg5),
            };
            0x2::table::add<0x1::type_name::TypeName, PriceData>(v2, arg3, v4);
        };
    }

    // decompiled from Move bytecode v6
}

