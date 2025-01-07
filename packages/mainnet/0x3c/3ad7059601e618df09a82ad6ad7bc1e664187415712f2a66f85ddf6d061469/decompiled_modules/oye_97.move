module 0x3c3ad7059601e618df09a82ad6ad7bc1e664187415712f2a66f85ddf6d061469::oye_97 {
    struct OYE_97 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OYE_97, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OYE_97>(arg0, 9, b"OYE_97", b"Cycy", b"Meme coins to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cbd66cad-ab89-4176-b973-b04ad5eb2bb8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OYE_97>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OYE_97>>(v1);
    }

    // decompiled from Move bytecode v6
}

