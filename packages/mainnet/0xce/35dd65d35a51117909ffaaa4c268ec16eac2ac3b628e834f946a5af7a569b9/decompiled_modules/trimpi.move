module 0xce35dd65d35a51117909ffaaa4c268ec16eac2ac3b628e834f946a5af7a569b9::trimpi {
    struct TRIMPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIMPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIMPI>(arg0, 9, b"TRIMPI", b"Trump", b"President of America", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6b4d82d8-1fce-4cf8-a44b-f766ab6161a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIMPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRIMPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

