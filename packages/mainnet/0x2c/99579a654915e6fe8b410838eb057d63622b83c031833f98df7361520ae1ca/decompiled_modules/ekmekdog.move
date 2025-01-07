module 0x2c99579a654915e6fe8b410838eb057d63622b83c031833f98df7361520ae1ca::ekmekdog {
    struct EKMEKDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EKMEKDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EKMEKDOG>(arg0, 9, b"EKMEKDOG", b"EKMEK DOG ", b"First stray dog on all chains! And he loves to eat baguettes Ekmek is symbol of resilience and friendship", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1a00d43f-2fc9-49d5-b6e1-94f330edbb29.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EKMEKDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EKMEKDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

