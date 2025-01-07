module 0x653aa4550fc514b0b06c60bcf0733811573968df5fc07909955c21e8466c2199::tdk {
    struct TDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDK>(arg0, 6, b"TDK", x"f09f90b8544f4144204b494e47f09f9191", x"54686520f09f91916b696e67f09f9191206f6620616c6c20f09f90b8746f616473f09f90b8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731570942922.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TDK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

