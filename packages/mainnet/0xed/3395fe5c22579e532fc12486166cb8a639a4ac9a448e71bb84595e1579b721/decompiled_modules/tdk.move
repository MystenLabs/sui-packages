module 0xed3395fe5c22579e532fc12486166cb8a639a4ac9a448e71bb84595e1579b721::tdk {
    struct TDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDK>(arg0, 6, b"TDK", b"TOAD KING", x"f09f90b8544f4144204b494e47f09f9191", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731571138604.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TDK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

