module 0x9fc8a1d34fb3fe49f4247e4d99df74b5b05bdf67d0a35b9cc17ea2c429229c70::pept {
    struct PEPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPT>(arg0, 9, b"PEPT", b"PepeTramp", b"President of YSA ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e6d7bca0-2eea-499a-93fa-44a9c773f43b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

