module 0x7937c953b225a7b7d17ca1b2292eb5c54a545d76d495c89bd22ac3002ce70beb::spooky {
    struct SPOOKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOOKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOOKY>(arg0, 9, b"SPOOKY", x"f09f8e8353706f6f6b79", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPOOKY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOOKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOOKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

