module 0xcedda179c6132934d2c8d9b0117577c5eb3c0b65f77cafb90aa02c6122ec0279::clm {
    struct CLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLM>(arg0, 9, b"CLM", b"CAILONME", b" This is a cailonme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30cf5419-6598-4967-9b64-0d0466fa2f9e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

