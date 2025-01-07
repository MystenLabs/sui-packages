module 0x960cf4d69df0f9747f231c58c84850ca44fe205c740bbd4a68e7fbd613c47679::ptm {
    struct PTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTM>(arg0, 9, b"PTM", b"puttome", b"put to talk or siren", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a494c7c8-530a-43e2-a796-a5eb2dee8463.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

