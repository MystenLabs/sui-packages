module 0x78e3577e62c34d30df7e4356fec2f42bd82954263537f0204bf4ab9da82f2357::fthg {
    struct FTHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTHG>(arg0, 9, b"FTHG", b"Faith", b"Claim and cool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/91de407f-b3d8-4f8f-b725-7d51e253a88c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTHG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FTHG>>(v1);
    }

    // decompiled from Move bytecode v6
}

