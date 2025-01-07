module 0xe350474a75fa96c632a24f6b23d2787d9c8567cbbe6c773e5d46e2fac94c1513::mriya {
    struct MRIYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRIYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRIYA>(arg0, 9, b"MRIYA", b"MriyaCoin", b"Cryptocurrency inspired by the Ukrainian Antonov 225 \"Mriya\". It symbolizes the dream of reaching new heights in technology, transportation, and international cooperation, honoring the memory of the world's largest aircraft, a symbol of Ukrainian strength", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8b06cd06-e108-47bd-8ce7-2652bad2fd1f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRIYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRIYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

