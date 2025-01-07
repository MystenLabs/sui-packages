module 0x66f79cdecd93e13fccc0d6055cf87636f0bc5ebdb9d4de06089c72f8055dc5ec::uno {
    struct UNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNO>(arg0, 9, b"UNO", b"UNO Games ", b"Uno is a video game based on the card game of the same name. It has been released for a number of platforms. The Xbox 360 version by Carbonated Games and Microsoft Game Studios was released on May 9, 2006, as a digital download via Xbox Live Arcade. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/95989e05-9dc4-4f9b-8366-3db9841eb829.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

