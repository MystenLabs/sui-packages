module 0x5440c3c710961e4411518624b34db534203f6290ed0a6ff325dc62d41d835c39::blho {
    struct BLHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLHO>(arg0, 9, b"BLHO", b"Blue Hot", b"Blue Hot flames are very hot.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/49dacdc6-d5ca-4f74-b560-899263548b17.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

