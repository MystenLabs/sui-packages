module 0x7ad61f729d49fcabd8bb683ca8e2965cff632a18df31e7ba2af4ecf91127cab7::jokso {
    struct JOKSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKSO>(arg0, 9, b"Jokso", b"zekih", b"Just let It go", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JOKSO>(&mut v2, 8974458879000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKSO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOKSO>>(v1);
    }

    // decompiled from Move bytecode v6
}

