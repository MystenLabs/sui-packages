module 0x309fb4dd0ac7f633240252c279c47e191efd9dc694aabbebb8fcb7c42db37ce3::pwgn {
    struct PWGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWGN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWGN>(arg0, 9, b"PWGN", b"Pinguin", b"penguin is a token meme of sui that is entirely owned by the community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ad1cc62b-2f24-481f-9c30-e0bd82b6f22b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWGN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PWGN>>(v1);
    }

    // decompiled from Move bytecode v6
}

