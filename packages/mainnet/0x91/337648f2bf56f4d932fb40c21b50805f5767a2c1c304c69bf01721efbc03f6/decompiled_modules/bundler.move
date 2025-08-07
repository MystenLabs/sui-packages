module 0x91337648f2bf56f4d932fb40c21b50805f5767a2c1c304c69bf01721efbc03f6::bundler {
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
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::object::uid_to_address(&v2.id));
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

    public fun next_wallet<T0>(arg0: &Bundler, arg1: address) : address {
        let v0 = inner<T0>(arg0, arg1);
        0x2::object::uid_to_address(&0x2::table_vec::borrow<Wallet<T0>>(&v0.inner, 0x2::table_vec::length<Wallet<T0>>(&v0.inner) - 1).id)
    }

    public fun total<T0>(arg0: &Bundler, arg1: address) : u64 {
        inner<T0>(arg0, arg1).total
    }

    public fun withdraw<T0>(arg0: &mut Bundler, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = inner_mut<T0>(arg0, 0x2::tx_context::sender(arg2));
        let Wallet { id: v1 } = 0x2::table_vec::pop_back<Wallet<T0>>(&mut v0.inner);
        let v2 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut v1, arg1);
        0x2::object::delete(v1);
        v0.total = v0.total - 0x2::coin::value<T0>(&v2);
        v2
    }

    // decompiled from Move bytecode v6
}

