module 0x34c12854d90774154f6140c0ef0c91c01a1d0e94a453a26c5b453e88f25ed04d::pengchill {
    struct PENGCHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGCHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGCHILL>(arg0, 6, b"PengChill", b"Penguin Has No Chill", b"wuu peng has no chillo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734558788043.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGCHILL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGCHILL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

