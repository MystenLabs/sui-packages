module 0xad62b158e74766eea74c6a9f292f03ad6bcc27378727691ec212b55b231a8f27::toilet {
    struct TOILET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOILET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOILET>(arg0, 9, b"TOILET", b"Skibidi", b" Skibidi Toilet is a meme based on the Skibidi Toilet game ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dd17b478-b2be-433c-8767-255a8827ca4a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOILET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOILET>>(v1);
    }

    // decompiled from Move bytecode v6
}

