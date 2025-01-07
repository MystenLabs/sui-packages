module 0x4d38ea3557aed5796a6ce7405d90551d0482e870dfb9ae6db575f2820f22ae32::scrl {
    struct SCRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCRL>(arg0, 9, b"SCRL", b"$Scamroll", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8db95e54-1eaf-4232-9cce-9fc6671a26ff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

