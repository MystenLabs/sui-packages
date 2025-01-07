module 0x2bfdf33d5d77b5f21d6b313273bab22d19a3a62ba357cf3fe78ffa7ff986ee36::hip {
    struct HIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIP>(arg0, 9, b"HIP", b"HipHip", b"Meme is meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d67fd437-ae0c-4a1f-9d39-4837bcbc4d4e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

