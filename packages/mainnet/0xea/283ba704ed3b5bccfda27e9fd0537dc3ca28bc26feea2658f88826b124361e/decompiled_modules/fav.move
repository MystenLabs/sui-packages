module 0xea283ba704ed3b5bccfda27e9fd0537dc3ca28bc26feea2658f88826b124361e::fav {
    struct FAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAV>(arg0, 9, b"FAV", b"Favent", b"Joy giver meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/81495064-841f-4ffe-9f4b-553f17182300.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAV>>(v1);
    }

    // decompiled from Move bytecode v6
}

