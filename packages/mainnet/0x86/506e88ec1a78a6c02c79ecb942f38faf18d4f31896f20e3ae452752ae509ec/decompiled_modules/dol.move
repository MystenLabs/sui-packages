module 0x86506e88ec1a78a6c02c79ecb942f38faf18d4f31896f20e3ae452752ae509ec::dol {
    struct DOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOL>(arg0, 9, b"DOL", b"DolphCoin ", b"DolphCoin is a community-driven meme coin promoting ocean conservation, positivity, and fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/474fdd93-a761-488a-a8e4-f6994b49d77c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

