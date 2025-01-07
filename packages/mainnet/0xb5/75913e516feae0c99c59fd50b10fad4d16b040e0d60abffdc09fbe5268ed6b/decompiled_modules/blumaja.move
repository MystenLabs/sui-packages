module 0xb575913e516feae0c99c59fd50b10fad4d16b040e0d60abffdc09fbe5268ed6b::blumaja {
    struct BLUMAJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUMAJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUMAJA>(arg0, 9, b"BLUMAJA", b"BLUM", b"Blumje", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2070d7b2-6158-4c77-8563-53a0adacaba8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUMAJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUMAJA>>(v1);
    }

    // decompiled from Move bytecode v6
}

