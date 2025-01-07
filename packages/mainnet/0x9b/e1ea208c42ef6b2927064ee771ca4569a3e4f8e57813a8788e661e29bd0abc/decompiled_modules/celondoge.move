module 0x9be1ea208c42ef6b2927064ee771ca4569a3e4f8e57813a8788e661e29bd0abc::celondoge {
    struct CELONDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CELONDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CELONDOGE>(arg0, 9, b"CELONDOGE", b"ChiefDoge", b"First of the doge clan, chief Elon doge. Hold for the bull run. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8a2ad0f7-e3f3-4a57-a786-d381aa60b512.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CELONDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CELONDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

