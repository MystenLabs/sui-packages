module 0x99e07b80eac75d33a1eeb817f11ba8741b65f14e431c1ad90c312a13de3a3172::maggi_45 {
    struct MAGGI_45 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGGI_45, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGGI_45>(arg0, 9, b"MAGGI_45", b"Maggi", b"For fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d678240-0323-4270-a0dd-fba6307d5a86.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGGI_45>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGGI_45>>(v1);
    }

    // decompiled from Move bytecode v6
}

