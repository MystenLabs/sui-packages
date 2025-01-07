module 0xc94cb7d0ec11f5593138c7a4af288ecb6be41192d8f2771e8408dcef50c3a221::kabosu {
    struct KABOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KABOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KABOSU>(arg0, 9, b"KABOSU", b"KABOSUI", b"Kabosu, the Shiba Inu whose image became synonymous with the Dogecoin cryptocurrency and the \"Doge\" meme, passed away recently, leaving behind a legacy that transcended the internet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7191a7e5-882c-4c4f-af95-bceb851ce21e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KABOSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KABOSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

