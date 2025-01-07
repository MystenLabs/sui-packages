module 0x3385f95d46832433502b94c30ddcb79fe841f1851dfd934b71426a38a8b538f1::smy {
    struct SMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMY>(arg0, 9, b"SMY", b"smiley", b"smiley is an alpha meme token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a827fc0b-bcb3-474e-985f-47a08cddfb17.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

