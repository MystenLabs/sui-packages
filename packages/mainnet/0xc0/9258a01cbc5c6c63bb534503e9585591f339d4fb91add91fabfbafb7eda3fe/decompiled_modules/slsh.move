module 0xc09258a01cbc5c6c63bb534503e9585591f339d4fb91add91fabfbafb7eda3fe::slsh {
    struct SLSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLSH>(arg0, 6, b"SLSH", b"Slushi3", b"Great tasting Slush", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1759399315258.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLSH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLSH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

