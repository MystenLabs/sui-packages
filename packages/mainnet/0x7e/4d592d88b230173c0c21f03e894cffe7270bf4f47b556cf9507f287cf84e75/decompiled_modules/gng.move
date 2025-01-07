module 0x7e4d592d88b230173c0c21f03e894cffe7270bf4f47b556cf9507f287cf84e75::gng {
    struct GNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GNG>(arg0, 9, b"GNG", b"Gangcar", b"Cat with a gun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1d22733c-6d30-4d5c-8e4e-1b97a5317c65-29957638-3280-4503-8c84-13a221cec236.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

