module 0x815fae4137b384336c71776a554daede97ecc933603512b9b92bb4ec81d5daa2::animeonsui {
    struct ANIMEONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANIMEONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANIMEONSUI>(arg0, 9, b"ANIMEONSUI", b"ELONMUT", b"NOTHING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e66661c7-707a-4cce-8d02-7186d0f82903.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANIMEONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANIMEONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

