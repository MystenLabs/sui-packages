module 0xeb312d5ea8084dc41349db815af7a40cd1d251597836c0ad3ad3ab3425835f1f::fidel_84 {
    struct FIDEL_84 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIDEL_84, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIDEL_84>(arg0, 9, b"FIDEL_84", b"Fidel", b"For fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f0567d5-47a0-49f2-8691-fd7816ae1870.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIDEL_84>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIDEL_84>>(v1);
    }

    // decompiled from Move bytecode v6
}

