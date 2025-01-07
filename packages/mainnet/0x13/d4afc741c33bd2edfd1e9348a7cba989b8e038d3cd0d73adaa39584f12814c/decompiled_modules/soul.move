module 0x13d4afc741c33bd2edfd1e9348a7cba989b8e038d3cd0d73adaa39584f12814c::soul {
    struct SOUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOUL>(arg0, 6, b"Soul", b"Synthetic Soul", b"Synthetic ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730960356857.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOUL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOUL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

