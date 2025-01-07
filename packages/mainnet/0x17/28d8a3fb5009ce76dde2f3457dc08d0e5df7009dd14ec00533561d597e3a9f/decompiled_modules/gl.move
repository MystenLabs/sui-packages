module 0x1728d8a3fb5009ce76dde2f3457dc08d0e5df7009dd14ec00533561d597e3a9f::gl {
    struct GL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GL>(arg0, 9, b"GL", b"Global", b"GLOBAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GL>(&mut v2, 6000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GL>>(v1);
    }

    // decompiled from Move bytecode v6
}

