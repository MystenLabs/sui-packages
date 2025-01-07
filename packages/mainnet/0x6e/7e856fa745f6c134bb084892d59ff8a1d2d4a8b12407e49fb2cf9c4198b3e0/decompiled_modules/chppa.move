module 0x6e7e856fa745f6c134bb084892d59ff8a1d2d4a8b12407e49fb2cf9c4198b3e0::chppa {
    struct CHPPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHPPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHPPA>(arg0, 9, b"CHPPA", b"CHOPPA", b"Choppa token is a meme token, choppa is a slang word meaning automatic weapon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f94f1888-11b4-4873-9fb3-bf9d3679b1b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHPPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHPPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

