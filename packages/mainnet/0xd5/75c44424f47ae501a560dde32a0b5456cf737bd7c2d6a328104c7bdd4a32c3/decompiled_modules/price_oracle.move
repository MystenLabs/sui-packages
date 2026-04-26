module 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::price_oracle {
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

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun get_price(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName) : (u64, u64) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        assert!(0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::contains<PriceStore>(arg0, arg1), 0);
        let v0 = &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<PriceStore>(arg0, arg1).prices;
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

    public fun get_price_generic<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address) : (u64, u64) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        get_price(arg0, arg1, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_account_registered(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address) : bool {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::contains<PriceStore>(arg0, arg1)
    }

    fun now_seconds(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public entry fun register(arg0: &AdminCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x2::tx_context::TxContext) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg1);
        assert!(!is_account_registered(arg1, 0x2::tx_context::sender(arg2)), 3);
        let v0 = PriceStore{prices: 0x2::table::new<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, PriceData>>(arg2)};
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::add<PriceStore>(arg1, v0, arg2);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = FeedCap{
            id     : 0x2::object::new(arg2),
            oracle : v1,
        };
        0x2::transfer::transfer<FeedCap>(v2, v1);
    }

    public fun set_price(arg0: &AdminCap, arg1: &FeedCap, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: 0x1::type_name::TypeName, arg4: 0x1::type_name::TypeName, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg2);
        set_price_with_cap(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun set_price_generic<T0, T1>(arg0: &AdminCap, arg1: &FeedCap, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg2);
        set_price_with_cap(arg0, arg1, arg2, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), arg3, arg4, arg5);
    }

    public fun set_price_with_cap(arg0: &AdminCap, arg1: &FeedCap, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: 0x1::type_name::TypeName, arg4: 0x1::type_name::TypeName, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg2);
        let v0 = arg1.oracle;
        assert!(0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::contains<PriceStore>(arg2, v0), 0);
        let v1 = &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_mut<PriceStore>(arg2, v0).prices;
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, PriceData>>(v1, arg3)) {
            0x2::table::add<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, PriceData>>(v1, arg3, 0x2::table::new<0x1::type_name::TypeName, PriceData>(arg7));
        };
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, PriceData>>(v1, arg3);
        if (0x2::table::contains<0x1::type_name::TypeName, PriceData>(v2, arg4)) {
            let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, PriceData>(v2, arg4);
            v3.price = arg5;
            v3.last_update = now_seconds(arg6);
        } else {
            let v4 = PriceData{
                price       : arg5,
                last_update : now_seconds(arg6),
            };
            0x2::table::add<0x1::type_name::TypeName, PriceData>(v2, arg4, v4);
        };
    }

    // decompiled from Move bytecode v6
}

