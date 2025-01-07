module 0xab32b8b4059893b47561066319a158f92e1b91f4fb5059d8e08cc917c131172b::admin {
    struct Admin has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v1, @0x7be4629ec0dda5a41013bcd9b04b502a1474374d0b3e075ef98d970ca5cb6661);
    }

    // decompiled from Move bytecode v6
}

