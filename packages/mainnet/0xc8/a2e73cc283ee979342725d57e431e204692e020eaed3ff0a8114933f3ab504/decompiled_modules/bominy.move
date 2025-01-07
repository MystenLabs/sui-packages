module 0xc8a2e73cc283ee979342725d57e431e204692e020eaed3ff0a8114933f3ab504::bominy {
    struct BOMINY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOMINY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOMINY>(arg0, 9, b"BOMINY", b"Bomi", b"This token was created to complement the of this meme pad.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c75bce0-a703-4679-afd3-727a384bbad7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOMINY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOMINY>>(v1);
    }

    // decompiled from Move bytecode v6
}

