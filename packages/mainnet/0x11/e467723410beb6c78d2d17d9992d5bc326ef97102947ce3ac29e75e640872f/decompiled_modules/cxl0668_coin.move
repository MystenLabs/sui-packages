module 0x11e467723410beb6c78d2d17d9992d5bc326ef97102947ce3ac29e75e640872f::cxl0668_coin {
    struct CXL0668_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CXL0668_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CXL0668_COIN>(arg0, 8, b"CXL0668_COIN", b"CXL0668_COIN_COIN", b"This is my coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/174563322")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CXL0668_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CXL0668_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

