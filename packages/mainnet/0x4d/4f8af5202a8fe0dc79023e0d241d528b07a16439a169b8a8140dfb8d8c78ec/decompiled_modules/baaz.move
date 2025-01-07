module 0x4d4f8af5202a8fe0dc79023e0d241d528b07a16439a169b8a8140dfb8d8c78ec::baaz {
    struct BAAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAAZ>(arg0, 9, b"BAAZ", b"Shabaazz", b"Freedom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/93e6a863-bd1b-40f3-a681-cfe564746020.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAAZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAAZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

