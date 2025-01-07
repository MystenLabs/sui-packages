module 0xd41f4636ea9c4811a9ff3016c5c6156f4b314e3e246b6da17d42ac1bb23fb3dc::play {
    struct PLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLAY>(arg0, 9, b"PLAY", b"Play!", b"Play Again! Win or loss, play again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/66a7161a-90f3-4e28-b813-bc486a3906de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

