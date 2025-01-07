module 0x3da613e7991ec9e1e27dc1806dbb61501475312e37f8197888b734f4d63bcdc2::m5 {
    struct M5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: M5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M5>(arg0, 9, b"M5", b"Memicat", x"4c65742773204d656f77f09f98bb20746f676574686572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f4d48aa-ac65-4645-a3ec-c66d0bad3118.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M5>>(v1);
    }

    // decompiled from Move bytecode v6
}

