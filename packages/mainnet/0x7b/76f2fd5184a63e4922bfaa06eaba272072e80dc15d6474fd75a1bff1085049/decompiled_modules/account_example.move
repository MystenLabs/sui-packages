module 0x7b76f2fd5184a63e4922bfaa06eaba272072e80dc15d6474fd75a1bff1085049::account_example {
    struct MyStruct has store, key {
        id: 0x2::object::UID,
        navi_account: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
    }

    public fun example_function(arg0: &MyStruct) {
        abort 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyStruct{
            id           : 0x2::object::new(arg0),
            navi_account : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg0),
        };
        0x2::transfer::share_object<MyStruct>(v0);
    }

    // decompiled from Move bytecode v6
}

