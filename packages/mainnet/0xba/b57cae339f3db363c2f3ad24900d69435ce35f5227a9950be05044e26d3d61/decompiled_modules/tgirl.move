module 0xbab57cae339f3db363c2f3ad24900d69435ce35f5227a9950be05044e26d3d61::tgirl {
    struct TGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGIRL>(arg0, 9, b"TGIRL", b"TattoGirl", b"Meme of AI tatto girl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/99bb929a-ef49-4720-97cc-51d6da10f57a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGIRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

