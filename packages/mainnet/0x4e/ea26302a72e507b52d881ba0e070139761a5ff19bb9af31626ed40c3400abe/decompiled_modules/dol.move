module 0x4eea26302a72e507b52d881ba0e070139761a5ff19bb9af31626ed40c3400abe::dol {
    struct DOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOL>(arg0, 9, b"DOL", b"DolphCoin", b"DolphCoin is a community-driven meme coin promoting ocean conservation, positivity, and fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7f535c64-73e3-4521-93d9-f24ef498c876.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

