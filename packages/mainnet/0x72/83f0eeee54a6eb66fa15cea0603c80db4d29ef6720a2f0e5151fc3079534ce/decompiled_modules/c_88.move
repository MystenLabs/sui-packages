module 0x7283f0eeee54a6eb66fa15cea0603c80db4d29ef6720a2f0e5151fc3079534ce::c_88 {
    struct C_88 has drop {
        dummy_field: bool,
    }

    fun init(arg0: C_88, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<C_88>(arg0, 6, b"88", b"test88", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipad.online/api/images/7c3be910a68380ab5265fca7a3f14e79558e470b5212c5e0e6fdc6da2b2fa1b4.jpg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<C_88>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<C_88>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

