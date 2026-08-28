module 0xc9191d19f18d15837a48c31fd738f61b4e5eca4be396812b4689e656e4e9914c::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALE>(arg0, 6, b"WHALE", b"blue", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipad.online/api/images/7c3be910a68380ab5265fca7a3f14e79558e470b5212c5e0e6fdc6da2b2fa1b4.jpg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WHALE>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

