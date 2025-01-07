module 0xc7d03811841ae4529a0da5b9e7bbdbdbf16faa2844ba821444dfce5b5393ee84::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORE>(arg0, 9, b"CORE", b"CYBERCORE", b"Cybercore (CORE)adalah token meme yang lahir dari semangat komunitas dan viralitas internet. Diciptakan untuk menghibur, menyatukan, dan membawa kesenangan dalam dunia crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30422f4d-fa04-4e12-8943-9e9b0e9948d9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORE>>(v1);
    }

    // decompiled from Move bytecode v6
}

