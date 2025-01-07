module 0x48554f893e06973e47a8113399725bde4b41e207597126edc872bb10de91db4::love40 {
    struct LOVE40 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVE40, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVE40>(arg0, 9, b"LOVE40", b"@meme83", b"Mummysimi ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c53252e2-5793-4fcb-a5fd-1aa802002de3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVE40>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOVE40>>(v1);
    }

    // decompiled from Move bytecode v6
}

