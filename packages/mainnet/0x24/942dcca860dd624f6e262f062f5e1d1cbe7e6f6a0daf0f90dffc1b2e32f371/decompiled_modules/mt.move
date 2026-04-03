module 0x24942dcca860dd624f6e262f062f5e1d1cbe7e6f6a0daf0f90dffc1b2e32f371::mt {
    struct MT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MT, arg1: &mut 0x2::tx_context::TxContext) {
        0xd0f58f70d9b1add5026ee9cefe306d9be9d29c54df48db27b75831e6c3ab23b8::mtoken::create_coin<MT>(arg0, 9, b"MT", b"MT", b"MT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.matrixdock.com/images/xaum/xaum-64x64-icon.png")), true, 0, arg1);
    }

    // decompiled from Move bytecode v6
}

