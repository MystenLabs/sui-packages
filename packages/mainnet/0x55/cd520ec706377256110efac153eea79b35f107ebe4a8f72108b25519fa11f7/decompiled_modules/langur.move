module 0x55cd520ec706377256110efac153eea79b35f107ebe4a8f72108b25519fa11f7::langur {
    struct LANGUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LANGUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LANGUR>(arg0, 9, b"LANGUR", b"LANGUR Cil", b"LANGUR is a good and funny meme only on the sui network..!!! There is no project whatsoever, just created for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/85bfdf42-bb92-41a5-a460-0f9537bd8766.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LANGUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LANGUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

