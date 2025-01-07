module 0x331f085f77c22b14716024e5ef7422c13fd9409ddf4231605458fe61212f00ec::wd {
    struct WD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WD>(arg0, 9, b"WD", b"WaveDown", b"Ok wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/af56af62-b59e-4fda-ad97-0954ad0999fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WD>>(v1);
    }

    // decompiled from Move bytecode v6
}

