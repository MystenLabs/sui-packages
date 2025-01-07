module 0xb647685328a85b7ae17d1576f24753f7182f92e260fcf8f2d0b848f909f5f960::sui_spooky {
    struct SUI_SPOOKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_SPOOKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_SPOOKY>(arg0, 9, b"SUI SPOOKY", x"f09f8e8353756953706f6f6b79", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_SPOOKY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_SPOOKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_SPOOKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

