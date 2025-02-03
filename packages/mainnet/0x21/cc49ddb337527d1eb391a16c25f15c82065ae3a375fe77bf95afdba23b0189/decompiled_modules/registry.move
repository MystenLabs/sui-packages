module 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::registry {
    struct Registry has store, key {
        id: 0x2::object::UID,
        books: 0x2::object_bag::ObjectBag,
    }

    struct BookKey has copy, drop, store {
        nft_type: 0x1::type_name::TypeName,
        ft_type: 0x1::type_name::TypeName,
    }

    public fun set_protections<T0: store + key, T1>(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::admin_cap::AdminCap, arg1: &mut Registry, arg2: 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::ProtectedActions) {
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::set_protections<T0, T1>(borrow_mut_book<T0, T1>(arg1), arg2);
    }

    public fun borrow_mut_book<T0: store + key, T1>(arg0: &mut Registry) : &mut 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::Orderbook<T0, T1> {
        if (!check_book_exists<T0, T1>(arg0)) {
            abort 1
        };
        let v0 = BookKey{
            nft_type : 0x1::type_name::get<T0>(),
            ft_type  : 0x1::type_name::get<T1>(),
        };
        0x2::object_bag::borrow_mut<BookKey, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::Orderbook<T0, T1>>(&mut arg0.books, v0)
    }

    public fun check_book_exists<T0: store + key, T1>(arg0: &Registry) : bool {
        let v0 = BookKey{
            nft_type : 0x1::type_name::get<T0>(),
            ft_type  : 0x1::type_name::get<T1>(),
        };
        0x2::object_bag::contains<BookKey>(&arg0.books, v0)
    }

    public fun create_orderbook<T0: store + key, T1>(arg0: &mut Registry, arg1: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::allowlist::Allowlist, arg2: &mut 0x2::tx_context::TxContext) {
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::allowlist::validate_currency<T0, T1>(arg1);
        let v0 = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::new<T0, T1>(arg2);
        register_book<T0, T1>(arg0, v0);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::event_emitter::emit_orderbook_created_event<T0, T1>(0x2::object::id<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::Orderbook<T0, T1>>(&v0));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id    : 0x2::object::new(arg0),
            books : 0x2::object_bag::new(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public(friend) fun register_book<T0: store + key, T1>(arg0: &mut Registry, arg1: 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::Orderbook<T0, T1>) {
        if (check_book_exists<T0, T1>(arg0)) {
            abort 0
        };
        let v0 = BookKey{
            nft_type : 0x1::type_name::get<T0>(),
            ft_type  : 0x1::type_name::get<T1>(),
        };
        0x2::object_bag::add<BookKey, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::Orderbook<T0, T1>>(&mut arg0.books, v0, arg1);
    }

    // decompiled from Move bytecode v6
}

