module 0x229fff9700179c5499f9ee6299fe39f51c6effa147b35f83f534c28433b6007d::moodsg001 {
    struct MOODSG001 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODSG001, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODSG001>(arg0, 9, b"MOODSG001", b"MOODSWING", b"unhappy floppy lazy meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/60ca9816-d562-474b-abc7-490380eca24f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODSG001>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOODSG001>>(v1);
    }

    // decompiled from Move bytecode v6
}

