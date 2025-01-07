module 0x792aea769b66c0058684200daf7b806ce4c9aaaf676a46618d91de3ca0191105::amm {
    struct AMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMM>(arg0, 9, b"AMM", b"AllMeme", b"All airdrop token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53b40e52-5784-4dbf-a649-0c755e0f1b2a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

