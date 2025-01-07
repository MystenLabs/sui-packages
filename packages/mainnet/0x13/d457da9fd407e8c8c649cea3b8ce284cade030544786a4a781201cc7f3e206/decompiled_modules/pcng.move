module 0x13d457da9fd407e8c8c649cea3b8ce284cade030544786a4a781201cc7f3e206::pcng {
    struct PCNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCNG>(arg0, 9, b"PCNG", b"pocong", b"Pocong adalah sejenis hantu yang berwujud manusia yang terbungkus kafan. Di Indonesia, hantu semacam ini dikenal pula sebagai hantu bungkus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d1ecd4a8-7562-473c-8f69-ff8d48cffc4c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PCNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

