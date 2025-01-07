module 0xb47372f0411f6f5610073b049e5075cdfff24b7b93543b02318e7af5e6cd4b08::wocean {
    struct WOCEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOCEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOCEAN>(arg0, 9, b"WOCEAN", b"WaveaG", b"That's so hard to claim ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/deeb2472-5fcb-47f1-82ad-569aa27f5c35.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOCEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOCEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

