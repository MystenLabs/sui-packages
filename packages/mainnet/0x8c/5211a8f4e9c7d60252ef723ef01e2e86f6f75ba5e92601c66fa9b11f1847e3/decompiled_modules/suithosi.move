module 0x8c5211a8f4e9c7d60252ef723ef01e2e86f6f75ba5e92601c66fa9b11f1847e3::suithosi {
    struct SUITHOSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITHOSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITHOSI>(arg0, 6, b"Suithosi", b"Suitoshi Nakamoto ", b"Dive into the revolution of the crypto world with Suitoshi Nakamotothe dawn of a thrilling new era! Embrace the legacy and make your mark by investing in Suitoshi!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730960395888.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITHOSI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITHOSI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

