module 0x792db55703ca10b03f7dc75a7bace5e2d8b48ce088af19a3ec5dabd8505d37aa::memedi {
    struct MEMEDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEDI>(arg0, 9, b"MEMEDI", b"Meme Dino ", b"Meme Dino World ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/347d7fa4-f625-42c8-a017-b4577f70c47e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

