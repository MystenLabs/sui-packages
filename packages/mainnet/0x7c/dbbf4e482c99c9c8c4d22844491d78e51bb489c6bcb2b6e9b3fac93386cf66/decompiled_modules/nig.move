module 0x7cdbbf4e482c99c9c8c4d22844491d78e51bb489c6bcb2b6e9b3fac93386cf66::nig {
    struct NIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIG>(arg0, 9, b"NIG", b"NIGG", b"NI GG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/999f5043-08e5-40c4-8b39-dd23669fbf10.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

