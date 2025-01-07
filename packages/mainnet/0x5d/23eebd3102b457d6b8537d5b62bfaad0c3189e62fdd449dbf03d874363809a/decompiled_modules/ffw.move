module 0x5d23eebd3102b457d6b8537d5b62bfaad0c3189e62fdd449dbf03d874363809a::ffw {
    struct FFW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFW>(arg0, 6, b"ffw", b"ffw", b"erdefcd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FFW>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFW>>(v1);
    }

    // decompiled from Move bytecode v6
}

