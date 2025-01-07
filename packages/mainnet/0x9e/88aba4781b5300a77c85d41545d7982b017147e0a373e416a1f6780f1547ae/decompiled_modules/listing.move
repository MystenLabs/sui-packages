module 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::listing {
    struct CoinTypeListed<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct CoinTypeDelisted<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct ListingCap has store, key {
        id: 0x2::object::UID,
    }

    struct CoinTypeWhitelist has key {
        id: 0x2::object::UID,
        coins: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    public fun add_coin_type<T0>(arg0: &ListingCap, arg1: &mut CoinTypeWhitelist) {
        if (coin_type_is_listed<T0>(arg1)) {
            err_coin_type_already_listed();
        };
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.coins, 0x1::type_name::get<T0>());
        let v0 = CoinTypeListed<T0>{dummy_field: false};
        0x2::event::emit<CoinTypeListed<T0>>(v0);
    }

    public fun assert_coin_type_is_listed<T0>(arg0: &CoinTypeWhitelist) : 0x1::type_name::TypeName {
        if (!coin_type_is_listed<T0>(arg0)) {
            err_coin_type_not_listed();
        };
        0x1::type_name::get<T0>()
    }

    public fun coin_type_is_listed<T0>(arg0: &CoinTypeWhitelist) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.coins, &v0)
    }

    fun err_coin_type_already_listed() {
        abort 0
    }

    fun err_coin_type_not_exists() {
        abort 1
    }

    fun err_coin_type_not_listed() {
        abort 2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ListingCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ListingCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = CoinTypeWhitelist{
            id    : 0x2::object::new(arg0),
            coins : 0x2::vec_set::singleton<0x1::type_name::TypeName>(0x1::type_name::get<0x2::sui::SUI>()),
        };
        0x2::transfer::share_object<CoinTypeWhitelist>(v1);
    }

    public fun remove_coin_type<T0>(arg0: &ListingCap, arg1: &mut CoinTypeWhitelist) {
        if (!coin_type_is_listed<T0>(arg1)) {
            err_coin_type_not_exists();
        };
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.coins, &v0);
        let v1 = CoinTypeDelisted<T0>{dummy_field: false};
        0x2::event::emit<CoinTypeDelisted<T0>>(v1);
    }

    // decompiled from Move bytecode v6
}

