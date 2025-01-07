module 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::listing {
    struct CoinTypeListed<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct CoinTypeUnlisted<phantom T0> has copy, drop {
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
        let v0 = &mut arg1.coins;
        let v1 = 0x1::type_name::get<T0>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(v0, &v1), 0);
        0x2::vec_set::insert<0x1::type_name::TypeName>(v0, v1);
        let v2 = CoinTypeListed<T0>{dummy_field: false};
        0x2::event::emit<CoinTypeListed<T0>>(v2);
    }

    public fun assert_coin_type_is_listed<T0>(arg0: &CoinTypeWhitelist) : 0x1::type_name::TypeName {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.coins, &v0), 2);
        v0
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
        let v0 = &mut arg1.coins;
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(v0, &v1), 1);
        0x2::vec_set::remove<0x1::type_name::TypeName>(v0, &v1);
        let v2 = CoinTypeUnlisted<T0>{dummy_field: false};
        0x2::event::emit<CoinTypeUnlisted<T0>>(v2);
    }

    // decompiled from Move bytecode v6
}

