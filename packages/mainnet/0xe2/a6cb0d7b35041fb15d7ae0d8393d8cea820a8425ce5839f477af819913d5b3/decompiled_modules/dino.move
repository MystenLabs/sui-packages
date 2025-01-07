module 0xe2a6cb0d7b35041fb15d7ae0d8393d8cea820a8425ce5839f477af819913d5b3::dino {
    struct DINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINO>(arg0, 9, b"DINO", b"DINOSUI", b"SUI DINO, THE BIGGEST DINO MEME ON SUI, EVERY CHAIN NEEDS IT. EVERYTHING IS JUST FINE, SUI DINO IS VERY SERIOUS DINO,  BRINGS MANY SUI, MANY FUN AND MUCH LOVE TO SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/22ab6c13-01f8-4e5a-8c55-e275be5a7619.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

