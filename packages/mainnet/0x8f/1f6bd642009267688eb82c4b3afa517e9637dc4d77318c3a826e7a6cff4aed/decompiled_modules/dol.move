module 0x8f1f6bd642009267688eb82c4b3afa517e9637dc4d77318c3a826e7a6cff4aed::dol {
    struct DOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOL>(arg0, 9, b"DOL", b"DolphCoin ", b"DolphCoin is a community-driven meme coin promoting ocean conservation, positivity, and fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d3b6d3d9-c749-4b8a-a8e4-3cde8daa1a1a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

