module 0x2f6eda80eebec5bcf0d1e33c6cd5689966d3bc52f1439670142da17e71c98808::wocean {
    struct WOCEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOCEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOCEAN>(arg0, 9, b"WOCEAN", b"WaveaG", b"That's so hard to claim ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ad6808b3-ba8e-4056-9078-8661f214bbde.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOCEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOCEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

