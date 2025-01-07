module 0x25d9f58239dab67ee46024bdb37907ca668febe53596910c77060cbe427e40f9::frt {
    struct FRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRT>(arg0, 9, b"FRT", b"Frog", b"Just a frog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/99e916b8-059c-495f-a66d-16c4cf81013b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

