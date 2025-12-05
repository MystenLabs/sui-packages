module 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_coin_whitelist {
    struct Null has drop, store {
        dummy_field: bool,
    }

    struct BribeCoinWhitelist has store, key {
        id: 0x2::object::UID,
        whitelist: 0x2::linked_table::LinkedTable<0x1::type_name::TypeName, Null>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    entry fun remove<T0>(arg0: &mut BribeCoinWhitelist, arg1: &AdminCap) {
        remove_(arg0, 0x1::type_name::get<T0>(), arg1);
    }

    entry fun add<T0>(arg0: &mut BribeCoinWhitelist, arg1: &AdminCap) {
        add_(arg0, 0x1::type_name::get<T0>(), arg1);
    }

    fun add_(arg0: &mut BribeCoinWhitelist, arg1: 0x1::type_name::TypeName, arg2: &AdminCap) {
        let v0 = Null{dummy_field: false};
        0x2::linked_table::push_back<0x1::type_name::TypeName, Null>(&mut arg0.whitelist, arg1, v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BribeCoinWhitelist{
            id        : 0x2::object::new(arg0),
            whitelist : 0x2::linked_table::new<0x1::type_name::TypeName, Null>(arg0),
        };
        let v1 = Null{dummy_field: false};
        0x2::linked_table::push_back<0x1::type_name::TypeName, Null>(&mut v0.whitelist, 0x1::type_name::get<0x2::sui::SUI>(), v1);
        let v2 = Null{dummy_field: false};
        0x2::linked_table::push_back<0x1::type_name::TypeName, Null>(&mut v0.whitelist, 0x1::type_name::get<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift::TYDE_SHIFT>(), v2);
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<BribeCoinWhitelist>(v0);
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun is_whitelisted(arg0: &BribeCoinWhitelist, arg1: 0x1::type_name::TypeName) : bool {
        0x2::linked_table::contains<0x1::type_name::TypeName, Null>(&arg0.whitelist, arg1)
    }

    fun remove_(arg0: &mut BribeCoinWhitelist, arg1: 0x1::type_name::TypeName, arg2: &AdminCap) {
        0x2::linked_table::remove<0x1::type_name::TypeName, Null>(&mut arg0.whitelist, arg1);
    }

    public fun whitelisted_coins(arg0: &BribeCoinWhitelist) : vector<0x1::type_name::TypeName> {
        whitelisted_coins_(arg0)
    }

    fun whitelisted_coins_(arg0: &BribeCoinWhitelist) : vector<0x1::type_name::TypeName> {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = 0x2::linked_table::front<0x1::type_name::TypeName, Null>(&arg0.whitelist);
        while (0x1::option::is_some<0x1::type_name::TypeName>(v1)) {
            let v2 = *0x1::option::borrow<0x1::type_name::TypeName>(v1);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, v2);
            v1 = 0x2::linked_table::next<0x1::type_name::TypeName, Null>(&arg0.whitelist, v2);
        };
        v0
    }

    // decompiled from Move bytecode v6
}

