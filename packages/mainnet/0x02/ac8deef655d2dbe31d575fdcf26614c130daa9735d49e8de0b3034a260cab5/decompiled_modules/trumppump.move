module 0x2ac8deef655d2dbe31d575fdcf26614c130daa9735d49e8de0b3034a260cab5::trumppump {
    struct TRUMPPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPPUMP>(arg0, 9, b"TRUMPPUMP", b"Trump", b"Meme of trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7ee799f5-892a-42d8-b204-efc3b35713fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

