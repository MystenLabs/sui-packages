module 0x37035f1d7da2734294743866ca1509204f3e816bf254b27f32f8a08d09436157::sexymeme {
    struct SEXYMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEXYMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEXYMEME>(arg0, 9, b"SEXYMEME", b"SEXY MEME", b"SEXY MEME SEXYMEME SEXYMEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ecd311c2-dace-4a43-82fe-75ec43d34668.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEXYMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEXYMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

