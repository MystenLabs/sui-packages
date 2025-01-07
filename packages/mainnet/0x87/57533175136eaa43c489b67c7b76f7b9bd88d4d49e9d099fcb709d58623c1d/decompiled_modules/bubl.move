module 0x8757533175136eaa43c489b67c7b76f7b9bd88d4d49e9d099fcb709d58623c1d::bubl {
    struct BUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBL>(arg0, 6, b"BUBL", b"BUBL on SUI", b"Bubbling on @SuiNetwork to make frens. HAVE FUN WITH BUBBLE! SOAR WITH BUBBLE! BUBBLE IT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731349937303.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

