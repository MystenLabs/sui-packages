module 0x3f656b65bf2be73c86ac269da3261edfec630e8011a2c10e89f4aabd8f99130::ntlonv {
    struct NTLONV has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTLONV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTLONV>(arg0, 9, b"NTLONV", b"DRAGON 886", b"GM Good Products ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/32388b38-d8bc-452e-b6c8-487d1c550229.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTLONV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NTLONV>>(v1);
    }

    // decompiled from Move bytecode v6
}

