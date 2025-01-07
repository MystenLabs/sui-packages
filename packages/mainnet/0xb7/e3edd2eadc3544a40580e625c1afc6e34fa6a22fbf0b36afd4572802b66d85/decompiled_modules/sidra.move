module 0xb7e3edd2eadc3544a40580e625c1afc6e34fa6a22fbf0b36afd4572802b66d85::sidra {
    struct SIDRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIDRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIDRA>(arg0, 9, b"SIDRA", b"Chain", b"Sidra meme token. Buy sidra meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/247ae1ec-c569-4b51-b57b-560d88f848d7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIDRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIDRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

