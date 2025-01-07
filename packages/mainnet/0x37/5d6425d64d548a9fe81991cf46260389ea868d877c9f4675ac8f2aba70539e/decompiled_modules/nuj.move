module 0x375d6425d64d548a9fe81991cf46260389ea868d877c9f4675ac8f2aba70539e::nuj {
    struct NUJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUJ>(arg0, 9, b"NUJ", b"UMBRALLA", b" GIRL WITH BANGS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c2c2150-c4ea-4c08-80eb-09476e9d2b20.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

