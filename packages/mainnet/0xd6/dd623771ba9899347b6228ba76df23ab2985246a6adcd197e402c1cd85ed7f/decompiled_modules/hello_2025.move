module 0xd6dd623771ba9899347b6228ba76df23ab2985246a6adcd197e402c1cd85ed7f::hello_2025 {
    struct Hello2025State has key {
        id: 0x2::object::UID,
        dummy_field: u8,
    }

    fun hello_version() : u128 {
        111
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Hello2025State{
            id          : 0x2::object::new(arg0),
            dummy_field : 0,
        };
        0x2::transfer::share_object<Hello2025State>(v0);
    }

    // decompiled from Move bytecode v6
}

