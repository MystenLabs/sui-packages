module 0x4eeb23d714db17a53eee36d2714ab847d9680f88fb1e9a8c8145fc96fdfe05b9::fome {
    struct FOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOME>(arg0, 6, b"FOME", b"Father of Meme", b"Sick of all these new meaningless memes that aren't really even memes? Join FOME, the first meme ever created in history (and was actually really funny)! Support the real father who gave birth to the culture we are living today. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732096142830.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

