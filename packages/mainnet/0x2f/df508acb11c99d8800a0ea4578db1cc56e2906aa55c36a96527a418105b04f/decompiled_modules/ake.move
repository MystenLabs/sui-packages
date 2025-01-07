module 0x2fdf508acb11c99d8800a0ea4578db1cc56e2906aa55c36a96527a418105b04f::ake {
    struct AKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKE>(arg0, 9, b"AKE", b"Akedae ", b"A Blockchain academia meme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/936a71ce-447a-4df7-ad6b-2bdfcc8f7cef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

