module 0x96bee62b28961bd677b7cb107117ca71c188e98c515115cc336b72aaa0e8208c::nghiem {
    struct NGHIEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGHIEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGHIEM>(arg0, 9, b"NGHIEM", b"Nunioi", b"Nghiemmm is king", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a1df10bf-cc3e-4890-930c-b86efe622eeb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGHIEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NGHIEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

