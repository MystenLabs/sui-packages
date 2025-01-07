module 0x42415c9b569d2291ec7dc85ca24a3f5710ac87f65a3752bfb852003ba360c42d::paws {
    struct PAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWS>(arg0, 9, b"PAWS", b"$PAWS", b"Paws token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a194565-1995-4c67-95b3-8a4efe53bc30.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

