module 0x91526978371d40560ecc23656a0f0a7b2bf0680adbc4cd5e89c913711db63bf3::pwc {
    struct PWC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWC>(arg0, 9, b"PWC", b"P Walrus", b"Potato Walrus Coin is a novel cryptocurrency with a quirky twist that supports wildlife conservation! Inspired by the viral sketch of a walrus that looks remarkably like a potato.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d2ff66df-5129-42ad-b191-c78895c954a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PWC>>(v1);
    }

    // decompiled from Move bytecode v6
}

