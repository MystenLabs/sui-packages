module 0x740df48c5b1b75a449a7c26c2b99c6d0a70b9a031b701024e0ede46e52c647ae::spay {
    struct SPAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPAY>(arg0, 9, b"SPAY", b"SuiPay", b"Sui fun meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/92e0cdc6-4b9d-495e-aa66-3863624b5e29-IMG_20240818_200113_489.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

