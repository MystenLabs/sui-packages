module 0xcc482955763956233f11efce946d114bc0032cb8a6b26b1fdb0cfe632e64a98d::jkwi {
    struct JKWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JKWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JKWI>(arg0, 9, b"JKWI", b"Mulyono", b"Meme for the 7th President of Indonesia.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/af37f18c-6cb0-48de-bdb7-4d9fc7ce68cd-1000270590.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JKWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JKWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

