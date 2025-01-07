module 0xf1f469f64b1e1432a21ee10a78ca69db02ddb2d75565d718de7f28a3ab8b004d::mrz {
    struct MRZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRZ>(arg0, 9, b"MRZ", b"MORTAZ", b"MORTAZ MEME COIN. FOR SELL.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ffe0bc76-5fe4-4a51-b923-a52116bd5cef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

