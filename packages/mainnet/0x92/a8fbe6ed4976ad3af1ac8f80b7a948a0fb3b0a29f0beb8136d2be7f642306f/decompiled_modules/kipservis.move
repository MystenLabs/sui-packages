module 0x92a8fbe6ed4976ad3af1ac8f80b7a948a0fb3b0a29f0beb8136d2be7f642306f::kipservis {
    struct KIPSERVIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIPSERVIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIPSERVIS>(arg0, 9, b"KIPSERVIS", b"ZAE", b"KIpdervis prom automatic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b70c1a4d-10c1-4a4f-bec8-9cb2cebf3b28.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIPSERVIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIPSERVIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

