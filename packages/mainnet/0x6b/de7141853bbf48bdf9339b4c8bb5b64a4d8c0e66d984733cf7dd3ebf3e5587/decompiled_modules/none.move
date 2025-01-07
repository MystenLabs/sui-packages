module 0x6bde7141853bbf48bdf9339b4c8bb5b64a4d8c0e66d984733cf7dd3ebf3e5587::none {
    struct NONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NONE>(arg0, 9, b"NONE", b"Memetop2", b"Nice meme hot gram 2024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d2ab87cc-a560-4870-bb53-9812fd34af10.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

