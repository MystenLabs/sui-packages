module 0x85bbf170fe30fc3ce885b0131bf81f30e5ee187084d1f029be79303a5c1bbba5::bundler {
    struct CoinKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Wallet<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct Bundle<phantom T0> has store {
        inner: 0x2::table_vec::TableVec<Wallet<T0>>,
        total: u64,
    }

    struct Bundler has key {
        id: 0x2::object::UID,
        inner: 0x2::bag::Bag,
    }

    public fun deposit<T0>(arg0: &mut Bundler, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        maybe_add<T0>(arg0, v0, arg2);
        let v1 = inner_mut<T0>(arg0, v0);
        v1.total = v1.total + 0x2::coin::value<T0>(&arg1);
        let v2 = Wallet<T0>{id: 0x2::object::new(arg2)};
        let v3 = CoinKey{dummy_field: false};
        0x2::dynamic_object_field::add<CoinKey, 0x2::coin::Coin<T0>>(&mut v2.id, v3, arg1);
        0x2::table_vec::push_back<Wallet<T0>>(&mut v1.inner, v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bundler{
            id    : 0x2::object::new(arg0),
            inner : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Bundler>(v0);
    }

    fun inner<T0>(arg0: &Bundler, arg1: address) : &Bundle<T0> {
        0x2::table::borrow<address, Bundle<T0>>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::table::Table<address, Bundle<T0>>>(&arg0.inner, 0x1::type_name::get<T0>()), arg1)
    }

    fun inner_mut<T0>(arg0: &mut Bundler, arg1: address) : &mut Bundle<T0> {
        0x2::table::borrow_mut<address, Bundle<T0>>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<address, Bundle<T0>>>(&mut arg0.inner, 0x1::type_name::get<T0>()), arg1)
    }

    fun maybe_add<T0>(arg0: &mut Bundler, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.inner, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::table::Table<address, Bundle<T0>>>(&mut arg0.inner, v0, 0x2::table::new<address, Bundle<T0>>(arg2));
        };
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<address, Bundle<T0>>>(&mut arg0.inner, v0);
        if (!0x2::table::contains<address, Bundle<T0>>(v1, arg1)) {
            let v2 = Bundle<T0>{
                inner : 0x2::table_vec::empty<Wallet<T0>>(arg2),
                total : 0,
            };
            0x2::table::add<address, Bundle<T0>>(v1, arg1, v2);
        };
    }

    public fun total<T0>(arg0: &Bundler, arg1: address) : u64 {
        inner<T0>(arg0, arg1).total
    }

    public fun withdraw<T0>(arg0: &mut Bundler, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = inner_mut<T0>(arg0, 0x2::tx_context::sender(arg1));
        let Wallet { id: v1 } = 0x2::table_vec::pop_back<Wallet<T0>>(&mut v0.inner);
        let v2 = CoinKey{dummy_field: false};
        let v3 = 0x2::dynamic_object_field::remove<CoinKey, 0x2::coin::Coin<T0>>(&mut v1, v2);
        0x2::object::delete(v1);
        v0.total = v0.total - 0x2::coin::value<T0>(&v3);
        v3
    }

    // decompiled from Move bytecode v6
}

